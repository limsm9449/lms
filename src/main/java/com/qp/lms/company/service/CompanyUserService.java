package com.qp.lms.company.service;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.qp.lms.common.Constant;
import com.qp.lms.common.SessionUtil;
import com.qp.lms.common.service.DdService;
import com.qp.lms.company.model.CompanyUserSet;
import com.qp.lms.company.model.CompanyUserVO;
import com.qp.lms.company.model.CompanyVO;

@Service
public class CompanyUserService {
	@Autowired
	private SqlSession sqlSession;

	@Autowired
	private DdService ddService;

    public CompanyUserSet companyUserList(CompanyUserSet set) throws Exception {
    	//쿼리에서 가져올 갯수 지정
    	set.getCondiVO().setLimitUnit(Constant.unitPerPage);

    	List<CompanyUserVO> list = sqlSession.selectList("companyUser.companyUserList",set.getCondiVO());
    	set.setList(list);
    	
    	//페이징 처리 변수 세팅
    	set.setTotalCount(((CompanyUserVO)sqlSession.selectOne("companyUser.companyUserTotal",set.getCondiVO())).getCnt());
    	set.setPageUnit(Constant.unitPerPage);
    	
    	return set;
    }
    
    
    
    
    
    ///////////////////////////////////////////////// Transaction ////////////////////////////////////////////////////
    
    @Transactional(propagation=Propagation.REQUIRED, rollbackFor={Throwable.class})
    public CompanyUserSet companyUserPwdReset(CompanyUserSet set) throws Exception {
    	set.getCondiVO().setUpdateUser(SessionUtil.getSessionUserId());
    	
   		sqlSession.update("companyUser.userPwdReset",set.getCondiVO());

   		set.setRtnMode(Constant.mode.UPDATE_OK.name());
   		
    	return set;
    }
    

}
