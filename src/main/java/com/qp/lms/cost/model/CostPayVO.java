package com.qp.lms.cost.model;

import com.qp.lms.common.CommonVO;

public class CostPayVO extends CommonVO {
	private static final long serialVersionUID = -1l; 
	
	private String c1Code;			/** 대분류 코드 */
	private String c2Code;			/** 중분류 코드 */
	private String c3Code;			/** 소분류 코드 */
	
	private String categoryName;
	private String courseId;
	private String courseCode;
	private String courseName;
	private String courseKindName;
	private String chasu;
	private String userId;
	private String userName;
	
	private String totalCost;
	private String paymentCost;
	private String companyCost;
	private String tutorCost;
	private String teacherCost;
	private String costId;
	private String teacherName;
	private String teacherBank;
	private String teacherAccNum;
	private String tutorName;
	private String tutorBank;
	private String tutorAccNum;
	private String paymentDate;
	
	private String email;
	private String mobile;

	public String getCourseCode() {
		return courseCode;
	}
	public static long getSerialVersionUID() {
		return serialVersionUID;
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
	public String getCategoryName() {
		return categoryName;
	}
	public void setCategoryName(String categoryName) {
		this.categoryName = categoryName;
	}
	public String getCourseId() {
		return courseId;
	}
	public void setCourseId(String courseId) {
		this.courseId = courseId;
	}
	public String getCourseKindName() {
		return courseKindName;
	}
	public void setCourseKindName(String courseKindName) {
		this.courseKindName = courseKindName;
	}
	public String getChasu() {
		return chasu;
	}
	public void setChasu(String chasu) {
		this.chasu = chasu;
	}
	public static long getSerialversionuid() {
		return serialVersionUID;
	}
	public String getCompanyCost() {
		return companyCost;
	}
	public void setCompanyCost(String companyCost) {
		this.companyCost = companyCost;
	}
	public String getTutorCost() {
		return tutorCost;
	}
	public void setTutorCost(String tutorCost) {
		this.tutorCost = tutorCost;
	}
	public String getTeacherCost() {
		return teacherCost;
	}
	public void setTeacherCost(String teacherCost) {
		this.teacherCost = teacherCost;
	}
	public String getCostId() {
		return costId;
	}
	public void setCostId(String costId) {
		this.costId = costId;
	}
	public String getTeacherBank() {
		return teacherBank;
	}
	public void setTeacherBank(String teacherBank) {
		this.teacherBank = teacherBank;
	}
	public String getTeacherAccNum() {
		return teacherAccNum;
	}
	public void setTeacherAccNum(String teacherAccNum) {
		this.teacherAccNum = teacherAccNum;
	}
	public String getTutorBank() {
		return tutorBank;
	}
	public void setTutorBank(String tutorBank) {
		this.tutorBank = tutorBank;
	}
	public String getTutorAccNum() {
		return tutorAccNum;
	}
	public void setTutorAccNum(String tutorAccNum) {
		this.tutorAccNum = tutorAccNum;
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
	public String getTeacherName() {
		return teacherName;
	}
	public void setTeacherName(String teacherName) {
		this.teacherName = teacherName;
	}
	public String getTutorName() {
		return tutorName;
	}
	public void setTutorName(String tutorName) {
		this.tutorName = tutorName;
	}
	public String getTotalCost() {
		return totalCost;
	}
	public void setTotalCost(String totalCost) {
		this.totalCost = totalCost;
	}
	public String getPaymentCost() {
		return paymentCost;
	}
	public void setPaymentCost(String paymentCost) {
		this.paymentCost = paymentCost;
	}
	public String getPaymentDate() {
		return paymentDate;
	}
	public void setPaymentDate(String paymentDate) {
		this.paymentDate = paymentDate;
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
