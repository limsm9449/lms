package com.qp.lms.exam.service;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.qp.lms.common.Constant;
import com.qp.lms.common.SessionUtil;
import com.qp.lms.evaluation.model.EvaluationVO;
import com.qp.lms.exam.model.ExamSet;
import com.qp.lms.exam.model.ExamVO;

@Service
public class UserExamService {
	@Autowired
	private SqlSession sqlSession;

    public ExamSet userExam(ExamSet set) throws Exception {
		set.getCondiVO().setUserId(SessionUtil.getSessionUserId());
		
		if ( "0".equals(set.getCondiVO().getWeek()) ) {
			set.getCondiVO().setExamKind("TOTAL");
		} else {
			set.getCondiVO().setExamKind("WEEK");
		}
		
		int cnt = sqlSession.selectOne("exam.userExamCount", set.getCondiVO());
    	if ( cnt == 0 ) {
        	List<ExamVO> standardList = sqlSession.selectList("exam.courseExamTypeStandard", set.getCondiVO());
    		for ( int i = 0; i < standardList.size(); i++ ) {
    			standardList.get(i).setUserId(SessionUtil.getSessionUserId());
    			sqlSession.insert("exam.courseExamInsert", standardList.get(i));
    		}
    	}
		
    	List<ExamVO> list =  sqlSession.selectList("exam.userExamList", set.getCondiVO());
    	set.setList(list);

    	List<ExamVO> tempList =  sqlSession.selectList("exam.userExamTempList", set.getCondiVO());
    	set.setTempList(tempList);

    	if ( "0".equals(set.getCondiVO().getWeek()) ) {
    		sqlSession.update("exam.userExamStartTimeUpd", set.getCondiVO());

    		String startTime = sqlSession.selectOne("exam.userExamStartTime", set.getCondiVO());
        	set.setStartTime(startTime);
    	}
    	
    	return set;
    }
    
    public ExamSet userExamResult(ExamSet set) throws Exception {
		set.getCondiVO().setUserId(SessionUtil.getSessionUserId());
		
    	List<ExamVO> list =  sqlSession.selectList("exam.userExamResultList", set.getCondiVO());
    	set.setList(list);
    	
    	ExamVO eval = sqlSession.selectOne("exam.userExamScore", set.getCondiVO());
    	set.setEval(eval);
        
    	return set;
    }
    
    ///////////////////////////////////////////////// Transaction ////////////////////////////////////////////////////
    @Transactional(propagation=Propagation.REQUIRED, rollbackFor={Throwable.class})
    public ExamSet userExamIns(ExamSet set) throws Exception {
    	ExamVO saveVO = new ExamVO();
		saveVO.setCourseId(set.getCondiVO().getCourseId());
		saveVO.setUserId(SessionUtil.getSessionUserId());
		
		String examKind = set.getCondiVO().getExamKind();

		if ( "".equals(examKind) ) {
			set.getCondiVO().setUserId(SessionUtil.getSessionUserId());
			sqlSession.delete("exam.userExamTempDelete", set.getCondiVO());

			for ( int i = 0; i < set.getCondiVO().getSeqs().length; i++ ) {
				saveVO.setExamKind("TEMP");
				saveVO.setWeek(set.getCondiVO().getWeeks()[i]);
				saveVO.setSeq(set.getCondiVO().getSeqs()[i]);
				saveVO.setAnswer(set.getCondiVO().getAnswers()[i]);
				
				sqlSession.insert("exam.userExamTempInsert",saveVO);
			}
		} else {
			for ( int i = 0; i < set.getCondiVO().getSeqs().length; i++ ) {
				saveVO.setExamKind(set.getCondiVO().getExamKinds()[i]);
				saveVO.setWeek(set.getCondiVO().getWeeks()[i]);
				saveVO.setSeq(set.getCondiVO().getSeqs()[i]);
				saveVO.setAnswer(set.getCondiVO().getAnswers()[i]);
				
				sqlSession.update("exam.userExamUpd",saveVO);
			}
		}
		
		if ( "TOTAL".equals(examKind) ) {
			//완료 처리
			sqlSession.update("exam.userExamInsertFlagUpd",saveVO);
	
			//시험 전체 점수를 계산한다.
			sqlSession.update("exam.userExamTotalUpdate",saveVO);
	
			//총점
			EvaluationVO condiVO = new EvaluationVO();
			condiVO.setCourseId(set.getCondiVO().getCourseId());
			condiVO.setUserId(SessionUtil.getSessionUserId());
			sqlSession.update("education.updEvalKeyForTotal",condiVO);
		}
		
		set.setRtnMode(Constant.mode.INSERT_OK.name());
		
    	return set;
    }

	
}
