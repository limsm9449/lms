package com.qp.lms.course.model;

import com.qp.lms.common.CommonVO;

public class CourseManageVO extends CommonVO {
	private static final long serialVersionUID = -1l; 

	private String categoryName;
	
	private String c1Code;			/** 대분류 코드 */
	private String c2Code;			/** 중분류 코드 */
	private String c3Code;			/** 소분류 코드 */
	
	private String courseId;
	private String courseCode;
	private String courseName;
	private String tutorId; 
	private String tutorName;
	private int chasu;
	private String courseCost;
	private String gFromDate;
	private String gToDate;
	private String cFromDate;
	private String cToDate;
	private String yCnt;
	private String aCnt;
	private String rCnt;
	private String cPeriod;
	private String openYn;
	private String status;
	private String statusName;
	private String learingGoal;
	private String learingContent; 
	private String evalMethod;
	private String learingTarget;
	private String learingCost;
	private String reportRate;
	private String examRate;
	private String discussionRate;
	private String progressRate;

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

	public int getChasu() {
		return chasu;
	}

	public void setChasu(int chasu) {
		this.chasu = chasu;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public String getLearingGoal() {
		return learingGoal;
	}

	public void setLearingGoal(String learingGoal) {
		this.learingGoal = learingGoal;
	}

	public String getLearingContent() {
		return learingContent;
	}

	public void setLearingContent(String learingContent) {
		this.learingContent = learingContent;
	}

	public String getEvalMethod() {
		return evalMethod;
	}

	public void setEvalMethod(String evalMethod) {
		this.evalMethod = evalMethod;
	}

	public String getLearingTarget() {
		return learingTarget;
	}

	public void setLearingTarget(String learingTarget) {
		this.learingTarget = learingTarget;
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

	public String getCourseName() {
		return courseName;
	}

	public void setCourseName(String courseName) {
		this.courseName = courseName;
	}

	public String getTutorId() {
		return tutorId;
	}

	public void setTutorId(String tutorId) {
		this.tutorId = tutorId;
	}

	public String getTutorName() {
		return tutorName;
	}

	public void setTutorName(String tutorName) {
		this.tutorName = tutorName;
	}

	public String getgFromDate() {
		return gFromDate;
	}

	public void setgFromDate(String gFromDate) {
		this.gFromDate = gFromDate;
	}

	public String getgToDate() {
		return gToDate;
	}

	public void setgToDate(String gToDate) {
		this.gToDate = gToDate;
	}

	public String getcFromDate() {
		return cFromDate;
	}

	public void setcFromDate(String cFromDate) {
		this.cFromDate = cFromDate;
	}

	public String getcToDate() {
		return cToDate;
	}

	public void setcToDate(String cToDate) {
		this.cToDate = cToDate;
	}

	public String getyCnt() {
		return yCnt;
	}

	public void setyCnt(String yCnt) {
		this.yCnt = yCnt;
	}

	public String getaCnt() {
		return aCnt;
	}

	public void setaCnt(String aCnt) {
		this.aCnt = aCnt;
	}

	public String getrCnt() {
		return rCnt;
	}

	public void setrCnt(String rCnt) {
		this.rCnt = rCnt;
	}

	public String getStatusName() {
		return statusName;
	}

	public void setStatusName(String statusName) {
		this.statusName = statusName;
	}

	public String getReportRate() {
		return reportRate;
	}

	public void setReportRate(String reportRate) {
		this.reportRate = reportRate;
	}

	public String getCourseCost() {
		return courseCost;
	}

	public void setCourseCost(String courseCost) {
		this.courseCost = courseCost;
	}

	public String getLearingCost() {
		return learingCost;
	}

	public void setLearingCost(String learingCost) {
		this.learingCost = learingCost;
	}

	public String getExamRate() {
		return examRate;
	}

	public void setExamRate(String examRate) {
		this.examRate = examRate;
	}

	public String getDiscussionRate() {
		return discussionRate;
	}

	public void setDiscussionRate(String discussionRate) {
		this.discussionRate = discussionRate;
	}

	public String getProgressRate() {
		return progressRate;
	}

	public void setProgressRate(String progressRate) {
		this.progressRate = progressRate;
	}

	public static long getSerialversionuid() {
		return serialVersionUID;
	}

	public String getcPeriod() {
		return cPeriod;
	}

	public void setcPeriod(String cPeriod) {
		this.cPeriod = cPeriod;
	}

	public String getOpenYn() {
		return openYn;
	}

	public void setOpenYn(String openYn) {
		this.openYn = openYn;
	}

	
	

}
