package com.qp.lms.login.model;

import java.util.List;

import com.qp.lms.common.CommonSet;
import com.qp.lms.company.model.CompanyVO;
import com.qp.lms.course.model.CourseVO;

public class LoginSet extends CommonSet {
	private LoginVO condiVO;		// 조건용
	private LoginVO data;			// 데이타용
	private String isWrongPassword;
	private String isNotExistUserId;
	private String isNotExistBackdoorUserId;
	private String isNotAuth;
	private String isNotAdmin;
	private String isNotCertification;
	
	private CompanyVO companyData;
	
	public String getIsWrongPassword() {
		return isWrongPassword;
	}

	public void setIsWrongPassword(String isWrongPassword) {
		this.isWrongPassword = isWrongPassword;
	}

	public String getIsNotExistUserId() {
		return isNotExistUserId;
	}

	public void setIsNotExistUserId(String isNotExistUserId) {
		this.isNotExistUserId = isNotExistUserId;
	}

	public LoginVO getCondiVO() {
		return condiVO;
	}

	public void setCondiVO(LoginVO condiVO) {
		this.condiVO = condiVO;
	}

	public LoginVO getData() {
		return data;
	}

	public void setData(LoginVO data) {
		this.data = data;
	}

	public String getIsNotAuth() {
		return isNotAuth;
	}

	public void setIsNotAuth(String isNotAuth) {
		this.isNotAuth = isNotAuth;
	}

	public CompanyVO getCompanyData() {
		return companyData;
	}

	public void setCompanyData(CompanyVO companyData) {
		this.companyData = companyData;
	}

	public String getIsNotAdmin() {
		return isNotAdmin;
	}

	public void setIsNotAdmin(String isNotAdmin) {
		this.isNotAdmin = isNotAdmin;
	}

	public String getIsNotExistBackdoorUserId() {
		return isNotExistBackdoorUserId;
	}

	public void setIsNotExistBackdoorUserId(String isNotExistBackdoorUserId) {
		this.isNotExistBackdoorUserId = isNotExistBackdoorUserId;
	}

	public String getIsNotCertification() {
		return isNotCertification;
	}

	public void setIsNotCertification(String isNotCertification) {
		this.isNotCertification = isNotCertification;
	}

	

}
