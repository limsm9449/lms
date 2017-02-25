package com.qp.lms.cost.service;

import java.util.HashMap;
import java.util.List;

import net.sf.json.JSONObject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.qp.lms.common.Constant;
import com.qp.lms.common.SessionUtil;
import com.qp.lms.common.service.DdService;
import com.qp.lms.cost.model.CostNotPaySet;
import com.qp.lms.cost.model.CostNotPayVO;

@Service
public class CostNotPayService {
	
	@Autowired
	private SqlSession sqlSession;
	
	@Autowired
	private DdService ddService;
	
	public CostNotPaySet costNotPayList(CostNotPaySet set) throws Exception {
		// 카테고리 대분류 
    	set.setDdCategory1Depth(ddService.getDdCategory1Depth());
    	
    	// 카테고리 중분류 
    	if ( set.getCondiVO().getC1Code() != null )
    		set.setDdCategory2Depth(ddService.getDdCategory2Depth(set.getCondiVO().getC1Code()));
    	
    	// 카테고리 소분류 
    	if ( set.getCondiVO().getC2Code() != null )
    	set.setDdCategory3Depth(ddService.getDdCategory3Depth(set.getCondiVO().getC2Code()));
    		
    	//쿼리에서 가져올 갯수 지정
    	set.getCondiVO().setLimitUnit(Constant.unitPerPage);

    	List<CostNotPayVO> list = sqlSession.selectList("costNotPay.costNotPayList",set.getCondiVO());
    	set.setList(list);
        
    	//페이징 처리 변수 세팅
    	set.setTotalCount(((CostNotPayVO)sqlSession.selectOne("costNotPay.costNotPayListTotal",set.getCondiVO())).getCnt());
    	set.setPageUnit(Constant.unitPerPage);
    	
    	return set;
    }
	
    public CostNotPaySet costNotPayU(CostNotPaySet set) throws Exception {
    	set.setData((CostNotPayVO) sqlSession.selectOne("costNotPay.costNotPayData",set.getCondiVO()));
        
    	List<CostNotPayVO> registerList = sqlSession.selectList("costNotPay.costNotPayRegisterList",set.getCondiVO());
    	set.setRegisterList(registerList);
    	
    	return set;
    }
    
    public CostNotPaySet costCheck(CostNotPaySet set) throws Exception {
    	CostNotPayVO paymentData = (CostNotPayVO) sqlSession.selectOne("costNotPay.costPayUserData",set.getCondiVO());
    	
    	CostNotPayVO saveVO = new CostNotPayVO();
    	saveVO.setCourseId(set.getCondiVO().getCourseId());

    	int companyCost = 0;
    	int teacherCost = 0;
    	int tutorCost = 0;
    	CostNotPayVO registerVO = null; 
    	for ( int i = 0; i < set.getCondiVO().getUserIds().length; i++ ) {
    		saveVO.setUserId(set.getCondiVO().getUserIds()[i]);
    		registerVO = (CostNotPayVO) sqlSession.selectOne("costNotPay.costPayData",saveVO);
    		
    		companyCost += Integer.parseInt(registerVO.getCompanyCost());
    		teacherCost += Integer.parseInt(registerVO.getTeacherCost());
    		tutorCost += Integer.parseInt(registerVO.getTutorCost());
    	}
    	
    	paymentData.setPaymentCost(Integer.toString(companyCost + teacherCost + tutorCost));
    	paymentData.setCompanyCost(Integer.toString(companyCost));
    	paymentData.setTeacherCost(Integer.toString(teacherCost));
    	paymentData.setTutorCost(Integer.toString(tutorCost));
    	
    	set.setPaymentData(paymentData);
    	
    	return set;
    }
   
    
	

    ///////////////////////////////////////////////// Transaction ////////////////////////////////////////////////////
    @Transactional(propagation=Propagation.REQUIRED, rollbackFor={Throwable.class})
    public CostNotPaySet costNotPayUUpd(CostNotPaySet set) throws Exception {
    	set.getCondiVO().setCreateUser(SessionUtil.getSessionUserId());
    	set.getCondiVO().setUpdateUser(SessionUtil.getSessionUserId());

    	boolean isPaid = false;
    	
    	//수강생이 지급처리 되었는지 체크
    	CostNotPayVO checkVO = new CostNotPayVO();
    	checkVO.setCourseId(set.getCondiVO().getCourseId());
    	for ( int i = 0; i < set.getCondiVO().getUserIds().length; i++ ) {
    		checkVO.setUserId(set.getCondiVO().getUserIds()[i]);
    		CostNotPayVO registerVO = sqlSession.selectOne("costNotPay.costCheckCourseRegister",checkVO);
    		if ( !"0".equals(registerVO.getCostId()) ) {
    			isPaid = true;
    			break;
    		}
    	}
    	
    	if ( isPaid ) {
			set.setRtnMode(Constant.mode.ERROR.name());
    	} else {
    		CostNotPayVO payUserData = (CostNotPayVO) sqlSession.selectOne("costNotPay.costPayUserData",set.getCondiVO());
    		
    		set.getCondiVO().setTeacherBank(payUserData.getTeacherBank());
    		set.getCondiVO().setTeacherAccNum(payUserData.getTeacherAccNum());
    		set.getCondiVO().setTutorBank(payUserData.getTutorBank());
    		set.getCondiVO().setTutorAccNum(payUserData.getTutorAccNum());
    		
	    	//지불정보를 생성한다.
	    	sqlSession.insert("costNotPay.costIns",set.getCondiVO());
	    	
	    	//마지막 id를 가져온다.
	    	String lastInsertId = sqlSession.selectOne("comm.lastInsertId");
	
	    	CostNotPayVO saveVO = new CostNotPayVO();
	    	saveVO.setCourseId(set.getCondiVO().getCourseId());
	    	saveVO.setCreateUser(SessionUtil.getSessionUserId());
	    	saveVO.setUpdateUser(SessionUtil.getSessionUserId());
	    	
	    	saveVO.setCostId(lastInsertId);
	
	    	//수강자 지급처리
	    	for ( int i = 0; i < set.getCondiVO().getUserIds().length; i++ ) {
	    		saveVO.setUserId(set.getCondiVO().getUserIds()[i]);
	    		sqlSession.update("costNotPay.costNotPayUpdate",saveVO);
	    	}
	    	
	    	//분배 금액 계산
	    	CostNotPayVO payVO = (CostNotPayVO) sqlSession.selectOne("costNotPay.costPayCalcData",saveVO);
	    	
	    	payVO.setCostId(lastInsertId);
	    	payVO.setUpdateUser(SessionUtil.getSessionUserId());
			
	    	//분배 금액 입력
	    	sqlSession.update("costNotPay.costUpd",payVO);
	    	
			set.setRtnMode(Constant.mode.UPDATE_OK.name());
    	}
    	
    	return set;
    }
	

}
