package com.qp.lms.course.model;

import com.qp.lms.common.CommonVO;

public class RegisterVO extends CommonVO {
	private static final long serialVersionUID = -1l; 
	
	private String courseId;
	private String userId;
	private String userKind;
	private String userName;
	private String status;
	private String statusName;
	private String paymentKind;
	private String paymentCost;
	private String bank;
	private String paymentDate;
	private String refundCost;
	private String refundDate;
	private String refundBank;
	private String refuncAccNum;
	
	private String email;
	private String homeTel;
	private String mobile;
	private String sex;
	private String sexName;
	private String birthDay;
     
	
	public String getCourseId() {
		return courseId;
	}
	public void setCourseId(String courseId) {
		this.courseId = courseId;
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
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	public String getStatusName() {
		return statusName;
	}
	public void setStatusName(String statusName) {
		this.statusName = statusName;
	}
	public String getUserKind() {
		return userKind;
	}
	public void setUserKind(String userKind) {
		this.userKind = userKind;
	}
	public String getPaymentKind() {
		return paymentKind;
	}
	public void setPaymentKind(String paymentKind) {
		this.paymentKind = paymentKind;
	}
	public String getPaymentCost() {
		return paymentCost;
	}
	public void setPaymentCost(String paymentCost) {
		this.paymentCost = paymentCost;
	}
	public String getBank() {
		return bank;
	}
	public void setBank(String bank) {
		this.bank = bank;
	}
	public String getPaymentDate() {
		return paymentDate;
	}
	public void setPaymentDate(String paymentDate) {
		this.paymentDate = paymentDate;
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
	public String getRefundBank() {
		return refundBank;
	}
	public void setRefundBank(String refundBank) {
		this.refundBank = refundBank;
	}
	public String getRefuncAccNum() {
		return refuncAccNum;
	}
	public void setRefuncAccNum(String refuncAccNum) {
		this.refuncAccNum = refuncAccNum;
	}
	public static long getSerialversionuid() {
		return serialVersionUID;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
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
	public String getSexName() {
		return sexName;
	}
	public void setSexName(String sexName) {
		this.sexName = sexName;
	}
	

	

}
