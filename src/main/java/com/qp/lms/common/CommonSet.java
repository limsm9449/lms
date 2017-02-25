package com.qp.lms.common;


public class CommonSet {
	private int pageUnit;
	private String rtnMode;		// 결과용
	private String rtnData;		// 결과용
	private int totalCount;
	
	private String isAdminYn; 
	
	public int getPageUnit() {
		return ( pageUnit == 0 ? 10 : pageUnit );
	}
	public void setPageUnit(int pageUnit) {
		this.pageUnit = pageUnit;
	}
	public String getRtnMode() {
		return rtnMode;
	}
	public void setRtnMode(String rtnMode) {
		this.rtnMode = rtnMode;
	}
	public String getIsAdminYn() {
		return isAdminYn;
	}
	public void setIsAdminYn(String isAdminYn) {
		this.isAdminYn = isAdminYn;
	}
	public int getTotalCount() {
		return totalCount;
	}
	public void setTotalCount(int totalCount) {
		this.totalCount = totalCount;
	}
	public String getRtnData() {
		return rtnData;
	}
	public void setRtnData(String rtnData) {
		this.rtnData = rtnData;
	}
	

	
	
	

	
	
	

}
