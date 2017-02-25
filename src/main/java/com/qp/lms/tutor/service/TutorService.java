package com.qp.lms.tutor.service;

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
import com.qp.lms.cost.model.CostPaySet;
import com.qp.lms.cost.model.CostPayVO;
import com.qp.lms.course.model.CourseVO;
import com.qp.lms.evaluation.model.EvaluationVO;
import com.qp.lms.exam.model.ExamVO;
import com.qp.lms.tutor.model.TutorSet;
import com.qp.lms.tutor.model.TutorVO;

@Service
public class TutorService {
	@Autowired
	private SqlSession sqlSession;

	@Autowired
	private DdService ddService;
	
   
    public TutorSet myCourse(TutorSet set) throws Exception {
    	set.getCondiVO().setUserId(SessionUtil.getSessionUserId());

    	set.setDdStatus(ddService.getDdStatusForProfessor());

    	//쿼리에서 가져올 갯수 지정
    	set.getCondiVO().setLimitUnit(Constant.unitPerPage);

    	List<CourseVO> list = sqlSession.selectList("tutor.myCourse",set.getCondiVO());
    	set.setCourses(list);
    	
    	//페이징 처리 변수 세팅
    	set.setTotalCount(((CourseVO)sqlSession.selectOne("tutor.myCourseTotal",set.getCondiVO())).getCnt());
    	set.setPageUnit(Constant.unitPerPage);

    	
        return set ;
    }

    public TutorSet courseEval(TutorSet set) throws Exception {
    	//과정 평가 비율을 가져온다.
    	CondiVO condi = new CondiVO();
    	condi.setCourseId(set.getCondiVO().getCourseId());
    	set.setCourse((CourseVO) sqlSession.selectOne("comm.courseForRate",condi));
    	
    	//수강생 목록을 가져온다.
    	List<EvaluationVO> list = sqlSession.selectList("tutor.courseEval",set.getCondiVO());
    	set.setCourseEvals(list);
    	
    	return set;
    }   

    /*
    public TutorSet courseEvalV(TutorSet set) throws Exception {
    	//수정가능여부 
    	//과정 평가 비율을 가져온다.
    	CondiVO condi = new CondiVO();
    	condi.setCourseId(set.getCondiVO().getCourseId());
    	set.setCourse((CourseVO) sqlSession.selectOne("comm.courseForRate",condi));

    	return set;
    } 
    */  

    @Transactional(propagation=Propagation.REQUIRED, rollbackFor={Throwable.class})
    public TutorSet updCourseEvalForEval(TutorSet set) throws Exception {
    	set.getCourseEval().setUpdateUser(SessionUtil.getSessionUserId());
    	
    	//레포트,시험,토론 점수 수정
    	sqlSession.update("tutor.updCourseEvalForEval",set.getCourseEval());

    	//총합계산
    	sqlSession.insert("education.updEvalKeyForTotal",set.getCourseEval());

    	set.setRtnMode(Constant.mode.UPDATE_OK.name());
    	
    	return set;
    }   

    @Transactional(propagation=Propagation.REQUIRED, rollbackFor={Throwable.class})
    public TutorSet evalCompleteUpd(TutorSet set) throws Exception {
    	set.getCondiVO().setUpdateUser(SessionUtil.getSessionUserId());

    	TutorVO condi = new TutorVO();
    	condi.setCourseId(set.getCondiVO().getCourseId());
    	
    	String[] userIds = set.getCondiVO().getUserIds();
    	for ( int i = 0; i < userIds.length; i++ ) {
    		condi.setUserId(userIds[i]);

    		//레포트,시험,토론 점수 수정
        	sqlSession.update("tutor.evalCompleteUpd",condi);
    	}

    	set.setRtnMode(Constant.mode.UPDATE_OK.name());
    	
    	return set;
    }   

}
