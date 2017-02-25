package com.qp.lms.compManager.service;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.qp.lms.common.Constant;
import com.qp.lms.common.SessionUtil;
import com.qp.lms.common.service.DdService;
import com.qp.lms.compManager.model.CompCourseRegSet;
import com.qp.lms.compManager.model.CompCourseRegVO;
import com.qp.lms.guest.model.BankVO;
import com.qp.lms.main.model.MainVO;
import com.qp.lms.member.model.MemberVO;

@Service
public class CompCourseRegService {
	@Autowired
	private SqlSession sqlSession;

	@Autowired
	private DdService ddService;

    public CompCourseRegSet compCourseRegList(CompCourseRegSet set) throws Exception {
    	set.getCondiVO().setUserId(SessionUtil.getSessionUserId());

    	//쿼리에서 가져올 갯수 지정
    	set.getCondiVO().setLimitUnit(Constant.unitPerPage);

    	List<CompCourseRegVO> list = sqlSession.selectList("compCourseReg.compCourseRegList",set.getCondiVO());
    	set.setList(list);
    	
    	//페이징 처리 변수 세팅
    	set.setTotalCount(((CompCourseRegVO)sqlSession.selectOne("compCourseReg.compCourseRegTotal",set.getCondiVO())).getCnt());
    	set.setPageUnit(Constant.unitPerPage);
    	
    	return set;
    }


    public CompCourseRegSet compCourseRegU(CompCourseRegSet set) throws Exception {
    	set.getCondiVO().setUserId(SessionUtil.getSessionUserId());

    	set.setData((CompCourseRegVO)sqlSession.selectOne("compCourseReg.compCourseRegData",set.getCondiVO()));

    	List<CompCourseRegVO> noRegisterUserList = sqlSession.selectList("compCourseReg.noRegisterUserList",set.getCondiVO());
    	set.setNoRegisterUserList(noRegisterUserList);

    	List<CompCourseRegVO> registerUserList = sqlSession.selectList("compCourseReg.registerUserList",set.getCondiVO());
    	set.setRegisterUserList(registerUserList);
    	
    	
    	return set;
    }
    
    
	public CompCourseRegSet application(CompCourseRegSet set) throws Exception {
		//은행 Info
		set.setDdBank(ddService.getDdCode("BANK"));
		
		
		//결재 신청할 대상자 리스트
		List<CompCourseRegVO> applicationUserList = sqlSession.selectList("compCourseReg.applicationUserList",set.getCondiVO());
    	set.setApplicationUserList(applicationUserList);
    	
    	set.setApplicationCnt(Integer.toString(applicationUserList.size()));
    	
    	//결재금액
    	int paymentCost = 0;
    	String userIds = "";
    	for ( int i = 0; i < applicationUserList.size(); i++ ) {
    		paymentCost += Integer.parseInt((String)applicationUserList.get(i).getCourseCost());
    		
    		if ( i == 0 )
    			userIds += (String)applicationUserList.get(i).getUserId();
    		else
    			userIds += "," + (String)applicationUserList.get(i).getUserId();
    	}
    	set.setPaymentCost(Integer.toString(paymentCost));
    	set.setUserIds(userIds);
    	
    	//point
    	System.out.print("userId : " + set.getCondiVO());
    	MainVO mainVO = (MainVO)sqlSession.selectOne("main.userPoint", set.getCondiVO());
    	set.setPoint(mainVO.getPoint());
    	
    	//사용자 정보
    	MemberVO memberCondiVO = new MemberVO();
    	memberCondiVO.setUserId(SessionUtil.getSessionUserId());
    	set.setMemberVO((MemberVO)sqlSession.selectOne("member.userData",memberCondiVO));
    	
    	//은행정보
    	List<BankVO> bankList = sqlSession.selectList("comm.getBankList",set.getCondiVO());
    	set.setBankList(bankList);
    	
    	return set;
    }

	
    ///////////////////////////////////////////////// Transaction ////////////////////////////////////////////////////
    
    @Transactional(propagation=Propagation.REQUIRED, rollbackFor={Throwable.class})
    public CompCourseRegSet compCourseRegister(CompCourseRegSet set) throws Exception {
    	CompCourseRegVO condi = new CompCourseRegVO();
    	condi.setCreateUser(SessionUtil.getSessionUserId());
    	
    	String addUserIds[] = set.getCondiVO().getAddUserIds().split(",");
    	for ( int i = 0; i < addUserIds.length; i++ ) {
    		condi.setCourseId(set.getCondiVO().getCourseId());
    		condi.setUserId(addUserIds[i]);
    		
    		sqlSession.insert("compCourseReg.userIns",condi);
    	}

    	set.setRtnMode(Constant.mode.INSERT_OK.name());
        
    	return set;
    }

    @Transactional(propagation=Propagation.REQUIRED, rollbackFor={Throwable.class})
    public CompCourseRegSet compCourseRegisterCancel(CompCourseRegSet set) throws Exception {
    	CompCourseRegVO condi = new CompCourseRegVO();
    	
    	String delUserIds[] = set.getCondiVO().getDelUserIds().split(",");
    	for ( int i = 0; i < delUserIds.length; i++ ) {
    		condi.setCourseId(set.getCondiVO().getCourseId());
    		condi.setUserId(delUserIds[i]);
    		
    		sqlSession.insert("compCourseReg.userDel",condi);
    	}

    	set.setRtnMode(Constant.mode.DELETE_OK.name());
        
    	return set;
    }

	@Transactional(propagation=Propagation.REQUIRED, rollbackFor={Throwable.class})
	public CompCourseRegSet approval(CompCourseRegSet set) throws Exception {
		set.getCondiVO().setCreateUser(SessionUtil.getSessionUserId());
		set.getCondiVO().setUserId(SessionUtil.getSessionUserId());
		
		//결재 내용 입력.
		sqlSession.insert("compCourseReg.approvalIns",set.getCondiVO());
		
		CompCourseRegVO saveVO = new CompCourseRegVO();
		saveVO.setCreateUser(set.getCondiVO().getCourseId());
		saveVO.setCourseId(set.getCondiVO().getCourseId());
		saveVO.setApprovalId(set.getCondiVO().getApprovalId());
		saveVO.setPaymentKind(set.getCondiVO().getPaymentKind());
		
		String[] userIds = set.getCondiVO().getSelIds().split(",");
		for ( int i = 0; i < userIds.length; i++ ) {
			saveVO.setUserId(userIds[i]);
	    	sqlSession.insert("compCourseReg.courseRegisterUpd",saveVO);

	    	//평가 데이타 생성
	    	sqlSession.insert("compCourseReg.courseEvalIns",saveVO);
	    	
	    	//주차별 진도 데이타 생성
	    	sqlSession.insert("compCourseReg.courseWeekIns",saveVO);
		}
		
		set.setRtnMode(Constant.mode.OK.name());
		
    	return set;
    }


    
}
