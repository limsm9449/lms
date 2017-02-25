package com.qp.lms.evaluation.model;

import java.util.List;

import com.qp.lms.course.model.CourseVO;
import com.qp.lms.common.CodeVO;
import com.qp.lms.common.CommonSet;
import com.qp.lms.exam.model.ExamVO;



public class EvaluationSet extends CommonSet {
	private EvaluationVO condiVO;		// 조건용
	private List<EvaluationVO> list;	// 리스트용
	private EvaluationVO data;			// 데이타용
	
	private List<CodeVO> ddCategory1Depth;		// 카테고리 대분류
	private List<CodeVO> ddCategory2Depth;		// 카테고리 중분류
	private List<CodeVO> ddCategory3Depth;		// 카테고리 소분류
	private List<CodeVO> ddCourseCode;			// 과정코드
	
	private EvaluationVO evaluation;				
	private List<EvaluationVO> week;

	//2014.6.20 추가
	private List<ExamVO> userExamList;

	public EvaluationVO getCondiVO() {
		return condiVO;
	}
	public void setCondiVO(EvaluationVO condiVO) {
		this.condiVO = condiVO;
	}
	public List<EvaluationVO> getList() {
		return list;
	}
	public void setList(List<EvaluationVO> list) {
		this.list = list;
	}
	public EvaluationVO getData() {
		return data;
	}
	public void setData(EvaluationVO data) {
		this.data = data;
	}
	public List<CodeVO> getDdCourseCode() {
		return ddCourseCode;
	}
	public void setDdCourseCode(List<CodeVO> ddCourseCode) {
		this.ddCourseCode = ddCourseCode;
	}
	public EvaluationVO getEvaluation() {
		return evaluation;
	}
	public void setEvaluation(EvaluationVO evaluation) {
		this.evaluation = evaluation;
	}
	public List<EvaluationVO> getWeek() {
		return week;
	}
	public void setWeek(List<EvaluationVO> week) {
		this.week = week;
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
	public List<ExamVO> getUserExamList() {
		return userExamList;
	}
	public void setUserExamList(List<ExamVO> userExamList) {
		this.userExamList = userExamList;
	}
	
	
	
	


	

}
