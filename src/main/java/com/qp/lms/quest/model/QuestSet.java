package com.qp.lms.quest.model;

import java.util.List;

import com.qp.lms.common.CodeVO;
import com.qp.lms.common.CommonSet;



public class QuestSet extends CommonSet { 
	
	private QuestVO condiVO;			
	private QuestVO data;			
	private List<QuestVO> list;
	private List<CodeVO> ddQuestGroup;
	private List<QuestVO> questDetailList;
	private List<QuestVO> userList;
	private List<QuestVO> userDetailList;			
	
	private List<CodeVO> ddCategory1Depth;		// 카테고리 대분류
	private List<CodeVO> ddCategory2Depth;		// 카테고리 중분류
	private List<CodeVO> ddCategory3Depth;		// 카테고리 소분류
	
	private String questName;

	public QuestVO getCondiVO() {
		return condiVO;
	}
	public void setCondiVO(QuestVO condiVO) {
		this.condiVO = condiVO;
	}
	public List<QuestVO> getList() {
		return list;
	}
	public void setList(List<QuestVO> list) {
		this.list = list;
	}
	public List<CodeVO> getDdQuestGroup() {
		return ddQuestGroup;
	}
	public void setDdQuestGroup(List<CodeVO> ddQuestGroup) {
		this.ddQuestGroup = ddQuestGroup;
	}
	public QuestVO getData() {
		return data;
	}
	public void setData(QuestVO data) {
		this.data = data;
	}
	public List<QuestVO> getQuestDetailList() {
		return questDetailList;
	}
	public void setQuestDetailList(List<QuestVO> questDetailList) {
		this.questDetailList = questDetailList;
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
	public List<QuestVO> getUserList() {
		return userList;
	}
	public void setUserList(List<QuestVO> userList) {
		this.userList = userList;
	}
	public List<QuestVO> getUserDetailList() {
		return userDetailList;
	}
	public void setUserDetailList(List<QuestVO> userDetailList) {
		this.userDetailList = userDetailList;
	}
	public String getQuestName() {
		return questName;
	}
	public void setQuestName(String questName) {
		this.questName = questName;
	}

	

}
