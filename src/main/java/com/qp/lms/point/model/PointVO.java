package com.qp.lms.point.model;

import com.qp.lms.common.CommonVO;

public class PointVO extends CommonVO {
	private static final long serialVersionUID = -1l; 

	private String userId;
	private String userName;
	private String userKind;
	private String mobile;
	private String email;
	private String inPoint;
	private String outPoint;
	private String remainPoint;
	private String kind;
	private String kindName;

	private String searchKind;
	private String searchStr;
	
	public String getUserId() {
		return userId;
	}
	public void setUserId(String userId) {
		this.userId = userId;
	}
	public String getUserName() {
		return userName;
	}
	public void setUserName(String userName) {
		this.userName = userName;
	}
	public String getInPoint() {
		return inPoint;
	}
	public void setInPoint(String inPoint) {
		this.inPoint = inPoint;
	}
	public String getOutPoint() {
		return outPoint;
	}
	public void setOutPoint(String outPoint) {
		this.outPoint = outPoint;
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
	public String getUserKind() {
		return userKind;
	}
	public void setUserKind(String userKind) {
		this.userKind = userKind;
	}
	public String getMobile() {
		return mobile;
	}
	public void setMobile(String mobile) {
		this.mobile = mobile;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getKindName() {
		return kindName;
	}
	public void setKindName(String kindName) {
		this.kindName = kindName;
	}
	public String getSearchKind() {
		return searchKind;
	}
	public void setSearchKind(String searchKind) {
		this.searchKind = searchKind;
	}
	public String getSearchStr() {
		return searchStr;
	}
	public void setSearchStr(String searchStr) {
		this.searchStr = searchStr;
	}
	public String getRemainPoint() {
		return remainPoint;
	}
	public void setRemainPoint(String remainPoint) {
		this.remainPoint = remainPoint;
	}

	
	

}
