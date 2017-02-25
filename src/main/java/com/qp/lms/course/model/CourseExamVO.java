package com.qp.lms.course.model;

import com.qp.lms.common.CommonVO;

public class CourseExamVO extends CommonVO {
	private static final long serialVersionUID = -1l; 

	private String c1Code;			/** 대분류 코드 */
	private String c2Code;			/** 중분류 코드 */
	private String c3Code;			/** 소분류 코드 */

	private String courseCode;
	private String courseName;
	private String seq;
	private String type;
	private String question;
	private String qa1;
	private String qa2;
	private String qa3;
	private String qa4;
	private String answer;
	private String grade;

	private String questionCnt;
	private String examRate;
	
	private String categoryName;
	
	private String[] seqs;
	private String[] types;
	private String[] questions;
	private String[] qa1s;
	private String[] qa2s;
	private String[] qa3s;
	private String[] qa4s;
	private String[] grades;
	private String[] answers;
	

	
	
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
	public String getSeq() {
		return seq;
	}
	public void setSeq(String seq) {
		this.seq = seq;
	}
	public String getType() {
		return type;
	}
	public void setType(String type) {
		this.type = type;
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
	public String getAnswer() {
		return answer;
	}
	public void setAnswer(String answer) {
		this.answer = answer;
	}
	public String getGrade() {
		return grade;
	}
	public void setGrade(String grade) {
		this.grade = grade;
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
	public String[] getGrades() {
		return grades;
	}
	public void setGrades(String[] grades) {
		this.grades = grades;
	}
	public String[] getAnswers() {
		return answers;
	}
	public void setAnswers(String[] answers) {
		this.answers = answers;
	}
	public static long getSerialversionuid() {
		return serialVersionUID;
	}
	public String getQuestionCnt() {
		return questionCnt;
	}
	public void setQuestionCnt(String questionCnt) {
		this.questionCnt = questionCnt;
	}
	public String getExamRate() {
		return examRate;
	}
	public void setExamRate(String examRate) {
		this.examRate = examRate;
	}
	

	
	

	
	

}
