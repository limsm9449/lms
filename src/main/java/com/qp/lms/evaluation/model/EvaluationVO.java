package com.qp.lms.evaluation.model;

import com.qp.lms.common.CommonVO;

public class EvaluationVO extends CommonVO {
	private static long serialVersionUID = -1l; 
	
	private String categoryName;
	
	private String c1Code;			/** 대분류 코드 */
	private String c2Code;			/** 중분류 코드 */
	private String c3Code;			/** 소분류 코드 */
	
	private String courseId;
	private String courseCode;
	private String courseName;
	private String userId;
	private String userName;
	private int chasu;
	private int report;
	private int exam;
	private int discussion;
	private int progress;
	private int total;
	private int reportCnt;
	private int examCnt;
	private int discussionCnt;
	private int progressCnt;
	private int totalCnt;
	private int week;
	private int page;
	private String studyStart;
	private String studyEnd;
	private String completeYn;
	private String title;

	private int reportRate;
	private int examRate;
	private int discussionRate;
	private int progressRate;
	private String status;

	private int reportCalc;
	private int examCalc;
	private int discussionCalc;
	private int progressCalc;

	private String condiParentCode;
	private String condiCode;
	private String condiCourseCode;
	private String condiFindStr;
	
	//2014.6.20 추가
	private String searchStr;
	private String searchKind;
	
	public static long getSerialVersionUID() {
		return serialVersionUID;
	}
	public static void setSerialVersionUID(long serialVersionUID) {
		EvaluationVO.serialVersionUID = serialVersionUID;
	}
	public String getUserId() {
		return userId;
	}
	public void setUserId(String userId) {
		this.userId = userId;
	}
	public int getReport() {
		return report;
	}
	public void setReport(int report) {
		this.report = report;
	}
	public int getExam() {
		return exam;
	}
	public void setExam(int exam) {
		this.exam = exam;
	}
	public int getDiscussion() {
		return discussion;
	}
	public void setDiscussion(int discussion) {
		this.discussion = discussion;
	}
	public int getProgress() {
		return progress;
	}
	public void setProgress(int progress) {
		this.progress = progress;
	}
	public int getTotal() {
		return total;
	}
	public void setTotal(int total) {
		this.total = total;
	}
	public int getWeek() {
		return week;
	}
	public void setWeek(int week) {
		this.week = week;
	}
	public int getProgressRate() {
		return progressRate;
	}
	public void setProgressRate(int progressRate) {
		this.progressRate = progressRate;
	}
	public String getStudyStart() {
		return studyStart;
	}
	public void setStudyStart(String studyStart) {
		this.studyStart = studyStart;
	}
	public String getStudyEnd() {
		return studyEnd;
	}
	public void setStudyEnd(String studyEnd) {
		this.studyEnd = studyEnd;
	}
	public String getCourseId() {
		return courseId;
	}
	public void setCourseId(String courseId) {
		this.courseId = courseId;
	}
	public int getPage() {
		return page;
	}
	public void setPage(int page) {
		this.page = page;
	}
	public String getCondiParentCode() {
		return condiParentCode;
	}
	public void setCondiParentCode(String condiParentCode) {
		this.condiParentCode = condiParentCode;
	}
	public String getCondiCode() {
		return condiCode;
	}
	public void setCondiCode(String condiCode) {
		this.condiCode = condiCode;
	}
	public String getCondiCourseCode() {
		return condiCourseCode;
	}
	public void setCondiCourseCode(String condiCourseCode) {
		this.condiCourseCode = condiCourseCode;
	}
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
	public String getUserName() {
		return userName;
	}
	public void setUserName(String userName) {
		this.userName = userName;
	}
	public int getChasu() {
		return chasu;
	}
	public void setChasu(int chasu) {
		this.chasu = chasu;
	}
	public int getReportRate() {
		return reportRate;
	}
	public void setReportRate(int reportRate) {
		this.reportRate = reportRate;
	}
	public int getExamRate() {
		return examRate;
	}
	public void setExamRate(int examRate) {
		this.examRate = examRate;
	}
	public int getDiscussionRate() {
		return discussionRate;
	}
	public void setDiscussionRate(int discussionRate) {
		this.discussionRate = discussionRate;
	}
	public String getCondiFindStr() {
		return condiFindStr;
	}
	public void setCondiFindStr(String condiFindStr) {
		this.condiFindStr = condiFindStr;
	}
	public int getReportCalc() {
		return reportCalc;
	}
	public void setReportCalc(int reportCalc) {
		this.reportCalc = reportCalc;
	}
	public int getExamCalc() {
		return examCalc;
	}
	public void setExamCalc(int examCalc) {
		this.examCalc = examCalc;
	}
	public int getDiscussionCalc() {
		return discussionCalc;
	}
	public void setDiscussionCalc(int discussionCalc) {
		this.discussionCalc = discussionCalc;
	}
	public int getProgressCalc() {
		return progressCalc;
	}
	public void setProgressCalc(int progressCalc) {
		this.progressCalc = progressCalc;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
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
	public String getCompleteYn() {
		return completeYn;
	}
	public void setCompleteYn(String completeYn) {
		this.completeYn = completeYn;
	}
	public int getReportCnt() {
		return reportCnt;
	}
	public void setReportCnt(int reportCnt) {
		this.reportCnt = reportCnt;
	}
	public int getExamCnt() {
		return examCnt;
	}
	public void setExamCnt(int examCnt) {
		this.examCnt = examCnt;
	}
	public int getDiscussionCnt() {
		return discussionCnt;
	}
	public void setDiscussionCnt(int discussionCnt) {
		this.discussionCnt = discussionCnt;
	}
	public int getProgressCnt() {
		return progressCnt;
	}
	public void setProgressCnt(int progressCnt) {
		this.progressCnt = progressCnt;
	}
	public int getTotalCnt() {
		return totalCnt;
	}
	public void setTotalCnt(int totalCnt) {
		this.totalCnt = totalCnt;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getSearchStr() {
		return searchStr;
	}
	public void setSearchStr(String searchStr) {
		this.searchStr = searchStr;
	}
	public String getSearchKind() {
		return searchKind;
	}
	public void setSearchKind(String searchKind) {
		this.searchKind = searchKind;
	}
	

	
	

}
