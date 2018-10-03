package com.qp.lms.exam.model;

import java.util.List;

import com.qp.lms.common.CodeVO;
import com.qp.lms.common.CommonSet;
import com.qp.lms.quest.model.QuestVO;



public class ExamSet extends CommonSet { 
	
	private ExamVO condiVO;			
	private ExamVO data;			
	private List<ExamVO> list;

	private List<ExamVO> userList;
	private List<ExamVO> userDetailList;		
	
	private List<CodeVO> ddCategory1Depth;		// 카테고리 대분류
	private List<CodeVO> ddCategory2Depth;		// 카테고리 중분류
	private List<CodeVO> ddCategory3Depth;		// 카테고리 소분류

	private ExamVO eval;			

	public ExamVO getCondiVO() {
		return condiVO;
	}
	public void setCondiVO(ExamVO condiVO) {
		this.condiVO = condiVO;
	}
	public List<ExamVO> getList() {
		return list;
	}
	public void setList(List<ExamVO> list) {
		this.list = list;
	}
	public ExamVO getData() {
		return data;
	}
	public void setData(ExamVO data) {
		this.data = data;
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
	public List<ExamVO> getUserList() {
		return userList;
	}
	public void setUserList(List<ExamVO> userList) {
		this.userList = userList;
	}
	public List<ExamVO> getUserDetailList() {
		return userDetailList;
	}
	public void setUserDetailList(List<ExamVO> userDetailList) {
		this.userDetailList = userDetailList;
	}
	public ExamVO getEval() {
		return eval;
	}
	public void setEval(ExamVO eval) {
		this.eval = eval;
	}

	

}
