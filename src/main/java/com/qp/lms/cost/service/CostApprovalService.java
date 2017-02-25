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
import com.qp.lms.cost.model.CostNotPayVO;
import com.qp.lms.cost.model.CostApprovalSet;
import com.qp.lms.cost.model.CostApprovalVO;
import com.qp.lms.course.model.CourseManageSet;

@Service
public class CostApprovalService {
	
	@Autowired
	private SqlSession sqlSession;
	
	@Autowired
	private DdService ddService;
	
	public CostApprovalSet costApprovalList(CostApprovalSet set) throws Exception {
    	//쿼리에서 가져올 갯수 지정
    	set.getCondiVO().setLimitUnit(Constant.unitPerPage);

    	List<CostApprovalVO> list = sqlSession.selectList("costApproval.costApprovalList",set.getCondiVO());
    	set.setList(list);
        
    	//페이징 처리 변수 세팅
    	set.setTotalCount(((CostApprovalVO)sqlSession.selectOne("costApproval.costApprovalTotal",set.getCondiVO())).getCnt());
    	set.setPageUnit(Constant.unitPerPage);
    	
    	return set;
    }
	
	public CostApprovalSet costApprovalRefundV(CostApprovalSet set) throws Exception {
		//결재한 과정 리스트
    	List<CostApprovalVO> courseList = sqlSession.selectList("costApproval.approvalCoursList",set.getCondiVO());
    	set.setCourseList(courseList);
    	
    	//결재 정보
    	set.setData((CostApprovalVO)sqlSession.selectOne("costApproval.costApprovalData",set.getCondiVO()));
    	
    	return set;
    }

	public CostApprovalSet costBankList(CostApprovalSet set) throws Exception {
    	//쿼리에서 가져올 갯수 지정
    	set.getCondiVO().setLimitUnit(Constant.unitPerPage);

    	List<CostApprovalVO> list = sqlSession.selectList("costApproval.costBankList",set.getCondiVO());
    	set.setList(list);
        
    	//페이징 처리 변수 세팅
    	set.setTotalCount(((CostApprovalVO)sqlSession.selectOne("costApproval.costBankTotal",set.getCondiVO())).getCnt());
    	set.setPageUnit(Constant.unitPerPage);
    	
    	return set;
    }
	
	public CostApprovalSet costRefundList(CostApprovalSet set) throws Exception {
    	//쿼리에서 가져올 갯수 지정
    	set.getCondiVO().setLimitUnit(Constant.unitPerPage);

    	List<CostApprovalVO> list = sqlSession.selectList("costApproval.costRefundList",set.getCondiVO());
    	set.setList(list);
        
    	//페이징 처리 변수 세팅
    	set.setTotalCount(((CostApprovalVO)sqlSession.selectOne("costApproval.costRefundTotal",set.getCondiVO())).getCnt());
    	set.setPageUnit(Constant.unitPerPage);
    	
    	return set;
    }
   
	public CostApprovalSet costRefundV(CostApprovalSet set) throws Exception {
		//결재한 과정 리스트
    	List<CostApprovalVO> courseList = sqlSession.selectList("costApproval.approvalCoursList",set.getCondiVO());
    	set.setCourseList(courseList);
    	
    	//결재 정보
    	set.setData((CostApprovalVO)sqlSession.selectOne("costApproval.costApprovalData",set.getCondiVO()));
    	
    	return set;
    }



	///////////////////////////////////////////////// Transaction ////////////////////////////////////////////////////
	    
	@Transactional(propagation=Propagation.REQUIRED, rollbackFor={Throwable.class})
	public CostApprovalSet costRefundUpd(CostApprovalSet set) throws Exception {
		set.getCondiVO().setUpdateUser(SessionUtil.getSessionUserId());
		
		//환불처리
		sqlSession.update("costApproval.costRefundUpd",set.getCondiVO());

		//수강신청자 환불처리
		sqlSession.update("costApproval.registerRefundUpd",set.getCondiVO());
		
		set.setRtnMode(Constant.mode.UPDATE_OK.name());
		
		return set;
	}

	@Transactional(propagation=Propagation.REQUIRED, rollbackFor={Throwable.class})
	public CostApprovalSet costBankUpd(CostApprovalSet set) throws Exception {
		set.getCondiVO().setUpdateUser(SessionUtil.getSessionUserId());
		
		//입금처리
		sqlSession.update("costApproval.costBankUpd",set.getCondiVO());
		
		//대상자를 가져온다.
		List<CostApprovalVO> registerList = sqlSession.selectList("costApproval.registerList",set.getCondiVO());
		if ( registerList != null ) {
			for ( int i = 0; i < registerList.size(); i++ ) {
				CostApprovalVO row = registerList.get(i);
				
				row.setCreateUser(SessionUtil.getSessionUserId());
				
				//수강신청자 확인 처리
				sqlSession.update("costApproval.registerConfirmUpd",row);
			}
		}
    	
		set.setRtnMode(Constant.mode.UPDATE_OK.name());
		
		return set;
	}

}
