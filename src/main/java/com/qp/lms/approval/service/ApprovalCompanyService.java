package com.qp.lms.approval.service;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.qp.lms.approval.model.ApprovalCompanySet;
import com.qp.lms.approval.model.ApprovalCompanyVO;
import com.qp.lms.common.Constant;
import com.qp.lms.common.SessionUtil;
import com.qp.lms.common.service.DdService;

@Service
public class ApprovalCompanyService {
	@Autowired
	private SqlSession sqlSession;

	@Autowired
	private DdService ddService;
	
    public ApprovalCompanySet approvalCompanyList(ApprovalCompanySet set) throws Exception {
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

    	List<ApprovalCompanyVO> list = sqlSession.selectList("approvalCompany.approvalCompanyList",set.getCondiVO());
    	set.setList(list);
    	
    	//페이징 처리 변수 세팅
    	set.setTotalCount(((ApprovalCompanyVO)sqlSession.selectOne("approvalCompany.approvalCompanyTotal",set.getCondiVO())).getCnt());
    	set.setPageUnit(Constant.unitPerPage);
    	
    	return set;
    }
    
    public ApprovalCompanySet approvalCompanyRefundP(ApprovalCompanySet set) throws Exception {
    	set.setData((ApprovalCompanyVO)sqlSession.selectOne("approvalCompany.approvalCompanyData",set.getCondiVO()));
    	
    	return set;
    }
    
    public ApprovalCompanySet waitingApprovalCompanyList(ApprovalCompanySet set) throws Exception {
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

    	List<ApprovalCompanyVO> list = sqlSession.selectList("approvalCompany.waitingApprovalCompanyList",set.getCondiVO());
    	set.setList(list);
    	
    	//페이징 처리 변수 세팅
    	set.setTotalCount(((ApprovalCompanyVO)sqlSession.selectOne("approvalCompany.waitingApprovalCompanyTotal",set.getCondiVO())).getCnt());
    	set.setPageUnit(Constant.unitPerPage);
    	
    	return set;
    }
    
    public ApprovalCompanySet refundCompanyList(ApprovalCompanySet set) throws Exception {
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

    	List<ApprovalCompanyVO> list = sqlSession.selectList("approvalCompany.refundCompanyList",set.getCondiVO());
    	set.setList(list);
    	
    	//페이징 처리 변수 세팅
    	set.setTotalCount(((ApprovalCompanyVO)sqlSession.selectOne("approvalCompany.refundCompanyTotal",set.getCondiVO())).getCnt());
    	set.setPageUnit(Constant.unitPerPage);
    	
    	return set;
    }
    
    ///////////////////////////////////////////////// Transaction ////////////////////////////////////////////////////
    
    @Transactional(propagation=Propagation.REQUIRED, rollbackFor={Throwable.class})
    public ApprovalCompanySet paymentConfrm(ApprovalCompanySet set) throws Exception {
    	set.getCondiVO().setUpdateUser(SessionUtil.getSessionUserId());
    	set.getCondiVO().setCreateUser(SessionUtil.getSessionUserId());
    	
    	//회사 입금 확인 처리
    	sqlSession.update("approvalCompany.paymentConfirm",set.getCondiVO());
    	
    	//평가 데이타 생성
    	sqlSession.insert("approvalCompany.courseEvalIns",set.getCondiVO());
    	
    	//주차별 진도 데이타 생성
    	sqlSession.insert("approvalCompany.courseWeekIns",set.getCondiVO());

    	//회사 확인 처리
    	sqlSession.update("approvalCompany.userPaymentConfirm",set.getCondiVO());

    	set.setRtnMode(Constant.mode.UPDATE_OK.name());
    	
        
    	return set;
    }
    
    @Transactional(propagation=Propagation.REQUIRED, rollbackFor={Throwable.class})
    public ApprovalCompanySet approvalCompanyRefundUpd(ApprovalCompanySet set) throws Exception {
    	set.getCondiVO().setUpdateUser(SessionUtil.getSessionUserId());
    	
    	//회사 환불처리
    	sqlSession.update("approvalCompany.approvalCompanyRefundUpd",set.getCondiVO());

    	//직원 환불처리
    	sqlSession.update("approvalCompany.approvalCompanyUserRefundUpd",set.getCondiVO());

    	set.setRtnMode(Constant.mode.UPDATE_OK.name());
    	
        
    	return set;
    }

    
}
