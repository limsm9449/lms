package com.qp.lms.pg.model;

import java.util.List;

import com.qp.lms.common.CommonSet;
import com.qp.lms.common.SessionVO;
import com.qp.lms.course.model.CourseVO;
import com.qp.lms.guest.model.BankVO;
import com.qp.lms.member.model.MemberVO;



public class PgSet extends CommonSet { 
	private SessionVO sessVO;
	private PgVO condiVO;
	private MemberVO memberVO;
	List<BankVO> bankList;
	private List<CourseVO> courseList;

	public SessionVO getSessVO() {
		return sessVO;
	}
	public void setSessVO(SessionVO sessVO) {
		this.sessVO = sessVO;
	}
	public PgVO getCondiVO() {
		return condiVO;
	}
	public void setCondiVO(PgVO condiVO) {
		this.condiVO = condiVO;
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
	public List<CourseVO> getCourseList() {
		return courseList;
	}
	public void setCourseList(List<CourseVO> courseList) {
		this.courseList = courseList;
	}		
	
	
	
}
