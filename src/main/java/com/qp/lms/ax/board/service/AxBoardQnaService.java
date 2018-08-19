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
    	
    	paramMap.put("SESSION_USER_ID", SessionUtil.getSessionUserId());
    	paramMap.put("KIND", "QNA");
    	paramMap.put("P_SEQ", paramMap.get("SEQ"));
    	hm.put("replyList", sqlSession.selectList("axBoard.axBoardReplyList", paramMap));
        
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
    public HashMap<String, Object>  axBoardQnaReplySave(HashMap<String, Object> paramMap) throws Exception {
		HashMap<String, Object> hm = new HashMap<String, Object>();
		
		List<HashMap<String, Object>> updList = (List<HashMap<String, Object>>)paramMap.get("modified");

		for ( int i = 0; i < updList.size(); i++ ) {
			HashMap<String, Object> row = (HashMap<String, Object>)updList.get(i);
			row.put("SESSION_USER_ID", SessionUtil.getSessionUserId());

			if ( "Y".equals((String)row.get("NEW_FLAG")) ) {
				sqlSession.insert("axBoard.axBoardReplyInsert", row);
			} else {
				sqlSession.update("axBoard.axBoardReplyUpdate", row);
			}
		}

		List<HashMap<String, Object>> delList = (List<HashMap<String, Object>>)paramMap.get("deleted");
		for ( int i = 0; i < delList.size(); i++ ) {
			sqlSession.delete("axBoard.axBoardReplyDelete", delList.get(i));
		}

		hm.put("RtnMode", Constant.mode.OK.name());
		
    	return hm;
    }

}
