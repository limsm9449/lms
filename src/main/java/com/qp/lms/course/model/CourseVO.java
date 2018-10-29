package com.qp.lms.course.model;

import java.util.List;

import com.qp.lms.common.CommonVO;

public class CourseVO extends CommonVO {
	private static final long serialVersionUID = -1l; 

	private String courseId;
	private String courseCode;
	private String courseName;
	private String tutorId; 
	private String tutorName;
	private String teacher; 
	private String teacherId; 
	private String teacherName;
	private int chasu;
	private String gFromDate;
	private String gToDate;
	private String cFromDate;
	private String cToDate;
	private String cPeriod;
	private String courseKindName;
	private String completeCnt;
	private String notCompleteCnt;
	private String reportCnt;
	private String examCnt;
	private String discussionCnt;
	private String progressCnt;
	private String companyYn;
	private String startYn;

	
	private String categoryName;
	
	private String c1Code;			/** 대분류 코드 */
	private String c1CodeName;		/** 대분류 코드 */
	private String c2Code;			/** 중분류 코드 */
	private String c3Code;			/** 소분류 코드 */
	
	private String yCnt;
	private String aCnt;
	private String rCnt;
	
	private String postscriptCnt;
	private String point;
	
	
	private String status;
	private String statusName;
	private String learingGoal;
	private String learingContent; 
	private String evalMethod;
	private String learingTarget;
	private String learingCost;
	private String courseCost;
	private String reportRate;
	private String reportRateName;
	private String examRate;
	private String examRateName;
	private String discussionRate;
	private String discussionRateName;
	private String progressRate;
	private String progressRateName;
	private String beginDate;
	private String finishDate;
	private String allCnt;
	private String bCnt;
	private String uCnt;
	private String lastWeek;
	private String lastPage;
	private String totalWeek;
	private String isEducationDate;

	private int maxChasu;
	private String newCourseId; 	//복사할때 사용할 course_id
	private String approvalStatus;
	
	private String isRegister;
	private String registerStatus;
	private String registerStatusName;
	
	private String userId;
	
	private String code;
	private String codeName;
	private String parentCode;
	private String completeYn;
	private String isStudy;
	private String mobileYn;
	private String recommendCourseYn;
	private String newCourseYn;
	
	private String submitDate;
	private String scoreDate;
	private String periodProgress;

	private String reportFail;
	private String examFail;
	private String discussionFail;
	private String progressFail;
	private String totalFail;
	private String totalCnt;
	private String answerCnt;
	private String postscriptYn;
	private String resourceCnt;

	private String isReport;
	private String isExam;
	private String isExamTotal;
	private String isExamWeek;
	private String isDiscussion;
	private String isProgress;
	
	private String condiParentCode;
	private String condiCode;
	private String condiCourseCode;
	private String condiStatus;
	
	private String oldCondiParentCode;
	private String oldCondiCode;
	private String oldCondiCourseCode;
	private String oldCondiStatus;
	
	private String companySubCnt;
    private String isExist;
    
    // 2014.6.17 추가
    private String weekCostYn;
    private String weekCostYnName;
    private String weekCost;
    private List<CourseVO> cartWeekList;
    private String week;
    private String title;
    
    //2014.6.18 추가
    private String questYn;
    private String qgId;
    
    //2014.6.19 추가
    private String courseEval;
    private String hPx;
    private String vPx;
    private String progress;
    private String exam;
    private String examYn;
    
    //2014.6.20 추가
    private String total;
    
    //2014.7.20
    private String remainDay;
    private String report;
    private String discussion;
    
    //2014.7.26
    private String weekCnt;
    private String cFromDay;
    private String cToDay;

    //2014.8.3
    private String postscriptEval;
    
    //2014.8.17
    private String approvalId;
    private String career;
    private String picture;
    
    private String grade;
    private String grade1;
    private String grade2;
    private String grade3;
    private String grade4;
    private String grade5;
    private String gradeCnt;

    private String reportYn;
    private String attendCourseCnt;
    private String waitingCourseCnt;
    private String completeCourseCnt;
    private String courseRemainDay;
    private String termYn;

    private String termPeriodFrom;
    private String termPeriodTo;
    private String studyPeriodFrom;
    private String studyPeriodTo;
    private String approvalCnt;
    private String directory;

    
	public String getPeriodProgress() {
		return periodProgress;
	}
	
	public void setPeriodProgress(String periodProgress) {
		this.periodProgress = periodProgress;
	}
	
