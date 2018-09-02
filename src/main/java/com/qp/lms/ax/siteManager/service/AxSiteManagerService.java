package com.qp.lms.ax.siteManager.service;

import java.math.BigDecimal;
import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;

import com.qp.lms.ax.common.service.AxCommService;
import com.qp.lms.common.CommUtil;
import com.qp.lms.common.Constant;
import com.qp.lms.common.SessionUtil;
import com.qp.lms.common.service.DdService;
import com.qp.lms.compManager.model.CompCourseRegVO;
import com.qp.lms.guest.model.BankVO;
import com.qp.lms.main.model.MainVO;
import com.qp.lms.member.model.MemberVO;

@Service
public class AxSiteManagerService {
	
	@Autowired
	private SqlSession sqlSession;
	
	@Autowired
	private DdService ddService;
	
	@Autowired
    private AxCommService axCommSvr;
	
	
	public HashMap<String, Object> axSiteManagerCourseUserList(HashMap<String, Object> paramMap) throws Exception {
		HashMap<String, Object> hm = new HashMap<String, Object>();
		
		paramMap.put("SESSION_USER_ID", SessionUtil.getSessionUserId());
		
    	hm.put("list1", sqlSession.selectList("axSiteManager.axCourseNoRegisterList", paramMap));
    	hm.put("list2", sqlSession.selectList("axSiteManager.axCourseRegisterList", paramMap));
        
    	return hm;
    }
	
	@Transactional(propagation=Propagation.REQUIRED, rollbackFor={Throwable.class})
    public HashMap<String, Object>  axSiteManagerCourseUserSave(HashMap<String, Object> paramMap) throws Exception {
		HashMap<String, Object> hm = new HashMap<String, Object>();
		
		List<HashMap<String, Object>> updList = (List<HashMap<String, Object>>)paramMap.get("modified");

		for ( int i = 0; i < updList.size(); i++ ) {
			HashMap<String, Object> row = (HashMap<String, Object>)updList.get(i);
			row.put("SESSION_USER_ID", SessionUtil.getSessionUserId());

			sqlSession.insert("axSiteManager.axCourseRegisterInsert", row);
		}

		List<HashMap<String, Object>> delList = (List<HashMap<String, Object>>)paramMap.get("deleted");
		for ( int i = 0; i < delList.size(); i++ ) {
			sqlSession.delete("axSiteManager.axCourseRegisterDelete", delList.get(i));
		}

		hm.put("RtnMode", Constant.mode.OK.name());
		
    	return hm;
    }
	
	@Transactional(propagation=Propagation.REQUIRED, rollbackFor={Throwable.class})
    public HashMap<String, Object> axUserCourseRegister(HashMap<String, Object> paramMap) throws Exception {
		HashMap<String, Object> hm = new HashMap<String, Object>();
		
		paramMap.put("userId", SessionUtil.getSessionUserId());
		
		//튜터를 구한다.
		int courseUserCnt = sqlSession.selectOne("axPg.axCourseUserCnt", paramMap);
		List<HashMap<String, Object>> tutorList = sqlSession.selectList("axPg.axCourseTutors", paramMap);
		for ( int m = 0; m < tutorList.size(); m++ ) {
			if ( CommUtil.getIntValue(tutorList.get(m).get("FROM_CNT")) <= courseUserCnt + m && CommUtil.getIntValue(tutorList.get(m).get("TO_CNT")) >= courseUserCnt + m ) {
				paramMap.put("tutorId", tutorList.get(m).get("TUTOR_ID"));
				break;
			}
		}
		
		//레포트를 구한다.
		String courseReportYn = sqlSession.selectOne("axPg.axCourseReportExist", paramMap);
		if ( "Y".equals(courseReportYn) ) {
			paramMap.put("reportSeq", sqlSession.selectOne("axPg.axCourseRandomReport", paramMap));
		}
		
		//반려된 케이스가 있으면 삭제를 해준다.
		sqlSession.delete("axPg.axRejectCourseRegisterDel", paramMap);
		sqlSession.delete("axPg.axRejectCourseEvalDel", paramMap);
		sqlSession.delete("axPg.axRejectCourseWeekDel", paramMap);

		paramMap.put("approvalId", "NULL");
		paramMap.put("paymentKind", "CARD");
		paramMap.put("SESSION_USER_ID", SessionUtil.getSessionUserId());
		
    	sqlSession.update("axPg.axCourseRegisterInsert",paramMap);
    	sqlSession.insert("axPg.axCourseEvalInsert",paramMap);
    	sqlSession.insert("axPg.axCourseWeekInsert",paramMap);
		
		hm.put("RtnMode", Constant.mode.OK.name());
		
    	return hm;
    }
	
	public HashMap<String, Object> axApprovalList(HashMap<String, Object> paramMap) throws Exception {
		HashMap<String, Object> hm = new HashMap<String, Object>();
		
		paramMap.put("USER_ID", SessionUtil.getSessionUserId());
		
    	hm.put("list", sqlSession.selectList("axSiteManager.axApprovalList", paramMap));
        
    	return hm;
    }
	
	public HashMap<String, Object> axApprovalUserList(HashMap<String, Object> paramMap) throws Exception {
		HashMap<String, Object> hm = new HashMap<String, Object>();
		
    	hm.put("list", sqlSession.selectList("axSiteManager.axApprovalUserList", paramMap));
        
    	return hm;
    }
}
