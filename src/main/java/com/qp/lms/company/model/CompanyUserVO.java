package com.qp.lms.company.model;

import com.qp.lms.common.CommonVO;

public class CompanyUserVO extends CommonVO {
	private static final long serialVersionUID = -1l; 

	
	private String compCd;
	private String userId;
	private String userName;
	private String tutorYn;
	private String email;
	private String tel;
	private String mobile;

	private String fUserName;		/** 검색 - 사용자명 */
	
	
	
	public String getCompCd() {
		return compCd;
	}
	public void setCompCd(String compCd) {
		this.compCd = compCd;
	}
	public String getUserId() {
		return userId;
	}
	public void setUserId(String userId) {
		this.userId = userId;
	}
	public String getUserName() {
		return userName;
	}
	public void setUserName(String userName) {
		this.userName = userName;
	}
	public String getTutorYn() {
		return tutorYn;
	}
	public void setTutorYn(String tutorYn) {
		this.tutorYn = tutorYn;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getTel() {
		return tel;
	}
	public void setTel(String tel) {
		this.tel = tel;
	}
	public String getMobile() {
		return mobile;
	}
	public void setMobile(String mobile) {
		this.mobile = mobile;
	}
	public static long getSerialversionuid() {
		return serialVersionUID;
	}
	public String getfUserName() {
		return fUserName;
	}
	public void setfUserName(String fUserName) {
		this.fUserName = fUserName;
	}

	
	
	

}
