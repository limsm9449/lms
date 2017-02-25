package com.qp.lms.cost.model;

import com.qp.lms.common.CommonVO;

public class CostRateVO extends CommonVO {
	private static final long serialVersionUID = -1l; 
	
	private String c1Code;			/** 대분류 코드 */
	private String c2Code;			/** 중분류 코드 */
	private String c3Code;			/** 소분류 코드 */
	
	private String categoryName;
	private String courseCode;
	private String courseName;
	private String companyRate;
	private String teacherRate;
	private String tutorRate;


	
                  
	public String getCourseCode() {
		return courseCode;
	}
	public static long getSerialVersionUID() {
		return serialVersionUID;
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
	public String getCompanyRate() {
		return companyRate;
	}
	public void setCompanyRate(String companyRate) {
		this.companyRate = companyRate;
	}
	public String getTeacherRate() {
		return teacherRate;
	}
	public void setTeacherRate(String teacherRate) {
		this.teacherRate = teacherRate;
	}
	public String getCategoryName() {
		return categoryName;
	}
	public void setCategoryName(String categoryName) {
		this.categoryName = categoryName;
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
	public static long getSerialversionuid() {
		return serialVersionUID;
	}
	public String getTutorRate() {
		return tutorRate;
	}
	public void setTutorRate(String tutorRate) {
		this.tutorRate = tutorRate;
	}
	

	
	
	
	

}
