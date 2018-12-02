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
	private String c2cYn;
	private String[] categorys;
	
	private String seq;
	private String findString;
	private String category;
	private String shap;
	private String userName;
	private String mobile;
	private String tel;
	private String email;
	private String contents;
	private String aboutMe;
	private String motive;
	private String companyName;
	private String attachUserId;
	private String title;
	private String orderKind;
	private String workerCardYn;
	private String supportEmployerYn;
	private String normalCourseYn;

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
	public String getShap() {
		return shap;
	}
	public void setShap(String shap) {
		this.shap = shap;
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
	public String getTel() {
		return tel;
	}
	public void setTel(String tel) {
		this.tel = tel;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getContents() {
		return contents;
	}
	public void setContents(String contents) {
		this.contents = contents;
	}
	public String getAboutMe() {
		return aboutMe;
	}
	public void setAboutMe(String aboutMe) {
		this.aboutMe = aboutMe;
	}
	public String getMotive() {
		return motive;
	}
	public void setMotive(String motive) {
		this.motive = motive;
	}
	public String getCompanyName() {
		return companyName;
	}
	public void setCompanyName(String companyName) {
		this.companyName = companyName;
	}
	public String getAttachUserId() {
		return attachUserId;
	}
	public void setAttachUserId(String attachUserId) {
		this.attachUserId = attachUserId;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getC2cYn() {
		return c2cYn;
	}
	public void setC2cYn(String c2cYn) {
		this.c2cYn = c2cYn;
	}
	public String getOrderKind() {
		return orderKind;
	}
	public void setOrderKind(String orderKind) {
		this.orderKind = orderKind;
	}
	public String getWorkerCardYn() {
		return workerCardYn;
	}
	public void setWorkerCardYn(String workerCardYn) {
		this.workerCardYn = workerCardYn;
	}
	public String getSupportEmployerYn() {
		return supportEmployerYn;
	}
	public void setSupportEmployerYn(String supportEmployerYn) {
		this.supportEmployerYn = supportEmployerYn;
	}
	public String getNormalCourseYn() {
		return normalCourseYn;
	}
	public void setNormalCourseYn(String normalCourseYn) {
		this.normalCourseYn = normalCourseYn;
	}
	
	
	

}
