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
	
	public HashMap<String, Object> axCostCalcList(HashMap<String, Object> paramMap) throws Exception {
		HashMap<String, Object> hm = new HashMap<String, Object>();
		
    	List<HashMap<String, Object>> list = sqlSession.selectList("axCost.axCostCalcList", paramMap);
    	hm.put("list", list);
        
    	return hm;
    }
	
	@Transactional(propagation=Propagation.REQUIRED, rollbackFor={Throwable.class})
    public HashMap<String, Object>  axCostCalcSave(HashMap<String, Object> paramMap) throws Exception {
		HashMap<String, Object> hm = new HashMap<String, Object>();
		
		List<HashMap<String, Object>> updList = (List<HashMap<String, Object>>)paramMap.get("modified");

		for ( int i = 0; i < updList.size(); i++ ) {
			HashMap<String, Object> row = (HashMap<String, Object>)updList.get(i);
			row.put("SESSION_USER_ID", SessionUtil.getSessionUserId());

			if ( "n".equals(row.get("EXIST_COST")) ) {
				sqlSession.update("axCost.axCostMasterInsert", row);
			}

			sqlSession.update("axCost.axCostMasterUpdate", row);
		}

		hm.put("RtnMode", Constant.mode.OK.name());
		
    	return hm;
    }
	
	@Transactional(propagation=Propagation.REQUIRED, rollbackFor={Throwable.class})
    public HashMap<String, Object>  axCostCalcUserSave(HashMap<String, Object> paramMap) throws Exception {
		HashMap<String, Object> hm = new HashMap<String, Object>();
		
		HashMap<String, Object> costHm = sqlSession.selectOne("axCost.axCostMasterExist", paramMap); 
		if ( "N".equals(costHm.get("EXIST_DATA")) ) {
			costHm.put("SESSION_USER_ID", SessionUtil.getSessionUserId());
			sqlSession.update("axCost.axCostMasterInsert", costHm);
		}
		
		List<HashMap<String, Object>> userList = sqlSession.selectList("axCost.axCostCalcUserList", paramMap);
		for ( int i = 0 ; i < userList.size(); i++ ) {
			if ( "N".equals((String)userList.get(i).get("EXIST_USER")) ) {
				sqlSession.insert("axCost.axCostCalcInsert", userList.get(i));
			}
			
			if ( "TUTOR".equals((String)userList.get(i).get("KIND")) ) {
				sqlSession.update("axCost.axCostCalcTutorUpdate", userList.get(i));
			} else if ( "CP".equals((String)userList.get(i).get("KIND")) ) {
				sqlSession.update("axCost.axCostCalcCpUpdate", userList.get(i));
			} else if ( "TEACHER".equals((String)userList.get(i).get("KIND")) ) {
				sqlSession.update("axCost.axCostCalcTeacherUpdate", userList.get(i));
			}
		}

		sqlSession.update("axCost.axCostMasterCalcUpdate", paramMap);

		hm.put("RtnMode", Constant.mode.OK.name());
		
    	return hm;
    }
	
	public HashMap<String, Object> axCostCalcTutorBoardList(HashMap<String, Object> paramMap) throws Exception {
		HashMap<String, Object> hm = new HashMap<String, Object>();
		
    	List<HashMap<String, Object>> list = sqlSession.selectList("axCost.axCostCalcTutorBoardList", paramMap);
    	hm.put("list", list);
        
    	return hm;
    }
	
	@Transactional(propagation=Propagation.REQUIRED, rollbackFor={Throwable.class})
    public HashMap<String, Object>  axCostCalcTutorBoardSave(HashMap<String, Object> paramMap) throws Exception {
		HashMap<String, Object> hm = new HashMap<String, Object>();
		
		List<HashMap<String, Object>> updList = (List<HashMap<String, Object>>)paramMap.get("modified");

		for ( int i = 0; i < updList.size(); i++ ) {
			HashMap<String, Object> row = (HashMap<String, Object>)updList.get(i);

			if ( "DATA".equals(row.get("KIND")) ) {
				sqlSession.update("axCost.axCostCalcBoardDataUpdate", row);
			} else {
				sqlSession.update("axCost.axCostCalcReplyUpdate", row);
			}
		}

		hm.put("RtnMode", Constant.mode.OK.name());
		
    	return hm;
    }
	
	public HashMap<String, Object> axCostCalcPaymentList(HashMap<String, Object> paramMap) throws Exception {
		HashMap<String, Object> hm = new HashMap<String, Object>();
		
    	List<HashMap<String, Object>> list = sqlSession.selectList("axCost.axCostCalcPaymentList", paramMap);
    	hm.put("list", list);
        
    	return hm;
    }
	
	@Transactional(propagation=Propagation.REQUIRED, rollbackFor={Throwable.class})
    public HashMap<String, Object>  axCostCalcPaymentSave(HashMap<String, Object> paramMap) throws Exception {
		HashMap<String, Object> hm = new HashMap<String, Object>();
		
		List<HashMap<String, Object>> updList = (List<HashMap<String, Object>>)paramMap.get("modified");

		for ( int i = 0; i < updList.size(); i++ ) {
			HashMap<String, Object> row = (HashMap<String, Object>)updList.get(i);
			row.put("SESSION_USER_ID", SessionUtil.getSessionUserId());

			sqlSession.update("axCost.axCostCalcPaymentUpdate", row);
		}

		hm.put("RtnMode", Constant.mode.OK.name());
		
    	return hm;
    }
    
    
    
}
