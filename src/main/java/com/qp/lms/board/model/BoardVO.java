package com.qp.lms.board.model;

import com.qp.lms.common.CommonVO;

public class BoardVO extends CommonVO{
	private static final long serialVersionUID = -1l; 
	
	private String seq;
	private String pSeq;
	private String aSeq;
	private String courseId;
	private String title;
	private String contents;
	private String userId;
	private String userName;
	private String userIp;	
	private String viewCnt;
	
	private String findString;
	private String isPopup;
	
	private String kind;
	private String replyCnt;		/** 답변글 갯수 */

	//2014.7.27
	private String fileYn;
	
	//2014.7.30
	private String isNew;
	
	//2014.9.28
	private String nextSeq;
	private String prevSeq;
	
	private String limit;
	private String answer;
	private String answerYn;
	
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getContents() {
		return contents;
	}
	public void setContents(String contents) {
		this.contents = contents;
	}
	public String getUserId() {
		return userId;
	}
	public void setUserId(String userId) {
		this.userId = userId;
	}
	public String getUserIp() {
		return userIp;
	}
	public void setUserIp(String userIp) {
		this.userIp = userIp;
	}
	public static long getSerialversionuid() {
		return serialVersionUID;
	}
	public String getFindString() {
		return findString;
	}
	public void setFindString(String findString) {
		this.findString = findString;
	}
	public String getUserName() {
		return userName;
	}
	public void setUserName(String userName) {
		this.userName = userName;
	}
	public String getIsPopup() {
		return isPopup;
	}
	public void setIsPopup(String isPopup) {
		this.isPopup = isPopup;
	}
	public String getKind() {
		return kind;
	}
	public void setKind(String kind) {
		this.kind = kind;
	}
	public String getReplyCnt() {
		return replyCnt;
	}
	public void setReplyCnt(String replyCnt) {
		this.replyCnt = replyCnt;
	}
	public String getCourseId() {
		return courseId;
	}
	public void setCourseId(String courseId) {
		this.courseId = courseId;
	}
	public String getSeq() {
		return seq;
	}
	public void setSeq(String seq) {
		this.seq = seq;
	}
	public String getpSeq() {
		return pSeq;
	}
	public void setpSeq(String pSeq) {
		this.pSeq = pSeq;
	}
	public String getViewCnt() {
		return viewCnt;
	}
	public void setViewCnt(String viewCnt) {
		this.viewCnt = viewCnt;
	}
	public String getFileYn() {
		return fileYn;
	}
	public void setFileYn(String fileYn) {
		this.fileYn = fileYn;
	}
	public String getIsNew() {
		return isNew;
	}
	public void setIsNew(String isNew) {
		this.isNew = isNew;
	}
	public String getNextSeq() {
		return nextSeq;
	}
	public void setNextSeq(String nextSeq) {
		this.nextSeq = nextSeq;
	}
	public String getPrevSeq() {
		return prevSeq;
	}
	public void setPrevSeq(String prevSeq) {
		this.prevSeq = prevSeq;
	}
	public String getLimit() {
		return limit;
	}
	public void setLimit(String limit) {
		this.limit = limit;
	}
	public String getaSeq() {
		return aSeq;
	}
	public void setaSeq(String aSeq) {
		this.aSeq = aSeq;
	}
	public String getAnswer() {
		return answer;
	}
	public void setAnswer(String answer) {
		this.answer = answer;
	}
	public String getAnswerYn() {
		return answerYn;
	}
	public void setAnswerYn(String answerYn) {
		this.answerYn = answerYn;
	}
	
	
	

}
