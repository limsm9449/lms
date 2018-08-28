package com.qp.lms.ax.score.service;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.qp.lms.common.CommUtil;
import com.qp.lms.common.Constant;
import com.qp.lms.common.SessionUtil;
import com.qp.lms.common.service.DdService;

@Service
public class AxScoreService {
	@Autowired
	private SqlSession sqlSession;
	
	public HashMap<String, Object> axScoreList(HashMap<String, Object> paramMap) throws Exception {
		HashMap<String, Object> hm = new HashMap<String, Object>();
		
		CommUtil.setSesstionInfo(paramMap);
		
		List<HashMap<String, Object>> list = sqlSession.selectList("axScore.axScoreList", paramMap);
    	hm.put("list", list);
        
    	return hm;
    }

	public HashMap<String, Object> axUserScoreList(HashMap<String, Object> paramMap) throws Exception {
		HashMap<String, Object> hm = new HashMap<String, Object>();

		CommUtil.setSesstionInfo(paramMap);
		
    	List<HashMap<String, Object>> list = sqlSession.selectList("axScore.axUserScoreList", paramMap);
    	hm.put("list", list);
        
    	return hm;
    }

	@Transactional(propagation=Propagation.REQUIRED, rollbackFor={Throwable.class})
    public HashMap<String, Object>  axUserScoreSave(HashMap<String, Object> paramMap) throws Exception {
		HashMap<String, Object> hm = new HashMap<String, Object>();
		
		List<HashMap<String, Object>> updList = (List<HashMap<String, Object>>)paramMap.get("modified");

		for ( int i = 0; i < updList.size(); i++ ) {
			sqlSession.update("axScore.axUserScoreUpdate", updList.get(i));
			sqlSession.update("axScore.axUserScoreUpdateTotal", updList.get(i));
		}

		hm.put("RtnMode", Constant.mode.OK.name());
		
    	return hm;
    }
	
	@Transactional(propagation=Propagation.REQUIRED, rollbackFor={Throwable.class})
	public HashMap<String, Object> axUserScoreWeekList(HashMap<String, Object> paramMap) throws Exception {
		HashMap<String, Object> hm = new HashMap<String, Object>();
		
		int cnt = sqlSession.selectOne("axScore.axUserScoreWeekCount", paramMap);
		if ( cnt == 0 ) {
			sqlSession.insert("axScore.axUserScoreWeekInsert", paramMap);
		}
		
    	List<HashMap<String, Object>> list = sqlSession.selectList("axScore.axUserScoreWeekList", paramMap);
    	hm.put("list", list);
        
    	return hm;
    }
	
	/*
	public HashMap<String, Object> axUserScoreReportList(HashMap<String, Object> paramMap) throws Exception {
		HashMap<String, Object> hm = new HashMap<String, Object>();
		
    	List<HashMap<String, Object>> list = sqlSession.selectList("axScore.axUserScoreReportList", paramMap);
    	hm.put("list", list);
        
    	return hm;
    }
    */
	
	@Transactional(propagation=Propagation.REQUIRED, rollbackFor={Throwable.class})
	public HashMap<String, Object> axUserScoreExamList(HashMap<String, Object> paramMap) throws Exception {
		HashMap<String, Object> hm = new HashMap<String, Object>();
		
		int cnt = sqlSession.selectOne("axScore.axUserScoreExamCount", paramMap);
		if ( cnt == 0 ) {
	    	List<HashMap<String, Object>> standardList = sqlSession.selectList("axScore.axUserScoreExamStandard", paramMap);
			for ( int i = 0; i < standardList.size(); i++ ) {
				standardList.get(i).put("SESSION_USER_ID", SessionUtil.getSessionUserId());
				sqlSession.insert("axScore.axUserScoreExamInsert", standardList.get(i));
			}
		}
		
    	List<HashMap<String, Object>> list = sqlSession.selectList("axScore.axUserScoreExamList", paramMap);
    	hm.put("list", list);
        
    	return hm;
    }
	
	@Transactional(propagation=Propagation.REQUIRED, rollbackFor={Throwable.class})
	public HashMap<String, Object> axUserScoreExamSave(HashMap<String, Object> paramMap) throws Exception {
		HashMap<String, Object> hm = new HashMap<String, Object>();
		
		List<HashMap<String, Object>> updList = (List<HashMap<String, Object>>)paramMap.get("modified");

		for ( int i = 0; i < updList.size(); i++ ) {
			HashMap<String, Object> row = (HashMap<String, Object>)updList.get(i);
			row.put("SESSION_USER_ID", SessionUtil.getSessionUserId());

			sqlSession.update("axScore.axUserScoreExamUpdate", row);
		}
		//시험 타입별 합계
		sqlSession.update("axScore.axUserScoreExamUpdateExamTypeTotal", paramMap);
		//시험합계(비율)
		sqlSession.update("axScore.axUserScoreUpdateExamTotal", paramMap);
		//전체합계(비율)
		sqlSession.update("axScore.axUserScoreUpdateTotal", paramMap);

		hm.put("RtnMode", Constant.mode.OK.name());
        
    	return hm;
    }
	
	@Transactional(propagation=Propagation.REQUIRED, rollbackFor={Throwable.class})
	public HashMap<String, Object> axUserScoreQuestList(HashMap<String, Object> paramMap) throws Exception {
		HashMap<String, Object> hm = new HashMap<String, Object>();
		
		int cnt = sqlSession.selectOne("axScore.axUserScoreQuestCount", paramMap);
		if ( cnt == 0 ) {
			sqlSession.insert("axScore.axUserScoreQuestInsert", paramMap);
		}
		
    	List<HashMap<String, Object>> list = sqlSession.selectList("axScore.axUserScoreQuestList", paramMap);
    	hm.put("list", list);
        
    	return hm;
    }
	
	public HashMap<String, Object> axUserScoreQuestOne(HashMap<String, Object> paramMap) throws Exception {
		HashMap<String, Object> hm = new HashMap<String, Object>();
		
    	hm.put("row", sqlSession.selectOne("axScore.axUserScoreQuestOne", paramMap));
        
    	return hm;
    }

    
    
}
