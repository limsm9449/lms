package com.qp.lms.system.model;

import com.qp.lms.common.CommonVO;


public class SystemVO extends CommonVO {
	private static final long serialVersionUID = -1l; 

	public String seq;
	public String userId;
	public String ip;
	public String url;
	public String parameter;
	public String createDate;
	public String userName;
	
	public String searchKind;
	public String searchStr;
	public String searchStr2;
	
	
	public String getSeq() {
		return seq;
	}
	public void setSeq(String seq) {
		this.seq = seq;
	}
	public String getUserId() {
		return userId;
	}
	public void setUserId(String userId) {
		this.userId = userId;
	}
	public String getIp() {
		return ip;
	}
	public void setIp(String ip) {
		this.ip = ip;
	}
	public String getUrl() {
		return url;
	}
	public void setUrl(String url) {
		this.url = url;
	}
	public String getParameter() {
		return parameter;
	}
	public void setParameter(String parameter) {
		this.parameter = parameter;
	}
	public String getCreateDate() {
		return createDate;
	}
	public void setCreateDate(String createDate) {
		this.createDate = createDate;
	}
	public String getUserName() {
		return userName;
	}
	public void setUserName(String userName) {
		this.userName = userName;
	}
	public static long getSerialversionuid() {
		return serialVersionUID;
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
	public String getSearchStr2() {
		return searchStr2;
	}
	public void setSearchStr2(String searchStr2) {
		this.searchStr2 = searchStr2;
	}
	
	
	
	
	

}
