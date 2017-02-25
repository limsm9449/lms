package com.qp.lms.postscript.model;

import java.util.List;

import com.qp.lms.common.CodeVO;
import com.qp.lms.common.CommonSet;



public class PostScriptSet extends CommonSet { 
	
	private PostScriptVO condiVO;			
	private PostScriptVO data;			
	private List<PostScriptVO> list;
	private List<PostScriptVO> userList;
	
	private List<CodeVO> ddCategory1Depth;		// 카테고리 대분류
	private List<CodeVO> ddCategory2Depth;		// 카테고리 중분류
	private List<CodeVO> ddCategory3Depth;		// 카테고리 소분류

	public PostScriptVO getCondiVO() {
		return condiVO;
	}
	public void setCondiVO(PostScriptVO condiVO) {
		this.condiVO = condiVO;
	}
	public List<PostScriptVO> getList() {
		return list;
	}
	public void setList(List<PostScriptVO> list) {
		this.list = list;
	}
	public PostScriptVO getData() {
		return data;
	}
	public void setData(PostScriptVO data) {
		this.data = data;
	}
	public List<PostScriptVO> getUserList() {
		return userList;
	}
	public void setUserList(List<PostScriptVO> userList) {
		this.userList = userList;
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
	

}
