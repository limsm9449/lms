package com.qp.lms.guest.model;

import java.util.List;

import com.qp.lms.board.model.BoardFaqVO;
import com.qp.lms.course.model.CourseCodeVO;
import com.qp.lms.course.model.CourseVO;



public class GuestSet {
	private GuestVO condiVO;			
	private List<CourseCodeVO> courseCode;
	private List<CourseVO> course;
	private CourseVO courseInfo;				
	
	private List<BankVO> bankList;
	
	public GuestVO getCondiVO() {
		return condiVO;
	}
	public void setCondiVO(GuestVO condiVO) {
		this.condiVO = condiVO;
	}
	public List<CourseCodeVO> getCourseCode() {
		return courseCode;
	}
	public void setCourseCode(List<CourseCodeVO> courseCode) {
		this.courseCode = courseCode;
	}
	public List<CourseVO> getCourse() {
		return course;
	}
	public void setCourse(List<CourseVO> course) {
		this.course = course;
	}
	public CourseVO getCourseInfo() {
		return courseInfo;
	}
	public void setCourseInfo(CourseVO courseInfo) {
		this.courseInfo = courseInfo;
	}
	public List<BankVO> getBankList() {
		return bankList;
	}
	public void setBankList(List<BankVO> bankList) {
		this.bankList = bankList;
	}



	
	
	
	
	
	
	

	

}
