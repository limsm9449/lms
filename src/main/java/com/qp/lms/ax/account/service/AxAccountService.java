package com.qp.lms.ax.account.service;

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

import com.qp.lms.ax.common.service.AxCommService;
import com.qp.lms.common.CommUtil;
import com.qp.lms.common.Constant;
import com.qp.lms.common.SessionUtil;

@Service
public class AxAccountService {
	@Autowired
	private SqlSession sqlSession;
	
	@Autowired
	private AxCommService axCommService;
	
	public HashMap<String, Object> axAccountList(HashMap<String, Object> paramMap) throws Exception {
		HashMap<String, Object> hm = new HashMap<String, Object>();
		
		CommUtil.setSesstionInfo(paramMap);
		
    	List<HashMap<String, Object>> list = sqlSession.selectList("axAccount.axAccountList", paramMap);
    	hm.put("list", list);
        
    	return hm;
    }
	
	@Transactional(propagation=Propagation.REQUIRED, rollbackFor={Throwable.class})
    public HashMap<String, Object>  axAccountSave(HashMap<String, Object> paramMap) throws Exception {
		HashMap<String, Object> hm = new HashMap<String, Object>();
		
		List<HashMap<String, Object>> updList = (List<HashMap<String, Object>>)paramMap.get("modified");

		//dup 체크
		String dupUserids = "";
		for ( int i = 0; i < updList.size(); i++ ) {
			HashMap<String, Object> row = (HashMap<String, Object>)updList.get(i);

			if ( "Y".equals((String)row.get("NEW_FLAG")) ) {
				int cnt = sqlSession.selectOne("axAccount.axAccountPk", row);
				if ( cnt > 0 ) {
					dupUserids += ( "".equals(dupUserids) ? "" : ", " ) + row.get("USER_ID");
				}
			}
		}
		if ( !"".equals(dupUserids) ) {
			hm.put("RtnMode", Constant.mode.DUPLICATION.name());
			hm.put("DupUserids", dupUserids);
			return hm;
		}

		for ( int i = 0; i < updList.size(); i++ ) {
			HashMap<String, Object> row = (HashMap<String, Object>)updList.get(i);
			row.put("SESSION_USER_ID", SessionUtil.getSessionUserId());

			if ( "Y".equals((String)row.get("NEW_FLAG")) ) {
				sqlSession.insert("axAccount.axAccountInsert", row);
				
				row.put("USER_PASSWORD", row.get("PWD"));
				sqlSession.update("axAccount.axChangePassword", row);
			} else {
				sqlSession.update("axAccount.axAccountUpdate", row);
			}
		}

		List<HashMap<String, Object>> delList = (List<HashMap<String, Object>>)paramMap.get("deleted");
		for ( int i = 0; i < delList.size(); i++ ) {
			sqlSession.delete("axAccount.axAccountDelete", delList.get(i));
		}

		hm.put("RtnMode", Constant.mode.OK.name());
		
    	return hm;
    }
	
