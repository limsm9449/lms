package com.qp.lms.board.model;

import java.util.List;

import com.qp.lms.common.CommonSet;

public class ReplySet extends CommonSet {
	private ReplyVO condiVO;		// 조건용
	private ReplyVO data;			// 데이타용
	private List<ReplyVO> list;	// 리스트용
	
	private String userId;
	
	public ReplyVO getCondiVO() {
		return condiVO;
	}
	public void setCondiVO(ReplyVO condiVO) {
		this.condiVO = condiVO;
	}
	public ReplyVO getData() {
		return data;
	}
	public void setData(ReplyVO data) {
		this.data = data;
	}
	public List<ReplyVO> getList() {
		return list;
	}
	public void setList(List<ReplyVO> list) {
		this.list = list;
	}
	public String getUserId() {
		return userId;
	}
	public void setUserId(String userId) {
		this.userId = userId;
	}

	
	

	

}
