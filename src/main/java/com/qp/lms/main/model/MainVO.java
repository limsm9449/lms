package com.qp.lms.main.model;

import com.qp.lms.common.CommonVO;

public class MainVO extends CommonVO {
	private static final long serialVersionUID = -1l; 

	private String userId;
	private String courseId;
	private String cartCourseId;
	private String totalCost;
	private String paymentCost;
	private String paymentPoint;
	private String paymentKind;
	private String paymentBank;
	private String approvalId;
	private String isLogin;

	//2014.6.17 추가
	private String weekCostYn;
	private String weeks;
	private String requestKind;
	private String cartWeeks;
	
	//2014.6.28 추가
	private String point;
	
	public String getCourseId() {
		return courseId;
	}
	public void setCourseId(String courseId) {
		this.courseId = courseId;
	}
	public static long getSerialversionuid() {
		return serialVersionUID;
	}
	public String getUserId() {
		return userId;
	}
	public void setUserId(String userId) {
		this.userId = userId;
	}
	public String getPaymentCost() {
		return paymentCost;
	}
	public void setPaymentCost(String paymentCost) {
		this.paymentCost = paymentCost;
	}
	public String getPaymentPoint() {
		return paymentPoint;
	}
	public void setPaymentPoint(String paymentPoint) {
		this.paymentPoint = paymentPoint;
	}
	public String getPaymentKind() {
		return paymentKind;
	}
	public void setPaymentKind(String paymentKind) {
		this.paymentKind = paymentKind;
	}
	public String getPaymentBank() {
		return paymentBank;
	}
	public void setPaymentBank(String paymentBank) {
		this.paymentBank = paymentBank;
	}
	public String getTotalCost() {
		return totalCost;
	}
	public void setTotalCost(String totalCost) {
		this.totalCost = totalCost;
	}
	public String getApprovalId() {
		return approvalId;
	}
	public void setApprovalId(String approvalId) {
		this.approvalId = approvalId;
	}
	public String getCartCourseId() {
		return cartCourseId;
	}
	public void setCartCourseId(String cartCourseId) {
		this.cartCourseId = cartCourseId;
	}
	public String getIsLogin() {
		return isLogin;
	}
	public void setIsLogin(String isLogin) {
		this.isLogin = isLogin;
	}
	public String getWeekCostYn() {
		return weekCostYn;
	}
	public void setWeekCostYn(String weekCostYn) {
		this.weekCostYn = weekCostYn;
	}
	public String getWeeks() {
		return weeks;
	}
	public void setWeeks(String weeks) {
		this.weeks = weeks;
	}
	public String getRequestKind() {
		return requestKind;
	}
	public void setRequestKind(String requestKind) {
		this.requestKind = requestKind;
	}
	public String getCartWeeks() {
		return cartWeeks;
	}
	public void setCartWeeks(String cartWeeks) {
		this.cartWeeks = cartWeeks;
	}
	public String getPoint() {
		return point;
	}
	public void setPoint(String point) {
		this.point = point;
	}
	
	
	

}
