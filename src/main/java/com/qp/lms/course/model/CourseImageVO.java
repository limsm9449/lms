package com.qp.lms.course.model;

import java.util.List;

import com.qp.lms.common.CommonVO;

public class CourseImageVO extends CommonVO {
	private static final long serialVersionUID = -1l; 

	private String courseId;
	private String courseName;
	private String courseCode;
	private String categoryName;
	private String swf;
	private String bImg;
	private String cImg;
	private String mImg1;
	private String mImg2;
	private String mImg3;
	private String sImg1;
	private String sImg2;
	private String sImg3;
	
	private String kind;
	
	private String c1Code;			/** 대분류 코드 */
	private String c2Code;			/** 중분류 코드 */
	private String c3Code;			/** 소분류 코드 */
	
	
	public String getCourseId() {
		return courseId;
	}
	public void setCourseId(String courseId) {
		this.courseId = courseId;
	}
	public String getCourseCode() {
		return courseCode;
	}
	public void setCourseCode(String courseCode) {
		this.courseCode = courseCode;
	}
	public String getSwf() {
		return swf;
	}
	public void setSwf(String swf) {
		this.swf = swf;
	}
	public String getbImg() {
		return bImg;
	}
	public void setbImg(String bImg) {
		this.bImg = bImg;
	}
	public String getcImg() {
		return cImg;
	}
	public void setcImg(String cImg) {
		this.cImg = cImg;
	}
	public String getmImg1() {
		return mImg1;
	}
	public void setmImg1(String mImg1) {
		this.mImg1 = mImg1;
	}
	public String getmImg2() {
		return mImg2;
	}
	public void setmImg2(String mImg2) {
		this.mImg2 = mImg2;
	}
	public String getmImg3() {
		return mImg3;
	}
	public void setmImg3(String mImg3) {
		this.mImg3 = mImg3;
	}
	public String getsImg1() {
		return sImg1;
	}
	public void setsImg1(String sImg1) {
		this.sImg1 = sImg1;
	}
	public String getsImg2() {
		return sImg2;
	}
	public void setsImg2(String sImg2) {
		this.sImg2 = sImg2;
	}
	public String getsImg3() {
		return sImg3;
	}
	public void setsImg3(String sImg3) {
		this.sImg3 = sImg3;
	}
	public static long getSerialversionuid() {
		return serialVersionUID;
	}
	public String getKind() {
		return kind;
	}
	public void setKind(String kind) {
		this.kind = kind;
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
	public String getCourseName() {
		return courseName;
	}
	public void setCourseName(String courseName) {
		this.courseName = courseName;
	}
	public String getCategoryName() {
		return categoryName;
	}
	public void setCategoryName(String categoryName) {
		this.categoryName = categoryName;
	}
	
	
	
}


