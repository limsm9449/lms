package com.qp.lms.common.model;

import com.qp.lms.common.CommonVO;

public class CommVO extends CommonVO {
	private static final long serialVersionUID = -1l; 

	private String courseId;
	private String userId;
	private String completeYn;
	private String courseKind;
	private String isPeriod;
	
	private String status;
	
	private String parentCode;
	private String categoryNames;
	
	private String kind;
	private String searchStr;
 
	//2014.8.3
	private String jspPage;
	
	//2014.8.24
	private String Url;

	
	
	public String getParentCode() {
		return parentCode;
	}
	public void setParentCode(String parentCode) {
		this.parentCode = parentCode;
	}
	public static long getSerialVersionUID() {
		return serialVersionUID;
	}
	public String getCategoryNames() {
		return categoryNames;
	}
	public void setCategoryNames(String categoryNames) {
		this.categoryNames = categoryNames;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	public String getCourseId() {
		return courseId;
	}
	public void setCourseId(String courseId) {
		this.courseId = courseId;
	}
	public String getUserId() {
		return userId;
	}
	public void setUserId(String userId) {
		this.userId = userId;
	}
	public static long getSerialversionuid() {
		return serialVersionUID;
	}
	public String getCompleteYn() {
		return completeYn;
	}
	public void setCompleteYn(String completeYn) {
		this.completeYn = completeYn;
	}
	public String getCourseKind() {
		return courseKind;
	}
	public void setCourseKind(String courseKind) {
		this.courseKind = courseKind;
	}
	public String getIsPeriod() {
		return isPeriod;
	}
	public void setIsPeriod(String isPeriod) {
		this.isPeriod = isPeriod;
	}
	public String getKind() {
		return kind;
	}
	public void setKind(String kind) {
		this.kind = kind;
	}
	public String getSearchStr() {
		return searchStr;
	}
	public void setSearchStr(String searchStr) {
		this.searchStr = searchStr;
	}
	public String getJspPage() {
		return jspPage;
	}
	public void setJspPage(String jspPage) {
		this.jspPage = jspPage;
	}
	public String getUrl() {
		return Url;
	}
	public void setUrl(String url) {
		Url = url;
	}
	
	
	
	

}
