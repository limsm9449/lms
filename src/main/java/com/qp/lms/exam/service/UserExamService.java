package com.qp.lms.exam.service;

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

	
    public ExamSet userExamN(ExamSet set) throws Exception {
    	List<ExamVO> list =  sqlSession.selectList("exam.userExamNewList", set.getCondiVO());
    	set.setList(list);
        
    	return set;
    }
    
    
    ///////////////////////////////////////////////// Transaction ////////////////////////////////////////////////////
    @Transactional(propagation=Propagation.REQUIRED, rollbackFor={Throwable.class})
    public ExamSet userExamIns(ExamSet set) throws Exception {
    	ExamVO saveVO = new ExamVO();
		saveVO.setCourseId(set.getCondiVO().getCourseId());
		saveVO.setUserId(SessionUtil.getSessionUserId());
		//saveVO.setQgId(set.getCondiVO().getQgId());
		for ( int i = 0; i < set.getCondiVO().getSeqs().length; i++ ) {
			saveVO.setSeq(set.getCondiVO().getSeqs()[i]);
			saveVO.setAnswer(set.getCondiVO().getAnswers()[i]);
			
			sqlSession.insert("exam.userExamIns",saveVO);
		}

		//완료 처리
		sqlSession.update("exam.userExamInsertFlagUpd",saveVO);

		//평가 점수
		sqlSession.update("exam.userExamValuation",saveVO);

		//총점
		EvaluationVO condiVO = new EvaluationVO();
		condiVO.setCourseId(set.getCondiVO().getCourseId());
		condiVO.setUserId(SessionUtil.getSessionUserId());
		sqlSession.insert("education.updEvalKeyForTotal",condiVO);
		
		set.setRtnMode(Constant.mode.INSERT_OK.name());
		
    	return set;
    }

	
}
