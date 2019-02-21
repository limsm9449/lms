package com.qp.lms.ax.log.service;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.qp.lms.common.Constant;
import com.qp.lms.common.SessionUtil;

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
	
	@Transactional(propagation=Propagation.REQUIRED, rollbackFor={Throwable.class})
    public HashMap<String, Object>  axLogDelete(HashMap<String, Object> paramMap) throws Exception {
		HashMap<String, Object> hm = new HashMap<String, Object>();
		
		sqlSession.update("axLog.axLogDelete", paramMap);
		
		hm.put("RtnMode", Constant.mode.OK.name());
		
    	return hm;
    }
    
    
	public HashMap<String, Object> axLoginLogList(HashMap<String, Object> paramMap) throws Exception {
		HashMap<String, Object> hm = new HashMap<String, Object>();
		
    	List<HashMap<String, Object>> list = sqlSession.selectList("axLog.axLoginLogList", paramMap);
    	hm.put("list", list);
        
    	return hm;
    }
    
	public HashMap<String, Object> axLoginMonthLogList(HashMap<String, Object> paramMap) throws Exception {
		HashMap<String, Object> hm = new HashMap<String, Object>();
		
    	List<HashMap<String, Object>> list = sqlSession.selectList("axLog.axLoginMonthLogList", paramMap);
    	hm.put("list", list);
        
    	return hm;
    }
	
	public HashMap<String, Object> axMailLogList(HashMap<String, Object> paramMap) throws Exception {
		HashMap<String, Object> hm = new HashMap<String, Object>();
		
    	List<HashMap<String, Object>> list1 = sqlSession.selectList("axLog.axMailLog1List", paramMap);
    	hm.put("list1", list1);

    	List<HashMap<String, Object>> list2 = sqlSession.selectList("axLog.axMailLog2List", paramMap);
    	hm.put("list2", list2);

    	return hm;
    }
	
	public HashMap<String, Object> axMailLogOne(HashMap<String, Object> paramMap) throws Exception {
		HashMap<String, Object> hm = new HashMap<String, Object>();
		
    	HashMap<String, Object> row = sqlSession.selectOne("axLog.axMailLogOne", paramMap);
    	hm.put("row", row);

    	return hm;
    }
	
	@Transactional(propagation=Propagation.REQUIRED, rollbackFor={Throwable.class})
    public HashMap<String, Object>  axMailLogDelete(HashMap<String, Object> paramMap) throws Exception {
		HashMap<String, Object> hm = new HashMap<String, Object>();
		
		sqlSession.update("axLog.axMailLogDelete1", paramMap);
		sqlSession.update("axLog.axMailLogDelete2", paramMap);
		
		hm.put("RtnMode", Constant.mode.OK.name());
		
    	return hm;
    }
    
}
