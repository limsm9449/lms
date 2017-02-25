package com.qp.lms.common;

/*
 * 공통으로 사용할 조건 VO
 */
public class CondiVO extends CommonVO {

	private String condiStatus;
	private String courseId;
	
	
	public String getCourseId() {
		return courseId;
	}
	public void setCourseId(String courseId) {
		this.courseId = courseId;
	}
	public String getCondiStatus() {
		return condiStatus;
	}
	public void setCondiStatus(String condiStatus) {
		this.condiStatus = condiStatus;
	}

}
