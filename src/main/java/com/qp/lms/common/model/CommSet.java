package com.qp.lms.common.model;

import java.util.List;

import com.qp.lms.common.CodeVO;
import com.qp.lms.common.CommonSet;
import com.qp.lms.course.model.CourseVO;
import com.qp.lms.member.model.MemberVO;
import com.qp.lms.user.model.UserVO;



public class CommSet extends CommonSet {
	private CommVO condiVO;		
	private List<CodeVO> ddCategory;
	
	private List<MemberVO> memberList;

	//2014.8.3
	private List<CourseVO> favorityCourseList;
	

	public CommVO getCondiVO() {
		return condiVO;
	}
	public void setCondiVO(CommVO condiVO) {
		this.condiVO = condiVO;
	}
	public List<CodeVO> getDdCategory() {
		return ddCategory;
	}
	public void setDdCategory(List<CodeVO> ddCategory) {
		this.ddCategory = ddCategory;
	}
	public List<MemberVO> getMemberList() {
		return memberList;
	}
	public void setMemberList(List<MemberVO> memberList) {
		this.memberList = memberList;
	}
	public List<CourseVO> getFavorityCourseList() {
		return favorityCourseList;
	}
	public void setFavorityCourseList(List<CourseVO> favorityCourseList) {
		this.favorityCourseList = favorityCourseList;
	}


	

	
	
	
	
	
	
	
	

	

}
