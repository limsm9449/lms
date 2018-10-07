package com.qp.lms.report.model;

import com.qp.lms.common.CommonSet;
import com.qp.lms.quest.model.QuestVO;



public class ReportSet extends CommonSet { 
	
	private ReportVO condiVO;			
	private ReportVO data;
	
	public ReportVO getCondiVO() {
		return condiVO;
	}
	public void setCondiVO(ReportVO condiVO) {
		this.condiVO = condiVO;
	}
	public ReportVO getData() {
		return data;
	}
	public void setData(ReportVO data) {
		this.data = data;
	}	
	

}
