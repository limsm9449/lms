package com.qp.lms.evaluation.service;

import java.util.List;


import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.qp.lms.course.model.CourseResourceVO;
import com.qp.lms.course.model.CourseSet;
import com.qp.lms.course.model.CourseVO;
import com.qp.lms.common.CodeVO;
import com.qp.lms.common.SessionUtil;
import com.qp.lms.common.Constant;
import com.qp.lms.common.service.DdService;
import com.qp.lms.evaluation.model.EvaluationSet;
import com.qp.lms.evaluation.model.EvaluationVO;
import com.qp.lms.exam.model.ExamVO;

@Service
public class EvaluationService {
	@Autowired
	private SqlSession sqlSession;

	@Autowired
	private DdService ddService;

	public EvaluationSet courseList(EvaluationSet set) throws Exception {
    	// 카테고리 대분류 
		set.setDdCategory1Depth(ddService.getDdCategory1Depth());
		
		// 카테고리 중분류 
		if ( set.getCondiVO().getC1Code() != null )
			set.setDdCategory2Depth(ddService.getDdCategory2Depth(set.getCondiVO().getC1Code()));
		
		// 카테고리 소분류 
		if ( set.getCondiVO().getC2Code() != null )
		set.setDdCategory3Depth(ddService.getDdCategory3Depth(set.getCondiVO().getC2Code()));
	
		// 과정코드 
		if ( set.getCondiVO().getC3Code() != null )
		set.setDdCourseCode(ddService.getDdCourseCode(set.getCondiVO().getC3Code()));
	
		//쿼리에서 가져올 갯수 지정
		set.getCondiVO().setLimitUnit(Constant.unitPerPage);
	
		List<EvaluationVO> list = sqlSession.selectList("evaluation.courseList",set.getCondiVO());
		set.setList(list);
		
		//페이징 처리 변수 세팅
		set.setTotalCount(((EvaluationVO)sqlSession.selectOne("evaluation.courseTotal",set.getCondiVO())).getCnt());
		set.setPageUnit(Constant.unitPerPage);
		
		return set;
	}

	public EvaluationSet courseEvalList(EvaluationSet set) throws Exception {
    	//쿼리에서 가져올 갯수 지정
    	set.getCondiVO().setLimitUnit(Constant.unitPerPage);

    	List<EvaluationVO> list = sqlSession.selectList("evaluation.courseEvalList",set.getCondiVO());
    	set.setList(list);
    	
    	//페이징 처리 변수 세팅
    	set.setTotalCount(((EvaluationVO)sqlSession.selectOne("evaluation.courseEvalTotal",set.getCondiVO())).getCnt());
    	set.setPageUnit(Constant.unitPerPage);
    	
    	return set;
   }

   public EvaluationSet courseEvalV(EvaluationSet set) throws Exception {
    	set.setEvaluation((EvaluationVO) sqlSession.selectOne("evaluation.courseEvalData",set.getCondiVO()));
    	
    	List<EvaluationVO> list = sqlSession.selectList("evaluation.courseWeekList",set.getCondiVO());
    	set.setWeek(list);
    	
    	//시험 데이타를 가져온다.
    	ExamVO condiVO = new ExamVO();
    	condiVO.setCourseId(set.getCondiVO().getCourseId());
    	condiVO.setUserId(set.getCondiVO().getUserId());
    	List<ExamVO> userExamList = sqlSession.selectList("exam.examUserDetail",condiVO);
    	set.setUserExamList(userExamList);
    	
    	return set;
   }
    
}
