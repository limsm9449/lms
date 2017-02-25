package com.qp.lms.system.model;

import java.util.List;

import com.qp.lms.common.CodeVO;
import com.qp.lms.common.CommonSet;
import com.qp.lms.common.model.CommVO;
import com.qp.lms.course.model.CourseVO;
import com.qp.lms.member.model.MemberVO;



public class SystemSet extends CommonSet {
	private SystemVO condiVO;		
	private List<SystemVO> logList;
	
	
	public SystemVO getCondiVO() {
		return condiVO;
	}
	public void setCondiVO(SystemVO condiVO) {
		this.condiVO = condiVO;
	}
	public List<SystemVO> getLogList() {
		return logList;
	}
	public void setLogList(List<SystemVO> logList) {
		this.logList = logList;
	}

	


	
	
	
	
	

	

}
