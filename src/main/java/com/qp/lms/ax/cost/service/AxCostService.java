package com.qp.lms.ax.cost.service;

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
public class AxCostService {
	@Autowired
	private SqlSession sqlSession;
	
	public HashMap<String, Object> axCostList(HashMap<String, Object> paramMap) throws Exception {
		HashMap<String, Object> hm = new HashMap<String, Object>();
		
    	List<HashMap<String, Object>> list = sqlSession.selectList("axCost.axCostList", paramMap);
    	hm.put("list", list);
        
    	return hm;
    }
	
	@Transactional(propagation=Propagation.REQUIRED, rollbackFor={Throwable.class})
    public HashMap<String, Object>  axCostSave(HashMap<String, Object> paramMap) throws Exception {
		HashMap<String, Object> hm = new HashMap<String, Object>();
		
		List<HashMap<String, Object>> updList = (List<HashMap<String, Object>>)paramMap.get("modified");

		for ( int i = 0; i < updList.size(); i++ ) {
			HashMap<String, Object> row = (HashMap<String, Object>)updList.get(i);
			row.put("SESSION_USER_ID", SessionUtil.getSessionUserId());

			if ( "R".equals(row.get("STATUS")) ) {
				sqlSession.update("axCost.axCostUpdateForRefund", row);
			} else {
				sqlSession.update("axCost.axCostUpdateForStatus", row);
			}

			sqlSession.update("axCost.axRegisterStatusUpd", row);
		}

		hm.put("RtnMode", Constant.mode.OK.name());
		
    	return hm;
    }
	
	
    
    
    
}
