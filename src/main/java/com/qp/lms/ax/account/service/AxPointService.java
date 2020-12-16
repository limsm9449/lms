package com.qp.lms.ax.account.service;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.qp.lms.ax.common.service.AxCommService;
import com.qp.lms.common.CommUtil;
import com.qp.lms.common.Constant;
import com.qp.lms.common.SessionUtil;

@Service
public class AxPointService {
	@Autowired
	private SqlSession sqlSession;
	
	@Autowired
	private AxCommService axCommService;
	
	public HashMap<String, Object> axPointCodeList(HashMap<String, Object> paramMap) throws Exception {
		HashMap<String, Object> hm = new HashMap<String, Object>();
		
    	List<HashMap<String, Object>> list = sqlSession.selectList("axPoint.axPointCodeList", paramMap);
    	hm.put("list", list);
        
    	return hm;
    }
	
	@Transactional(propagation=Propagation.REQUIRED, rollbackFor={Throwable.class})
    public HashMap<String, Object>  axPointCodeSave(HashMap<String, Object> paramMap) throws Exception {
		HashMap<String, Object> hm = new HashMap<String, Object>();
		
		List<HashMap<String, Object>> updList = (List<HashMap<String, Object>>)paramMap.get("modified");

		//dup 체크
		for ( int i = 0; i < updList.size(); i++ ) {
			HashMap<String, Object> row = (HashMap<String, Object>)updList.get(i);

			if ( "Y".equals((String)row.get("NEW_FLAG")) ) {
				int cnt = sqlSession.selectOne("axPoint.axPointCodePk", row);
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
				sqlSession.insert("axPoint.axPointCodeInsert", row);
			} else {
				sqlSession.update("axPoint.axPointCodeUpdate", row);
			}
		}

		List<HashMap<String, Object>> delList = (List<HashMap<String, Object>>)paramMap.get("deleted");
		for ( int i = 0; i < delList.size(); i++ ) {
			sqlSession.delete("axPoint.axPointCodeDelete", delList.get(i));
		}

		hm.put("RtnMode", Constant.mode.OK.name());
		
    	return hm;
    }
	
	public HashMap<String, Object> axPointList(HashMap<String, Object> paramMap) throws Exception {
		HashMap<String, Object> hm = new HashMap<String, Object>();
		
    	List<HashMap<String, Object>> list = sqlSession.selectList("axPoint.axPointList", paramMap);
    	hm.put("list", list);
        
    	return hm;
    }

	public HashMap<String, Object> axPointDetailList(HashMap<String, Object> paramMap) throws Exception {
		HashMap<String, Object> hm = new HashMap<String, Object>();
		
    	List<HashMap<String, Object>> list = sqlSession.selectList("axPoint.axPointDetailList", paramMap);
    	hm.put("list", list);
        
    	return hm;
    }
	
	public HashMap<String, Object> axPointEventMemberList(HashMap<String, Object> paramMap) throws Exception {
		HashMap<String, Object> hm = new HashMap<String, Object>();
		
    	List<HashMap<String, Object>> list = sqlSession.selectList("axPoint.axPointEventMemberList", paramMap);
    	hm.put("list", list);
        
    	return hm;
    }
	
