package com.qp.lms.quest.model;

import com.qp.lms.common.CommonVO;

public class QuestVO extends CommonVO {

	private String qgId;
	private String groupName;
	private String useYn;
	private String seq;
	private String type;
	private String question;
	private String qa1;
	private String qa2;
	private String qa3;
	private String qa4;
	private String courseId;
	private String answer;
	private String answer1;
	private String answer2;
	private String answer3;
	private String answer4;
	private String userName;
	private String email;
	private String mobile;
	private String questYn;

	private String[] qgIds;
	private String[] seqs;
	private String[] types;
	private String[] questions;
	private String[] qa1s;
	private String[] qa2s;
	private String[] qa3s;
	private String[] qa4s;
	private String[] answers;
	private String[] answers1;
	private String[] answers2;
	private String[] answers3;
	private String[] answers4;

	private String c1Code;			/** 대분류 코드 */
	private String c2Code;			/** 중분류 코드 */
	private String c3Code;			/** 소분류 코드 */

	private String categoryName;
	private String courseCode;
	private String courseName;
	private String answer1Cnt;
	private String answer2Cnt;
	private String answer3Cnt;
	private String answer4Cnt;
	private String searchStr;
	private String searchKind;

	public String getQgId() {
		return qgId;
	}
	public void setQgId(String qgId) {
		this.qgId = qgId;
	}
	public String getGroupName() {
		return groupName;
	}
	public void setGroupName(String groupName) {
		this.groupName = groupName;
	}
	public String getUseYn() {
		return useYn;
	}
	public void setUseYn(String useYn) {
		this.useYn = useYn;
	}
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
	public String getAnswer1Cnt() {
		return answer1Cnt;
	}
	public void setAnswer1Cnt(String answer1Cnt) {
		this.answer1Cnt = answer1Cnt;
	}
	public String getAnswer2Cnt() {
		return answer2Cnt;
	}
	public void setAnswer2Cnt(String answer2Cnt) {
		this.answer2Cnt = answer2Cnt;
	}
	public String getAnswer3Cnt() {
		return answer3Cnt;
	}
	public void setAnswer3Cnt(String answer3Cnt) {
		this.answer3Cnt = answer3Cnt;
	}
	public String getAnswer4Cnt() {
		return answer4Cnt;
	}
	public void setAnswer4Cnt(String answer4Cnt) {
		this.answer4Cnt = answer4Cnt;
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
	public String getQuestYn() {
		return questYn;
	}
	public void setQuestYn(String questYn) {
		this.questYn = questYn;
	}
	public String getAnswer1() {
		return answer1;
	}
	public void setAnswer1(String answer1) {
		this.answer1 = answer1;
	}
	public String getAnswer2() {
		return answer2;
	}
	public void setAnswer2(String answer2) {
		this.answer2 = answer2;
	}
	public String getAnswer3() {
		return answer3;
	}
	public void setAnswer3(String answer3) {
		this.answer3 = answer3;
	}
	public String getAnswer4() {
		return answer4;
	}
	public void setAnswer4(String answer4) {
		this.answer4 = answer4;
	}
	public String[] getAnswers1() {
		return answers1;
	}
	public void setAnswers1(String[] answers1) {
		this.answers1 = answers1;
	}
	public String[] getAnswers2() {
		return answers2;
	}
	public void setAnswers2(String[] answers2) {
		this.answers2 = answers2;
	}
	public String[] getAnswers3() {
		return answers3;
	}
	public void setAnswers3(String[] answers3) {
		this.answers3 = answers3;
	}
	public String[] getAnswers4() {
		return answers4;
	}
	public void setAnswers4(String[] answers4) {
		this.answers4 = answers4;
	}
	public String[] getQgIds() {
		return qgIds;
	}
	public void setQgIds(String[] qgIds) {
		this.qgIds = qgIds;
	}
	
	

}
