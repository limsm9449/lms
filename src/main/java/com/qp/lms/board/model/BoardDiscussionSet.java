package com.qp.lms.board.model;

import java.util.List;

import com.qp.lms.common.CommonSet;

public class BoardDiscussionSet extends CommonSet {
	private BoardDiscussionVO condiVO;			// 조건용
	private BoardDiscussionVO data;			// 데이타용
	private List<BoardDiscussionVO> list;		// 리스트용
	
	private String isAuth;
	private String userId;
	
	public BoardDiscussionVO getCondiVO() {
		return condiVO;
	}
	public void setCondiVO(BoardDiscussionVO condiVO) {
		this.condiVO = condiVO;
	}
	public BoardDiscussionVO getData() {
		return data;
	}
	public void setData(BoardDiscussionVO data) {
		this.data = data;
	}
	public List<BoardDiscussionVO> getList() {
		return list;
	}
	public void setList(List<BoardDiscussionVO> list) {
		this.list = list;
	}
	public String getIsAuth() {
		return isAuth;
	}
	public void setIsAuth(String isAuth) {
		this.isAuth = isAuth;
	}
	public String getUserId() {
		return userId;
	}
	public void setUserId(String userId) {
		this.userId = userId;
	}

	
	

	

}
