package com.qp.lms.ax.board.service;

import java.io.File;
import java.io.UnsupportedEncodingException;
import java.util.HashMap;
import java.util.List;
import java.util.Random;

import javax.mail.MessagingException;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.qp.lms.board.model.AttachVO;
import com.qp.lms.common.CommUtil;
import com.qp.lms.common.Constant;
import com.qp.lms.common.PlainMail;
import com.qp.lms.common.SessionUtil;
import com.qp.lms.common.service.DdService;
import com.qp.lms.member.model.MemberVO;

@Service
public class AxBoardReportService {
	@Autowired
	private SqlSession sqlSession;
	
	public HashMap<String, Object> axBoardReportList(HashMap<String, Object> paramMap) throws Exception {
		HashMap<String, Object> hm = new HashMap<String, Object>();
		
		paramMap.put("USER_ID", SessionUtil.getSessionUserId());
		
    	hm.put("list", sqlSession.selectList("axBoard.axBoardReportList", paramMap));
        
    	return hm;
    }
	
	public HashMap<String, Object> axBoardReportOne(HashMap<String, Object> paramMap) throws Exception {
		HashMap<String, Object> hm = new HashMap<String, Object>();
		
    	hm.put("row", sqlSession.selectOne("axBoard.axBoardReportOne", paramMap));
        
    	return hm;
    }
	
	@Transactional(propagation=Propagation.REQUIRED, rollbackFor={Throwable.class})
    public HashMap<String, Object>  axBoardReportSave(HashMap<String, Object> paramMap) throws Exception {
		HashMap<String, Object> hm = new HashMap<String, Object>();
		
		String mode = (String)paramMap.get("MODE");

		if ( "INSERT".equals(mode) ) {
			paramMap.put("USER_ID", SessionUtil.getSessionUserId());
			
			sqlSession.insert("axBoard.axBoardReportInsert", paramMap);

	    	//마지막 ID를 구한다.
	    	paramMap.put("P_SEQ", (String)sqlSession.selectOne("axComm.lastInsertId"));
	    	
	    	//추가한 첨부파일이 있으면 옮겨주고, 임시 테이블에서 삭제한다.
	    	sqlSession.insert("axComm.axAttachFromTempAttachToAttachInsert",paramMap);
	    	sqlSession.delete("axComm.axAttachTempDelete",paramMap);
	    	
		} else if ( "UPDATE".equals(mode) ) {
			sqlSession.update("axBoard.axBoardReportUpdate", paramMap);
		} else if ( "VIEW".equals(mode) ) {
			sqlSession.update("axBoard.axBoardReportViewCntUpd", paramMap);
		} else if ( "DELETE".equals(mode) ) {
			sqlSession.delete("axBoard.axBoardReportDelete", paramMap);
			
	    	paramMap.put("P_SEQ", paramMap.get("SEQ"));

	    	//첨부파일 삭제한다.
	    	List<HashMap<String, Object>> list = sqlSession.selectList("axComm.axAttachList", paramMap);
	    	for ( int i = 0; i < list.size(); i++ ) {
	    		//파일 삭제
	    		String fullFileName = CommUtil.getFileFolder() + list.get(i).get("FILE_PATH") + list.get(i).get("FILE_NAME");
	            File f = new File(fullFileName);
	            f.delete();
	    	}
            sqlSession.delete("axComm.axAttachDelete", paramMap);
		}

		hm.put("RtnMode", Constant.mode.OK.name());
		
    	return hm;
    }
    
}
