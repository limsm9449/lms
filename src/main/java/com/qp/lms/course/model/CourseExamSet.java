package com.qp.lms.course.model;

import java.util.List;

import com.qp.lms.common.CodeVO;
import com.qp.lms.common.CommonSet;



public class CourseExamSet extends CommonSet {
	private CourseExamVO condiVO;		// 조건용
	private List<CourseExamVO> list;	// 리스트용
	private CourseExamVO data;			// 데이타용

	private List<CourseExamVO> examList;	// 시험 리스트

	private List<CodeVO> ddCategory1Depth;		// 카테고리 대분류
	private List<CodeVO> ddCategory2Depth;		// 카테고리 중분류
	private List<CodeVO> ddCategory3Depth;		// 카테고리 소분류

	private List<CodeVO> ddCourseCode;			// 과정코드

	
	public CourseExamVO getCondiVO() {
		return condiVO;
	}
	public void setCondiVO(CourseExamVO condiVO) {
		this.condiVO = condiVO;
	}
	public List<CourseExamVO> getList() {
		return list;
	}
	public void setList(List<CourseExamVO> list) {
		this.list = list;
	}
	public CourseExamVO getData() {
		return data;
	}
	public void setData(CourseExamVO data) {
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
	public List<CodeVO> getDdCourseCode() {
		return ddCourseCode;
	}
	public void setDdCourseCode(List<CodeVO> ddCourseCode) {
		this.ddCourseCode = ddCourseCode;
	}
	public List<CourseExamVO> getExamList() {
		return examList;
	}
	public void setExamList(List<CourseExamVO> examList) {
		this.examList = examList;
	}
	
	
	


	

}
