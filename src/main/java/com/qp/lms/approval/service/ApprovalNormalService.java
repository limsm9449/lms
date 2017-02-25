package com.qp.lms.approval.service;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.qp.lms.approval.model.ApprovalNormalSet;
import com.qp.lms.approval.model.ApprovalNormalVO;
import com.qp.lms.common.Constant;
import com.qp.lms.common.SessionUtil;
import com.qp.lms.common.service.DdService;
import com.qp.lms.course.model.CourseMasterVO;
import com.qp.lms.course.model.RegisterVO;

@Service
public class ApprovalNormalService {
	@Autowired
	private SqlSession sqlSession;

	@Autowired
	private DdService ddService;
	
    public ApprovalNormalSet approvalNormalList(ApprovalNormalSet set) throws Exception {
    	// 카테고리 대분류 
    	set.setDdCategory1Depth(ddService.getDdCategory1Depth());
    	
    	// 카테고리 중분류 
    	if ( set.getCondiVO().getC1Code() != null )
    		set.setDdCategory2Depth(ddService.getDdCategory2Depth(set.getCondiVO().getC1Code()));
    	
    	// 카테고리 소분류 
    	if ( set.getCondiVO().getC2Code() != null )
    	set.setDdCategory3Depth(ddService.getDdCategory3Depth(set.getCondiVO().getC2Code()));

    	// 과정코드 
    	if ( set.getCondiVO().getC3Code() != null )
    	set.setDdCourseCode(ddService.getDdCourseCode(set.getCondiVO().getC3Code()));

    	//쿼리에서 가져올 갯수 지정
    	set.getCondiVO().setLimitUnit(Constant.unitPerPage);

    	List<ApprovalNormalVO> list = sqlSession.selectList("approvalNormal.approvalNormalList",set.getCondiVO());
    	set.setList(list);
    	
    	//페이징 처리 변수 세팅
    	set.setTotalCount(((ApprovalNormalVO)sqlSession.selectOne("approvalNormal.approvalNormalTotal",set.getCondiVO())).getCnt());
    	set.setPageUnit(Constant.unitPerPage);
    	
    	return set;
    }
    
    public ApprovalNormalSet approvalNormalRefundP(ApprovalNormalSet set) throws Exception {
    	set.setData((ApprovalNormalVO)sqlSession.selectOne("approvalNormal.approvalNormalData",set.getCondiVO()));
    	
    	return set;
    }
    
    public ApprovalNormalSet waitingApprovalNormalList(ApprovalNormalSet set) throws Exception {
    	// 카테고리 대분류 
    	set.setDdCategory1Depth(ddService.getDdCategory1Depth());
    	
    	// 카테고리 중분류 
    	if ( set.getCondiVO().getC1Code() != null )
    		set.setDdCategory2Depth(ddService.getDdCategory2Depth(set.getCondiVO().getC1Code()));
    	
    	// 카테고리 소분류 
    	if ( set.getCondiVO().getC2Code() != null )
    	set.setDdCategory3Depth(ddService.getDdCategory3Depth(set.getCondiVO().getC2Code()));

    	// 과정코드 
    	if ( set.getCondiVO().getC3Code() != null )
    	set.setDdCourseCode(ddService.getDdCourseCode(set.getCondiVO().getC3Code()));

    	//쿼리에서 가져올 갯수 지정 
    	set.getCondiVO().setLimitUnit(Constant.unitPerPage);

    	List<ApprovalNormalVO> list = sqlSession.selectList("approvalNormal.waitingApprovalNormalList",set.getCondiVO());
    	set.setList(list);
    	
    	//페이징 처리 변수 세팅
    	set.setTotalCount(((ApprovalNormalVO)sqlSession.selectOne("approvalNormal.waitingApprovalNormalTotal",set.getCondiVO())).getCnt());
    	set.setPageUnit(Constant.unitPerPage);
    	
    	return set;
    }
    
    public ApprovalNormalSet refundNormalList(ApprovalNormalSet set) throws Exception {
    	// 카테고리 대분류 
    	set.setDdCategory1Depth(ddService.getDdCategory1Depth());
    	
    	// 카테고리 중분류 
    	if ( set.getCondiVO().getC1Code() != null )
    		set.setDdCategory2Depth(ddService.getDdCategory2Depth(set.getCondiVO().getC1Code()));
    	
    	// 카테고리 소분류 
    	if ( set.getCondiVO().getC2Code() != null )
    	set.setDdCategory3Depth(ddService.getDdCategory3Depth(set.getCondiVO().getC2Code()));

    	// 과정코드 
    	if ( set.getCondiVO().getC3Code() != null )
    	set.setDdCourseCode(ddService.getDdCourseCode(set.getCondiVO().getC3Code()));

    	//쿼리에서 가져올 갯수 지정
    	set.getCondiVO().setLimitUnit(Constant.unitPerPage);

    	List<ApprovalNormalVO> list = sqlSession.selectList("approvalNormal.refundNormalList",set.getCondiVO());
    	set.setList(list);
    	
    	//페이징 처리 변수 세팅
    	set.setTotalCount(((ApprovalNormalVO)sqlSession.selectOne("approvalNormal.refundNormalTotal",set.getCondiVO())).getCnt());
    	set.setPageUnit(Constant.unitPerPage);
    	
    	return set;
    }
    
    ///////////////////////////////////////////////// Transaction ////////////////////////////////////////////////////
    
    @Transactional(propagation=Propagation.REQUIRED, rollbackFor={Throwable.class})
    public ApprovalNormalSet paymentConfrm(ApprovalNormalSet set) throws Exception {
    	set.getCondiVO().setUpdateUser(SessionUtil.getSessionUserId());
    	set.getCondiVO().setCreateUser(SessionUtil.getSessionUserId());
    	
    	//입금 확인 처리
    	sqlSession.update("approvalNormal.paymentConfirm",set.getCondiVO());

    	//수강신청 확인 처리
    	sqlSession.update("approvalNormal.registerConfirm",set.getCondiVO());
    	
    	//평가 데이타 생성
    	sqlSession.insert("approvalNormal.courseEvalIns",set.getCondiVO());
    	
    	//주차별 진도 데이타 생성
    	sqlSession.insert("approvalNormal.courseWeekIns",set.getCondiVO());
    	
    	//point 적립
    	sqlSession.insert("approvalNormal.pointCourseInIns",set.getCondiVO());
    	
    	set.setRtnMode(Constant.mode.UPDATE_OK.name());
    	
        
    	return set;
    }
    
    @Transactional(propagation=Propagation.REQUIRED, rollbackFor={Throwable.class})
    public ApprovalNormalSet approvalNormalRefundUpd(ApprovalNormalSet set) throws Exception {
    	set.getCondiVO().setUpdateUser(SessionUtil.getSessionUserId());
    	
    	sqlSession.update("approvalNormal.approvalNormalRefundUpd",set.getCondiVO());

    	//환불처리로 point를 뺌 
    	sqlSession.insert("approvalNormal.pointCourseRefundOutIns",set.getCondiVO());

    	set.setRtnMode(Constant.mode.UPDATE_OK.name());
    	
        
    	return set;
    }

    
}
