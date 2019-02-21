package com.qp.lms.ax.setting.service;

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
public class AxSettingService {
	@Autowired
	private SqlSession sqlSession;
	
	public HashMap<String, Object> axSettingBankList(HashMap<String, Object> paramMap) throws Exception {
		HashMap<String, Object> hm = new HashMap<String, Object>();
		
    	List<HashMap<String, Object>> list = sqlSession.selectList("axSetting.axSettingBankList", paramMap);
    	hm.put("list", list);
        
    	return hm;
    }
	
	@Transactional(propagation=Propagation.REQUIRED, rollbackFor={Throwable.class})
    public HashMap<String, Object>  axSettingBankSave(HashMap<String, Object> paramMap) throws Exception {
		HashMap<String, Object> hm = new HashMap<String, Object>();
		
		List<HashMap<String, Object>> updList = (List<HashMap<String, Object>>)paramMap.get("modified");

		for ( int i = 0; i < updList.size(); i++ ) {
			HashMap<String, Object> row = (HashMap<String, Object>)updList.get(i);
			row.put("SESSION_USER_ID", SessionUtil.getSessionUserId());

			if ( "Y".equals((String)row.get("NEW_FLAG")) ) {
				sqlSession.insert("axSetting.axSettingBankInsert", row);
			} else {
				sqlSession.update("axSetting.axSettingBankUpdate", row);
			}
		}

		List<HashMap<String, Object>> delList = (List<HashMap<String, Object>>)paramMap.get("deleted");
		for ( int i = 0; i < delList.size(); i++ ) {
			sqlSession.delete("axSetting.axSettingBankDelete", delList.get(i));
		}

		hm.put("RtnMode", Constant.mode.OK.name());
		
    	return hm;
    }
    
	public HashMap<String, Object> axSettingMailList(HashMap<String, Object> paramMap) throws Exception {
		HashMap<String, Object> hm = new HashMap<String, Object>();
		
    	List<HashMap<String, Object>> list = sqlSession.selectList("axSetting.axSettingMailList", paramMap);
    	hm.put("list", list);
        
    	return hm;
    }
	
	@Transactional(propagation=Propagation.REQUIRED, rollbackFor={Throwable.class})
    public HashMap<String, Object>  axSettingMailSave(HashMap<String, Object> paramMap) throws Exception {
		HashMap<String, Object> hm = new HashMap<String, Object>();
		
		List<HashMap<String, Object>> updList = (List<HashMap<String, Object>>)paramMap.get("modified");

		for ( int i = 0; i < updList.size(); i++ ) {
			HashMap<String, Object> row = (HashMap<String, Object>)updList.get(i);
			row.put("SESSION_USER_ID", SessionUtil.getSessionUserId());

			if ( "Y".equals((String)row.get("NEW_FLAG")) ) {
				sqlSession.insert("axSetting.axSettingMailInsert", row);
			} else {
				sqlSession.update("axSetting.axSettingMailUpdate", row);
			}
		}

		List<HashMap<String, Object>> delList = (List<HashMap<String, Object>>)paramMap.get("deleted");
		for ( int i = 0; i < delList.size(); i++ ) {
			sqlSession.delete("axSetting.axSettingMailDelete", delList.get(i));
		}

		hm.put("RtnMode", Constant.mode.OK.name());
		
    	return hm;
    }
    
	public HashMap<String, Object> axSettingConfigList(HashMap<String, Object> paramMap) throws Exception {
		HashMap<String, Object> hm = new HashMap<String, Object>();
		
    	List<HashMap<String, Object>> list = sqlSession.selectList("axSetting.axSettingConfigList", paramMap);
    	hm.put("list", list);
        
    	return hm;
    }
	
	@Transactional(propagation=Propagation.REQUIRED, rollbackFor={Throwable.class})
    public HashMap<String, Object>  axSettingConfigSave(HashMap<String, Object> paramMap) throws Exception {
		HashMap<String, Object> hm = new HashMap<String, Object>();
		
		List<HashMap<String, Object>> updList = (List<HashMap<String, Object>>)paramMap.get("modified");

		for ( int i = 0; i < updList.size(); i++ ) {
			HashMap<String, Object> row = (HashMap<String, Object>)updList.get(i);
			row.put("SESSION_USER_ID", SessionUtil.getSessionUserId());

			sqlSession.update("axSetting.axSettingConfigUpdate", row);
		}

		hm.put("RtnMode", Constant.mode.OK.name());
		
    	return hm;
    }
    
	public HashMap<String, Object> axSettingCodeList(HashMap<String, Object> paramMap) throws Exception {
		HashMap<String, Object> hm = new HashMap<String, Object>();
		
    	List<HashMap<String, Object>> list = sqlSession.selectList("axSetting.axSettingCodeList", paramMap);
    	hm.put("list", list);
        
    	return hm;
    }
	
	@Transactional(propagation=Propagation.REQUIRED, rollbackFor={Throwable.class})
    public HashMap<String, Object>  axSettingCodeSave(HashMap<String, Object> paramMap) throws Exception {
		HashMap<String, Object> hm = new HashMap<String, Object>();
		
		List<HashMap<String, Object>> updList = (List<HashMap<String, Object>>)paramMap.get("modified");

		for ( int i = 0; i < updList.size(); i++ ) {
			HashMap<String, Object> row = (HashMap<String, Object>)updList.get(i);
			row.put("SESSION_USER_ID", SessionUtil.getSessionUserId());

			sqlSession.update("axSetting.axSettingCodeUpdate", row);
		}

		hm.put("RtnMode", Constant.mode.OK.name());
		
    	return hm;
    }
	
