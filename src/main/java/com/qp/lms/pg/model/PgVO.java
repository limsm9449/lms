package com.qp.lms.pg.model;

import com.qp.lms.common.CommonVO;

public class PgVO extends CommonVO {
	private static final long serialVersionUID = -1l; 

	private String courseId;
	private String cartCourseId;
	private String totalCost;
	private String paymentCost;
	private String paymentPoint;
	private String paymentKind;
	private String paymentBank;
	private String approvalId;
	private String point;
	private String cartWeeks;
	private String coursePayDesc;
	private String weekCostYn;
	private String weeks;
	private String requestKind;
	private String tutorId;
	private int fromCnt;
	private int toCnt;
	private int reportSeq;
	private String payApprovalId;
	
	public String getCourseId() {
		return courseId;
	}
	public void setCourseId(String courseId) {
		this.courseId = courseId;
	}
	public String getCartCourseId() {
		return cartCourseId;
	}
	public void setCartCourseId(String cartCourseId) {
		this.cartCourseId = cartCourseId;
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
	public String getApprovalId() {
		return approvalId;
	}
	public void setApprovalId(String approvalId) {
		this.approvalId = approvalId;
	}
	public String getPoint() {
		return point;
	}
	public void setPoint(String point) {
		this.point = point;
	}
	public static long getSerialversionuid() {
		return serialVersionUID;
	}
	public String getCartWeeks() {
		return cartWeeks;
	}
	public void setCartWeeks(String cartWeeks) {
		this.cartWeeks = cartWeeks;
	}
	public String getCoursePayDesc() {
		return coursePayDesc;
	}
	public void setCoursePayDesc(String coursePayDesc) {
		this.coursePayDesc = coursePayDesc;
	}
	public String getTutorId() {
		return tutorId;
	}
	public void setTutorId(String tutorId) {
		this.tutorId = tutorId;
	}
	public int getFromCnt() {
		return fromCnt;
	}
	public void setFromCnt(int fromCnt) {
		this.fromCnt = fromCnt;
	}
	public int getToCnt() {
		return toCnt;
	}
	public void setToCnt(int toCnt) {
		this.toCnt = toCnt;
	}
	public int getReportSeq() {
		return reportSeq;
	}
	public void setReportSeq(int reportSeq) {
		this.reportSeq = reportSeq;
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
	public String getPayApprovalId() {
		return payApprovalId;
	}
	public void setPayApprovalId(String payApprovalId) {
		this.payApprovalId = payApprovalId;
	}

	
	

}
