package com.qp.lms.education.model;

import com.qp.lms.common.CommonVO;

public class EducationVO extends CommonVO {
	private static final long serialVersionUID = -1l; 

	private String courseId;
	private String week;
	private String page;
	private String courseCode;
	private String jucha;
	private String mobileYn;

	

	public String getCourseId() {
		return courseId;
	}

	public void setCourseId(String courseId) {
		this.courseId = courseId;
	}

	public static long getSerialversionuid() {
		return serialVersionUID;
	}

	public String getWeek() {
		return week;
	}

	public void setWeek(String week) {
		this.week = week;
	}

	public String getPage() {
		return page;
	}

	public void setPage(String page) {
		this.page = page;
	}

	public String getCourseCode() {
		return courseCode;
	}

	public void setCourseCode(String courseCode) {
		this.courseCode = courseCode;
	}

	public String getJucha() {
		return jucha;
	}

	public void setJucha(String jucha) {
		this.jucha = jucha;
	}

	public String getMobileYn() {
		return mobileYn;
	}

	public void setMobileYn(String mobileYn) {
		this.mobileYn = mobileYn;
	}



	

}
