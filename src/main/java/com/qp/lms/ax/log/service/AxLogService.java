package com.qp.lms.ax.log.service;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class AxLogService {
	@Autowired
	private SqlSession sqlSession;
	
	public HashMap<String, Object> axLogList(HashMap<String, Object> paramMap) throws Exception {
		HashMap<String, Object> hm = new HashMap<String, Object>();
		
    	List<HashMap<String, Object>> list = sqlSession.selectList("axLog.axLogList", paramMap);
    	hm.put("list", list);
        
    	return hm;
    }
    
    
}
