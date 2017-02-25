package com.qp.lms.home.service;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.qp.lms.common.SessionUtil;
import com.qp.lms.home.model.HomeSet;
import com.qp.lms.login.model.LoginVO;

@Service
public class HomeService {

	@Autowired
	private SqlSession sqlSession;

    public HomeSet aLeft(HomeSet set) throws Exception {
    	LoginVO condiVO = new LoginVO();
    	condiVO.setUserId(SessionUtil.getSessionUserId());

    	set.setLoginVO((LoginVO) sqlSession.selectOne("login.getUserInfo",condiVO));
    	
        return set ;
    }

}
