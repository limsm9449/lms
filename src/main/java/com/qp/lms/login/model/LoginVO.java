package com.qp.lms.login.model;

import com.qp.lms.common.CommonVO;

public class LoginVO extends CommonVO{
	private static final long serialVersionUID = -1l; 
	
	private String userId;
	private String userName;
	private String password;
	private String adminYn;
	private String siteManagerYn;
	private String contentsManagerYn;
	private String tutorYn;
	private String teacherYn;
	private String retiredYn;
	private String compCd;
	private String backdoorUserId;
	private String email;
	private String mobile;
	private String compName;
	private String c2cYn;
	private String compType;
	
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
	public String getSiteManagerYn() {
		return siteManagerYn;
	}
	public void setSiteManagerYn(String siteManagerYn) {
		this.siteManagerYn = siteManagerYn;
	}
	public String getContentsManagerYn() {
		return contentsManagerYn;
	}
	public void setContentsManagerYn(String contentsManagerYn) {
		this.contentsManagerYn = contentsManagerYn;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getMobile() {
		return mobile;
	}
	public void setMobile(String mobile) {
		this.mobile = mobile;
	}
	public String getCompName() {
		return compName;
	}
	public void setCompName(String compName) {
		this.compName = compName;
	}
	public String getC2cYn() {
		return c2cYn;
	}
	public void setC2cYn(String c2cYn) {
		this.c2cYn = c2cYn;
	}
	public String getCompType() {
		return compType;
	}
	public void setCompType(String compType) {
		this.compType = compType;
	}
	
	
	
	
	
	

}
