package com.qp.lms.approval.model;

import java.util.List;

import com.qp.lms.common.CodeVO;
import com.qp.lms.common.CommonSet;

 

public class ApprovalNormalSet extends CommonSet {
	private ApprovalNormalVO condiVO;				// 조건용
	private List<ApprovalNormalVO> list;				// 리스트용
	private ApprovalNormalVO data;					// 데이타용
	private String rtnMode;					// 결과용
	
	private List<CodeVO> ddCategory1Depth;		// 카테고리 대분류
	private List<CodeVO> ddCategory2Depth;		// 카테고리 중분류
	private List<CodeVO> ddCategory3Depth;		// 카테고리 소분류
	private List<CodeVO> ddCourseCode;			// 과정코드
	
	
	public ApprovalNormalVO getCondiVO() {
		return condiVO;
	}
	public void setCondiVO(ApprovalNormalVO condiVO) {
		this.condiVO = condiVO;
	}
	public List<ApprovalNormalVO> getList() { 
		return list;
	}
	public void setList(List<ApprovalNormalVO> list) {
		this.list = list;
	}
	public ApprovalNormalVO getData() {
		return data;
	}
	public void setData(ApprovalNormalVO data) {
		this.data = data;
	}
	public String getRtnMode() {
		return rtnMode;
	}
	public void setRtnMode(String rtnMode) {
		this.rtnMode = rtnMode;
	}
	public List<CodeVO> getDdCourseCode() {
		return ddCourseCode; 
	}
	public void setDdCourseCode(List<CodeVO> ddCourseCode) {
		this.ddCourseCode = ddCourseCode;
	}
	public List<CodeVO> getDdCategory1Depth() {
		return ddCategory1Depth;
	}
	public void setDdCategory1Depth(List<CodeVO> ddCategory1Depth) {
		this.ddCategory1Depth = ddCategory1Depth;
	}
	public List<CodeVO> getDdCategory2Depth() {
		return ddCategory2Depth;
	}
	public void setDdCategory2Depth(List<CodeVO> ddCategory2Depth) {
		this.ddCategory2Depth = ddCategory2Depth;
	}
	public List<CodeVO> getDdCategory3Depth() {
		return ddCategory3Depth;
	}
	public void setDdCategory3Depth(List<CodeVO> ddCategory3Depth) {
		this.ddCategory3Depth = ddCategory3Depth;
	}
	
	
	
	


	

}