	@Transactional(propagation=Propagation.REQUIRED, rollbackFor={Throwable.class})
    public HashMap<String, Object>  axPasswordReset(HashMap<String, Object> paramMap) throws Exception {
		HashMap<String, Object> hm = new HashMap<String, Object>();
		
		//패스워드 변경
    	String newPassword = "U" + Integer.toString((int)(Math.random() * 100000));
    	
    	paramMap.put("SESSION_USER_ID", SessionUtil.getSessionUserId());
    	paramMap.put("USER_PASSWORD", newPassword);
		sqlSession.update("axAccount.axChangePassword", paramMap);

    	StringBuffer contents = new StringBuffer();
    	contents.append("<div style='font-size: 12px; width: 650px; height:500px; margin:0 auto;' align='center'>");
    	contents.append("  <div align='left'>");
    	contents.append("    <a href='" + SessionUtil.getAttribute("serverDomain") + "'><img src='http://www.qlearning.co.kr/resources/images/common/toplogo.png' style='border:0;' /></a>");
    	contents.append("  </div>");
    	contents.append("  <div style='text-align: left;margin: 30px 10px 30px;'>");
    	contents.append("    <p style='font-size: 14px; line-height: 1.5;'>안녕하세요.<br />온라인 학습 사이트 <b>큐러닝</b>입니다.<br /><br /></p>");
    	contents.append("    " + paramMap.get("USER_NAME") + "님의 임시 비밀번호를 발송합니다.<br />");
    	contents.append("    임시 비밀번호는 [<b>" + newPassword + "</b>]입니다. 로그인 후 비밀번호를 변경하여 주십시오.");
    	contents.append("    <p style='display:block;margin: 30px 10px;'>비밀번호 변경은 <span style='color:#0a88d9'>마이페이지 > 비밀번호 변경</span> 페이지에서 변경 하실 수 있습니다.</p>");
    	contents.append("    임시 비밀번호의 대소문자에 유의하시기 바랍니다.");
    	contents.append("  </div>");
    	contents.append("  <div style='margin: 40px 0 0;'>");
    	contents.append("    <div style='float: left;'><img src='http://www.qlearning.co.kr/resources/images/admin/common/bottom_logo.png' alt='Qpeople' /></div>");
    	contents.append("    <div style='float: left;margin-left: 20px;'><p style='font-size: 11px;'>Copyrights 2017 Qpeople Academy. ALL Right Reserved</p></div>");
    	contents.append("  </div>");
    	contents.append("</div>");
    	
    	axCommService.axMailSave(SessionUtil.getSessionUserId(), (String)paramMap.get("EMAIL"), "[비밀번호 확인메일] 임시 비밀번호를 발송합니다.", contents.toString());
		axCommService.axSendMail(null);
		
		hm.put("RtnMode", Constant.mode.OK.name());
		
    	return hm;
    }
	
	@Transactional(propagation=Propagation.REQUIRED, rollbackFor={Throwable.class})
    public HashMap<String, Object>  axPasswordChange(HashMap<String, Object> paramMap) throws Exception {
		HashMap<String, Object> hm = new HashMap<String, Object>();
		
    	try {
        	paramMap.put("SESSION_USER_ID", SessionUtil.getSessionUserId());
    		sqlSession.update("axAccount.axChangePassword", paramMap);
    		hm.put("RtnMode", Constant.mode.OK.name());
    	} catch ( UnsupportedEncodingException e ) {
    		e.printStackTrace();
    		hm.put("RtnMode", Constant.mode.ERROR.name());
    	} catch ( MessagingException e ) {
    		hm.put("RtnMode", Constant.mode.ERROR.name());
    	}
		
    	return hm;
    }
	
	@Transactional(propagation=Propagation.REQUIRED, rollbackFor={Throwable.class})
    public HashMap<String, Object>  axReSendCertification(HashMap<String, Object> paramMap) throws Exception {
		HashMap<String, Object> hm = new HashMap<String, Object>();
		
		//cerification key 생성
    	String certificationKey = "";
    	Random rand = new Random();
    	for ( int i = 0; i < 20; i++ ) {
    		int idx = rand.nextInt(62);
    		
    		certificationKey += "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz1234567890".substring(idx, idx + 1);
    	}

    	paramMap.put("SESSION_USER_ID", SessionUtil.getSessionUserId());
    	paramMap.put("CERTIFICATION_KEY", certificationKey);
		sqlSession.update("axAccount.axChangeCertification", paramMap);
    	
    	StringBuffer contents = new StringBuffer();
    	contents.append("<div style='font-size: 12px; width: 650px; height:500px; margin:0 auto;' align='center'>");
    	contents.append("  <div align='left'>");
    	contents.append("    <a href='" + SessionUtil.getAttribute("serverDomain") + "'><img src='http://www.qlearning.co.kr/resources/images/common/toplogo.png' style='border:0;' /></a>");
    	contents.append("  </div>");
    	contents.append("  <div style='text-align: left;margin: 30px 10px 30px;'>");
    	contents.append("    <p style='font-size: 14px; line-height: 1.5;'>안녕하세요.<br />온라인 학습 사이트 <b>큐러닝</b>입니다.<br /><br /></p>");
    	contents.append("    " + (String)paramMap.get("USER_NAME") + "님의 회원가입을 축하드립니다.<br />");
    	contents.append("    회원 가입을 정상적으로 처리하기 위해서는 아래 이메일 인증 주소를 클릭 하시거나 <a href='" + SessionUtil.getAttribute("serverDomain") + "/guest/certification.do?certificationKey=" + certificationKey + "'>여기</a>를 클릭하여 주십시오.");
    	contents.append("    <p style='display:block;margin: 30px 10px;'><a href='http://" + SessionUtil.getAttribute("serverDomain") + "/guest/certification.do?certificationKey=" + certificationKey + "'>" + SessionUtil.getAttribute("serverDomain") + "/guest/certification.do?certificationKey=" + certificationKey + "</a></p>");
    	contents.append("    이메일이 정상적으로 인증 되지 않을 경우 고객센터로 연락 주시면 신속하게 처리해 드리겠습니다.  ");
    	contents.append("  </div>");
    	contents.append("  <div style='margin: 40px 0 0;'>");
    	contents.append("    <div style='float: left;'><img src='http://www.qlearning.co.kr/resources/images/admin/common/bottom_logo.png' alt='Qpeople' /></div>");
    	contents.append("    <div style='float: left;margin-left: 20px;'><p style='font-size: 11px;'>Copyrights 2017 Qpeople Academy. ALL Right Reserved</p></div>");
    	contents.append("  </div>");
    	contents.append("</div>");

    	axCommService.axMailSave(SessionUtil.getSessionUserId(), (String)paramMap.get("EMAIL"), "[회원가입 인증메일] 큐러닝에 가입하신 환영합니다.", contents.toString());
		axCommService.axSendMail(null);
    	
		hm.put("RtnMode", Constant.mode.OK.name());
		
    	return hm;
    }    
	
