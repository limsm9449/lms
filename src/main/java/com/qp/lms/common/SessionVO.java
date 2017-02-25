package com.qp.lms.common;

import java.util.List;

import com.qp.lms.course.model.CourseVO;

public class SessionVO {
	private String userId;
	private String userName;
	private String adminYn;
	private String adminKind;
	private String tutorYn;
	private String teacherYn;
	private String compManagerYn;
	private String userIp;
	
	private String downloadAuth;				/** 튜터, 어드민, 강사는 첨부 다운로드 권한이 있다. */
	
	//2014.8.3
	private List<CourseVO> favorityCourseList;
		
	public String getUserId() {
		return userId;
	}
	public void setUserId(String userId) {
		this.userId = userId;
	}
	public String getUserName() {
		return userName;
	}
	public void setUserName(String userName) {
		this.userName = userName;
	}
	public String getUserIp() {
		return userIp;
	}
	public void setUserIp(String userIp) {
		this.userIp = userIp;
	}
	public String getAdminYn() {
		return adminYn;
	}
	public void setAdminYn(String adminYn) {
		this.adminYn = adminYn;
	}
	public String getTutorYn() {
		return tutorYn;
	}
	public void setTutorYn(String tutorYn) {
		this.tutorYn = tutorYn;
	}
	public String getTeacherYn() {
		return teacherYn;
	}
	public void setTeacherYn(String teacherYn) {
		this.teacherYn = teacherYn;
	}
	public String getDownloadAuth() {
		return downloadAuth;
	}
	public void setDownloadAuth(String downloadAuth) {
		this.downloadAuth = downloadAuth;
	}
	public String getCompManagerYn() {
		return compManagerYn;
	}
	public void setCompManagerYn(String compManagerYn) {
		this.compManagerYn = compManagerYn;
	}
	public String getAdminKind() {
		return adminKind;
	}
	public void setAdminKind(String adminKind) {
		this.adminKind = adminKind;
	}
	public List<CourseVO> getFavorityCourseList() {
		return favorityCourseList;
	}
	public void setFavorityCourseList(List<CourseVO> favorityCourseList) {
		this.favorityCourseList = favorityCourseList;
	}
	
		

}
