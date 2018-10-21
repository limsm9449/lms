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

	private String tutorId;
	private int fromCnt;
	private int toCnt;
	private int reportSeq;

	private String c1Code;			/** 대분류 코드 */
	private String c2Code;			/** 중분류 코드 */
	private String c3Code;			/** 소분류 코드 */
	private String courseName;
	
	private String compCd;
	private String[] categorys;
	
	private String seq;
	private String findString;
	private String category;

	
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
	public String getCompCd() {
		return compCd;
	}
	public void setCompCd(String compCd) {
		this.compCd = compCd;
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
	public String[] getCategorys() {
		return categorys;
	}
	public void setCategorys(String[] categorys) {
		this.categorys = categorys;
	}
	public String getCategory() {
		return category;
	}
	public void setCategory(String category) {
		this.category = category;
	}
	
	
	

}