	public String getAttendCourseCnt() {
		return attendCourseCnt;
	}
	
	public void setAttendCourseCnt(String attendCourseCnt) {
		this.attendCourseCnt = attendCourseCnt;
	}
	
	public String getCompleteCourseCnt() {
		return completeCourseCnt;
	}
	
	public void setCompleteCourseCnt(String completeCourseCnt) {
		this.completeCourseCnt = completeCourseCnt;
	}
	
	public String getCourseRemainDay() {
		return courseRemainDay;
	}
	
	public void setCourseRemainDay(String courseRemainDay) {
		this.courseRemainDay = courseRemainDay;
	}
	
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


	public int getMaxChasu() {
		return maxChasu;
	}

	public void setMaxChasu(int maxChasu) {
		this.maxChasu = maxChasu;
	}

	public String getBeginDate() {
		return beginDate;
	}

	public void setBeginDate(String beginDate) {
		this.beginDate = beginDate;
	}

	public String getFinishDate() {
		return finishDate;
	}

	public void setFinishDate(String finishDate) {
		this.finishDate = finishDate;
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

	public String getCourseName() {
		return courseName;
	}

	public void setCourseName(String courseName) {
		this.courseName = courseName;
	}

	public String getNewCourseId() {
		return newCourseId;
	}

	public void setNewCourseId(String newCourseId) {
		this.newCourseId = newCourseId;
	}

	public String getAllCnt() {
		return allCnt;
	}

	public void setAllCnt(String allCnt) {
		this.allCnt = allCnt;
	}

	public String getbCnt() {
		return bCnt;
	}

	public void setbCnt(String bCnt) {
		this.bCnt = bCnt;
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

	public String getuCnt() {
		return uCnt;
	}

	public void setuCnt(String uCnt) {
		this.uCnt = uCnt;
	}

	public String getApprovalStatus() {
		return approvalStatus;
	}

	public void setApprovalStatus(String approvalStatus) {
		this.approvalStatus = approvalStatus;
	}

	public String getUserId() {
		return userId;
	}

	public void setUserId(String userId) {
		this.userId = userId;
	}

	public String getCode() {
		return code;
	}

	public void setCode(String code) {
		this.code = code;
	}

	public String getParentCode() {
		return parentCode;
	}

	public void setParentCode(String parentCode) {
		this.parentCode = parentCode;
	}

	public String getReportRateName() {
		return reportRateName;
	}

	public void setReportRateName(String reportRateName) {
		this.reportRateName = reportRateName;
	}

	public String getExamRateName() {
		return examRateName;
	}

	public void setExamRateName(String examRateName) {
		this.examRateName = examRateName;
	}

	public String getDiscussionRateName() {
		return discussionRateName;
	}

	public void setDiscussionRateName(String discussionRateName) {
		this.discussionRateName = discussionRateName;
	}

	public String getProgressRateName() {
		return progressRateName;
	}

	public void setProgressRateName(String progressRateName) {
		this.progressRateName = progressRateName;
	}

	public static long getSerialVersionUID() {
		return serialVersionUID;
	}

	public String getIsRegister() {
		return isRegister;
	}

	public void setIsRegister(String isRegister) {
		this.isRegister = isRegister;
	}

	public String getRegisterStatus() {
		return registerStatus;
	}

	public void setRegisterStatus(String registerStatus) {
		this.registerStatus = registerStatus;
	}

	public String getRegisterStatusName() {
		return registerStatusName;
	}

	public void setRegisterStatusName(String registerStatusName) {
		this.registerStatusName = registerStatusName;
	}

	public static long getSerialversionuid() {
		return serialVersionUID;
	}

	public String getIsReport() {
		return isReport;
	}

	public void setIsReport(String isReport) {
		this.isReport = isReport;
	}

	public String getIsExam() {
		return isExam;
	}

	public void setIsExam(String isExam) {
		this.isExam = isExam;
	}

	public String getIsDiscussion() {
		return isDiscussion;
	}

	public void setIsDiscussion(String isDiscussion) {
		this.isDiscussion = isDiscussion;
	}

	public String getIsProgress() {
		return isProgress;
	}

	public void setIsProgress(String isProgress) {
		this.isProgress = isProgress;
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

	public String getCondiStatus() {
		return condiStatus;
	}

	public void setCondiStatus(String condiStatus) {
		this.condiStatus = condiStatus;
	}

	public String getOldCondiParentCode() {
		return oldCondiParentCode;
	}

	public void setOldCondiParentCode(String oldCondiParentCode) {
		this.oldCondiParentCode = oldCondiParentCode;
	}

	public String getOldCondiCode() {
		return oldCondiCode;
	}

	public void setOldCondiCode(String oldCondiCode) {
		this.oldCondiCode = oldCondiCode;
	}

	public String getOldCondiCourseCode() {
		return oldCondiCourseCode;
	}

	public void setOldCondiCourseCode(String oldCondiCourseCode) {
		this.oldCondiCourseCode = oldCondiCourseCode;
	}

	public String getOldCondiStatus() {
		return oldCondiStatus;
	}

	public void setOldCondiStatus(String oldCondiStatus) {
		this.oldCondiStatus = oldCondiStatus;
	}

	public String getLastWeek() {
		return lastWeek;
	}

	public void setLastWeek(String lastWeek) {
		this.lastWeek = lastWeek;
	}

	public String getLastPage() {
		return lastPage;
	}

	public void setLastPage(String lastPage) {
		this.lastPage = lastPage;
	}

	public String getTotalWeek() {
		return totalWeek;
	}

	public void setTotalWeek(String totalWeek) {
		this.totalWeek = totalWeek;
	}

	public String getReportCnt() {
		return reportCnt;
	}

	public void setReportCnt(String reportCnt) {
		this.reportCnt = reportCnt;
	}

	public String getExamCnt() {
		return examCnt;
	}

	public void setExamCnt(String examCnt) {
		this.examCnt = examCnt;
	}

	public String getDiscussionCnt() {
		return discussionCnt;
	}

	public void setDiscussionCnt(String discussionCnt) {
		this.discussionCnt = discussionCnt;
	}

	public String getProgressCnt() {
		return progressCnt;
	}

	public void setProgressCnt(String progressCnt) {
		this.progressCnt = progressCnt;
	}


	public String getTutorName() {
		return tutorName;
	}

	public void setTutorName(String tutorName) {
		this.tutorName = tutorName;
	}

	public String getCompanyYn() {
		return companyYn;
	}

	public void setCompanyYn(String companyYn) {
		this.companyYn = companyYn;
	}

	public String getCompanySubCnt() {
		return companySubCnt;
	}

	public void setCompanySubCnt(String companySubCnt) {
		this.companySubCnt = companySubCnt;
	}

	public String getIsEducationDate() {
		return isEducationDate;
	}

	public void setIsEducationDate(String isEducationDate) {
		this.isEducationDate = isEducationDate;
	}

	public String getIsExist() {
		return isExist;
	}

	public void setIsExist(String isExist) {
		this.isExist = isExist;
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

	public String getTutorId() {
		return tutorId;
	}

	public void setTutorId(String tutorId) {
		this.tutorId = tutorId;
	}

	public String getyCnt() {
		return yCnt;
	}

	public void setyCnt(String yCnt) {
		this.yCnt = yCnt;
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

	public String getPostscriptCnt() {
		return postscriptCnt;
	}

	public void setPostscriptCnt(String postscriptCnt) {
		this.postscriptCnt = postscriptCnt;
	}

	public String getPoint() {
		return point;
	}

	public void setPoint(String point) {
		this.point = point;
	}

	public String getTeacher() {
		return teacher;
	}

	public void setTeacher(String teacher) {
		this.teacher = teacher;
	}

	public String getTeacherName() {
		return teacherName;
	}

	public void setTeacherName(String teacherName) {
		this.teacherName = teacherName;
	}

	public String getcPeriod() {
		return cPeriod;
	}

	public void setcPeriod(String cPeriod) {
		this.cPeriod = cPeriod;
	}

	public String getCourseKindName() {
		return courseKindName;
	}

	public void setCourseKindName(String courseKindName) {
		this.courseKindName = courseKindName;
	}

	public String getCompleteCnt() {
		return completeCnt;
	}

	public void setCompleteCnt(String completeCnt) {
		this.completeCnt = completeCnt;
	}

	public String getNotCompleteCnt() {
		return notCompleteCnt;
	}

	public void setNotCompleteCnt(String notCompleteCnt) {
		this.notCompleteCnt = notCompleteCnt;
	}

	public String getWeekCostYn() {
		return weekCostYn;
	}

	public void setWeekCostYn(String weekCostYn) {
		this.weekCostYn = weekCostYn;
	}

	public String getWeekCost() {
		return weekCost;
	}

	public void setWeekCost(String weekCost) {
		this.weekCost = weekCost;
	}

	public String getWeekCostYnName() {
		return weekCostYnName;
	}

	public void setWeekCostYnName(String weekCostYnName) {
		this.weekCostYnName = weekCostYnName;
	}

	public List<CourseVO> getCartWeekList() {
		return cartWeekList;
	}

	public void setCartWeekList(List<CourseVO> cartWeekList) {
		this.cartWeekList = cartWeekList;
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

	public String getQuestYn() {
		return questYn;
	}

	public void setQuestYn(String questYn) {
		this.questYn = questYn;
	}

	public String getQgId() {
		return qgId;
	}

	public void setQgId(String qgId) {
		this.qgId = qgId;
	}

	public String getCourseEval() {
		return courseEval;
	}

	public void setCourseEval(String courseEval) {
		this.courseEval = courseEval;
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

	public String getProgress() {
		return progress;
	}

	public void setProgress(String progress) {
		this.progress = progress;
	}

	public String getExam() {
		return exam;
	}

	public void setExam(String exam) {
		this.exam = exam;
	}

	public String getExamYn() {
		return examYn;
	}

	public void setExamYn(String examYn) {
		this.examYn = examYn;
	}

	public String getTotal() {
		return total;
	}

	public void setTotal(String total) {
		this.total = total;
	}

	public String getRemainDay() {
		return remainDay;
	}

	public void setRemainDay(String remainDay) {
		this.remainDay = remainDay;
	}

	public String getReport() {
		return report;
	}

	public void setReport(String report) {
		this.report = report;
	}

	public String getDiscussion() {
		return discussion;
	}

	public void setDiscussion(String discussion) {
		this.discussion = discussion;
	}

	public String getTeacherId() {
		return teacherId;
	}

	public void setTeacherId(String teacherId) {
		this.teacherId = teacherId;
	}

	public String getWeekCnt() {
		return weekCnt;
	}

	public void setWeekCnt(String weekCnt) {
		this.weekCnt = weekCnt;
	}

	public String getcFromDay() {
		return cFromDay;
	}

	public void setcFromDay(String cFromDay) {
		this.cFromDay = cFromDay;
	}

	public String getcToDay() {
		return cToDay;
	}

	public void setcToDay(String cToDay) {
		this.cToDay = cToDay;
	}

	public String getPostscriptEval() {
		return postscriptEval;
	}

	public void setPostscriptEval(String postscriptEval) {
		this.postscriptEval = postscriptEval;
	}

	public String getApprovalId() {
		return approvalId;
	}

	public void setApprovalId(String approvalId) {
		this.approvalId = approvalId;
	}

	public String getCareer() {
		return career;
	}

	public void setCareer(String career) {
		this.career = career;
	}

	public String getPicture() {
		return picture;
	}

	public void setPicture(String picture) {
		this.picture = picture;
	}

	public String getStartYn() {
		return startYn;
	}

	public void setStartYn(String startYn) {
		this.startYn = startYn;
	}

	public String getCodeName() {
		return codeName;
	}

	public void setCodeName(String codeName) {
		this.codeName = codeName;
	}

	public String getIsExamTotal() {
		return isExamTotal;
	}

	public void setIsExamTotal(String isExamTotal) {
		this.isExamTotal = isExamTotal;
	}

	public String getIsExamWeek() {
		return isExamWeek;
	}

	public void setIsExamWeek(String isExamWeek) {
		this.isExamWeek = isExamWeek;
	}

	public String getGrade() {
		return grade;
	}

	public void setGrade(String grade) {
		this.grade = grade;
	}

	public String getGradeCnt() {
		return gradeCnt;
	}

	public void setGradeCnt(String gradeCnt) {
		this.gradeCnt = gradeCnt;
	}

	public String getGrade1() {
		return grade1;
	}

	public void setGrade1(String grade1) {
		this.grade1 = grade1;
	}

	public String getGrade2() {
		return grade2;
	}

	public void setGrade2(String grade2) {
		this.grade2 = grade2;
	}

	public String getGrade3() {
		return grade3;
	}

	public void setGrade3(String grade3) {
		this.grade3 = grade3;
	}

	public String getGrade4() {
		return grade4;
	}

	public void setGrade4(String grade4) {
		this.grade4 = grade4;
	}

	public String getGrade5() {
		return grade5;
	}

	public void setGrade5(String grade5) {
		this.grade5 = grade5;
	}

	public String getReportYn() {
		return reportYn;
	}

	public void setReportYn(String reportYn) {
		this.reportYn = reportYn;
	}

	public String getWaitingCourseCnt() {
		return waitingCourseCnt;
	}

	public void setWaitingCourseCnt(String waitingCourseCnt) {
		this.waitingCourseCnt = waitingCourseCnt;
	}

	public String getCompleteYn() {
		return completeYn;
	}

	public void setCompleteYn(String completeYn) {
		this.completeYn = completeYn;
	}

	public String getIsStudy() {
		return isStudy;
	}

	public void setIsStudy(String isStudy) {
		this.isStudy = isStudy;
	}

	public String getMobileYn() {
		return mobileYn;
	}

	public void setMobileYn(String mobileYn) {
		this.mobileYn = mobileYn;
	}

	public String getRecommendCourseYn() {
		return recommendCourseYn;
	}

	public void setRecommendCourseYn(String recommendCourseYn) {
		this.recommendCourseYn = recommendCourseYn;
	}

	public String getNewCourseYn() {
		return newCourseYn;
	}

	public void setNewCourseYn(String newCourseYn) {
		this.newCourseYn = newCourseYn;
	}

	public String getSubmitDate() {
		return submitDate;
	}

	public void setSubmitDate(String submitDate) {
		this.submitDate = submitDate;
	}

	public String getScoreDate() {
		return scoreDate;
	}

	public void setScoreDate(String scoreDate) {
		this.scoreDate = scoreDate;
	}

	public String getReportFail() {
		return reportFail;
	}

	public void setReportFail(String reportFail) {
		this.reportFail = reportFail;
	}

	public String getExamFail() {
		return examFail;
	}

	public void setExamFail(String examFail) {
		this.examFail = examFail;
	}

	public String getDiscussionFail() {
		return discussionFail;
	}

	public void setDiscussionFail(String discussionFail) {
		this.discussionFail = discussionFail;
	}

	public String getProgressFail() {
		return progressFail;
	}

	public void setProgressFail(String progressFail) {
		this.progressFail = progressFail;
	}

	public String getTotalFail() {
		return totalFail;
	}

	public void setTotalFail(String totalFail) {
		this.totalFail = totalFail;
	}

	public String getTotalCnt() {
		return totalCnt;
	}

	public void setTotalCnt(String totalCnt) {
		this.totalCnt = totalCnt;
	}

	public String getAnswerCnt() {
		return answerCnt;
	}

	public void setAnswerCnt(String answerCnt) {
		this.answerCnt = answerCnt;
	}

	public String getPostscriptYn() {
		return postscriptYn;
	}

	public void setPostscriptYn(String postscriptYn) {
		this.postscriptYn = postscriptYn;
	}

	public String getResourceCnt() {
		return resourceCnt;
	}

	public void setResourceCnt(String resourceCnt) {
		this.resourceCnt = resourceCnt;
	}

	public String getTermYn() {
		return termYn;
	}

	public void setTermYn(String termYn) {
		this.termYn = termYn;
	}

	public String getTermPeriodFrom() {
		return termPeriodFrom;
	}

	public void setTermPeriodFrom(String termPeriodFrom) {
		this.termPeriodFrom = termPeriodFrom;
	}

	public String getTermPeriodTo() {
		return termPeriodTo;
	}

	public void setTermPeriodTo(String termPeriodTo) {
		this.termPeriodTo = termPeriodTo;
	}

	public String getStudyPeriodFrom() {
		return studyPeriodFrom;
	}

	public void setStudyPeriodFrom(String studyPeriodFrom) {
		this.studyPeriodFrom = studyPeriodFrom;
	}

	public String getStudyPeriodTo() {
		return studyPeriodTo;
	}

	public void setStudyPeriodTo(String studyPeriodTo) {
		this.studyPeriodTo = studyPeriodTo;
	}

	public String getApprovalCnt() {
		return approvalCnt;
	}

	public void setApprovalCnt(String approvalCnt) {
		this.approvalCnt = approvalCnt;
	}

	public String getC1CodeName() {
		return c1CodeName;
	}

	public void setC1CodeName(String c1CodeName) {
		this.c1CodeName = c1CodeName;
	}

	public String getDirectory() {
		return directory;
	}

	public void setDirectory(String directory) {
		this.directory = directory;
	}



}
