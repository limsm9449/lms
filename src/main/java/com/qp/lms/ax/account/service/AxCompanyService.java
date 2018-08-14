package com.qp.lms.ax.account.service;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.qp.lms.common.Constant;
import com.qp.lms.common.SessionUtil;
import com.qp.lms.common.service.DdService;

@Service
public class AxCompanyService {
	@Autowired
	private SqlSession sqlSession;
	
	public HashMap<String, Object> axCompanyList(HashMap<String, Object> paramMap) throws Exception {
		HashMap<String, Object> hm = new HashMap<String, Object>();
		
    	List<HashMap<String, Object>> list = sqlSession.selectList("axCompany.axCompanyList", paramMap);
    	hm.put("list", list);
        
    	return hm;
    }
	
	@Transactional(propagation=Propagation.REQUIRED, rollbackFor={Throwable.class})
    public HashMap<String, Object>  axCompanySave(HashMap<String, Object> paramMap) throws Exception {
		HashMap<String, Object> hm = new HashMap<String, Object>();
		
		List<HashMap<String, Object>> updList = (List<HashMap<String, Object>>)paramMap.get("modified");

		//dup 체크
		for ( int i = 0; i < updList.size(); i++ ) {
			HashMap<String, Object> row = (HashMap<String, Object>)updList.get(i);

			if ( "Y".equals((String)row.get("NEW_FLAG")) ) {
				int cnt = sqlSession.selectOne("axCompany.axCompanyPk", row);
				if ( cnt > 0 ) {
					hm.put("RtnMode", Constant.mode.DUPLICATION.name());
					return hm;
				}
			}
		}

		for ( int i = 0; i < updList.size(); i++ ) {
			HashMap<String, Object> row = (HashMap<String, Object>)updList.get(i);
			row.put("SESSION_USER_ID", SessionUtil.getSessionUserId());

			if ( "Y".equals((String)row.get("NEW_FLAG")) ) {
				sqlSession.insert("axCompany.axCompanyInsert", row);
			} else {
				sqlSession.update("axCompany.axCompanyUpdate", row);
			}
		}

		List<HashMap<String, Object>> delList = (List<HashMap<String, Object>>)paramMap.get("deleted");
		for ( int i = 0; i < delList.size(); i++ ) {
			sqlSession.delete("axCompany.axCompanyDelete", delList.get(i));
		}

		hm.put("RtnMode", Constant.mode.OK.name());
		
    	return hm;
    }
	
	public HashMap<String, Object> axCompanyImageList(HashMap<String, Object> paramMap) throws Exception {
		HashMap<String, Object> hm = new HashMap<String, Object>();
		
    	HashMap<String, Object> row = sqlSession.selectOne("axCompany.axCompanyOne", paramMap);
    	hm.put("row", row);
        
    	return hm;
    }
	
	@Transactional(propagation=Propagation.REQUIRED, rollbackFor={Throwable.class})
    public HashMap<String, Object> axCompanyImageUpload(HashMap<String, Object> paramMap) throws Exception {
		HashMap<String, Object> hm = new HashMap<String, Object>();
		
		paramMap.put("SESSION_USER_ID", SessionUtil.getSessionUserId());
		
		sqlSession.update("axCompany.axCompanyImageUpdate", paramMap);

		hm.put("RtnMode", Constant.mode.OK.name());
		
    	return hm;
    }
	
	
    
    
    
}
