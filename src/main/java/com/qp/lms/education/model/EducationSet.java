package com.qp.lms.education.model;

import java.util.List;

import com.qp.lms.course.model.CourseResourceVO;
import com.qp.lms.course.model.CourseVO;
import com.qp.lms.evaluation.model.EvaluationVO;
import com.qp.lms.common.CommonSet;



public class EducationSet extends CommonSet {
	private EducationVO condiVO;					//조건
	private List<CourseResourceVO> resourceList; 	//과정 제목 리스트
	private CourseVO data;							//과정 정보
	//private EvaluationVO courseRate;				
	private EvaluationVO evaluation;				
	private List<EvaluationVO> week;
	private List<CourseResourceVO> resourcePageList;
	private String contentsUrl;
	
	
	public EducationVO getCondiVO() {
		return condiVO;
	}
	public void setCondiVO(EducationVO condiVO) {
		this.condiVO = condiVO;
	}
	public List<CourseResourceVO> getResourceList() {
		return resourceList;
	}
	public void setResourceList(List<CourseResourceVO> resourceList) {
		this.resourceList = resourceList;
	}
	public CourseVO getData() {
		return data;
	}
	public void setData(CourseVO data) {
		this.data = data;
	}
	public EvaluationVO getEvaluation() {
		return evaluation;
	}
	public void setEvaluation(EvaluationVO evaluation) {
		this.evaluation = evaluation;
	}
	public List<EvaluationVO> getWeek() {
		return week;
	}
	public void setWeek(List<EvaluationVO> week) {
		this.week = week;
	}
	public List<CourseResourceVO> getResourcePageList() {
		return resourcePageList;
	}
	public void setResourcePageList(List<CourseResourceVO> resourcePageList) {
		this.resourcePageList = resourcePageList;
	}
	public String getContentsUrl() {
		return contentsUrl;
	}
	public void setContentsUrl(String contentsUrl) {
		this.contentsUrl = contentsUrl;
	}



}
