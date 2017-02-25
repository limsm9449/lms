package com.qp.lms.home.model;

import com.qp.lms.common.CommonSet;
import com.qp.lms.common.SessionVO;
import com.qp.lms.login.model.LoginVO;



public class HomeSet extends CommonSet {
	private HomeVO condiVO;
	private HomeVO data;
	private String compManagerYn;
	private SessionVO sessionVO;
	
	private LoginVO loginVO;
	

	public String getCompManagerYn() {
		return compManagerYn;
	}
	public void setCompManagerYn(String compManagerYn) {
		this.compManagerYn = compManagerYn;
	}
	public SessionVO getSessionVO() {
		return sessionVO;
	}
	public void setSessionVO(SessionVO sessionVO) {
		this.sessionVO = sessionVO;
	}
	public HomeVO getCondiVO() {
		return condiVO;
	}
	public void setCondiVO(HomeVO condiVO) {
		this.condiVO = condiVO;
	}
	public HomeVO getData() {
		return data;
	}
	public void setData(HomeVO data) {
		this.data = data;
	}
	public LoginVO getLoginVO() {
		return loginVO;
	}
	public void setLoginVO(LoginVO loginVO) {
		this.loginVO = loginVO;
	}
	
	
	

	

}
