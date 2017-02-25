package com.qp.lms.compManager.model;

import com.qp.lms.common.CommonVO;

public class CompUserVO extends CommonVO {
	private static final long serialVersionUID = -1l; 

	private String workerId;
	private String userId;
	private String userName;
	private String userPassword;
	private String email;	
	private String regNumber;	
	private String regNumber1;	
	private String regNumber2;	
	private String homeTel;	
	private String homeTel1;	
	private String homeTel2;	
	private String homeTel3;	
	private String mobile;	
	private String mobile1;	
	private String mobile2;	
	private String mobile3;	
	private String compCd;
	private String error;
	private String sex;
	private String birthDay;
	
	private String searchKind;
	private String searchStr;

	private String fileName;

	private String courseCnt;	//수강 과정 갯수
	
	public String getUserId() {
		return userId;
	}
	public void setUserId(String userId) {
		this.userId = userId;
	}
	public String getSearchStr() {
		return searchStr;
	}
	public void setSearchStr(String searchStr) {
		this.searchStr = searchStr;
	}
	public static long getSerialversionuid() {
		return serialVersionUID;
	}
	public String getFileName() {
		return fileName;
	}
	public void setFileName(String fileName) {
		this.fileName = fileName;
	}
	public String getUserName() {
		return userName;
	}
	public void setUserName(String userName) {
		this.userName = userName;
	}
	public String getUserPassword() {
		return userPassword;
	}
	public void setUserPassword(String userPassword) {
		this.userPassword = userPassword;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getRegNumber1() {
		return regNumber1;
	}
	public void setRegNumber1(String regNumber1) {
		this.regNumber1 = regNumber1;
	}
	public String getRegNumber2() {
		return regNumber2;
	}
	public void setRegNumber2(String regNumber2) {
		this.regNumber2 = regNumber2;
	}
	public String getHomeTel1() {
		return homeTel1;
	}
	public void setHomeTel1(String homeTel1) {
		this.homeTel1 = homeTel1;
	}
	public String getHomeTel2() {
		return homeTel2;
	}
	public void setHomeTel2(String homeTel2) {
		this.homeTel2 = homeTel2;
	}
	public String getHomeTel3() {
		return homeTel3;
	}
	public void setHomeTel3(String homeTel3) {
		this.homeTel3 = homeTel3;
	}
	public String getMobile1() {
		return mobile1;
	}
	public void setMobile1(String mobile1) {
		this.mobile1 = mobile1;
	}
	public String getMobile2() {
		return mobile2;
	}
	public void setMobile2(String mobile2) {
		this.mobile2 = mobile2;
	}
	public String getMobile3() {
		return mobile3;
	}
	public void setMobile3(String mobile3) {
		this.mobile3 = mobile3;
	}
	public String getCompCd() {
		return compCd;
	}
	public void setCompCd(String compCd) {
		this.compCd = compCd;
	}
	public String getRegNumber() {
		return regNumber;
	}
	public void setRegNumber(String regNumber) {
		this.regNumber = regNumber;
	}
	public String getHomeTel() {
		return homeTel;
	}
	public void setHomeTel(String homeTel) {
		this.homeTel = homeTel;
	}
	public String getMobile() {
		return mobile;
	}
	public void setMobile(String mobile) {
		this.mobile = mobile;
	}
	public String getWorkerId() {
		return workerId;
	}
	public void setWorkerId(String workerId) {
		this.workerId = workerId;
	}
	public String getError() {
		return error;
	}
	public void setError(String error) {
		this.error = error;
	}
	public String getCourseCnt() {
		return courseCnt;
	}
	public void setCourseCnt(String courseCnt) {
		this.courseCnt = courseCnt;
	}
	public String getSearchKind() {
		return searchKind;
	}
	public void setSearchKind(String searchKind) {
		this.searchKind = searchKind;
	}
	public String getSex() {
		return sex;
	}
	public void setSex(String sex) {
		this.sex = sex;
	}
	public String getBirthDay() {
		return birthDay;
	}
	public void setBirthDay(String birthDay) {
		this.birthDay = birthDay;
	}
	

}
