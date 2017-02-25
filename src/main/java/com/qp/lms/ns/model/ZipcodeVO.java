package com.qp.lms.ns.model;

import com.qp.lms.common.CommonVO;

public class ZipcodeVO extends CommonVO{
	private static final long serialVersionUID = -1l; 
	
	private String homeZip;
	private String homeZip1;
	private String homeZip2;
	private String homeAddr;
	private String homeAddr1;
	private String homeAddr2;
	private String seq;

	
	public static long getSerialversionuid() {
		return serialVersionUID;
	}

	public String getHomeZip() {
		return homeZip;
	}

	public void setHomeZip(String homeZip) {
		this.homeZip = homeZip;
	}

	public String getHomeZip1() {
		return homeZip1;
	}

	public void setHomeZip1(String homeZip1) {
		this.homeZip1 = homeZip1;
	}

	public String getHomeZip2() {
		return homeZip2;
	}

	public void setHomeZip2(String homeZip2) {
		this.homeZip2 = homeZip2;
	}

	public String getHomeAddr() {
		return homeAddr;
	}

	public void setHomeAddr(String homeAddr) {
		this.homeAddr = homeAddr;
	}

	public String getHomeAddr1() {
		return homeAddr1;
	}

	public void setHomeAddr1(String homeAddr1) {
		this.homeAddr1 = homeAddr1;
	}

	public String getHomeAddr2() {
		return homeAddr2;
	}

	public void setHomeAddr2(String homeAddr2) {
		this.homeAddr2 = homeAddr2;
	}

	public String getSeq() {
		return seq;
	}

	public void setSeq(String seq) {
		this.seq = seq;
	}

	
	
	
		
	
	

}
