package com.qp.lms.member.model;

import com.qp.lms.common.CommonVO;

public class MemberVO extends CommonVO{
	private static final long serialVersionUID = -1l; 
	
	private String seq;
	private String userId;
	private String userName;
	private String userPassword;
	private String newUserPassword;
	private String email;	
	private String adminYn;	
	private String adminYnName;	
	private String teacherYn;
	private String tutorYn;
	private String homeZipcodeSeq;	
	private String homeZip;	
	private String homeZip1;	
	private String homeZip2;	
	private String homeAddr;	
	private String homeAddr1;	
	private String homeAddr2;	
	private String homeTel;	
	private String homeTel1;	
	private String homeTel2;	
	private String homeTel3;	
	private String mobile;	
	private String mobile1;	
	private String mobile2;	
	private String mobile3;	
	private String job;
	private String jobName;
	private String compCd;
	private String sex;
	private String birthDay;
	
	private String retiredYn;
	private String retiredReason;
	
	private String courseId;
	private String registerUserId;

	private String userKind;
	private String searchKind;
	private String searchStr;
	
	private String certificationYn;
	private String certificationKey;

	//2014.7.20
	private String sexName;
	
	//2014.8.15
	private String career;
	private String picture;
	private String careerYn;
	private String pictureYn;
	
	//2014.9.27
	private String certificationYnName;
	
	
	
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
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getHomeZip1() {
		return homeZip1;
	}
	public void setHomeZip1(String homeZip1) {
		this.homeZip1 = homeZip1;
	}
	public String getHomeZip2() {
		return homeZip2;
	}
	public void setHomeZip2(String homeZip2) {
		this.homeZip2 = homeZip2;
	}
	public String getHomeAddr1() {
		return homeAddr1;
	}
	public void setHomeAddr1(String homeAddr1) {
		this.homeAddr1 = homeAddr1;
	}
	public String getHomeAddr2() {
		return homeAddr2;
	}
	public void setHomeAddr2(String homeAddr2) {
		this.homeAddr2 = homeAddr2;
	}
	public String getHomeTel1() {
		return homeTel1;
	}
	public void setHomeTel1(String homeTel1) {
		this.homeTel1 = homeTel1;
	}
	public String getHomeTel2() {
		return homeTel2;
	}
	public void setHomeTel2(String homeTel2) {
		this.homeTel2 = homeTel2;
	}
	public String getHomeTel3() {
		return homeTel3;
	}
	public void setHomeTel3(String homeTel3) {
		this.homeTel3 = homeTel3;
	}
	public String getMobile1() {
		return mobile1;
	}
	public void setMobile1(String mobile1) {
		this.mobile1 = mobile1;
	}
	public String getMobile2() {
		return mobile2;
	}
	public void setMobile2(String mobile2) {
		this.mobile2 = mobile2;
	}
	public String getMobile3() {
		return mobile3;
	}
	public void setMobile3(String mobile3) {
		this.mobile3 = mobile3;
	}
	public String getJob() {
		return job;
	}
	public void setJob(String job) {
		this.job = job;
	}
	public static long getSerialversionuid() {
		return serialVersionUID;
	}
	public String getHomeZipcodeSeq() {
		return homeZipcodeSeq;
	}
	public void setHomeZipcodeSeq(String homeZipcodeSeq) {
		this.homeZipcodeSeq = homeZipcodeSeq;
	}
	public String getHomeAddr() {
		return homeAddr;
	}
	public void setHomeAddr(String homeAddr) {
		this.homeAddr = homeAddr;
	}
	public String getHomeTel() {
		return homeTel;
	}
	public void setHomeTel(String homeTel) {
		this.homeTel = homeTel;
	}
	public String getMobile() {
		return mobile;
	}
	public void setMobile(String mobile) {
		this.mobile = mobile;
	}
	public String getUserPassword() {
		return userPassword;
	}
	public void setUserPassword(String userPassword) {
		this.userPassword = userPassword;
	}
	public String getHomeZip() {
		return homeZip;
	}
	public void setHomeZip(String homeZip) {
		this.homeZip = homeZip;
	}
	public String getNewUserPassword() {
		return newUserPassword;
	}
	public void setNewUserPassword(String newUserPassword) {
		this.newUserPassword = newUserPassword;
	}
	public String getRetiredYn() {
		return retiredYn;
	}
	public void setRetiredYn(String retiredYn) {
		this.retiredYn = retiredYn;
	}
	public String getJobName() {
		return jobName;
	}
	public void setJobName(String jobName) {
		this.jobName = jobName;
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
	public String getRegisterUserId() {
		return registerUserId;
	}
	public void setRegisterUserId(String registerUserId) {
		this.registerUserId = registerUserId;
	}
	public String getAdminYn() {
		return adminYn;
	}
	public void setAdminYn(String adminYn) {
		this.adminYn = adminYn;
	}
	public String getTeacherYn() {
		return teacherYn;
	}
	public void setTeacherYn(String teacherYn) {
		this.teacherYn = teacherYn;
	}
	public String getTutorYn() {
		return tutorYn;
	}
	public void setTutorYn(String tutorYn) {
		this.tutorYn = tutorYn;
	}
	public String getCompCd() {
		return compCd;
	}
	public void setCompCd(String compCd) {
		this.compCd = compCd;
	}
	public String getSearchStr() {
		return searchStr;
	}
	public void setSearchStr(String searchStr) {
		this.searchStr = searchStr;
	}
	public String getUserKind() {
		return userKind;
	}
	public void setUserKind(String userKind) {
		this.userKind = userKind;
	}
	public String getSearchKind() {
		return searchKind;
	}
	public void setSearchKind(String searchKind) {
		this.searchKind = searchKind;
	}
	public String getSex() {
		return sex;
	}
	public void setSex(String sex) {
		this.sex = sex;
	}
	public String getBirthDay() {
		return birthDay;
	}
	public void setBirthDay(String birthDay) {
		this.birthDay = birthDay;
	}
	public String getAdminYnName() {
		return adminYnName;
	}
	public void setAdminYnName(String adminYnName) {
		this.adminYnName = adminYnName;
	}
	public String getRetiredReason() {
		return retiredReason;
	}
	public void setRetiredReason(String retiredReason) {
		this.retiredReason = retiredReason;
	}
	public String getCertificationYn() {
		return certificationYn;
	}
	public void setCertificationYn(String certificationYn) {
		this.certificationYn = certificationYn;
	}
	public String getCertificationKey() {
		return certificationKey;
	}
	public void setCertificationKey(String certificationKey) {
		this.certificationKey = certificationKey;
	}
	public String getSexName() {
		return sexName;
	}
	public void setSexName(String sexName) {
		this.sexName = sexName;
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
	public String getCareerYn() {
		return careerYn;
	}
	public void setCareerYn(String careerYn) {
		this.careerYn = careerYn;
	}
	public String getPictureYn() {
		return pictureYn;
	}
	public void setPictureYn(String pictureYn) {
		this.pictureYn = pictureYn;
	}
	public String getCertificationYnName() {
		return certificationYnName;
	}
	public void setCertificationYnName(String certificationYnName) {
		this.certificationYnName = certificationYnName;
	}
	

}
