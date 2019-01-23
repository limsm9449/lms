package com.qp.lms.login.service;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.qp.lms.common.CommUtil;
import com.qp.lms.common.Constant;
import com.qp.lms.company.model.CompanyVO;
import com.qp.lms.course.model.CourseVO;
import com.qp.lms.login.model.LoginSet;
import com.qp.lms.login.model.LoginVO;

@Service
public class LoginService {

	@Autowired
	private SqlSession sqlSession;


    public LoginSet loginCheck(LoginSet set) throws Exception {
    	LoginVO loginVO = (LoginVO) sqlSession.selectOne("login.getLoginUser",set.getCondiVO());
    	
    	if ( loginVO == null ) {
    		set.setIsNotExistUserId("N");
    		set.setIsWrongPassword("N");
    		
    		if ( ((LoginVO)sqlSession.selectOne("login.isExistUser",set.getCondiVO())).getCnt() == 0 ) { 
    			set.setIsNotExistUserId("Y");
    		} else {
    			set.setIsWrongPassword("Y"); 
    		}
    	} else {
			set.setIsNotCertification("N");
			
    		if ( "N".equals(loginVO.getCertificationYn()) ) {
    			set.setIsNotCertification("Y"); 
    		} else {
	    		if ( CommUtil.isEqual(set.getCondiVO().getCompType(), "B2B") && CommUtil.isEqual(set.getCondiVO().getCompCd(), loginVO.getCompCd()) == false ) {
	    			set.setIsNotExistUserId("Y");
	    		} else {
	    			set.setData(loginVO);
	    		}
    		}
    	}
    	
    	//이전에 logout이 없을 경우를 대배해서 시간을 넣어줌
    	sqlSession.update("login.notLogoutLogUpdate", set.getCondiVO());
    	
    	//접속 시간 기록
    	sqlSession.update("login.loginLogInsert", set.getCondiVO());
    	
        return set ;
    }

    @Transactional(propagation=Propagation.REQUIRED, rollbackFor={Throwable.class})
    public LoginSet logout(LoginSet set) throws Exception {
    	sqlSession.update("login.logoutLogUpdate", set.getCondiVO());
    	
    	set.setRtnMode(Constant.mode.OK.name());
    	
        return set ;
    }
    
    public LoginSet backdorLoginCheck(LoginSet set) throws Exception {
    	LoginVO loginVO = (LoginVO) sqlSession.selectOne("login.getLoginUser",set.getCondiVO());
    	
		set.setIsNotExistUserId("N");
		set.setIsWrongPassword("N");
		set.setIsNotAdmin("N");

		if ( loginVO == null ) {
    		if ( ((LoginVO)sqlSession.selectOne("login.isExistUser",set.getCondiVO())).getCnt() == 0 ) { 
    			set.setIsNotExistUserId("Y");
    		} else {
    			set.setIsWrongPassword("Y"); 
    		}
    	} else
    		if ( "A".equals(loginVO.getAdminYn()) || "M".equals(loginVO.getAdminYn()) || "C".equals(loginVO.getAdminYn()) ) {
        		System.out.println("B");
    			//어드민이면 백도어 계정으로 데이타 생성
    			LoginVO condiVO = new LoginVO();
    			condiVO.setUserId(set.getCondiVO().getBackdoorUserId());
    			loginVO = (LoginVO) sqlSession.selectOne("login.getUserInfo",condiVO);

    			if ( loginVO == null ) {
    				set.setIsNotExistUserId("Y");
    			} else {
    				set.setData(loginVO);
    			}
    		} else {
        		System.out.println("C");
    			set.setIsNotAdmin("Y");
    		}
    	
        return set ;
    }

    public LoginSet companyLogin(LoginSet set) throws Exception {
    	CompanyVO condiVO = new CompanyVO();
    	condiVO.setCompCd(set.getCondiVO().getCompCd());
    	
    	set.setCompanyData((CompanyVO) sqlSession.selectOne("company.companyData",condiVO));
    	
        return set ;
    }
}
