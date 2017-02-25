package com.qp.lms.common;

import java.io.Serializable;

public class CommonVO implements Serializable{
	private static final long serialVersionUID = -1l; 
	
	private String userId;
	private String createDate;
	private String createUser;
	private String updateDate;
	private String updateUser; 
	private String locale;
	
	private int rownum;
	private int cnt;
	
	private String selIds;	//선택된 ids들...
	
	private int subCnt;	//하위에서 사용하고 있는 갯수	

	private int pageNum;
	private int limitStart;
	private int limitUnit;
	
	private String mode;
	private String auth;	
	
	private String screen;	//넘어온 화면 코드
	
	private String isExcel;
	
	private String isEdit;
	private String isAdmin;

	private String isViewTitle;	//타이블 보여줄지 여부


	// 삭제하면 안됨.-------------------------------------------------
	public int getPageNum() {
		return ( pageNum == 0 ? 1 : pageNum );
	}
	public void setPageNum(int pageNum) {
		this.pageNum = pageNum;
	}
	public int getLimitStart() {
		limitStart = ( getPageNum() - 1 ) * limitUnit;
		return limitStart;
	}
	public void setLimitStart(int limitStart) {
		this.limitStart = limitStart;
	}
	public int getLimitUnit() {
		return ( limitUnit == 0 ? 10 : limitUnit);
	}
	public void setLimitUnit(int limitUnit) {
		this.limitUnit = limitUnit;
	}
	public String getIsExcel() {
		return (isExcel == null ? "N" : isExcel);
	}
	public void setIsExcel(String isExcel) {
		this.isExcel = isExcel;
	}
	// 삭제하면 안됨.-------------------------------------------------


	
	public String getCreateDate() {
		return createDate;
	}

	public void setCreateDate(String createDate) {
		this.createDate = createDate;
	}

	public String getCreateUser() {
		return createUser;
	}

	public void setCreateUser(String createUser) {
		this.createUser = createUser;
	}

	public String getUpdateDate() {
		return updateDate;
	}

	public void setUpdateDate(String updateDate) {
		this.updateDate = updateDate;
	}

	public String getUpdateUser() {
		return updateUser;
	}

	public void setUpdateUser(String updateUser) {
		this.updateUser = updateUser;
	}

	public String getLocale() {
		return locale;
	}

	public void setLocale(String locale) {
		this.locale = locale;
	}

	public int getCnt() {
		return cnt;
	}

	public void setCnt(int cnt) {
		this.cnt = cnt;
	}
	public int getSubCnt() {
		return subCnt;
	}
	public void setSubCnt(int subCnt) {
		this.subCnt = subCnt;
	}
	public String getSelIds() {
		return selIds;
	}
	public void setSelIds(String selIds) {
		this.selIds = selIds;
	}
	public static long getSerialVersionUID() {
		return serialVersionUID;
	}
	public String getUserId() {
		return userId;
	}
	public void setUserId(String userId) {
		this.userId = userId;
	}
	public String getMode() {
		return mode;
	}
	public void setMode(String mode) {
		this.mode = mode;
	}
	public static long getSerialversionuid() {
		return serialVersionUID;
	}
	public String getScreen() {
		return screen;
	}
	public void setScreen(String screen) {
		this.screen = screen;
	}
	public String getAuth() {
		return auth;
	}
	public void setAuth(String auth) {
		this.auth = auth;
	}
	public int getRownum() {
		return rownum;
	}
	public void setRownum(int rownum) {
		this.rownum = rownum;
	}
	public String getIsEdit() {
		return isEdit;
	}
	public void setIsEdit(String isEdit) {
		this.isEdit = isEdit;
	}
	public String getIsAdmin() {
		return isAdmin;
	}
	public void setIsAdmin(String isAdmin) {
		this.isAdmin = isAdmin;
	}
	public String getIsViewTitle() {
		return isViewTitle;
	}
	public void setIsViewTitle(String isViewTitle) {
		this.isViewTitle = isViewTitle;
	}

	
	
	

	
	
	

}
