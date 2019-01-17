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
	private String homeZipcode;	
	private String homeZip;	
	private String homeAddr;	
	private String homeTel;	
	private String mobile;	
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
	
	private String userYear;
	private String userMonth;
	private String userDay;
	
	private String recommendId;
	private String hintQuestion;
	private String hintAnswer;
	private String emailInformYn;
	
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
	public String getJob() {
		return job;
	}
	public void setJob(String job) {
		this.job = job;
	}
	public static long getSerialversionuid() {
		return serialVersionUID;
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
	public String getUserYear() {
		return userYear;
	}
	public void setUserYear(String userYear) {
		this.userYear = userYear;
	}
	public String getUserMonth() {
		return userMonth;
	}
	public void setUserMonth(String userMonth) {
		this.userMonth = userMonth;
	}
	public String getUserDay() {
		return userDay;
	}
	public void setUserDay(String userDay) {
		this.userDay = userDay;
	}
	public String getHomeZipcode() {
		return homeZipcode;
	}
	public void setHomeZipcode(String homeZipcode) {
		this.homeZipcode = homeZipcode;
	}
	public String getRecommendId() {
		return recommendId;
	}
	public void setRecommendId(String recommendId) {
		this.recommendId = recommendId;
	}
	public String getHintQuestion() {
		return hintQuestion;
	}
	public void setHintQuestion(String hintQuestion) {
		this.hintQuestion = hintQuestion;
	}
	public String getHintAnswer() {
		return hintAnswer;
	}
	public void setHintAnswer(String hintAnswer) {
		this.hintAnswer = hintAnswer;
	}
	public String getEmailInformYn() {
		return emailInformYn;
	}
	public void setEmailInformYn(String emailInformYn) {
		this.emailInformYn = emailInformYn;
	}
	

}
