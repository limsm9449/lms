package com.qp.lms.course.model;

import java.util.List;

import com.qp.lms.common.CodeVO;
import com.qp.lms.common.CommonSet;


public class CourseCodeSet extends CommonSet {
	private CourseCodeVO condiVO;			// 조건용
	private List<CourseCodeVO> list;		// 리스트용
	private CourseCodeVO data;				// 데이타용
	
	private List<CodeVO> ddCategory1Depth;		// 카테고리 대분류
	private List<CodeVO> ddCategory2Depth;		// 카테고리 중분류
	private List<CodeVO> ddCategory3Depth;		// 카테고리 소분류
	private List<CodeVO> ddTeacher;			// 강사
	private List<CodeVO> ddQuestGroup;			// 설문
	
	
	
	public CourseCodeVO getCondiVO() {
		return condiVO;
	}
	public void setCondiVO(CourseCodeVO condiVO) {
		this.condiVO = condiVO;
	}
	public List<CourseCodeVO> getList() {
		return list;
	}
	public void setList(List<CourseCodeVO> list) {
		this.list = list;
	}
	public CourseCodeVO getData() {
		return data;
	}
	public void setData(CourseCodeVO data) {
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
	public List<CodeVO> getDdTeacher() {
		return ddTeacher;
	}
	public void setDdTeacher(List<CodeVO> ddTeacher) {
		this.ddTeacher = ddTeacher;
	}
	public List<CodeVO> getDdQuestGroup() {
		return ddQuestGroup;
	}
	public void setDdQuestGroup(List<CodeVO> ddQuestGroup) {
		this.ddQuestGroup = ddQuestGroup;
	}
	
	
	
	
	
	

	

}
