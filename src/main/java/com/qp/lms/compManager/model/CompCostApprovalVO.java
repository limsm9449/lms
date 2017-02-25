package com.qp.lms.compManager.model;

import com.qp.lms.common.CommonVO;

public class CompCostApprovalVO extends CommonVO {
	private static final long serialVersionUID = -1l; 
	
	private String approvalId;
	private String totalCost;
	private String paymentPoint;
	private String paymentCost;
	private String paymentBank;
	private String paymentDate;
	private String paymentKind;
	private String courseName;
	
	public String getApprovalId() {
		return approvalId;
	}
	public void setApprovalId(String approvalId) {
		this.approvalId = approvalId;
	}
	public String getTotalCost() {
		return totalCost;
	}
	public void setTotalCost(String totalCost) {
		this.totalCost = totalCost;
	}
	public String getPaymentPoint() {
		return paymentPoint;
	}
	public void setPaymentPoint(String paymentPoint) {
		this.paymentPoint = paymentPoint;
	}
	public String getPaymentCost() {
		return paymentCost;
	}
	public void setPaymentCost(String paymentCost) {
		this.paymentCost = paymentCost;
	}
	public String getPaymentBank() {
		return paymentBank;
	}
	public void setPaymentBank(String paymentBank) {
		this.paymentBank = paymentBank;
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
	public String getPaymentKind() {
		return paymentKind;
	}
	public void setPaymentKind(String paymentKind) {
		this.paymentKind = paymentKind;
	}
	public String getCourseName() {
		return courseName;
	}
	public void setCourseName(String courseName) {
		this.courseName = courseName;
	}
		
	

}