	public HashMap<String, Object> axAccountImageList(HashMap<String, Object> paramMap) throws Exception {
		HashMap<String, Object> hm = new HashMap<String, Object>();
		
    	HashMap<String, Object> row = sqlSession.selectOne("axAccount.axAccountOne", paramMap);
    	hm.put("row", row);
        
    	return hm;
    }
	
	@Transactional(propagation=Propagation.REQUIRED, rollbackFor={Throwable.class})
    public HashMap<String, Object> axAccountImageUpload(HashMap<String, Object> paramMap) throws Exception {
		HashMap<String, Object> hm = new HashMap<String, Object>();
		
		paramMap.put("SESSION_USER_ID", SessionUtil.getSessionUserId());
		
		sqlSession.update("axAccount.axAccountImageUpdate", paramMap);

		hm.put("RtnMode", Constant.mode.OK.name());
		
    	return hm;
    }
	
	public HashMap<String, Object> axAccountUserOne(HashMap<String, Object> paramMap) throws Exception {
		HashMap<String, Object> hm = new HashMap<String, Object>();
		
		if ( CommUtil.isEqual((String)paramMap.get("USER_ID"), "") ) {
			paramMap.put("USER_ID", SessionUtil.getSessionUserId());
		} else {
			paramMap.put("USER_ID", (String)paramMap.get("USER_ID"));
		}
		
    	HashMap<String, Object> row = sqlSession.selectOne("axAccount.axAccountUserOne", paramMap);
    	hm.put("row", row);
        
    	return hm;
    }
	
	@Transactional(propagation=Propagation.REQUIRED, rollbackFor={Throwable.class})
    public HashMap<String, Object>  axAccountUserSave(HashMap<String, Object> paramMap) throws Exception {
		HashMap<String, Object> hm = new HashMap<String, Object>();
		
		paramMap.put("USER_ID", SessionUtil.getSessionUserId());
		sqlSession.update("axAccount.axAccountUserUpdate", paramMap);

		hm.put("RtnMode", Constant.mode.OK.name());
		
    	return hm;
    }
	
	@Transactional(propagation=Propagation.REQUIRED, rollbackFor={Throwable.class})
    public HashMap<String, Object>  axAccountUserCareerSave(HashMap<String, Object> paramMap) throws Exception {
		HashMap<String, Object> hm = new HashMap<String, Object>();
		
		if ( CommUtil.isEqual((String)paramMap.get("USER_ID"), "") ) {
			paramMap.put("USER_ID", SessionUtil.getSessionUserId());
		} else {
			paramMap.put("USER_ID", (String)paramMap.get("USER_ID"));
		}
		paramMap.put("SESSION_USER_ID", SessionUtil.getSessionUserId());
		
		sqlSession.update("axAccount.axAccountUserCareerUpdate", paramMap);

		hm.put("RtnMode", Constant.mode.OK.name());
		
    	return hm;
    }
    
}
