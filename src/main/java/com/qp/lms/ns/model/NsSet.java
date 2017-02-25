package com.qp.lms.ns.model;

import java.util.List;

import com.qp.lms.common.CodeVO;
import com.qp.lms.common.CommonSet;

public class NsSet extends CommonSet {
	private NsVO condiVO;		// 조건용
	private NsVO data;
	
	private List<ZipcodeVO> zipcode; 

	public NsVO getCondiVO() {
		return condiVO;
	}

	public void setCondiVO(NsVO condiVO) {
		this.condiVO = condiVO;
	}

	public List<ZipcodeVO> getZipcode() {
		return zipcode;
	}

	public void setZipcode(List<ZipcodeVO> zipcode) {
		this.zipcode = zipcode;
	}

	public NsVO getData() {
		return data;
	}

	public void setData(NsVO data) {
		this.data = data;
	}
	


	
	

	

}
