package com.qp.lms.common;

import java.util.List;

import com.qp.lms.course.model.CourseVO;

public class SessionVO {
	private String userId;
	private String userName;
	private String adminYn;
	private String siteManagerYn;
	private String contentsManagerYn;
	private String tutorYn;
	private String teacherYn;
	private String userIp;
	private String auth;
	private String email;
	private String mobile;
	private String compName;
	private String c2cYn;
	private String downloadAuth;				/** 튜터, 어드민, 강사는 첨부 다운로드 권한이 있다. */
	
	
	//2014.8.3
	private List<CourseVO> favorityCourseList;
	private String subDomain;
	private String compCd;
	private String userCompCd;
		
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
	public List<CourseVO> getFavorityCourseList() {
		return favorityCourseList;
	}
	public void setFavorityCourseList(List<CourseVO> favorityCourseList) {
		this.favorityCourseList = favorityCourseList;
	}
	public String getSiteManagerYn() {
		return siteManagerYn;
	}
	public void setSiteManagerYn(String siteManagerYn) {
		this.siteManagerYn = siteManagerYn;
	}
	public String getContentsManagerYn() {
		return contentsManagerYn;
	}
	public void setContentsManagerYn(String contentsManagerYn) {
		this.contentsManagerYn = contentsManagerYn;
	}
	public String getAuth() {
		return auth;
	}
	public void setAuth(String auth) {
		this.auth = auth;
	}
	public String getSubDomain() {
		return subDomain;
	}
	public void setSubDomain(String subDomain) {
		this.subDomain = subDomain;
	}
	public String getCompCd() {
		return compCd;
	}
	public void setCompCd(String compCd) {
		this.compCd = compCd;
	}
	public String getUserCompCd() {
		return userCompCd;
	}
	public void setUserCompCd(String userCompCd) {
		this.userCompCd = userCompCd;
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
	public String getCompName() {
		return compName;
	}
	public void setCompName(String compName) {
		this.compName = compName;
	}
	public String getC2cYn() {
		return c2cYn;
	}
	public void setC2cYn(String c2cYn) {
		this.c2cYn = c2cYn;
	}
	
		

}
