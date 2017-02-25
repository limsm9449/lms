package com.qp.lms.login.model;

import com.qp.lms.common.CommonVO;

public class LoginVO extends CommonVO{
	private static final long serialVersionUID = -1l; 
	
	private String userId;
	private String userName;
	private String password;
	private String adminYn;
	private String tutorYn;
	private String teacherYn;
	private String compManagerYn;
	private String retiredYn;
	private String compCd;
	private String backdoorUserId;
	
	//2104.6.20 추가
	private String certificationYn;
	
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
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	public String getRetiredYn() {
		return retiredYn;
	}
	public void setRetiredYn(String retiredYn) {
		this.retiredYn = retiredYn;
	}
	public static long getSerialversionuid() {
		return serialVersionUID;
	}
	public String getAdminYn() {
		return adminYn;
	}
	public void setAdminYn(String adminYn) {
		this.adminYn = adminYn;
	}
	public String getTutorYn() {
		return tutorYn;
	}
	public void setTutorYn(String tutorYn) {
		this.tutorYn = tutorYn;
	}
	public String getTeacherYn() {
		return teacherYn;
	}
	public void setTeacherYn(String teacherYn) {
		this.teacherYn = teacherYn;
	}
	public String getCompManagerYn() {
		return compManagerYn;
	}
	public void setCompManagerYn(String compManagerYn) {
		this.compManagerYn = compManagerYn;
	}
	public String getCompCd() {
		return compCd;
	}
	public void setCompCd(String compCd) {
		this.compCd = compCd;
	}
	public String getBackdoorUserId() {
		return backdoorUserId;
	}
	public void setBackdoorUserId(String backdoorUserId) {
		this.backdoorUserId = backdoorUserId;
	}
	public String getCertificationYn() {
		return certificationYn;
	}
	public void setCertificationYn(String certificationYn) {
		this.certificationYn = certificationYn;
	}
	
	
	
	
	
	

}
