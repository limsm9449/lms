package com.qp.lms.course.model;

import java.util.List;

import com.qp.lms.common.CodeVO;
import com.qp.lms.common.CommonSet;
import com.qp.lms.member.model.MemberVO;
import com.qp.lms.user.model.UserVO;



public class CourseSet extends CommonSet { 
	private CourseVO condiVO;		// 조건용
	private List<CourseVO> list;	// 리스트용
	private CourseVO data;			// 데이타용

	private List<CodeVO> ddCategory1Depth;		// 카테고리 대분류
	private List<CodeVO> ddCategory2Depth;		// 카테고리 중분류
	private List<CodeVO> ddCategory3Depth;		// 카테고리 소분류


	
	private List<MemberVO> staffList;
	
	private List<CodeVO> ddMobile; 
	private List<CodeVO> ddCourseCode; 
	private List<CodeVO> ddTutor;
	private List<CodeVO> ddStatus;

	private List<CodeVO> ddRate;
	
	private List<RegisterVO> approvalList;
	private List<RegisterVO> rejectList;
	
	private List<CodeVO> ddCategory;
	private List<CodeVO> ddParentCategory;
	
	private String existCourseUserids = "";
	private String existUserids = "";

	public CourseVO getCondiVO() {
		return condiVO;
	}
	public void setCondiVO(CourseVO condiVO) {
		this.condiVO = condiVO;
	}
	public List<CourseVO> getList() {
		return list;
	}
	public void setList(List<CourseVO> list) {
		this.list = list;
	}
	public CourseVO getData() {
		return data;
	}
	public void setData(CourseVO data) {
		this.data = data;
	}
	public List<CodeVO> getDdCourseCode() {
		return ddCourseCode;
	}
	public void setDdCourseCode(List<CodeVO> ddCourseCode) {
		this.ddCourseCode = ddCourseCode;
	}
	public List<CodeVO> getDdRate() {
		return ddRate;
	}
	public void setDdRate(List<CodeVO> ddRate) {
		this.ddRate = ddRate;
	}
	public List<CodeVO> getDdStatus() {
		return ddStatus;
	}
	public void setDdStatus(List<CodeVO> ddStatus) {
		this.ddStatus = ddStatus;
	}
	public List<RegisterVO> getApprovalList() {
		return approvalList;
	}
	public void setApprovalList(List<RegisterVO> approvalList) {
		this.approvalList = approvalList;
	}
	public List<RegisterVO> getRejectList() {
		return rejectList;
	}
	public void setRejectList(List<RegisterVO> rejectList) {
		this.rejectList = rejectList;
	}
	public List<CodeVO> getDdCategory() {
		return ddCategory;
	}
	public void setDdCategory(List<CodeVO> ddCategory) {
		this.ddCategory = ddCategory;
	}
	public List<CodeVO> getDdParentCategory() {
		return ddParentCategory;
	}
	public void setDdParentCategory(List<CodeVO> ddParentCategory) {
		this.ddParentCategory = ddParentCategory;
	}
	public List<CodeVO> getDdTutor() {
		return ddTutor;
	}
	public void setDdTutor(List<CodeVO> ddTutor) {
		this.ddTutor = ddTutor;
	}
	public List<MemberVO> getStaffList() {
		return staffList;
	}
	public void setStaffList(List<MemberVO> staffList) {
		this.staffList = staffList;
	}
	public List<CodeVO> getDdMobile() {
		return ddMobile;
	}
	public void setDdMobile(List<CodeVO> ddMobile) {
		this.ddMobile = ddMobile;
	}
	public String getExistCourseUserids() {
		return existCourseUserids;
	}
	public void setExistCourseUserids(String existCourseUserids) {
		this.existCourseUserids = existCourseUserids;
	}
	public String getExistUserids() {
		return existUserids;
	}
	public void setExistUserids(String existUserids) {
		this.existUserids = existUserids;
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
