package com.qp.lms.teacher.model;

import java.util.List;

import com.qp.lms.common.CodeVO;
import com.qp.lms.common.CommonSet;
import com.qp.lms.common.CondiVO;
import com.qp.lms.course.model.CourseVO;
import com.qp.lms.evaluation.model.EvaluationVO;
import com.qp.lms.exam.model.ExamVO;



public class TeacherSet extends CommonSet {
	private TeacherVO condiVO;			
	private List<CourseVO> courses;
	private CourseVO course;				
	private EvaluationVO courseRate;				
	private List<EvaluationVO> courseEvals;				
	private List<EvaluationVO> courseWeeks;
	private EvaluationVO courseEval;
	
	private List<CodeVO> ddStatus;


	
	public List<CourseVO> getCourses() {
		return courses;
	}
	public void setCourses(List<CourseVO> courses) {
		this.courses = courses;
	}
	public CourseVO getCourse() {
		return course;
	}
	public void setCourse(CourseVO course) {
		this.course = course;
	}
	public EvaluationVO getCourseRate() {
		return courseRate;
	}
	public void setCourseRate(EvaluationVO courseRate) {
		this.courseRate = courseRate;
	}

	public List<EvaluationVO> getCourseWeeks() {
		return courseWeeks;
	}
	public void setCourseWeeks(List<EvaluationVO> courseWeeks) {
		this.courseWeeks = courseWeeks;
	}
	public List<CodeVO> getDdStatus() {
		return ddStatus;
	}
	public void setDdStatus(List<CodeVO> ddStatus) {
		this.ddStatus = ddStatus;
	}
	public List<EvaluationVO> getCourseEvals() {
		return courseEvals;
	}
	public void setCourseEvals(List<EvaluationVO> courseEvals) {
		this.courseEvals = courseEvals;
	}
	public EvaluationVO getCourseEval() {
		return courseEval;
	}
	public void setCourseEval(EvaluationVO courseEval) {
		this.courseEval = courseEval;
	}
	public TeacherVO getCondiVO() {
		return condiVO;
	}
	public void setCondiVO(TeacherVO condiVO) {
		this.condiVO = condiVO;
	}
	
	
	

	

}
