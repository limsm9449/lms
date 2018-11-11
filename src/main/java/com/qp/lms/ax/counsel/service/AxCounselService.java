package com.qp.lms.ax.counsel.service;

import java.io.File;
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

@Service
public class AxCounselService {
	@Autowired
	private SqlSession sqlSession;
	
	public HashMap<String, Object> axCounselList(HashMap<String, Object> paramMap) throws Exception {
		HashMap<String, Object> hm = new HashMap<String, Object>();
		
		paramMap.put("USER_ID", SessionUtil.getSessionUserId());
		
    	hm.put("list", sqlSession.selectList("axCounsel.axCounselList", paramMap));
        
    	return hm;
    }
	
	public HashMap<String, Object> axCounselOne(HashMap<String, Object> paramMap) throws Exception {
		HashMap<String, Object> hm = new HashMap<String, Object>();
		
    	hm.put("row", sqlSession.selectOne("axCounsel.axCounselOne", paramMap));
        
    	return hm;
    }
	
	@Transactional(propagation=Propagation.REQUIRED, rollbackFor={Throwable.class})
    public HashMap<String, Object>  axCounselSave(HashMap<String, Object> paramMap) throws Exception {
		HashMap<String, Object> hm = new HashMap<String, Object>();
		
		sqlSession.update("axCounsel.axCounselAnswerUpd", paramMap);

		hm.put("RtnMode", Constant.mode.OK.name());
		
    	return hm;
    }
    
	public HashMap<String, Object> axInquiryList(HashMap<String, Object> paramMap) throws Exception {
		HashMap<String, Object> hm = new HashMap<String, Object>();
		
		paramMap.put("USER_ID", SessionUtil.getSessionUserId());
		
    	hm.put("list", sqlSession.selectList("axCounsel.axInquiryList", paramMap));
        
    	return hm;
    }
	
	public HashMap<String, Object> axInquiryOne(HashMap<String, Object> paramMap) throws Exception {
		HashMap<String, Object> hm = new HashMap<String, Object>();
		
    	hm.put("row", sqlSession.selectOne("axCounsel.axInquiryOne", paramMap));
        
    	return hm;
    }
	
	@Transactional(propagation=Propagation.REQUIRED, rollbackFor={Throwable.class})
    public HashMap<String, Object>  axInquirySave(HashMap<String, Object> paramMap) throws Exception {
		HashMap<String, Object> hm = new HashMap<String, Object>();

		List<HashMap<String, Object>> updList = (List<HashMap<String, Object>>)paramMap.get("modified");

		for ( int i = 0; i < updList.size(); i++ ) {
			HashMap<String, Object> row = (HashMap<String, Object>)updList.get(i);
			row.put("SESSION_USER_ID", SessionUtil.getSessionUserId());

			sqlSession.update("axCounsel.axInquiryUpd", row);
		}

		hm.put("RtnMode", Constant.mode.OK.name());
		
    	return hm;
    }

}
