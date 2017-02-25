package com.qp.lms.board.model;

import java.util.List;

import com.qp.lms.common.CodeVO;
import com.qp.lms.common.CommonSet;

public class BoardFaqSet extends CommonSet {
	private BoardFaqVO condiVO;			// 조건용
	private BoardFaqVO data;				// 데이타용
	private List<BoardFaqVO> list;			// 리스트용
	
	private List<CodeVO> ddCategory; 
	
	public BoardFaqVO getCondiVO() {
		return condiVO;
	}
	public void setCondiVO(BoardFaqVO condiVO) {
		this.condiVO = condiVO;
	}
	public BoardFaqVO getData() {
		return data;
	}
	public void setData(BoardFaqVO data) {
		this.data = data;
	}
	public List<BoardFaqVO> getList() {
		return list;
	}
	public void setList(List<BoardFaqVO> list) {
		this.list = list;
	}
	public List<CodeVO> getDdCategory() {
		return ddCategory;
	}
	public void setDdCategory(List<CodeVO> ddCategory) {
		this.ddCategory = ddCategory;
	}

	
	

	

}
