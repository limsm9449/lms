package com.qp.lms.approval.model;

import java.util.List;

import com.qp.lms.common.CodeVO;
import com.qp.lms.common.CommonSet;

 

public class ApprovalCompanySet extends CommonSet {
	private ApprovalCompanyVO condiVO;				// 조건용
	private List<ApprovalCompanyVO> list;				// 리스트용
	private ApprovalCompanyVO data;					// 데이타용
	private String rtnMode;					// 결과용
	
	private List<CodeVO> ddCategory1Depth;		// 카테고리 대분류
	private List<CodeVO> ddCategory2Depth;		// 카테고리 중분류
	private List<CodeVO> ddCategory3Depth;		// 카테고리 소분류
	private List<CodeVO> ddCourseCode;			// 과정코드
	
	
	public ApprovalCompanyVO getCondiVO() {
		return condiVO;
	}
	public void setCondiVO(ApprovalCompanyVO condiVO) {
		this.condiVO = condiVO;
	}
	public List<ApprovalCompanyVO> getList() { 
		return list;
	}
	public void setList(List<ApprovalCompanyVO> list) {
		this.list = list;
	}
	public ApprovalCompanyVO getData() {
		return data;
	}
	public void setData(ApprovalCompanyVO data) {
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
