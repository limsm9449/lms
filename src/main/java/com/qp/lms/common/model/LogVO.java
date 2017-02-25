package com.qp.lms.common.model;

import com.qp.lms.common.CommonVO;

public class LogVO extends CommonVO {
	private static final long serialVersionUID = -1l; 

	private String url;
	private String parameter;
	private String ip;
	
	
	
	public String getUrl() {
		return url;
	}
	public void setUrl(String url) {
		this.url = url;
	}
	public static long getSerialversionuid() {
		return serialVersionUID;
	}
	public String getIp() {
		return ip;
	}
	public void setIp(String ip) {
		this.ip = ip;
	}
	public String getParameter() {
		return parameter;
	}
	public void setParameter(String parameter) {
		this.parameter = parameter;
	}

	
	
	
	
	

}
