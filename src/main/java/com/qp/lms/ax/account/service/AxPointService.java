package com.qp.lms.ax.account.service;

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
public class AxPointService {
	@Autowired
	private SqlSession sqlSession;
	
	public HashMap<String, Object> axPointList(HashMap<String, Object> paramMap) throws Exception {
		HashMap<String, Object> hm = new HashMap<String, Object>();
		
    	List<HashMap<String, Object>> list = sqlSession.selectList("axPoint.axPointList", paramMap);
    	hm.put("list", list);
        
    	return hm;
    }

	public HashMap<String, Object> axPointDetailList(HashMap<String, Object> paramMap) throws Exception {
		HashMap<String, Object> hm = new HashMap<String, Object>();
		
    	List<HashMap<String, Object>> list = sqlSession.selectList("axPoint.axPointDetailList", paramMap);
    	
    	//잔액 계산
    	int remain = 0;
    	for ( int i = list.size() - 1; i >= 0; i-- ) {
    		remain = remain + CommUtil.getIntValue(list.get(i).get("IN_POINT")) - CommUtil.getIntValue(list.get(i).get("OUT_POINT"));
    		list.get(i).put("REMAIN_POINT", remain);
    	}
    	hm.put("list", list);
        
    	return hm;
    }
	
    
    
    
}
