package com.qp.lms.board.model;

import java.util.List;

import com.qp.lms.common.CommonSet;

public class AttachSet extends CommonSet {
	private AttachVO condiVO;		// 조건용
	private AttachVO data;			// 데이타용
	private List<AttachVO> list;	// 리스트용
	
	private String attachFolder;
	
	private String isMy;
	private String downloadAuth;
	
	public AttachVO getCondiVO() {
		return condiVO;
	}
	public void setCondiVO(AttachVO condiVO) {
		this.condiVO = condiVO;
	}
	public AttachVO getData() {
		return data;
	}
	public void setData(AttachVO data) {
		this.data = data;
	}
	public List<AttachVO> getList() {
		return list;
	}
	public void setList(List<AttachVO> list) {
		this.list = list;
	}
	public String getAttachFolder() {
		return attachFolder;
	}
	public void setAttachFolder(String attachFolder) {
		this.attachFolder = attachFolder;
	}
	public String getIsMy() {
		return isMy;
	}
	public void setIsMy(String isMy) {
		this.isMy = isMy;
	}
	public String getDownloadAuth() {
		return downloadAuth;
	}
	public void setDownloadAuth(String downloadAuth) {
		this.downloadAuth = downloadAuth;
	}
	

	

}
