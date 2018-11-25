package com.qp.lms.ax.board.service;

import java.io.File;
import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.qp.lms.common.Constant;
import com.qp.lms.common.SessionUtil;
import com.qp.lms.common.service.CommService;

@Service
public class AxMainBoardNoticeService {
	@Autowired
	private SqlSession sqlSession;
    
    @Autowired
    private CommService commSvr;
	
	public HashMap<String, Object> axMainBoardNoticeList(HashMap<String, Object> paramMap) throws Exception {
		HashMap<String, Object> hm = new HashMap<String, Object>();
		
		paramMap.put("USER_ID", SessionUtil.getSessionUserId());
		
    	hm.put("list", sqlSession.selectList("axMainBoard.axMainBoardNoticeList", paramMap));
        
    	return hm;
    }
	
	public HashMap<String, Object> axMainBoardNoticeOne(HashMap<String, Object> paramMap) throws Exception {
		HashMap<String, Object> hm = new HashMap<String, Object>();
		
    	hm.put("row", sqlSession.selectOne("axMainBoard.axMainBoardNoticeOne", paramMap));
        
    	return hm;
    }
	
	@Transactional(propagation=Propagation.REQUIRED, rollbackFor={Throwable.class})
    public HashMap<String, Object>  axMainBoardNoticeSave(HashMap<String, Object> paramMap) throws Exception {
		HashMap<String, Object> hm = new HashMap<String, Object>();
		
		String mode = (String)paramMap.get("MODE");

		if ( "INSERT".equals(mode) ) {
			paramMap.put("USER_ID", SessionUtil.getSessionUserId());
			
			sqlSession.insert("axMainBoard.axMainBoardNoticeInsert", paramMap);
		} else if ( "UPDATE".equals(mode) ) {
			sqlSession.update("axMainBoard.axMainBoardNoticeUpdate", paramMap);
		}
		
		List<HashMap<String, Object>> updList = (List<HashMap<String, Object>>)paramMap.get("modified");
		if ( updList != null ) {
			for ( int i = 0; i < updList.size(); i++ ) {
				HashMap<String, Object> row = (HashMap<String, Object>)updList.get(i);
				row.put("SESSION_USER_ID", SessionUtil.getSessionUserId());
	
				sqlSession.update("axMainBoard.axMainBoardNoticeMainUpdate", row);
			}
		}
		
		List<HashMap<String, Object>> delList = (List<HashMap<String, Object>>)paramMap.get("deleted");
		if ( delList != null ) {
			for ( int i = 0; i < delList.size(); i++ ) {
				sqlSession.delete("axMainBoard.axMainBoardNoticeDelete", delList.get(i));
				
				if ( "Y".equals(delList.get(i).get("IMG1")) ) {
					File f = new File(commSvr.getSetting("NOTICE_IMG_FOLDER") + "//" + delList.get(i).get("COMP_CD") +"//" + delList.get(i).get("SEQ") + "_img1.jpg");
					f.delete();
				}
				if ( "Y".equals(delList.get(i).get("IMG2")) ) {
					File f = new File(commSvr.getSetting("NOTICE_IMG_FOLDER") + "//" + delList.get(i).get("COMP_CD") +"//" + delList.get(i).get("SEQ") + "_img2.jpg");
					f.delete();
				}
			}
		}

		hm.put("RtnMode", Constant.mode.OK.name());
		
    	return hm;
    }

	public HashMap<String, Object> axMainBoardNoticeImageList(HashMap<String, Object> paramMap) throws Exception {
		HashMap<String, Object> hm = new HashMap<String, Object>();
		
    	List<HashMap<String, Object>> list = sqlSession.selectList("axMainBoard.axMainBoardNoticeOne", paramMap);
    	hm.put("list", list);
        
    	return hm;
    }
	
	@Transactional(propagation=Propagation.REQUIRED, rollbackFor={Throwable.class})
    public HashMap<String, Object>  axMainBoardNoticeImageUpload(HashMap<String, Object> paramMap) throws Exception {
		HashMap<String, Object> hm = new HashMap<String, Object>();
		
		paramMap.put("SESSION_USER_ID", SessionUtil.getSessionUserId());
		
		sqlSession.update("axMainBoard.axMainBoardNoticeImageUpdate", paramMap);

		hm.put("RtnMode", Constant.mode.OK.name());
		
    	return hm;
    }
    
}
