package com.qp.lms.board.model;

import com.qp.lms.common.CommonVO;

public class ReplyVO extends CommonVO{
	private static final long serialVersionUID = -1l; 
	
	private String seq;
	private String kind;
	private String pSeq;
	private String contents;
	private String userId;
	private String userName;
	private String userIp;
	private String rSeq;
	
	//2014.8.17
	private String courseId;
	
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
	public String getUserName() {
		return userName;
	}
	public void setUserName(String userName) {
		this.userName = userName;
	}
	public String getKind() {
		return kind;
	}
	public void setKind(String kind) {
		this.kind = kind;
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
	public String getCourseId() {
		return courseId;
	}
	public void setCourseId(String courseId) {
		this.courseId = courseId;
	}
	public String getrSeq() {
		return rSeq;
	}
	public void setrSeq(String rSeq) {
		this.rSeq = rSeq;
	}
	
	
	

}
