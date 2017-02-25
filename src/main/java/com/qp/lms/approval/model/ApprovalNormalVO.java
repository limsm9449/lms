package com.qp.lms.approval.model;

import com.qp.lms.common.CommonVO;

public class ApprovalNormalVO extends CommonVO {
	private static final long serialVersionUID = -1l; 

	private String categoryName;
	
	private String c1Code;			/** 대분류 코드 */
	private String c2Code;			/** 중분류 코드 */
	private String c3Code;			/** 소분류 코드 */
	
	private String courseId;
	private String chasu;
	private String courseCode; 
	private String courseName;
	private String userId;
	private String userName; 
	private String paymentCost;
	private String paymentDate;
	private String paymentBank;
	
	private String refundBank;
	private String refundAccNum;
	private String refundCost;
	private String refundDate;

	
	
	
	public String getCourseId() {
		return courseId;
	}
	public void setCourseId(String courseId) {
		this.courseId = courseId;
	}
	public String getCourseName() {
		return courseName;
	}
	public void setCourseName(String courseName) {
		this.courseName = courseName;
	}
	public String getCategoryName() {
		return categoryName;
	}
	public void setCategoryName(String categoryName) {
		this.categoryName = categoryName;
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
	public String getChasu() {
		return chasu;
	}
	public void setChasu(String chasu) {
		this.chasu = chasu;
	}
	public String getCourseCode() {
		return courseCode;
	}
	public void setCourseCode(String courseCode) {
		this.courseCode = courseCode;
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
	public static long getSerialversionuid() {
		return serialVersionUID;
	}
	public String getRefundBank() {
		return refundBank;
	}
	public void setRefundBank(String refundBank) {
		this.refundBank = refundBank;
	}
	public String getRefundAccNum() {
		return refundAccNum;
	}
	public void setRefundAccNum(String refundAccNum) {
		this.refundAccNum = refundAccNum;
	}
	public String getRefundCost() {
		return refundCost;
	}
	public void setRefundCost(String refundCost) {
		this.refundCost = refundCost;
	}
	public String getRefundDate() {
		return refundDate;
	}
	public void setRefundDate(String refundDate) {
		this.refundDate = refundDate;
	}
	public String getPaymentBank() {
		return paymentBank;
	}
	public void setPaymentBank(String paymentBank) {
		this.paymentBank = paymentBank;
	}

	

}
