package com.qp.lms.report.service;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.qp.lms.common.Constant;
import com.qp.lms.common.SessionUtil;
import com.qp.lms.evaluation.model.EvaluationVO;
import com.qp.lms.quest.model.QuestSet;
import com.qp.lms.report.model.ReportSet;
import com.qp.lms.report.model.ReportVO;

@Service
public class UserReportService {
	@Autowired
	private SqlSession sqlSession;

    public ReportSet userReport(ReportSet set) throws Exception {
		set.getCondiVO().setUserId(SessionUtil.getSessionUserId());
		
    	ReportVO report = sqlSession.selectOne("report.userReport", set.getCondiVO());
    	if ( "0".equals(report.getAttachSeq()) ) {
    		sqlSession.insert("report.courseAttachInsert",set.getCondiVO());
    		
    		report = sqlSession.selectOne("report.userReport", set.getCondiVO());
    	}
    	
    	set.setData(report);

    	return set;
    }

    public ReportSet userReportResult(ReportSet set) throws Exception {
		set.getCondiVO().setUserId(SessionUtil.getSessionUserId());
		
    	ReportVO report = sqlSession.selectOne("report.userReportResult", set.getCondiVO());
    	set.setData(report);

    	return set;
    }
	
    public ReportSet userReportScore(ReportSet set) throws Exception {
    	ReportVO report = sqlSession.selectOne("report.userReportResult", set.getCondiVO());
    	set.setData(report);

    	return set;
    }

    @Transactional(propagation=Propagation.REQUIRED, rollbackFor={Throwable.class})
    public ReportSet userReportIns(ReportSet set) throws Exception {
    	set.getCondiVO().setUserId(SessionUtil.getSessionUserId());
    	
		sqlSession.update("report.UserReportInsertFlagUpd",set.getCondiVO());

		set.setRtnMode(Constant.mode.INSERT_OK.name());
		
    	return set;
    }

    @Transactional(propagation=Propagation.REQUIRED, rollbackFor={Throwable.class})
    public ReportSet userReportScoreSave(ReportSet set) throws Exception {
		sqlSession.update("report.UserReportScoreUpd",set.getCondiVO());

		//총점
		EvaluationVO condiVO = new EvaluationVO();
		condiVO.setCourseId(set.getCondiVO().getCourseId());
		condiVO.setUserId(set.getCondiVO().getUserId());
		sqlSession.update("education.updEvalKeyForTotal",condiVO);
		//이수여부
		sqlSession.update("education.updEvalKeyForComplete",condiVO);

		set.setRtnMode(Constant.mode.INSERT_OK.name());
		
    	return set;
    }
}