	@Transactional(propagation=Propagation.REQUIRED, rollbackFor={Throwable.class})
    public HashMap<String, Object>  axPointEventMemberSave(HashMap<String, Object> paramMap) throws Exception {
		HashMap<String, Object> hm = new HashMap<String, Object>();
		
		paramMap.put("SESSION_USER_ID", SessionUtil.getSessionUserId());
		
		List<HashMap<String, Object>> updList = (List<HashMap<String, Object>>)paramMap.get("modified");
		for ( int i = 0 ; i < updList.size(); i++ ) {
			paramMap.put("USER_ID", updList.get(i).get("USER_ID"));
			
			sqlSession.insert("axPoint.memberEventPointInsert", paramMap);
		}
		
		for ( int i = 0 ; i < updList.size(); i++ ) {
	    	StringBuffer contents = new StringBuffer();
	    	contents.append("<div style='font-size: 12px; width: 650px; height:500px; margin:0 auto;' align='center'>");
	    	contents.append("  <div align='left'>");
	    	contents.append("    <a href='" + SessionUtil.getAttribute("serverDomain") + "'><img src='http://www.qlearning.co.kr/resources/images/common/toplogo.png' style='border:0;' /></a>");
	    	contents.append("  </div>");
	    	contents.append("  <div style='text-align: left;margin: 30px 10px 30px;'>");
	    	contents.append("    <p style='font-size: 14px; line-height: 1.5;'>안녕하세요.<br />온라인 학습 사이트 <b>큐러닝</b>입니다.<br /><br /></p>");
	    	contents.append("    " + updList.get(i).get("USER_NAME") + "님의 포인트가 ( " + CommUtil.toNumFormat((String)paramMap.get("POINT")) + " )점 적립되었습니다. <br />");
	    	contents.append("    <p style='display:block;margin: 30px 10px;'>자세한 적립/사용내역은 <span style='color:#0a88d9'>마이페이지 > 포인트</span> 페이지에서 확인하실 수 있습니다.</p>");
	    	contents.append("  </div>");
	    	contents.append("  <div style='margin: 40px 0 0;'>");
	    	contents.append("    <div style='float: left;'><img src='http://www.qlearning.co.kr/resources/images/admin/common/bottom_logo.png' alt='Qpeople' /></div>");
	    	contents.append("    <div style='float: left;margin-left: 20px;'><p style='font-size: 11px;'>Copyrights 2017 Qpeople Academy. ALL Right Reserved</p></div>");
	    	contents.append("  </div>");
	    	contents.append("</div>");
	    	
	    	axCommService.axMailSave((String)updList.get(i).get("USER_ID"), (String)updList.get(i).get("EMAIL"), "회원 이벤트 포인트 지급 공지", contents.toString());
		}
		axCommService.axSendMail(null);
		
		hm.put("RtnMode", Constant.mode.OK.name());
		
    	return hm;
    }
    
	@Transactional(propagation=Propagation.REQUIRED, rollbackFor={Throwable.class})
    public HashMap<String, Object>  axPointSave(HashMap<String, Object> paramMap) throws Exception {
		HashMap<String, Object> hm = new HashMap<String, Object>();
		

		List<HashMap<String, Object>> delList = (List<HashMap<String, Object>>)paramMap.get("deleted");
		for ( int i = 0; i < delList.size(); i++ ) {
			sqlSession.delete("axPoint.axPointDelete", delList.get(i));

	    	StringBuffer contents = new StringBuffer();
	    	contents.append("<div style='font-size: 12px; width: 650px; height:500px; margin:0 auto;' align='center'>");
	    	contents.append("  <div align='left'>");
	    	contents.append("    <a href='" + SessionUtil.getAttribute("serverDomain") + "'><img src='http://www.qlearning.co.kr/resources/images/common/toplogo.png' style='border:0;' /></a>");
	    	contents.append("  </div>");
	    	contents.append("  <div style='text-align: left;margin: 30px 10px 30px;'>");
	    	contents.append("    <p style='font-size: 14px; line-height: 1.5;'>안녕하세요.<br />온라인 학습 사이트 <b>큐러닝</b>입니다.<br /><br /></p>");
	    	contents.append("    " + delList.get(i).get("USER_NAME") + "님의 포인트 ( " + CommUtil.toNumFormat("" + delList.get(i).get("POINT")) + " )점이 [사유(구매취소 취소 등)]로 적립 취소되었습니다 <br />");
	    	contents.append("    <p style='display:block;margin: 30px 10px;'>자세한 적립/사용내역은 <span style='color:#0a88d9'>마이페이지 > 포인트</span> 페이지에서 확인하실 수 있습니다.</p>");
	    	contents.append("  </div>");
	    	contents.append("  <div style='margin: 40px 0 0;'>");
	    	contents.append("    <div style='float: left;'><img src='http://www.qlearning.co.kr/resources/images/admin/common/bottom_logo.png' alt='Qpeople' /></div>");
	    	contents.append("    <div style='float: left;margin-left: 20px;'><p style='font-size: 11px;'>Copyrights 2017 Qpeople Academy. ALL Right Reserved</p></div>");
	    	contents.append("  </div>");
	    	contents.append("</div>");
	    	
	    	axCommService.axMailSave((String)delList.get(i).get("USER_ID"), (String)delList.get(i).get("EMAIL"), "회원 포인트 취소 공지", contents.toString());

		}

		hm.put("RtnMode", Constant.mode.OK.name());
		
    	return hm;
    }
	
    
}
