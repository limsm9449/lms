package com.qp.lms.board.model;

import com.qp.lms.common.CommonVO;

public class BoardDiscussionVO extends CommonVO{
	private static final long serialVersionUID = -1l; 
	
	private String seq;
	private String courseId;
	private String ref;
	private String ord;
	private String step;
	private String title;
	private String contents;
	private String userId;
	private String userName;
	private String userIp;	
	private int viewCnt;

	private String findString;
	private String isPopup;
	
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
	public int getViewCnt() {
		return viewCnt;
	}
	public void setViewCnt(int viewCnt) {
		this.viewCnt = viewCnt;
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
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getSeq() {
		return seq;
	}
	public void setSeq(String seq) {
		this.seq = seq;
	}
	public String getCourseId() {
		return courseId;
	}
	public void setCourseId(String courseId) {
		this.courseId = courseId;
	}
	public String getRef() {
		return ref;
	}
	public void setRef(String ref) {
		this.ref = ref;
	}
	public String getOrd() {
		return ord;
	}
	public void setOrd(String ord) {
		this.ord = ord;
	}
	public String getStep() {
		return step;
	}
	public void setStep(String step) {
		this.step = step;
	}
	public String getIsPopup() {
		return isPopup;
	}
	public void setIsPopup(String isPopup) {
		this.isPopup = isPopup;
	}
	
	

}
