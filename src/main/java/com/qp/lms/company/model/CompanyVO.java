package com.qp.lms.company.model;

import com.qp.lms.common.CommonVO;

public class CompanyVO extends CommonVO {
	private static final long serialVersionUID = -1l; 

	
	private String compCd;
	private String compName;
	private String addr;
	private String zipcodeSeq;
	private String compTel;
	private String fax;
	private String tutorId;
	private String businessNo;
	private String ownerName;
	
	private String tutorName;
	private String tutorEmail;
	private String tutorTel;
	private String tutorMobile;
	private String tutorPassword;
	
	private String orgTutorId;
	private String empCnt;					/** 직원수 */

	private String fCompName;				/** 검색 - 회사명 */

	
	
	public String getCompCd() {
		return compCd;
	}
	public void setCompCd(String compCd) {
		this.compCd = compCd;
	}
	public String getCompName() {
		return compName;
	}
	public void setCompName(String compName) {
		this.compName = compName;
	}
	public String getAddr() {
		return addr;
	}
	public void setAddr(String addr) {
		this.addr = addr;
	}
	public String getZipcodeSeq() {
		return zipcodeSeq;
	}
	public void setZipcodeSeq(String zipcodeSeq) {
		this.zipcodeSeq = zipcodeSeq;
	}
	public String getCompTel() {
		return compTel;
	}
	public void setCompTel(String compTel) {
		this.compTel = compTel;
	}
	public String getTutorId() {
		return tutorId;
	}
	public void setTutorId(String tutorId) {
		this.tutorId = tutorId;
	}
	public String getBusinessNo() {
		return businessNo;
	}
	public void setBusinessNo(String businessNo) {
		this.businessNo = businessNo;
	}
	public String getOwnerName() {
		return ownerName;
	}
	public void setOwnerName(String ownerName) {
		this.ownerName = ownerName;
	}
	public static long getSerialversionuid() {
		return serialVersionUID;
	}
	public String getEmpCnt() {
		return empCnt;
	}
	public void setEmpCnt(String empCnt) {
		this.empCnt = empCnt;
	}
	public String getfCompName() {
		return fCompName;
	}
	public void setfCompName(String fCompName) {
		this.fCompName = fCompName;
	}
	public String getTutorName() {
		return tutorName;
	}
	public void setTutorName(String tutorName) {
		this.tutorName = tutorName;
	}
	public String getTutorEmail() {
		return tutorEmail;
	}
	public void setTutorEmail(String tutorEmail) {
		this.tutorEmail = tutorEmail;
	}
	public String getTutorTel() {
		return tutorTel;
	}
	public void setTutorTel(String tutorTel) {
		this.tutorTel = tutorTel;
	}
	public String getTutorMobile() {
		return tutorMobile;
	}
	public void setTutorMobile(String tutorMobile) {
		this.tutorMobile = tutorMobile;
	}
	public String getTutorPassword() {
		return tutorPassword;
	}
	public void setTutorPassword(String tutorPassword) {
		this.tutorPassword = tutorPassword;
	}
	public String getFax() {
		return fax;
	}
	public void setFax(String fax) {
		this.fax = fax;
	}
	public String getOrgTutorId() {
		return orgTutorId;
	}
	public void setOrgTutorId(String orgTutorId) {
		this.orgTutorId = orgTutorId;
	}

	
	
	

}
