package com.qp.lms.main.model;

import java.util.List;

import com.qp.lms.common.CodeVO;
import com.qp.lms.common.CommonSet;
import com.qp.lms.common.SessionVO;
import com.qp.lms.course.model.CourseResourceVO;
import com.qp.lms.course.model.CourseVO;
import com.qp.lms.guest.model.BankVO;
import com.qp.lms.member.model.MemberVO;



public class MainSet extends CommonSet { 
	private SessionVO sessVO;

	private MainVO condiVO;		
	private MainVO data;
	
	private List<CourseVO> courseList;
	private CourseVO courseData;
	private List<CourseResourceVO> courseResourceList;

	private List<CourseVO> categoryList;

	//2014.6.24 추가
	private MemberVO memberVO;
	
	//2014.8.3
	List<BankVO> bankList;
	
	//2014.8.24
	List<CodeVO> ddMailList; 

	private List<CodeVO> ddCategory1Depth;		// 카테고리 대분류
	private List<CodeVO> ddCategory2Depth;		// 카테고리 중분류
	private List<CodeVO> ddCategory3Depth;		// 카테고리 소분류
	
	public void setCondiVO(MainVO condiVO) {
		this.condiVO = condiVO;
	}
	public void setData(MainVO data) {
		this.data = data;
	}
	public MainVO getCondiVO() {
		return condiVO;
	}
	public MainVO getData() {
		return data;
	}
	public SessionVO getSessVO() {
		return sessVO;
	}
	public void setSessVO(SessionVO sessVO) {
		this.sessVO = sessVO;
	}
	public List<CourseVO> getCourseList() {
		return courseList;
	}
	public void setCourseList(List<CourseVO> courseList) {
		this.courseList = courseList;
	}
	public CourseVO getCourseData() {
		return courseData;
	}
	public void setCourseData(CourseVO courseData) {
		this.courseData = courseData;
	}
	public List<CourseResourceVO> getCourseResourceList() {
		return courseResourceList;
	}
	public void setCourseResourceList(List<CourseResourceVO> courseResourceList) {
		this.courseResourceList = courseResourceList;
	}
	public MemberVO getMemberVO() {
		return memberVO;
	}
	public void setMemberVO(MemberVO memberVO) {
		this.memberVO = memberVO;
	}
	public List<BankVO> getBankList() {
		return bankList;
	}
	public void setBankList(List<BankVO> bankList) {
		this.bankList = bankList;
	}
	public List<CodeVO> getDdMailList() {
		return ddMailList;
	}
	public void setDdMailList(List<CodeVO> ddMailList) {
		this.ddMailList = ddMailList;
	}
	public List<CourseVO> getCategoryList() {
		return categoryList;
	}
	public void setCategoryList(List<CourseVO> categoryList) {
		this.categoryList = categoryList;
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
