package com.qp.lms.ax.board.service;

import java.util.HashMap;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.qp.lms.common.Constant;
import com.qp.lms.common.SessionUtil;

@Service
public class AxBoardEventService {
	@Autowired
	private SqlSession sqlSession;
	
	public HashMap<String, Object> axBoardEventList(HashMap<String, Object> paramMap) throws Exception {
		HashMap<String, Object> hm = new HashMap<String, Object>();
		
		paramMap.put("USER_ID", SessionUtil.getSessionUserId());
		
    	hm.put("list", sqlSession.selectList("axBoard.axBoardEventList", paramMap));
        
    	return hm;
    }
	
	public HashMap<String, Object> axBoardEventOne(HashMap<String, Object> paramMap) throws Exception {
		HashMap<String, Object> hm = new HashMap<String, Object>();
		
    	hm.put("row", sqlSession.selectOne("axBoard.axBoardEventOne", paramMap));
        
    	return hm;
    }
	
	@Transactional(propagation=Propagation.REQUIRED, rollbackFor={Throwable.class})
    public HashMap<String, Object>  axBoardEventSave(HashMap<String, Object> paramMap) throws Exception {
		HashMap<String, Object> hm = new HashMap<String, Object>();
		
		String mode = (String)paramMap.get("MODE");

		if ( "INSERT".equals(mode) ) {
			paramMap.put("USER_ID", SessionUtil.getSessionUserId());
			
			sqlSession.insert("axBoard.axBoardEventInsert", paramMap);
		} else if ( "UPDATE".equals(mode) ) {
			sqlSession.update("axBoard.axBoardEventUpdate", paramMap);
		} else if ( "VIEW".equals(mode) ) {
			sqlSession.update("axBoard.axBoardEventViewCntUpd", paramMap);
		} else if ( "DELETE".equals(mode) ) {
			sqlSession.delete("axBoard.axBoardEventDelete", paramMap);
		}

		hm.put("RtnMode", Constant.mode.OK.name());
		
    	return hm;
    }
    
}
