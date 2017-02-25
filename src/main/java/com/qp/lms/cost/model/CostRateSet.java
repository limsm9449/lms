package com.qp.lms.cost.model;

import java.util.List;

import com.qp.lms.common.CodeVO;
import com.qp.lms.common.CommonSet;


public class CostRateSet extends CommonSet {
	private CostRateVO condiVO;			// 조건용
	private List<CostRateVO> list;			// 리스트용
	private CostRateVO data;				// 데이타용
	
	private List<CodeVO> ddCategory1Depth;		// 카테고리 대분류
	private List<CodeVO> ddCategory2Depth;		// 카테고리 중분류
	private List<CodeVO> ddCategory3Depth;		// 카테고리 소분류
	
	
	
	public CostRateVO getCondiVO() {
		return condiVO;
	}
	public void setCondiVO(CostRateVO condiVO) {
		this.condiVO = condiVO;
	}
	public List<CostRateVO> getList() {
		return list;
	}
	public void setList(List<CostRateVO> list) {
		this.list = list;
	}
	public CostRateVO getData() {
		return data;
	}
	public void setData(CostRateVO data) {
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
	
	
	
	
	
	

	

}
