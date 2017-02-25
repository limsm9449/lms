package com.qp.lms.board.model;

import com.qp.lms.common.CommonVO;

public class AttachVO extends CommonVO{
	private static final long serialVersionUID = -1l; 
	
	private String seq;
	private String pSeq;
	private String userId;
	private String kind;
	private String fileName;
	private long fileSize;
	private String filePath;
	private String orgFileName;
	private String createDate;
	//private String mode;

	//private int pSeqNew;
	//private String boardKind; 		//C(과정),N(공통) 구분

	public String getFileName() {
		return fileName;
	}
	public void setFileName(String fileName) {
		this.fileName = fileName;
	}
	public String getFilePath() {
		return filePath;
	}
	public void setFilePath(String filePath) {
		this.filePath = filePath;
	}
	public String getOrgFileName() {
		return orgFileName;
	}
	public void setOrgFileName(String orgFileName) {
		this.orgFileName = orgFileName;
	}
	public String getCreateDate() {
		return createDate;
	}
	public void setCreateDate(String createDate) {
		this.createDate = createDate;
	}
	public static long getSerialversionuid() {
		return serialVersionUID;
	}
	public long getFileSize() {
		return fileSize;
	}
	public void setFileSize(long fileSize) {
		this.fileSize = fileSize;
	}
	public String getUserId() {
		return userId;
	}
	public void setUserId(String userId) {
		this.userId = userId;
	}
	public String getKind() {
		return kind;
	}
	public void setKind(String kind) {
		this.kind = kind;
	}
	public String getSeq() {
		return seq;
	}
	public void setSeq(String seq) {
		this.seq = seq;
	}
	public String getpSeq() {
		return pSeq;
	}
	public void setpSeq(String pSeq) {
		this.pSeq = pSeq;
	}
	

	
	
	

}
