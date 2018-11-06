package com.qp.lms.main.model;

import java.util.List;

import com.qp.lms.board.model.BoardFaqVO;
import com.qp.lms.board.model.BoardVO;
import com.qp.lms.common.CodeVO;
import com.qp.lms.common.CommonSet;
import com.qp.lms.common.SessionVO;
import com.qp.lms.counsel.model.CounselVO;
import com.qp.lms.course.model.CourseResourceVO;
import com.qp.lms.course.model.CourseVO;
import com.qp.lms.guest.model.BankVO;
import com.qp.lms.member.model.MemberVO;
import com.qp.lms.postscript.model.PostScriptVO;



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

	private List<BoardVO> noticeList;
	private List<BoardVO> faqList;
	private List<CounselVO> counselList;
	private List<CourseVO> attendCourseList;
	private List<CourseVO> completeCourseList;
	private CourseVO courseSummary;
	private List<PostScriptVO> postScriptList;
	private List<BoardFaqVO> boardFaqList;
	private List<CodeVO> ddCategory;
	private List<BoardVO> boardEventList;
	private List<BoardVO> boardNoticeList;
	private BoardVO boardNotice;
	private BoardFaqVO boardFaq;
	private List<CourseVO> categoryMainCourseList;
	private List<CourseVO> interestCourseList;


	
	public List<CourseVO> getInterestCourseList() {
		return interestCourseList;
	}
	public void setInterestCourseList(List<CourseVO> interestCourseList) {
		this.interestCourseList = interestCourseList;
	}
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
	public List<BoardVO> getNoticeList() {
		return noticeList;
	}
	public void setNoticeList(List<BoardVO> noticeList) {
		this.noticeList = noticeList;
	}
	public List<CounselVO> getCounselList() {
		return counselList;
	}
	public void setCounselList(List<CounselVO> counselList) {
		this.counselList = counselList;
	}
	public List<CourseVO> getAttendCourseList() {
		return attendCourseList;
	}
	public void setAttendCourseList(List<CourseVO> attendCourseList) {
		this.attendCourseList = attendCourseList;
	}
	public List<CourseVO> getCompleteCourseList() {
		return completeCourseList;
	}
	public void setCompleteCourseList(List<CourseVO> completeCourseList) {
		this.completeCourseList = completeCourseList;
	}
	public CourseVO getCourseSummary() {
		return courseSummary;
	}
	public void setCourseSummary(CourseVO courseSummary) {
		this.courseSummary = courseSummary;
	}
	public List<PostScriptVO> getPostScriptList() {
		return postScriptList;
	}
	public void setPostScriptList(List<PostScriptVO> postScriptList) {
		this.postScriptList = postScriptList;
	}
	public List<BoardFaqVO> getBoardFaqList() {
		return boardFaqList;
	}
	public void setBoardFaqList(List<BoardFaqVO> boardFaqList) {
		this.boardFaqList = boardFaqList;
	}
	public List<CodeVO> getDdCategory() {
		return ddCategory;
	}
	public void setDdCategory(List<CodeVO> ddCategory) {
		this.ddCategory = ddCategory;
	}
	public List<BoardVO> getBoardEventList() {
		return boardEventList;
	}
	public void setBoardEventList(List<BoardVO> boardEventList) {
		this.boardEventList = boardEventList;
	}
	public List<BoardVO> getBoardNoticeList() {
		return boardNoticeList;
	}
	public void setBoardNoticeList(List<BoardVO> boardNoticeList) {
		this.boardNoticeList = boardNoticeList;
	}
	public BoardVO getBoardNotice() {
		return boardNotice;
	}
	public void setBoardNotice(BoardVO boardNotice) {
		this.boardNotice = boardNotice;
	}
	public BoardFaqVO getBoardFaq() {
		return boardFaq;
	}
	public void setBoardFaq(BoardFaqVO boardFaq) {
		this.boardFaq = boardFaq;
	}
	public List<BoardVO> getFaqList() {
		return faqList;
	}
	public void setFaqList(List<BoardVO> faqList) {
		this.faqList = faqList;
	}
	public List<CourseVO> getCategoryMainCourseList() {
		return categoryMainCourseList;
	}
	public void setCategoryMainCourseList(List<CourseVO> categoryMainCourseList) {
		this.categoryMainCourseList = categoryMainCourseList;
	}
	
}
