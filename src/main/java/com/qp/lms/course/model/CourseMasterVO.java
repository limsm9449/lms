package com.qp.lms.course.model;

import com.qp.lms.common.CommonVO;

public class CourseMasterVO extends CommonVO {
	private static final long serialVersionUID = -1l; 

	private String courseCode;
	private String courseName;
	private String tutorId; 
	private String tutorName;
	private String learingGoal;
	private String learingContent; 
	private String learingCost;
	private String courseCost;
	private String evalMethod;
	private String learingTarget;
	private String reportRate;
	private String examRate;
	private String discussionRate;
	private String progressRate;
	
	private String categoryName;
	
	private String c1Code;			/** 대분류 코드 */
	private String c2Code;			/** 중분류 코드 */
	private String c3Code;			/** 소분류 코드 */

	//2014.6.16
	private String title;
	private String week;
	private String[] weeks;
	private String weekCost;
	private String[] weekCosts;
	private String weekCostYn;
	private String weekCostYnName;
	private String promotionVideoYn;

	
	
	public String getCourseCode() {
		return courseCode;
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
	public static long getSerialversionuid() {
		return serialVersionUID;
	}
	public String getCategoryName() {
		return categoryName;
	}
	public void setCategoryName(String categoryName) {
		this.categoryName = categoryName;
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
	public String getLearingCost() {
		return learingCost;
	}
	public void setLearingCost(String learingCost) {
		this.learingCost = learingCost;
	}
	public String getCourseCost() {
		return courseCost;
	}
	public void setCourseCost(String courseCost) {
		this.courseCost = courseCost;
	}
	public String[] getWeekCosts() {
		return weekCosts;
	}
	public void setWeekCosts(String[] weekCosts) {
		this.weekCosts = weekCosts;
	}
	public String getWeekCost() {
		return weekCost;
	}
	public void setWeekCost(String weekCost) {
		this.weekCost = weekCost;
	}
	public String getWeek() {
		return week;
	}
	public void setWeek(String week) {
		this.week = week;
	}
	public String[] getWeeks() {
		return weeks;
	}
	public void setWeeks(String[] weeks) {
		this.weeks = weeks;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
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
	public String getPromotionVideoYn() {
		return promotionVideoYn;
	}
	public void setPromotionVideoYn(String promotionVideoYn) {
		this.promotionVideoYn = promotionVideoYn;
	}
	

	
	

	
	

}
