package com.qp.lms.company.model;

import java.util.List;

import com.qp.lms.common.CodeVO;
import com.qp.lms.common.CommonSet;
import com.qp.lms.course.model.CourseVO;
import com.qp.lms.course.model.CourseMasterVO;
import com.qp.lms.course.model.NormalCourseVO;
import com.qp.lms.course.model.RegisterVO;



public class CompanyCourseSet extends CommonSet { 
	private CompanyCourseVO condiVO;			// 조건용
	private List<CompanyCourseVO> list;			// 리스트용
	private CompanyCourseVO data;				// 데이타용
	private CourseMasterVO cmData;				// 과정 마스터 데이타용

	private List<CodeVO> ddCategory1Depth;		// 카테고리 대분류
	private List<CodeVO> ddCategory2Depth;		// 카테고리 중분류
	private List<CodeVO> ddCategory3Depth;		// 카테고리 소분류
	private List<CodeVO> ddCourseCode;			// 과정코드
	private List<CodeVO> ddStatus;				// 과정상태
	private List<CodeVO> ddCompany;			// 회사

	private List<RegisterVO> registerList;			// 수강생 리스트

	private List<CompanyCourseVO> titleList;	// 목차

	//2014.6.16
	private List<CompanyCourseVO> weekCostList;	// 차수별 비용 리스트

	
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
	public List<CodeVO> getDdStatus() {
		return ddStatus;
	}
	public void setDdStatus(List<CodeVO> ddStatus) {
		this.ddStatus = ddStatus;
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
	public CompanyCourseVO getCondiVO() {
		return condiVO;
	}
	public void setCondiVO(CompanyCourseVO condiVO) {
		this.condiVO = condiVO;
	}
	public List<CompanyCourseVO> getList() {
		return list;
	}
	public void setList(List<CompanyCourseVO> list) {
		this.list = list;
	}
	public CompanyCourseVO getData() {
		return data;
	}
	public void setData(CompanyCourseVO data) {
		this.data = data;
	}
	public List<CodeVO> getDdCompany() {
		return ddCompany;
	}
	public void setDdCompany(List<CodeVO> ddCompany) {
		this.ddCompany = ddCompany;
	}
	public List<CompanyCourseVO> getTitleList() {
		return titleList;
	}
	public void setTitleList(List<CompanyCourseVO> titleList) {
		this.titleList = titleList;
	}
	public List<CompanyCourseVO> getWeekCostList() {
		return weekCostList;
	}
	public void setWeekCostList(List<CompanyCourseVO> weekCostList) {
		this.weekCostList = weekCostList;
	}

	
	


	

}
