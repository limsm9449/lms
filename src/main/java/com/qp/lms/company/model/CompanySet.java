package com.qp.lms.company.model;

import java.util.List;

import com.qp.lms.common.CodeVO;
import com.qp.lms.common.CommonSet;



public class CompanySet extends CommonSet { 
	private CompanyVO condiVO;				// 조건용
	private List<CompanyVO> list;			// 리스트용
	private CompanyVO data;				// 데이타용

	private List<CodeVO> ddTutor;			// 튜터 대상자들
	
	private List<CompanyUserVO> userList;			// 회사 직원 리스트용
	
	
	
	public CompanyVO getCondiVO() {
		return condiVO;
	}
	public void setCondiVO(CompanyVO condiVO) {
		this.condiVO = condiVO;
	}
	public List<CompanyVO> getList() {
		return list;
	}
	public void setList(List<CompanyVO> list) {
		this.list = list;
	}
	public CompanyVO getData() {
		return data;
	}
	public void setData(CompanyVO data) {
		this.data = data;
	}
	public List<CompanyUserVO> getUserList() {
		return userList;
	}
	public void setUserList(List<CompanyUserVO> userList) {
		this.userList = userList;
	}
	public List<CodeVO> getDdTutor() {
		return ddTutor;
	}
	public void setDdTutor(List<CodeVO> ddTutor) {
		this.ddTutor = ddTutor;
	}
	


	

}
