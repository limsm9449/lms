package com.qp.lms.ax.board.service;

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
public class AxBoardQnaService {
	@Autowired
	private SqlSession sqlSession;
	
	public HashMap<String, Object> axBoardQnaList(HashMap<String, Object> paramMap) throws Exception {
		HashMap<String, Object> hm = new HashMap<String, Object>();
		
		paramMap.put("USER_ID", SessionUtil.getSessionUserId());
		
    	hm.put("list", sqlSession.selectList("axBoard.axBoardQnaList", paramMap));
        
    	return hm;
    }
	
	public HashMap<String, Object> axBoardQnaOne(HashMap<String, Object> paramMap) throws Exception {
		HashMap<String, Object> hm = new HashMap<String, Object>();
		
    	hm.put("row", sqlSession.selectOne("axBoard.axBoardQnaOne", paramMap));
        
    	return hm;
    }
	
	@Transactional(propagation=Propagation.REQUIRED, rollbackFor={Throwable.class})
    public HashMap<String, Object>  axBoardQnaSave(HashMap<String, Object> paramMap) throws Exception {
		HashMap<String, Object> hm = new HashMap<String, Object>();
		
		String mode = (String)paramMap.get("MODE");

		if ( "INSERT".equals(mode) ) {
			paramMap.put("USER_ID", SessionUtil.getSessionUserId());
			
			sqlSession.insert("axBoard.axBoardQnaInsert", paramMap);
		} else if ( "UPDATE".equals(mode) ) {
			sqlSession.update("axBoard.axBoardQnaUpdate", paramMap);
		} else if ( "VIEW".equals(mode) ) {
			sqlSession.update("axBoard.axBoardQnaViewCntUpd", paramMap);
		} else if ( "DELETE".equals(mode) ) {
			sqlSession.delete("axBoard.axBoardQnaDelete", paramMap);
		}

		hm.put("RtnMode", Constant.mode.OK.name());
		
    	return hm;
    }

	@Transactional(propagation=Propagation.REQUIRED, rollbackFor={Throwable.class})
    public HashMap<String, Object>  axBoardQnaAnswerSave(HashMap<String, Object> paramMap) throws Exception {
		HashMap<String, Object> hm = new HashMap<String, Object>();
		
		paramMap.put("USER_ID", SessionUtil.getSessionUserId());
		sqlSession.update("axBoard.axBoardQnaAnswerUpdate", paramMap);

		hm.put("RtnMode", Constant.mode.OK.name());
		
    	return hm;
    }

}
