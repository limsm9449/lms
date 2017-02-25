package com.qp.lms.compManager.model;

import java.util.List;

import com.qp.lms.common.CommonSet;
import com.qp.lms.member.model.MemberVO;



public class CompUserSet extends CommonSet { 
	private CompUserVO condiVO;				// 조건용
	private List<CompUserVO> list;			// 리스트용
	private CompUserVO data;				// 데이타용

	private String compCd;
	
	private List<MemberVO> memberList;

	
	public CompUserVO getCondiVO() {
		return condiVO;
	}
	public void setCondiVO(CompUserVO condiVO) {
		this.condiVO = condiVO;
	}
	public List<CompUserVO> getList() {
		return list;
	}
	public void setList(List<CompUserVO> list) {
		this.list = list;
	}
	public CompUserVO getData() {
		return data;
	}
	public void setData(CompUserVO data) {
		this.data = data;
	}
	public List<MemberVO> getMemberList() {
		return memberList;
	}
	public void setMemberList(List<MemberVO> memberList) {
		this.memberList = memberList;
	}
	public String getCompCd() {
		return compCd;
	}
	public void setCompCd(String compCd) {
		this.compCd = compCd;
	}



	

}
