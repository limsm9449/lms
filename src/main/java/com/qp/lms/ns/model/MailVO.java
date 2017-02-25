package com.qp.lms.ns.model;

import com.qp.lms.common.CommonVO;

public class MailVO extends CommonVO{
	private static final long serialVersionUID = -1l; 
	
	private String userName;
	private String mobile;
	private String email;
	private String category;
	private String mailSubject;
	private String mailContents;
	
	
	public String getUserName() {
		return userName;
	}
	public void setUserName(String userName) {
		this.userName = userName;
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
	public static long getSerialversionuid() {
		return serialVersionUID;
	}
	public String getMailSubject() {
		return mailSubject;
	}
	public void setMailSubject(String mailSubject) {
		this.mailSubject = mailSubject;
	}
	public String getMailContents() {
		return mailContents;
	}
	public void setMailContents(String mailContents) {
		this.mailContents = mailContents;
	}
	public String getCategory() {
		return category;
	}
	public void setCategory(String category) {
		this.category = category;
	}


	
	
	
	
		
	
	

}
