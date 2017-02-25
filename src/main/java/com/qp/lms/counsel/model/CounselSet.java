package com.qp.lms.counsel.model;

import java.util.List;

import com.qp.lms.common.CodeVO;
import com.qp.lms.common.CommonSet;



public class CounselSet extends CommonSet { 
	private CounselVO condiVO;			// 조건용
	private List<CounselVO> list;		// 리스트용
	private CounselVO data;			// 데이타용
	
	private List<CodeVO> ddCategory;				// 카테고리
	
	public CounselVO getCondiVO() {
		return condiVO;
	}
	public void setCondiVO(CounselVO condiVO) {
		this.condiVO = condiVO;
	}
	public List<CounselVO> getList() {
		return list;
	}
	public void setList(List<CounselVO> list) {
		this.list = list;
	}
	public CounselVO getData() {
		return data;
	}
	public void setData(CounselVO data) {
		this.data = data;
	}
	public List<CodeVO> getDdCategory() {
		return ddCategory;
	}
	public void setDdCategory(List<CodeVO> ddCategory) {
		this.ddCategory = ddCategory;
	}

	


	

}
