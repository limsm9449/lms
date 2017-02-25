package com.qp.lms.teacher.service;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.qp.lms.common.CondiVO;
import com.qp.lms.common.Constant;
import com.qp.lms.common.SessionUtil;
import com.qp.lms.common.service.DdService;
import com.qp.lms.course.model.CourseVO;
import com.qp.lms.evaluation.model.EvaluationVO;
import com.qp.lms.exam.model.ExamVO;
import com.qp.lms.teacher.model.TeacherSet;
import com.qp.lms.teacher.model.TeacherVO;

@Service
public class TeacherService {
	@Autowired
	private SqlSession sqlSession;

	@Autowired
	private DdService ddService;
	
   
    public TeacherSet myCourse(TeacherSet set) throws Exception {
    	set.getCondiVO().setUserId(SessionUtil.getSessionUserId());

    	set.setDdStatus(ddService.getDdStatusForProfessor());

    	//쿼리에서 가져올 갯수 지정
    	set.getCondiVO().setLimitUnit(Constant.unitPerPage);

    	List<CourseVO> list = sqlSession.selectList("teacher.myCourse",set.getCondiVO());
    	set.setCourses(list);
    	
    	//페이징 처리 변수 세팅
    	set.setTotalCount(((CourseVO)sqlSession.selectOne("teacher.myCourseTotal",set.getCondiVO())).getCnt());
    	set.setPageUnit(Constant.unitPerPage);

    	
        return set ;
    }

    public TeacherSet courseEval(TeacherSet set) throws Exception {
    	//과정 평가 비율을 가져온다.
    	CondiVO condi = new CondiVO();
    	condi.setCourseId(set.getCondiVO().getCourseId());
    	set.setCourse((CourseVO) sqlSession.selectOne("comm.courseForRate",condi));
    	
    	//수강생 목록을 가져온다.
    	List<EvaluationVO> list = sqlSession.selectList("teacher.courseEval",set.getCondiVO());
    	set.setCourseEvals(list);
    	
    	return set;
    }   
    
    /*
    public TeacherSet courseEvalV(TeacherSet set) throws Exception {
    	//수정가능여부 
    	//과정 평가 비율을 가져온다.
    	CondiVO condi = new CondiVO();
    	condi.setCourseId(set.getCondiVO().getCourseId());
    	set.setCourse((CourseVO) sqlSession.selectOne("comm.courseForRate",condi));
    	
    	return set;
    }
    */   

    @Transactional(propagation=Propagation.REQUIRED, rollbackFor={Throwable.class})
    public TeacherSet updCourseEvalForEval(TeacherSet set) throws Exception {
    	set.getCourseEval().setUpdateUser(SessionUtil.getSessionUserId());
    	
    	//레포트,시험,토론 점수 수정
    	sqlSession.update("teacher.updCourseEvalForEval",set.getCourseEval());

    	//총합계산
    	sqlSession.insert("education.updEvalKeyForTotal",set.getCourseEval());

    	set.setRtnMode(Constant.mode.UPDATE_OK.name());
    	
    	return set;
    }   

    @Transactional(propagation=Propagation.REQUIRED, rollbackFor={Throwable.class})
    public TeacherSet evalCompleteUpd(TeacherSet set) throws Exception {
    	set.getCondiVO().setUpdateUser(SessionUtil.getSessionUserId());

    	TeacherVO condi = new TeacherVO();
    	condi.setCourseId(set.getCondiVO().getCourseId());
    	
    	String[] userIds = set.getCondiVO().getUserIds();
    	for ( int i = 0; i < userIds.length; i++ ) {
    		condi.setUserId(userIds[i]);

    		//레포트,시험,토론 점수 수정
        	sqlSession.update("teacher.evalCompleteUpd",condi);
    	}

    	set.setRtnMode(Constant.mode.UPDATE_OK.name());
    	
    	return set;
    }   

}