	public HashMap<String, Object> axMainFrameList(HashMap<String, Object> paramMap) throws Exception {
		HashMap<String, Object> hm = new HashMap<String, Object>();
		
    	List<HashMap<String, Object>> list = sqlSession.selectList("axSetting.axMainFrameList", paramMap);
    	hm.put("list", list);
        
    	return hm;
    }
	
	@Transactional(propagation=Propagation.REQUIRED, rollbackFor={Throwable.class})
    public HashMap<String, Object>  axMainFrameSave(HashMap<String, Object> paramMap) throws Exception {
		HashMap<String, Object> hm = new HashMap<String, Object>();
		
		List<HashMap<String, Object>> updList = (List<HashMap<String, Object>>)paramMap.get("modified");

		for ( int i = 0; i < updList.size(); i++ ) {
			HashMap<String, Object> row = (HashMap<String, Object>)updList.get(i);

			if ( "Y".equals((String)row.get("NEW_FLAG")) ) {
				sqlSession.insert("axSetting.axMainFrameInsert", row);
			} else {
				sqlSession.update("axSetting.axMainFrameUpdate", row);
			}
		}

		List<HashMap<String, Object>> delList = (List<HashMap<String, Object>>)paramMap.get("deleted");
		for ( int i = 0; i < delList.size(); i++ ) {
			sqlSession.delete("axSetting.axMainFrameDelete", delList.get(i));
		}

		hm.put("RtnMode", Constant.mode.OK.name());
		
    	return hm;
    }
	
	public HashMap<String, Object> axMainFrameDetailList(HashMap<String, Object> paramMap) throws Exception {
		HashMap<String, Object> hm = new HashMap<String, Object>();
		
    	List<HashMap<String, Object>> list = sqlSession.selectList("axSetting.axMainFrameDetailList", paramMap);
    	hm.put("list", list);
        
    	return hm;
    }
	
	@Transactional(propagation=Propagation.REQUIRED, rollbackFor={Throwable.class})
    public HashMap<String, Object>  axMainFrameDetailSave(HashMap<String, Object> paramMap) throws Exception {
		HashMap<String, Object> hm = new HashMap<String, Object>();
		
		List<HashMap<String, Object>> updList = (List<HashMap<String, Object>>)paramMap.get("modified");

		for ( int i = 0; i < updList.size(); i++ ) {
			HashMap<String, Object> row = (HashMap<String, Object>)updList.get(i);

			if ( "Y".equals((String)row.get("NEW_FLAG")) ) {
				sqlSession.insert("axSetting.axMainFrameDetailInsert", row);
			} else {
				sqlSession.update("axSetting.axMainFrameDetailUpdate", row);
			}
		}

		List<HashMap<String, Object>> delList = (List<HashMap<String, Object>>)paramMap.get("deleted");
		for ( int i = 0; i < delList.size(); i++ ) {
			sqlSession.delete("axSetting.axMainFrameDetailDelete", delList.get(i));
		}

		hm.put("RtnMode", Constant.mode.OK.name());
		
    	return hm;
    }
	
	@Transactional(propagation=Propagation.REQUIRED, rollbackFor={Throwable.class})
    public HashMap<String, Object>  axMainFrameApply(HashMap<String, Object> paramMap) throws Exception {
		HashMap<String, Object> hm = new HashMap<String, Object>();
		
		sqlSession.update("axSetting.axMainFrameApply", paramMap);
		sqlSession.update("axSetting.axMainFrameDetailApply", paramMap);

		hm.put("RtnMode", Constant.mode.OK.name());
		
    	return hm;
    }

	public HashMap<String, Object> axMainFrameCompanyDomain(HashMap<String, Object> paramMap) throws Exception {
		HashMap<String, Object> hm = new HashMap<String, Object>();
		
    	String domain = sqlSession.selectOne("axSetting.axMainFrameCompanyDomain", paramMap);
    	hm.put("domain", domain);
        
    	return hm;
    }

	public HashMap<String, Object> axSettingSmtpList(HashMap<String, Object> paramMap) throws Exception {
		HashMap<String, Object> hm = new HashMap<String, Object>();
		
    	List<HashMap<String, Object>> list = sqlSession.selectList("axSetting.axSettingSmtpList", paramMap);
    	hm.put("list", list);
        
    	return hm;
    }
	
	@Transactional(propagation=Propagation.REQUIRED, rollbackFor={Throwable.class})
    public HashMap<String, Object>  axSettingSmtpSave(HashMap<String, Object> paramMap) throws Exception {
		HashMap<String, Object> hm = new HashMap<String, Object>();
		
		List<HashMap<String, Object>> updList = (List<HashMap<String, Object>>)paramMap.get("modified");

		for ( int i = 0; i < updList.size(); i++ ) {
			HashMap<String, Object> row = (HashMap<String, Object>)updList.get(i);
			row.put("SESSION_USER_ID", SessionUtil.getSessionUserId());

			if ( "Y".equals((String)row.get("NEW_FLAG")) ) {
				sqlSession.insert("axSetting.axSettingSmtpInsert", row);
			} else {
				sqlSession.update("axSetting.axSettingSmtpUpdate", row);
			}
		}

		List<HashMap<String, Object>> delList = (List<HashMap<String, Object>>)paramMap.get("deleted");
		for ( int i = 0; i < delList.size(); i++ ) {
			sqlSession.delete("axSetting.axSettingSmtpDelete", delList.get(i));
		}

		hm.put("RtnMode", Constant.mode.OK.name());
		
    	return hm;
    }
}
