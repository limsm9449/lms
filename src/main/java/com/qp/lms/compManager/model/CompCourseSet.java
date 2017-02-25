package com.qp.lms.compManager.model;

import java.util.List;

import com.qp.lms.common.CodeVO;
import com.qp.lms.common.CommonSet;



public class CompCourseSet extends CommonSet { 
	private CompCourseVO condiVO;				// 조건용
	private List<CompCourseVO> list;			// 리스트용
	private CompCourseVO data;					// 데이타용
	
	public CompCourseVO getCondiVO() {
		return condiVO;
	}
	public void setCondiVO(CompCourseVO condiVO) {
		this.condiVO = condiVO;
	}
	public List<CompCourseVO> getList() {
		return list;
	}
	public void setList(List<CompCourseVO> list) {
		this.list = list;
	}
	public CompCourseVO getData() {
		return data;
	}
	public void setData(CompCourseVO data) {
		this.data = data;
	}

	



	

}
