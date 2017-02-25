package com.qp.lms.course.model;

import java.util.List;

import com.qp.lms.common.CodeVO;
import com.qp.lms.common.CommonSet;



public class CourseMasterSet extends CommonSet {
	private CourseMasterVO condiVO;		// 조건용
	private List<CourseMasterVO> list;	// 리스트용
	private CourseMasterVO data;			// 데이타용
	
	private List<CodeVO> ddCategory1Depth;		// 카테고리 대분류
	private List<CodeVO> ddCategory2Depth;		// 카테고리 중분류
	private List<CodeVO> ddCategory3Depth;		// 카테고리 소분류

	private List<CodeVO> ddTutor;				// 튜터
	private List<CodeVO> ddCourseCode;			// 과정코드
	
	//2014.6.16
	private List<CourseMasterVO> weekCostList;	// 리스트용
	private List<CodeVO> ddWeekCost;			// 과정 비용 유형 
	
	public CourseMasterVO getCondiVO() {
		return condiVO;
	}
	public void setCondiVO(CourseMasterVO condiVO) {
		this.condiVO = condiVO;
	}
	public List<CourseMasterVO> getList() {
		return list;
	}
	public void setList(List<CourseMasterVO> list) {
		this.list = list;
	}
	public CourseMasterVO getData() {
		return data;
	}
	public void setData(CourseMasterVO data) {
		this.data = data;
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
	public List<CodeVO> getDdTutor() {
		return ddTutor;
	}
	public void setDdTutor(List<CodeVO> ddTutor) {
		this.ddTutor = ddTutor;
	}
	public List<CodeVO> getDdCourseCode() {
		return ddCourseCode;
	}
	public void setDdCourseCode(List<CodeVO> ddCourseCode) {
		this.ddCourseCode = ddCourseCode;
	}
	public List<CourseMasterVO> getWeekCostList() {
		return weekCostList;
	}
	public void setWeekCostList(List<CourseMasterVO> weekCostList) {
		this.weekCostList = weekCostList;
	}
	public List<CodeVO> getDdWeekCost() {
		return ddWeekCost;
	}
	public void setDdWeekCost(List<CodeVO> ddWeekCost) {
		this.ddWeekCost = ddWeekCost;
	}
	
	
	


	

}
