package com.qp.lms.exam.model;

import com.qp.lms.common.CommonVO;

public class ExamVO extends CommonVO {

	private String seq;
	private String type;
	private String question;
	private String qa1;
	private String qa2;
	private String qa3;
	private String qa4;
	private String courseId;
	private String answer;
	private String userAnswer;
	private String grade;
	private String completeYn;
	private String exam;

	private String over90;
	private String over80;
	private String over70;
	private String under70;
	private String userName;
	private String email;
	private String mobile;

	private String[] examKinds;
	private String[] weeks;
	private String[] seqs;
	private String[] types;
	private String[] questions;
	private String[] qa1s;
	private String[] qa2s;
	private String[] qa3s;
	private String[] qa4s;
	private String[] answers;

	private String c1Code;			/** 대분류 코드 */
	private String c2Code;			/** 중분류 코드 */
	private String c3Code;			/** 소분류 코드 */

	private String categoryName;
	private String courseCode;
	private String courseName;
	private String searchStr;
	private String searchKind;
	private String examKind;
	
	private String weekFrom;
	private String weekTo;
	private String level;
	private String questionCnt;
	private String answerDesc;
	private String answerYn;
	private String examTotal;
	private String examAnswer;
	private String week;

	public String getSeq() {
		return seq;
	}
	public void setSeq(String seq) {
		this.seq = seq;
	}
	public String getQuestion() {
		return question;
	}
	public void setQuestion(String question) {
		this.question = question;
	}
	public String getQa1() {
		return qa1;
	}
	public void setQa1(String qa1) {
		this.qa1 = qa1;
	}
	public String getQa2() {
		return qa2;
	}
	public void setQa2(String qa2) {
		this.qa2 = qa2;
	}
	public String getQa3() {
		return qa3;
	}
	public void setQa3(String qa3) {
		this.qa3 = qa3;
	}
	public String getQa4() {
		return qa4;
	}
	public void setQa4(String qa4) {
		this.qa4 = qa4;
	}
	public String getCourseId() {
		return courseId;
	}
	public void setCourseId(String courseId) {
		this.courseId = courseId;
	}
	public String getAnswer() {
		return answer;
	}
	public void setAnswer(String answer) {
		this.answer = answer;
	}
	public String getType() {
		return type;
	}
	public void setType(String type) {
		this.type = type;
	}
	public String[] getSeqs() {
		return seqs;
	}
	public void setSeqs(String[] seqs) {
		this.seqs = seqs;
	}
	public String[] getTypes() {
		return types;
	}
	public void setTypes(String[] types) {
		this.types = types;
	}
	public String[] getQuestions() {
		return questions;
	}
	public void setQuestions(String[] questions) {
		this.questions = questions;
	}
	public String[] getQa1s() {
		return qa1s;
	}
	public void setQa1s(String[] qa1s) {
		this.qa1s = qa1s;
	}
	public String[] getQa2s() {
		return qa2s;
	}
	public void setQa2s(String[] qa2s) {
		this.qa2s = qa2s;
	}
	public String[] getQa3s() {
		return qa3s;
	}
	public void setQa3s(String[] qa3s) {
		this.qa3s = qa3s;
	}
	public String[] getQa4s() {
		return qa4s;
	}
	public void setQa4s(String[] qa4s) {
		this.qa4s = qa4s;
	}
	public String[] getAnswers() {
		return answers;
	}
	public void setAnswers(String[] answers) {
		this.answers = answers;
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
	public String getCategoryName() {
		return categoryName;
	}
	public void setCategoryName(String categoryName) {
		this.categoryName = categoryName;
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
	public String getUserName() {
		return userName;
	}
	public void setUserName(String userName) {
		this.userName = userName;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getMobile() {
		return mobile;
	}
	public void setMobile(String mobile) {
		this.mobile = mobile;
	}
	public String getGrade() {
		return grade;
	}
	public void setGrade(String grade) {
		this.grade = grade;
	}
	public String getCompleteYn() {
		return completeYn;
	}
	public void setCompleteYn(String completeYn) {
		this.completeYn = completeYn;
	}
	public String getOver90() {
		return over90;
	}
	public void setOver90(String over90) {
		this.over90 = over90;
	}
	public String getOver80() {
		return over80;
	}
	public void setOver80(String over80) {
		this.over80 = over80;
	}
	public String getOver70() {
		return over70;
	}
	public void setOver70(String over70) {
		this.over70 = over70;
	}
	public String getUnder70() {
		return under70;
	}
	public void setUnder70(String under70) {
		this.under70 = under70;
	}
	public String getExam() {
		return exam;
	}
	public void setExam(String exam) {
		this.exam = exam;
	}
	public String getUserAnswer() {
		return userAnswer;
	}
	public void setUserAnswer(String userAnswer) {
		this.userAnswer = userAnswer;
	}
	public String getExamKind() {
		return examKind;
	}
	public void setExamKind(String examKind) {
		this.examKind = examKind;
	}
	public String getWeekFrom() {
		return weekFrom;
	}
	public void setWeekFrom(String weekFrom) {
		this.weekFrom = weekFrom;
	}
	public String getWeekTo() {
		return weekTo;
	}
	public void setWeekTo(String weekTo) {
		this.weekTo = weekTo;
	}
	public String getLevel() {
		return level;
	}
	public void setLevel(String level) {
		this.level = level;
	}
	public String getQuestionCnt() {
		return questionCnt;
	}
	public void setQuestionCnt(String questionCnt) {
		this.questionCnt = questionCnt;
	}
	public String getAnswerDesc() {
		return answerDesc;
	}
	public void setAnswerDesc(String answerDesc) {
		this.answerDesc = answerDesc;
	}
	public String getExamTotal() {
		return examTotal;
	}
	public void setExamTotal(String examTotal) {
		this.examTotal = examTotal;
	}
	public String getAnswerYn() {
		return answerYn;
	}
	public void setAnswerYn(String answerYn) {
		this.answerYn = answerYn;
	}
	public String getExamAnswer() {
		return examAnswer;
	}
	public void setExamAnswer(String examAnswer) {
		this.examAnswer = examAnswer;
	}
	public String getWeek() {
		return week;
	}
	public void setWeek(String week) {
		this.week = week;
	}
	public String[] getExamKinds() {
		return examKinds;
	}
	public void setExamKinds(String[] examKinds) {
		this.examKinds = examKinds;
	}
	public String[] getWeeks() {
		return weeks;
	}
	public void setWeeks(String[] weeks) {
		this.weeks = weeks;
	}
	
	

}
