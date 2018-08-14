package com.qp.lms.ax.score.service;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.qp.lms.common.Constant;
import com.qp.lms.common.SessionUtil;
import com.qp.lms.common.service.DdService;

@Service
public class AxScoreService {
	@Autowired
	private SqlSession sqlSession;
	
	public HashMap<String, Object> axScoreList(HashMap<String, Object> paramMap) throws Exception {
		HashMap<String, Object> hm = new HashMap<String, Object>();
		
    	List<HashMap<String, Object>> list = sqlSession.selectList("axScore.axScoreList", paramMap);
    	hm.put("list", list);
        
    	return hm;
    }

	public HashMap<String, Object> axUserScoreList(HashMap<String, Object> paramMap) throws Exception {
		HashMap<String, Object> hm = new HashMap<String, Object>();
		
    	List<HashMap<String, Object>> list = sqlSession.selectList("axScore.axUserScoreList", paramMap);
    	hm.put("list", list);
        
    	return hm;
    }

	@Transactional(propagation=Propagation.REQUIRED, rollbackFor={Throwable.class})
    public HashMap<String, Object>  axUserScoreSave(HashMap<String, Object> paramMap) throws Exception {
		HashMap<String, Object> hm = new HashMap<String, Object>();
		
		List<HashMap<String, Object>> updList = (List<HashMap<String, Object>>)paramMap.get("modified");

		for ( int i = 0; i < updList.size(); i++ ) {
			sqlSession.update("axScore.axUserScoreUpdateReportDiscussion", updList.get(i));
			sqlSession.update("axScore.axUserScoreUpdateTotal", updList.get(i));
		}

		hm.put("RtnMode", Constant.mode.OK.name());
		
    	return hm;
    }
	
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

    
    
}
