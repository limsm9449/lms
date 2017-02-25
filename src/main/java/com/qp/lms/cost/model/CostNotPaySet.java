package com.qp.lms.cost.model;

import java.util.List;

import com.qp.lms.common.CodeVO;
import com.qp.lms.common.CommonSet;


public class CostNotPaySet extends CommonSet {
	private CostNotPayVO condiVO;				// 조건용
	private List<CostNotPayVO> list;			// 리스트용
	private CostNotPayVO data;					// 데이타용

	private CostNotPayVO paymentData;			// 지불 정보					

	private List<CostNotPayVO> registerList;	// 리스트용
	
	
	private List<CodeVO> ddCategory1Depth;		// 카테고리 대분류
	private List<CodeVO> ddCategory2Depth;		// 카테고리 중분류
	private List<CodeVO> ddCategory3Depth;		// 카테고리 소분류
	
	
	
	public CostNotPayVO getCondiVO() {
		return condiVO;
	}
	public void setCondiVO(CostNotPayVO condiVO) {
		this.condiVO = condiVO;
	}
	public List<CostNotPayVO> getList() {
		return list;
	}
	public void setList(List<CostNotPayVO> list) {
		this.list = list;
	}
	public CostNotPayVO getData() {
		return data;
	}
	public void setData(CostNotPayVO data) {
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
	public List<CostNotPayVO> getRegisterList() {
		return registerList;
	}
	public void setRegisterList(List<CostNotPayVO> registerList) {
		this.registerList = registerList;
	}
	public CostNotPayVO getPaymentData() {
		return paymentData;
	}
	public void setPaymentData(CostNotPayVO paymentData) {
		this.paymentData = paymentData;
	}
	
	
	
	
	

	

}
