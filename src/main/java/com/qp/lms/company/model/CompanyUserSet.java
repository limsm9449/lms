package com.qp.lms.company.model;

import java.util.List;

import com.qp.lms.common.CodeVO;
import com.qp.lms.common.CommonSet;



public class CompanyUserSet extends CommonSet { 
	private CompanyUserVO condiVO;				// 조건용
	private List<CompanyUserVO> list;			// 리스트용

	
	public CompanyUserVO getCondiVO() {
		return condiVO;
	}
	public void setCondiVO(CompanyUserVO condiVO) {
		this.condiVO = condiVO;
	}
	public List<CompanyUserVO> getList() {
		return list;
	}
	public void setList(List<CompanyUserVO> list) {
		this.list = list;
	}


	

}
