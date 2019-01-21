package com.qp.lms.user.model;

import com.qp.lms.common.CommonVO;

public class UserVO extends CommonVO {
	private static final long serialVersionUID = -1l; 

	private String courseCode;
	private String courseId;

	private String screen;
	
	//2014.7.20
	private String userName;
	private String mobile;
	private String email;
	private String counselCnt;
	
	//2014.7.27
	private String seq;
	private String answerSeq;
	private String findString;
	private String contents;
	private String title;
	
	//2014.7.30
	private String category;
	private String pageUrl;
	
	//2014.8.3
	private String c1Code;			/** 대분류 코드 */
	private String c2Code;			/** 중분류 코드 */
	private String c3Code;			/** 소분류 코드 */
	private String courseName;
	
	//2014.8.17
	private String approvalId;
	
	//2014.9.13
	private String isLogin;
	
	private String compCd;
	
	public String getCourseCode() {
		return courseCode;
	}

	public void setCourseCode(String courseCode) {
		this.courseCode = courseCode;
	}

	public String getCourseId() {
		return courseId;
	}

	public void setCourseId(String courseId) {
		this.courseId = courseId;
	}

	public String getScreen() {
		return screen;
	}

	public void setScreen(String screen) {
		this.screen = screen;
	}

	public static long getSerialversionuid() {
		return serialVersionUID;
	}

	public String getUserName() {
		return userName;
	}

	public void setUserName(String userName) {
		this.userName = userName;
	}

	public String getMobile() {
		return mobile;
	}

	public void setMobile(String mobile) {
		this.mobile = mobile;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getCounselCnt() {
		return counselCnt;
	}

	public void setCounselCnt(String counselCnt) {
		this.counselCnt = counselCnt;
	}

	public String getSeq() {
		return seq;
	}

	public void setSeq(String seq) {
		this.seq = seq;
	}

	public String getFindString() {
		return findString;
	}

	public void setFindString(String findString) {
		this.findString = findString;
	}

	public String getContents() {
		return contents;
	}

	public void setContents(String contents) {
		this.contents = contents;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getAnswerSeq() {
		return answerSeq;
	}

	public void setAnswerSeq(String answerSeq) {
		this.answerSeq = answerSeq;
	}

	public String getCategory() {
		return category;
	}

	public void setCategory(String category) {
		this.category = category;
	}

	public String getPageUrl() {
		return pageUrl;
	}

	public void setPageUrl(String pageUrl) {
		this.pageUrl = pageUrl;
	}

	public String getC1Code() {
		return c1Code;
	}

	public void setC1Code(String c1Code) {
		this.c1Code = c1Code;
	}

	public String getC2Code() {
		return c2Code;
	}

	public void setC2Code(String c2Code) {
		this.c2Code = c2Code;
	}

	public String getC3Code() {
		return c3Code;
	}

	public void setC3Code(String c3Code) {
		this.c3Code = c3Code;
	}

	public String getCourseName() {
		return courseName;
	}

	public void setCourseName(String courseName) {
		this.courseName = courseName;
	}

	public String getApprovalId() {
		return approvalId;
	}

	public void setApprovalId(String approvalId) {
		this.approvalId = approvalId;
	}

	public String getIsLogin() {
		return isLogin;
	}

	public void setIsLogin(String isLogin) {
		this.isLogin = isLogin;
	}

	public String getCompCd() {
		return compCd;
	}

	public void setCompCd(String compCd) {
		this.compCd = compCd;
	}



}
