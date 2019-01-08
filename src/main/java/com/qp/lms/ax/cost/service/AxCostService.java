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
	
	public HashMap<String, Object> axCardCostList(HashMap<String, Object> paramMap) throws Exception {
		HashMap<String, Object> hm = new HashMap<String, Object>();
		
    	List<HashMap<String, Object>> list = sqlSession.selectList("axCost.axCardCostList", paramMap);
    	hm.put("list", list);
        
    	return hm;
    }
	
	public HashMap<String, Object> axCostCalcStatusList(HashMap<String, Object> paramMap) throws Exception {
		HashMap<String, Object> hm = new HashMap<String, Object>();
		
    	List<HashMap<String, Object>> list = sqlSession.selectList("axCost.axCostCalcStatusList", paramMap);
    	hm.put("list", list);
        
    	return hm;
    }
	
	@Transactional(propagation=Propagation.REQUIRED, rollbackFor={Throwable.class})
    public HashMap<String, Object>  axCostCalcStatusSave(HashMap<String, Object> paramMap) throws Exception {
		HashMap<String, Object> hm = new HashMap<String, Object>();

		//과정별 last_yn = n
		sqlSession.update("axCost.axCostLastYnUpdate", paramMap);
		
		//COST에 데이타 생성
		sqlSession.insert("axCost.axCostMasterInsert", paramMap);
		
		//마지막 ID를 구한다.
    	paramMap.put("SEQ", (String)sqlSession.selectOne("axComm.lastInsertId"));

		//과정의 사용자, 자료게시판, Qna 게시판, 답변의 대상에 COST의 SEQ 세팅
		sqlSession.update("axCost.axCourseRegisterTargetUpdate", paramMap);
		sqlSession.update("axCost.axBoardDataTargetUpdate", paramMap);
		sqlSession.update("axCost.axBoardQnaTargetUpdate", paramMap);
		sqlSession.update("axCost.axReplyTargetUpdate", paramMap);
		
		//정산 안한 수강생의 총 금액을 구한다.
		sqlSession.update("axCost.axCostTotalCostUpdate", paramMap);

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

			sqlSession.update("axCost.axCostMasterUpdate", row);
		}

		hm.put("RtnMode", Constant.mode.OK.name());
		
    	return hm;
    }
	
	@Transactional(propagation=Propagation.REQUIRED, rollbackFor={Throwable.class})
    public HashMap<String, Object>  axCostTutorCalcSave(HashMap<String, Object> paramMap) throws Exception {
		HashMap<String, Object> hm = new HashMap<String, Object>();
		
		//과정의 사용자, 자료게시판, Qna 게시판, 답변의 대상에 COST의 SEQ 세팅
		sqlSession.update("axCost.axCourseRegisterTargetUpdate", paramMap);
		sqlSession.update("axCost.axBoardDataTargetUpdate", paramMap);
		sqlSession.update("axCost.axBoardQnaTargetUpdate", paramMap);
		sqlSession.update("axCost.axReplyTargetUpdate", paramMap);

		hm.put("RtnMode", Constant.mode.OK.name());
		
    	return hm;
    }
	
	@Transactional(propagation=Propagation.REQUIRED, rollbackFor={Throwable.class})
    public HashMap<String, Object>  axCostCalcUserSave(HashMap<String, Object> paramMap) throws Exception {
		HashMap<String, Object> hm = new HashMap<String, Object>();
		
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
			} else if ( "QNA_REPLY".equals(row.get("KIND")) ) {
				sqlSession.update("axCost.axCostCalcBoardQnaUpdate", row);
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
    
	public HashMap<String, Object> axIncomeList(HashMap<String, Object> paramMap) throws Exception {
		HashMap<String, Object> hm = new HashMap<String, Object>();
		
		paramMap.put("AUTH", SessionUtil.getAuth());
		paramMap.put("USER_ID", SessionUtil.getSessionUserId());
		
    	List<HashMap<String, Object>> list = null;
    	
    	if ( "ADMIN".equals(SessionUtil.getAuth()) ) {
    		list = sqlSession.selectList("axCost.axIncomeAdminList", paramMap);
    	} else {
    		list = sqlSession.selectList("axCost.axIncomeList", paramMap);
    	}
    	hm.put("list", list);
        
    	return hm;
    }    
    
	public HashMap<String, Object> axIncomeMonthList(HashMap<String, Object> paramMap) throws Exception {
		HashMap<String, Object> hm = new HashMap<String, Object>();
		
		paramMap.put("AUTH", SessionUtil.getAuth());
		paramMap.put("USER_ID", SessionUtil.getSessionUserId());
		
    	List<HashMap<String, Object>> list = null;
    	
    	if ( "ADMIN".equals(SessionUtil.getAuth()) ) {
    		list = sqlSession.selectList("axCost.axIncomeMonthAdminList", paramMap);
    	} else {
    		list = sqlSession.selectList("axCost.axIncomeMonthList", paramMap);
    	}
    	hm.put("list", list);
        
    	return hm;
    }    
    
}
