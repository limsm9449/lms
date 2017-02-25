package com.qp.lms.board.model;

import com.qp.lms.common.CommonVO;

public class BoardFaqVO extends CommonVO{
	private static final long serialVersionUID = -1l; 
	
	private String seq;
	private String category;
	private String categoryName;
	private String title;
	private String contents;
	private String viewCnt;
	
	private String findString;
	
	//2014.7.30
	private String isNew;
		
	public String getSeq() {
		return seq;
	}
	public void setSeq(String seq) {
		this.seq = seq;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getContents() {
		return contents;
	}
	public void setContents(String contents) {
		this.contents = contents;
	}
	public String getCategory() {
		return category;
	}
	public void setCategory(String category) {
		this.category = category;
	}
	public String getViewCnt() {
		return viewCnt;
	}
	public void setViewCnt(String viewCnt) {
		this.viewCnt = viewCnt;
	}
	public String getFindString() {
		return findString;
	}
	public void setFindString(String findString) {
		this.findString = findString;
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
	public String getIsNew() {
		return isNew;
	}
	public void setIsNew(String isNew) {
		this.isNew = isNew;
	}
		
	
	
	

}
