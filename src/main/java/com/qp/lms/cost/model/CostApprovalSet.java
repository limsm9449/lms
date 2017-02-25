package com.qp.lms.cost.model;

import java.util.List;

import com.qp.lms.common.CodeVO;
import com.qp.lms.common.CommonSet;


public class CostApprovalSet extends CommonSet {
	private CostApprovalVO condiVO;				// 조건용
	private List<CostApprovalVO> list;				// 리스트용
	private CostApprovalVO data;					// 데이타용

	private List<CostApprovalVO> courseList;
	
	
	public CostApprovalVO getCondiVO() {
		return condiVO;
	}
	public void setCondiVO(CostApprovalVO condiVO) {
		this.condiVO = condiVO;
	}
	public List<CostApprovalVO> getList() {
		return list;
	}
	public void setList(List<CostApprovalVO> list) {
		this.list = list;
	}
	public CostApprovalVO getData() {
		return data;
	}
	public void setData(CostApprovalVO data) {
		this.data = data;
	}
	public List<CostApprovalVO> getCourseList() {
		return courseList;
	}
	public void setCourseList(List<CostApprovalVO> courseList) {
		this.courseList = courseList;
	}
	
	
	
	

	

}
