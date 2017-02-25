package com.qp.lms.course.model;

import java.util.List;

import com.qp.lms.common.CodeVO;
import com.qp.lms.common.CommonSet;
import com.qp.lms.member.model.MemberVO;
import com.qp.lms.user.model.UserVO;



public class CourseManageSet extends CommonSet { 
	private CourseManageVO condiVO;			// 조건용
	private List<CourseManageVO> list;			// 리스트용
	private CourseManageVO data;				// 데이타용
	private CourseMasterVO cmData;				// 과정 마스터 데이타용

	private List<CodeVO> ddCategory1Depth;		// 카테고리 대분류
	private List<CodeVO> ddCategory2Depth;		// 카테고리 중분류
	private List<CodeVO> ddCategory3Depth;		// 카테고리 소분류
	private List<CodeVO> ddCourseCode;			// 과정코드
	private List<CodeVO> ddStatus;				// 과정상태
	private List<CodeVO> ddTutor;				// 튜터

	private List<RegisterVO> registerList;			// 수강생 리스트


	
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
	public CourseManageVO getCondiVO() {
		return condiVO;
	}
	public void setCondiVO(CourseManageVO condiVO) {
		this.condiVO = condiVO;
	}
	public List<CourseManageVO> getList() {
		return list;
	}
	public void setList(List<CourseManageVO> list) {
		this.list = list;
	}
	public CourseManageVO getData() {
		return data;
	}
	public void setData(CourseManageVO data) {
		this.data = data;
	}
	public List<CodeVO> getDdCourseCode() {
		return ddCourseCode;
	}
	public void setDdCourseCode(List<CodeVO> ddCourseCode) {
		this.ddCourseCode = ddCourseCode;
	}
	public List<CodeVO> getDdStatus() {
		return ddStatus;
	}
	public void setDdStatus(List<CodeVO> ddStatus) {
		this.ddStatus = ddStatus;
	}
	public List<CodeVO> getDdTutor() {
		return ddTutor;
	}
	public void setDdTutor(List<CodeVO> ddTutor) {
		this.ddTutor = ddTutor;
	}
	public CourseMasterVO getCmData() {
		return cmData;
	}
	public void setCmData(CourseMasterVO cmData) {
		this.cmData = cmData;
	}
	public List<RegisterVO> getRegisterList() {
		return registerList;
	}
	public void setRegisterList(List<RegisterVO> registerList) {
		this.registerList = registerList;
	}

	
	


	

}
