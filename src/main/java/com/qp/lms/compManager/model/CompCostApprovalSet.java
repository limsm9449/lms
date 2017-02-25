package com.qp.lms.compManager.model;

import java.util.List;

import com.qp.lms.common.CodeVO;
import com.qp.lms.common.CommonSet;


public class CompCostApprovalSet extends CommonSet {
	private CompCostApprovalVO condiVO;				// 조건용
	private List<CompCostApprovalVO> list;				// 리스트용
	private CompCostApprovalVO data;					// 데이타용

	private List<CompCostApprovalVO> courseList;
	
	
	public CompCostApprovalVO getCondiVO() {
		return condiVO;
	}
	public void setCondiVO(CompCostApprovalVO condiVO) {
		this.condiVO = condiVO;
	}
	public List<CompCostApprovalVO> getList() {
		return list;
	}
	public void setList(List<CompCostApprovalVO> list) {
		this.list = list;
	}
	public CompCostApprovalVO getData() {
		return data;
	}
	public void setData(CompCostApprovalVO data) {
		this.data = data;
	}
	public List<CompCostApprovalVO> getCourseList() {
		return courseList;
	}
	public void setCourseList(List<CompCostApprovalVO> courseList) {
		this.courseList = courseList;
	}
	
	
	
	

	

}
