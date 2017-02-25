package com.qp.lms.postscript.model;

import com.qp.lms.common.CommonVO;

public class PostScriptVO extends CommonVO {

	private String courseId;
	private String contents;
	private String eval;
	private String categoryName;
	private String courseCode;
	private String courseName;
	private String userName;
	private String email;
	private String mobile;

	private String evalCnt10;
	private String evalCnt8;
	private String evalCnt6;
	private String evalCnt4;
	private String evalCnt2;
	private String evalAvg;
	
	private String c1Code;			/** 대분류 코드 */
	private String c2Code;			/** 중분류 코드 */
	private String c3Code;			/** 소분류 코드 */
	private String searchStr;
	private String searchKind;
	
	public String getCourseId() {
		return courseId;
	}
	public void setCourseId(String courseId) {
		this.courseId = courseId;
	}
	public String getContents() {
		return contents;
	}
	public void setContents(String contents) {
		this.contents = contents;
	}
	public String getEval() {
		return eval;
	}
	public void setEval(String eval) {
		this.eval = eval;
	}
	public String getCategoryName() {
		return categoryName;
	}
	public void setCategoryName(String categoryName) {
		this.categoryName = categoryName;
	}
	public String getCourseCode() {
		return courseCode;
	}
	public void setCourseCode(String courseCode) {
		this.courseCode = courseCode;
	}
	public String getCourseName() {
		return courseName;
	}
	public void setCourseName(String courseName) {
		this.courseName = courseName;
	}
	public String getEvalCnt10() {
		return evalCnt10;
	}
	public void setEvalCnt10(String evalCnt10) {
		this.evalCnt10 = evalCnt10;
	}
	public String getEvalCnt8() {
		return evalCnt8;
	}
	public void setEvalCnt8(String evalCnt8) {
		this.evalCnt8 = evalCnt8;
	}
	public String getEvalCnt6() {
		return evalCnt6;
	}
	public void setEvalCnt6(String evalCnt6) {
		this.evalCnt6 = evalCnt6;
	}
	public String getEvalCnt4() {
		return evalCnt4;
	}
	public void setEvalCnt4(String evalCnt4) {
		this.evalCnt4 = evalCnt4;
	}
	public String getEvalCnt2() {
		return evalCnt2;
	}
	public void setEvalCnt2(String evalCnt2) {
		this.evalCnt2 = evalCnt2;
	}
	public String getEvalAvg() {
		return evalAvg;
	}
	public void setEvalAvg(String evalAvg) {
		this.evalAvg = evalAvg;
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
	public String getSearchStr() {
		return searchStr;
	}
	public void setSearchStr(String searchStr) {
		this.searchStr = searchStr;
	}
	public String getSearchKind() {
		return searchKind;
	}
	public void setSearchKind(String searchKind) {
		this.searchKind = searchKind;
	}
	public String getUserName() {
		return userName;
	}
	public void setUserName(String userName) {
		this.userName = userName;
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

	

}
