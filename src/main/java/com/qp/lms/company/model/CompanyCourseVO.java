package com.qp.lms.company.model;

import com.qp.lms.common.CommonVO;

public class CompanyCourseVO extends CommonVO {
	private static final long serialVersionUID = -1l; 

	private String categoryName;
	
	private String c1Code;			/** 대분류 코드 */
	private String c2Code;			/** 중분류 코드 */
	private String c3Code;			/** 소분류 코드 */
	
	private String courseId;
	private String courseCode;
	private String courseName;
	private String compCd; 
	private String compName;
	private String tutorId; 
	private String tutorName;
	private int chasu;
	private String courseCost;
	private String cPeriod;
	private String openYn;
	private String yCnt;
	private String aCnt;
	private String rCnt;
	
	
	
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

	private String hPx;
	private String vPx;

	private String week;
	private String title;
	
	//2014.6.16
	private String[] weeks;
	private String weekCost;
	private String[] weekCosts;
	private String weekCostYn;
	private String weekCostYnName;
	


	public String getCourseCode() {
		return courseCode;
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


	public String getCompCd() {
		return compCd;
	}


	public void setCompCd(String compCd) {
		this.compCd = compCd;
	}


	public String getCompName() {
		return compName;
	}


	public void setCompName(String compName) {
		this.compName = compName;
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


	public int getChasu() {
		return chasu;
	}


	public void setChasu(int chasu) {
		this.chasu = chasu;
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


	public String getLearingCost() {
		return learingCost;
	}


	public void setLearingCost(String learingCost) {
		this.learingCost = learingCost;
	}


	public String getReportRate() {
		return reportRate;
	}


	public void setReportRate(String reportRate) {
		this.reportRate = reportRate;
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


	public void setCourseCode(String courseCode) {
		this.courseCode = courseCode;
	}


	public String getCourseCost() {
		return courseCost;
	}


	public void setCourseCost(String courseCost) {
		this.courseCost = courseCost;
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


	public String gethPx() {
		return hPx;
	}


	public void sethPx(String hPx) {
		this.hPx = hPx;
	}


	public String getvPx() {
		return vPx;
	}


	public void setvPx(String vPx) {
		this.vPx = vPx;
	}


	public String getWeek() {
		return week;
	}


	public void setWeek(String week) {
		this.week = week;
	}


	public String getTitle() {
		return title;
	}


	public void setTitle(String title) {
		this.title = title;
	}


	public String[] getWeeks() {
		return weeks;
	}


	public void setWeeks(String[] weeks) {
		this.weeks = weeks;
	}


	public String getWeekCost() {
		return weekCost;
	}


	public void setWeekCost(String weekCost) {
		this.weekCost = weekCost;
	}


	public String[] getWeekCosts() {
		return weekCosts;
	}


	public void setWeekCosts(String[] weekCosts) {
		this.weekCosts = weekCosts;
	}


	public String getWeekCostYn() {
		return weekCostYn;
	}


	public void setWeekCostYn(String weekCostYn) {
		this.weekCostYn = weekCostYn;
	}


	public String getWeekCostYnName() {
		return weekCostYnName;
	}


	public void setWeekCostYnName(String weekCostYnName) {
		this.weekCostYnName = weekCostYnName;
	}

	
	

}
