package com.qp.lms.ax.board.service;

import java.io.File;
import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.qp.lms.board.model.BoardDiscussionVO;
import com.qp.lms.common.CommUtil;
import com.qp.lms.common.Constant;
import com.qp.lms.common.SessionUtil;

@Service
public class AxBoardDiscussionService {
	@Autowired
	private SqlSession sqlSession;
	
	public HashMap<String, Object> axBoardDiscussionList(HashMap<String, Object> paramMap) throws Exception {
		HashMap<String, Object> hm = new HashMap<String, Object>();
		
		paramMap.put("USER_ID", SessionUtil.getSessionUserId());
		
    	hm.put("list", sqlSession.selectList("axBoard.axBoardDiscussionList", paramMap));
        
    	return hm;
    }
	
	public HashMap<String, Object> axBoardDiscussionOne(HashMap<String, Object> paramMap) throws Exception {
		HashMap<String, Object> hm = new HashMap<String, Object>();
		
    	hm.put("row", sqlSession.selectOne("axBoard.axBoardDiscussionOne", paramMap));
        
    	return hm;
    }
	
	@Transactional(propagation=Propagation.REQUIRED, rollbackFor={Throwable.class})
    public HashMap<String, Object>  axBoardDiscussionSave(HashMap<String, Object> paramMap) throws Exception {
		HashMap<String, Object> hm = new HashMap<String, Object>();
		
		String mode = (String)paramMap.get("MODE");

		if ( "INSERT".equals(mode) ) {
			paramMap.put("USER_ID", SessionUtil.getSessionUserId());
			
    		sqlSession.insert("axBoard.axBoardDiscussionInsert",paramMap);
        	
    		//마지막 ID를 구한다.
	    	paramMap.put("SEQ", (String)sqlSession.selectOne("axComm.lastInsertId"));

        	//Ref 세팅
	    	paramMap.put("REF", paramMap.get("SEQ"));
    		sqlSession.insert("axBoard.axBoardDiscussionRefUpdate",paramMap);
		} else if ( "REPLY_INSERT".equals(mode) ) {
			paramMap.put("USER_ID", SessionUtil.getSessionUserId());

			//Ord를 구해서 정렬을 증가시킨다.
    		HashMap<String, Object> row =  sqlSession.selectOne("axBoard.axBoardDiscussionOne",paramMap);
    		sqlSession.update("axBoard.axBoardDiscussionOrdUpdate",row);
        	
        	//답변을 입력한다.
    		row.put("TITLE", paramMap.get("TITLE"));
    		row.put("CONTENTS", paramMap.get("CONTENTS"));
    		sqlSession.insert("axBoard.axBoardDiscussionReplyInsert",row);
		} else if ( "UPDATE".equals(mode) ) {
			sqlSession.update("axBoard.axBoardDiscussionUpdate", paramMap);
		} else if ( "VIEW".equals(mode) ) {
			sqlSession.update("axBoard.axBoardDiscussionViewCntUpd", paramMap);
		} else if ( "DELETE".equals(mode) ) {
			sqlSession.delete("axBoard.axBoardDiscussionDelete", paramMap);
		}

		hm.put("RtnMode", Constant.mode.OK.name());
		
    	return hm;
    }

}
