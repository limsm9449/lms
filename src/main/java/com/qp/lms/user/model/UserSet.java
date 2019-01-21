package com.qp.lms.user.model;

import java.util.List;

import com.qp.lms.board.model.AttachVO;
import com.qp.lms.board.model.BoardFaqVO;
import com.qp.lms.board.model.BoardVO;
import com.qp.lms.common.CodeVO;
import com.qp.lms.common.CommonSet;
import com.qp.lms.course.model.CourseCodeVO;
import com.qp.lms.course.model.CourseResourceVO;
import com.qp.lms.course.model.CourseVO;
import com.qp.lms.evaluation.model.EvaluationVO;



public class UserSet extends CommonSet {
	private UserVO condiVO;			
	private List<CourseCodeVO> courseCode;
	private List<CourseVO> course;
	private CourseVO courseInfo;				
	private EvaluationVO courseRate;				
	private EvaluationVO evaluation;				
	private List<EvaluationVO> week;
	private List<CourseVO> exam;
	
	//2014.7.20
	private UserVO data;			
	
	//2014.7.27
	private List<BoardVO> boardDataList;
	private BoardVO boardData;
	private List<BoardVO> boardQnaList;
	private BoardVO boardQna;
	private List<AttachVO> attachList;
	private List<BoardVO> answerList;
	private BoardVO boardAnswer;
	private List<BoardVO> boardNoticeList;
	private BoardVO boardNotice;
	private List<BoardFaqVO> boardFaqList;
	private BoardFaqVO boardFaq;
	private List<CodeVO> ddCategory;
	
	//2014.8.3
	private List<CourseVO> courseList;
	
	private List<CodeVO> ddCategory1Depth;		// 카테고리 대분류
	private List<CodeVO> ddCategory2Depth;		// 카테고리 중분류
	private List<CodeVO> ddCategory3Depth;		// 카테고리 소분류	

	private List<EvaluationVO> attendanceDays;
	
	private List<CourseResourceVO> ResourceList;
	private List<CourseResourceVO> ResourcePageList;
	

	public UserVO getCondiVO() {
		return condiVO;
	}
	public void setCondiVO(UserVO condiVO) {
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
	public EvaluationVO getCourseRate() {
		return courseRate;
	}
	public void setCourseRate(EvaluationVO courseRate) {
		this.courseRate = courseRate;
	}
	public UserVO getData() {
		return data;
	}
	public void setData(UserVO data) {
		this.data = data;
	}
	public List<BoardVO> getBoardDataList() {
		return boardDataList;
	}
	public void setBoardDataList(List<BoardVO> boardDataList) {
		this.boardDataList = boardDataList;
	}
	public List<BoardVO> getBoardQnaList() {
		return boardQnaList;
	}
	public void setBoardQnaList(List<BoardVO> boardQnaList) {
		this.boardQnaList = boardQnaList;
	}
	public BoardVO getBoardData() {
		return boardData;
	}
	public void setBoardData(BoardVO boardData) {
		this.boardData = boardData;
	}
	public BoardVO getBoardQna() {
		return boardQna;
	}
	public void setBoardQna(BoardVO boardQna) {
		this.boardQna = boardQna;
	}
	public List<AttachVO> getAttachList() {
		return attachList;
	}
	public void setAttachList(List<AttachVO> attachList) {
		this.attachList = attachList;
	}
	public List<BoardVO> getAnswerList() {
		return answerList;
	}
	public void setAnswerList(List<BoardVO> answerList) {
		this.answerList = answerList;
	}
	public BoardVO getBoardAnswer() {
		return boardAnswer;
	}
	public void setBoardAnswer(BoardVO boardAnswer) {
		this.boardAnswer = boardAnswer;
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
	public List<CodeVO> getDdCategory() {
		return ddCategory;
	}
	public void setDdCategory(List<CodeVO> ddCategory) {
		this.ddCategory = ddCategory;
	}
	public List<BoardFaqVO> getBoardFaqList() {
		return boardFaqList;
	}
	public void setBoardFaqList(List<BoardFaqVO> boardFaqList) {
		this.boardFaqList = boardFaqList;
	}
	public BoardFaqVO getBoardFaq() {
		return boardFaq;
	}
	public void setBoardFaq(BoardFaqVO boardFaq) {
		this.boardFaq = boardFaq;
	}
	public List<CourseVO> getCourseList() {
		return courseList;
	}
	public void setCourseList(List<CourseVO> courseList) {
		this.courseList = courseList;
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
	public List<CourseVO> getExam() {
		return exam;
	}
	public void setExam(List<CourseVO> exam) {
		this.exam = exam;
	}
	public List<EvaluationVO> getAttendanceDays() {
		return attendanceDays;
	}
	public void setAttendanceDays(List<EvaluationVO> attendanceDays) {
		this.attendanceDays = attendanceDays;
	}
	public List<CourseResourceVO> getResourceList() {
		return ResourceList;
	}
	public void setResourceList(List<CourseResourceVO> resourceList) {
		ResourceList = resourceList;
	}
	public List<CourseResourceVO> getResourcePageList() {
		return ResourcePageList;
	}
	public void setResourcePageList(List<CourseResourceVO> resourcePageList) {
		ResourcePageList = resourcePageList;
	}



	
	
	
	
	
	
	

	

}
