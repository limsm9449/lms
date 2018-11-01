package com.qp.lms.education.service;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.qp.lms.common.CommUtil;
import com.qp.lms.common.Constant;
import com.qp.lms.common.SessionUtil;
import com.qp.lms.course.model.CourseResourceVO;
import com.qp.lms.course.model.CourseVO;
import com.qp.lms.education.model.EducationSet;
import com.qp.lms.evaluation.model.EvaluationSet;
import com.qp.lms.evaluation.model.EvaluationVO;

@Service
public class EducationService {
	@Autowired
	private SqlSession sqlSession;

	public EducationSet checkMyCourse(EducationSet set) throws Exception {
    	set.getCondiVO().setUserId(SessionUtil.getSessionUserId());
    	set.setData((CourseVO) sqlSession.selectOne("education.checkMyCourse",set.getCondiVO()));
    	
        return set ;
    }
	
    public EducationSet eduHome(EducationSet set) throws Exception {
    	set.getCondiVO().setUserId(SessionUtil.getSessionUserId());
    	set.setData((CourseVO) sqlSession.selectOne("education.courseData",set.getCondiVO()));

    	List<CourseResourceVO> list = sqlSession.selectList("education.courseResourceList",set.getCondiVO());
    	set.setResourceList(list);

    	if ( "".equals(CommUtil.getString(set.getCondiVO().getWeek())) ) {
    		set.getCondiVO().setWeek(set.getData().getLastWeek());
    		set.getCondiVO().setPage(set.getData().getLastPage());
    	} else if ( Integer.parseInt(set.getCondiVO().getWeek()) > Integer.parseInt(set.getData().getLastWeek()) ) {
    		set.getCondiVO().setWeek(set.getData().getLastWeek());
    		set.getCondiVO().setPage("1");
    	} else if ( Integer.parseInt(set.getCondiVO().getWeek()) < Integer.parseInt(set.getData().getLastWeek()) ) {
    		set.getCondiVO().setPage("1");
    	}
    	
        return set ;
    }
    
    public EducationSet eduSampleHome(EducationSet set) throws Exception {
    	set.setData((CourseVO) sqlSession.selectOne("education.courseSampleData",set.getCondiVO()));

    	List<CourseResourceVO> list = sqlSession.selectList("education.courseResourceAllList",set.getCondiVO());
    	set.setResourceList(list);

        return set ;
    }
    
    public EducationSet contentsHome(EducationSet set) throws Exception {
    	set.setData((CourseVO) sqlSession.selectOne("education.courseCodeData",set.getCondiVO()));

    	List<CourseResourceVO> list = sqlSession.selectList("education.courseCodeResourceList",set.getCondiVO());
    	set.setResourceList(list);

        return set ;
    }
    

    @Transactional(propagation=Propagation.REQUIRED, rollbackFor={Throwable.class})
    public EvaluationSet updPrevPage(EvaluationSet set) throws Exception {
    	set.getCondiVO().setUserId(SessionUtil.getSessionUserId());
    	
    	EvaluationVO eval = (EvaluationVO)sqlSession.selectOne("education.weekPageKey",set.getCondiVO());
    	if ( eval != null && !"".equals(eval.getStudyEnd()) ) {
    		sqlSession.insert("education.updWeekPageKey",set.getCondiVO());
    	}
    	sqlSession.insert("education.updWeekKey",set.getCondiVO());
    	sqlSession.insert("education.updEvalKeyForProgress",set.getCondiVO());
    	sqlSession.insert("education.updEvalKeyForTotal",set.getCondiVO());
    	
    	set.setRtnMode(Constant.mode.UPDATE_OK.name());
    	
        return set ;
    }
    
    @Transactional(propagation=Propagation.REQUIRED, rollbackFor={Throwable.class})
    public EvaluationSet updPage(EvaluationSet set) throws Exception {
    	set.getCondiVO().setUserId(SessionUtil.getSessionUserId());
    	
    	EvaluationVO eval = (EvaluationVO)sqlSession.selectOne("education.weekPageKey",set.getCondiVO());
    	if ( eval == null ) {
    		sqlSession.insert("education.insWeekPage",set.getCondiVO());
    	}
    	sqlSession.insert("education.updWeekKey",set.getCondiVO());
    	sqlSession.insert("education.updEvalKeyForProgress",set.getCondiVO());
    	sqlSession.insert("education.updEvalKeyForTotal",set.getCondiVO());
    	sqlSession.insert("education.updEvalKeyForLastEducation",set.getCondiVO());
    	
    	set.setRtnMode(Constant.mode.UPDATE_OK.name());
    	
        return set ;
    }

    public EducationSet progress(EducationSet set) throws Exception {
    	set.getCondiVO().setUserId(SessionUtil.getSessionUserId());

    	EvaluationVO vo = new EvaluationVO();
    	vo.setCourseId(set.getCondiVO().getCourseId());
    	vo.setUserId(set.getCondiVO().getUserId());
    	set.setEvaluation((EvaluationVO) sqlSession.selectOne("evaluation.courseEvalData",vo));
    	
    	List<EvaluationVO> list = sqlSession.selectList("evaluation.courseWeekList",vo);
    	set.setWeek(list);

        return set ;
    }

    @Transactional(propagation=Propagation.REQUIRED, rollbackFor={Throwable.class})
    public EducationSet progressComplete(EducationSet set) throws Exception {
    	set.getCondiVO().setUserId(SessionUtil.getSessionUserId());
    	
    	sqlSession.insert("education.updEvalKeyForComplete",set.getCondiVO());

    	set.setData((CourseVO) sqlSession.selectOne("education.courseData",set.getCondiVO()));

        return set ;
    }

}
