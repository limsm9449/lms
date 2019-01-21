package com.qp.lms.course.model;

import com.qp.lms.common.CommonVO;

public class CourseResourceVO extends CommonVO {
	private static final long serialVersionUID = -1l; 

	private String courseCode;
	private String courseName;
	private String title;
	private String week;
	private String weekTime;
	private String directory;
	private String rootDirectory;
	private String pageCnt;
	private String weekCnt;
	private String previewPage;
	private String weekCost;
	private String codeName;

	private String categoryName;
	
	private String c1Code;			/** 대분류 코드 */
	private String c2Code;			/** 중분류 코드 */
	private String c3Code;			/** 소분류 코드 */

	private String[] titles;
	private String[] weeks;
	private String[] directorys;
	private String[] pageCnts;
	private String[] previewPages;
	
	private String vPx;
	private String hPx;
	
	private String fileName;
	private String page;
	
	private int addPageCnt;
	
	
	
	public String getCourseCode() {
		return courseCode;
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
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getWeek() {
		return week;
	}
	public void setWeek(String week) {
		this.week = week;
	}
	public String getDirectory() {
		return directory;
	}
	public void setDirectory(String directory) {
		this.directory = directory;
	}
	public String getPageCnt() {
		return pageCnt;
	}
	public void setPageCnt(String pageCnt) {
		this.pageCnt = pageCnt;
	}
	public String getWeekCnt() {
		return weekCnt;
	}
	public void setWeekCnt(String weekCnt) {
		this.weekCnt = weekCnt;
	}
	public String getCodeName() {
		return codeName;
	}
	public void setCodeName(String codeName) {
		this.codeName = codeName;
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
	public String[] getTitles() {
		return titles;
	}
	public void setTitles(String[] titles) {
		this.titles = titles;
	}
	public String[] getWeeks() {
		return weeks;
	}
	public void setWeeks(String[] weeks) {
		this.weeks = weeks;
	}
	public String[] getDirectorys() {
		return directorys;
	}
	public void setDirectorys(String[] directorys) {
		this.directorys = directorys;
	}
	public String[] getPageCnts() {
		return pageCnts;
	}
	public void setPageCnts(String[] pageCnts) {
		this.pageCnts = pageCnts;
	}
	public static long getSerialversionuid() {
		return serialVersionUID;
	}
	public String getCategoryName() {
		return categoryName;
	}
	public void setCategoryName(String categoryName) {
		this.categoryName = categoryName;
	}
	public String getRootDirectory() {
		return rootDirectory;
	}
	public void setRootDirectory(String rootDirectory) {
		this.rootDirectory = rootDirectory;
	}
	public String getvPx() {
		return vPx;
	}
	public void setvPx(String vPx) {
		this.vPx = vPx;
	}
	public String gethPx() {
		return hPx;
	}
	public void sethPx(String hPx) {
		this.hPx = hPx;
	}
	public String getFileName() {
		return fileName;
	}
	public void setFileName(String fileName) {
		this.fileName = fileName;
	}
	public String getPreviewPage() {
		return previewPage;
	}
	public void setPreviewPage(String previewPage) {
		this.previewPage = previewPage;
	}
	public String getWeekCost() {
		return weekCost;
	}
	public void setWeekCost(String weekCost) {
		this.weekCost = weekCost;
	}
	public String[] getPreviewPages() {
		return previewPages;
	}
	public void setPreviewPages(String[] previewPages) {
		this.previewPages = previewPages;
	}
	public String getWeekTime() {
		return weekTime;
	}
	public void setWeekTime(String weekTime) {
		this.weekTime = weekTime;
	}
	public String getPage() {
		return page;
	}
	public void setPage(String page) {
		this.page = page;
	}
	public int getAddPageCnt() {
		return addPageCnt;
	}
	public void setAddPageCnt(int addPageCnt) {
		this.addPageCnt = addPageCnt;
	}
	

	
	

	
	

}
