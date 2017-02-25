package com.qp.lms.member.model;

import java.util.List;

import com.qp.lms.board.model.BoardFaqVO;
import com.qp.lms.common.CodeVO;
import com.qp.lms.common.CommonSet;

public class MemberSet extends CommonSet {
	private MemberVO condiVO;		// 조건용
	private MemberVO data;			// 데이타용
	private List<MemberVO> list;	// 리스트용

	private List<CodeVO> ddTel; 
	private List<CodeVO> ddMobile; 
	private List<CodeVO> ddJob; 
	private List<CodeVO> ddUserKind; 

	//2014.8.9 추가
	private List<BoardFaqVO> faqList;
	

	public MemberVO getCondiVO() {
		return condiVO;
	}
	public void setCondiVO(MemberVO condiVO) {
		this.condiVO = condiVO;
	}
	public MemberVO getData() {
		return data;
	}
	public void setData(MemberVO data) {
		this.data = data;
	}
	public List<CodeVO> getDdTel() {
		return ddTel;
	}
	public void setDdTel(List<CodeVO> ddTel) {
		this.ddTel = ddTel;
	}
	public List<CodeVO> getDdMobile() {
		return ddMobile;
	}
	public void setDdMobile(List<CodeVO> ddMobile) {
		this.ddMobile = ddMobile;
	}
	public List<CodeVO> getDdJob() {
		return ddJob;
	}
	public void setDdJob(List<CodeVO> ddJob) {
		this.ddJob = ddJob;
	}
	public List<MemberVO> getList() {
		return list;
	}
	public void setList(List<MemberVO> list) {
		this.list = list;
	}
	public List<CodeVO> getDdUserKind() {
		return ddUserKind;
	}
	public void setDdUserKind(List<CodeVO> ddUserKind) {
		this.ddUserKind = ddUserKind;
	}
	public List<BoardFaqVO> getFaqList() {
		return faqList;
	}
	public void setFaqList(List<BoardFaqVO> faqList) {
		this.faqList = faqList;
	}

	
	

	

}
