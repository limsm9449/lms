package com.qp.lms.guest.model;

import com.qp.lms.common.CommonVO;

public class BankVO extends CommonVO {
	private static final long serialVersionUID = -1l; 

	private String seq;
	private String bankName;
	private String accNo;
	private String user;
	
	
	
	public String getBankName() {
		return bankName;
	}
	public void setBankName(String bankName) {
		this.bankName = bankName;
	}
	public String getAccNo() {
		return accNo;
	}
	public void setAccNo(String accNo) {
		this.accNo = accNo;
	}
	public String getUser() {
		return user;
	}
	public void setUser(String user) {
		this.user = user;
	}
	public static long getSerialversionuid() {
		return serialVersionUID;
	}
	public String getSeq() {
		return seq;
	}
	public void setSeq(String seq) {
		this.seq = seq;
	}

		
	
	
	
	
	
	
	

}
