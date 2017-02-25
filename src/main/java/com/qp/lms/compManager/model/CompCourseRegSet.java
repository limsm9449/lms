package com.qp.lms.compManager.model;

import java.util.List;

import com.qp.lms.common.CodeVO;
import com.qp.lms.common.CommonSet;
import com.qp.lms.guest.model.BankVO;
import com.qp.lms.member.model.MemberVO;



public class CompCourseRegSet extends CommonSet { 
	private CompCourseRegVO condiVO;				// 조건용
	private List<CompCourseRegVO> list;			// 리스트용
	private CompCourseRegVO data;					// 데이타용
	
	private List<CompCourseRegVO> noRegisterUserList; 	// 신청할 사용자 
	private List<CompCourseRegVO> registerUserList;	 	// 신청한 사용자
	private List<CompCourseRegVO> applicationUserList;	// 결재 신청할 사용자
	
	private List<CodeVO> ddBank;						// 은행
	
	private String paymentCost;
	private String applicationCnt;
	private String userIds;
	
	//2014.10.5 추가
	private MemberVO memberVO;
	List<BankVO> bankList;
	private String point;
	
	
	public CompCourseRegVO getCondiVO() {
		return condiVO;
	}
	public void setCondiVO(CompCourseRegVO condiVO) {
		this.condiVO = condiVO;
	}
	public List<CompCourseRegVO> getList() {
		return list;
	}
	public void setList(List<CompCourseRegVO> list) {
		this.list = list;
	}
	public CompCourseRegVO getData() {
		return data;
	}
	public void setData(CompCourseRegVO data) {
		this.data = data;
	}
	public List<CompCourseRegVO> getNoRegisterUserList() {
		return noRegisterUserList;
	}
	public void setNoRegisterUserList(List<CompCourseRegVO> noRegisterUserList) {
		this.noRegisterUserList = noRegisterUserList;
	}
	public List<CompCourseRegVO> getRegisterUserList() {
		return registerUserList;
	}
	public void setRegisterUserList(List<CompCourseRegVO> registerUserList) {
		this.registerUserList = registerUserList;
	}
	public List<CompCourseRegVO> getApplicationUserList() {
		return applicationUserList;
	}
	public void setApplicationUserList(List<CompCourseRegVO> applicationUserList) {
		this.applicationUserList = applicationUserList;
	}
	public String getPaymentCost() {
		return paymentCost;
	}
	public void setPaymentCost(String paymentCost) {
		this.paymentCost = paymentCost;
	}
	public String getApplicationCnt() {
		return applicationCnt;
	}
	public void setApplicationCnt(String applicationCnt) {
		this.applicationCnt = applicationCnt;
	}
	public List<CodeVO> getDdBank() {
		return ddBank;
	}
	public void setDdBank(List<CodeVO> ddBank) {
		this.ddBank = ddBank;
	}
	public String getUserIds() {
		return userIds;
	}
	public void setUserIds(String userIds) {
		this.userIds = userIds;
	}
	public MemberVO getMemberVO() {
		return memberVO;
	}
	public void setMemberVO(MemberVO memberVO) {
		this.memberVO = memberVO;
	}
	public List<BankVO> getBankList() {
		return bankList;
	}
	public void setBankList(List<BankVO> bankList) {
		this.bankList = bankList;
	}
	public String getPoint() {
		return point;
	}
	public void setPoint(String point) {
		this.point = point;
	}

	



	

}
