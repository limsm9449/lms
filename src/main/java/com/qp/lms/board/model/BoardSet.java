package com.qp.lms.board.model;

import java.util.List;

import com.qp.lms.common.CommonSet;

public class BoardSet extends CommonSet {
	private BoardVO condiVO;			// 조건용
	private BoardVO data;				// 데이타용
	private List<BoardVO> list;		// 리스트용
	private List<BoardVO> answerList;	// 리스트용
	
	private String isAuth;
	private String userId;
	
	//2014.8.17
	private List<ReplyVO> replyList;
	
	public BoardVO getCondiVO() {
		return condiVO;
	}
	public void setCondiVO(BoardVO condiVO) {
		this.condiVO = condiVO;
	}
	public BoardVO getData() {
		return data;
	}
	public void setData(BoardVO data) {
		this.data = data;
	}
	public List<BoardVO> getList() {
		return list;
	}
	public void setList(List<BoardVO> list) {
		this.list = list;
	}
	public String getIsAuth() {
		return isAuth;
	}
	public void setIsAuth(String isAuth) {
		this.isAuth = isAuth;
	}
	public List<BoardVO> getAnswerList() {
		return answerList;
	}
	public void setAnswerList(List<BoardVO> answerList) {
		this.answerList = answerList;
	}
	public String getUserId() {
		return userId;
	}
	public void setUserId(String userId) {
		this.userId = userId;
	}
	public List<ReplyVO> getReplyList() {
		return replyList;
	}
	public void setReplyList(List<ReplyVO> replyList) {
		this.replyList = replyList;
	}

	
	

	

}
