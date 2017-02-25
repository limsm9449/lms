package com.qp.lms.course.model;

import com.qp.lms.common.CommonVO;

public class CourseCodeVO extends CommonVO {
	private static final long serialVersionUID = -1l; 

	private String courseCode;
	private String teacherId;
	private int hPx;
	private int vPx;
	private String code;
	private String codeName;
	private String useYn;
	private String directory;
	private String point;

	private String categoryName;
	private String courseName;
	private String teacherName;

	private String c1Code;			/** 대분류 코드 */
	private String c2Code;			/** 중분류 코드 */
	private String c3Code;			/** 소분류 코드 */

	//2014.6.18 추가
	private String questGroupYn;
	private String qgId;
	private String questGroupName;;
                  
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
	public int gethPx() {
		return hPx;
	}
	public void sethPx(int hPx) {
		this.hPx = hPx;
	}
	public int getvPx() {
		return vPx;
	}
	public void setvPx(int vPx) {
		this.vPx = vPx;
	}
	public String getUseYn() {
		return useYn;
	}
	public void setUseYn(String useYn) {
		this.useYn = useYn;
	}
	public String getCode() {
		return code;
	}

	public void setCode(String code) {
		this.code = code;
	}

	public String getCodeName() {
		return codeName;
	}

	public void setCodeName(String codeName) {
		this.codeName = codeName;
	}

	public String getDirectory() {
		return directory;
	}

	public void setDirectory(String directory) {
		this.directory = directory;
	}

	public static long getSerialversionuid() {
		return serialVersionUID;
	}
	public String getTeacherId() {
		return teacherId;
	}
	public void setTeacherId(String teacherId) {
		this.teacherId = teacherId;
	}
	public String getCategoryName() {
		return categoryName;
	}
	public void setCategoryName(String categoryName) {
		this.categoryName = categoryName;
	}
	public String getTeacherName() {
		return teacherName;
	}
	public void setTeacherName(String teacherName) {
		this.teacherName = teacherName;
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
	public String getPoint() {
		return point;
	}
	public void setPoint(String point) {
		this.point = point;
	}
	public String getQuestGroupYn() {
		return questGroupYn;
	}
	public void setQuestGroupYn(String questGroupYn) {
		this.questGroupYn = questGroupYn;
	}
	public String getQgId() {
		return qgId;
	}
	public void setQgId(String qgId) {
		this.qgId = qgId;
	}
	public String getQuestGroupName() {
		return questGroupName;
	}
	public void setQuestGroupName(String questGroupName) {
		this.questGroupName = questGroupName;
	}
	
	

	
	
	
	

}
