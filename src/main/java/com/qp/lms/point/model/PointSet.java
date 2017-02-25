package com.qp.lms.point.model;

import java.util.List;

import com.qp.lms.common.CodeVO;
import com.qp.lms.common.CommonSet;
import com.qp.lms.member.model.MemberVO;
import com.qp.lms.user.model.UserVO;



public class PointSet extends CommonSet { 
	private PointVO condiVO;			// 조건용
	private List<PointVO> list;		// 리스트용
	private PointVO data;				// 데이타용

	private List<PointVO> pointList;			// Point 리스트

	private String remainPoint;

	
	public PointVO getCondiVO() {
		return condiVO;
	}
	public void setCondiVO(PointVO condiVO) {
		this.condiVO = condiVO;
	}
	public List<PointVO> getList() {
		return list;
	}
	public void setList(List<PointVO> list) {
		this.list = list;
	}
	public PointVO getData() {
		return data;
	}
	public void setData(PointVO data) {
		this.data = data;
	}
	public List<PointVO> getPointList() {
		return pointList;
	}
	public void setPointList(List<PointVO> pointList) {
		this.pointList = pointList;
	}
	public String getRemainPoint() {
		return remainPoint;
	}
	public void setRemainPoint(String remainPoint) {
		this.remainPoint = remainPoint;
	}
	


	

}
