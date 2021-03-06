package com.qp.lms.ax.common.service;

import java.io.UnsupportedEncodingException;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.HashMap;
import java.util.List;

import javax.mail.MessagingException;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.qp.lms.common.CommUtil;
import com.qp.lms.common.PlainMail;

@Service
public class AxCommService {
	@Autowired
	private SqlSession sqlSession;

	public HashMap<String, Object> axDd(HashMap<String, Object> paramMap) throws Exception {
		HashMap<String, Object> hm = new HashMap<String, Object>();
		
		String[] ddKinds = ((String)paramMap.get("DD_KIND")).split(",");
		for ( int i = 0; i < ddKinds.length; i++ ) {
			if ( "CategoryLevel1".equals(ddKinds[i]) ) {
				List<HashMap<String, Object>> list = sqlSession.selectList("axComm.axDdCategoryLevel1", paramMap);
		    	hm.put(ddKinds[i], list);
			} else if ( "CategoryLevel2".equals(ddKinds[i]) ) {
		    	hm.put(ddKinds[i], sqlSession.selectList("axComm.axDdCategoryLevel2", paramMap));
			} else if ( "CategoryLevel3".equals(ddKinds[i]) ) {
		    	hm.put(ddKinds[i], sqlSession.selectList("axComm.axDdCategoryLevel3", paramMap));
			} else if ( "Teacher".equals(ddKinds[i]) ) {
		    	hm.put(ddKinds[i], sqlSession.selectList("axComm.axDdTeacher", paramMap));
			} else if ( "Tutor".equals(ddKinds[i]) ) {
		    	hm.put(ddKinds[i], sqlSession.selectList("axComm.axDdTutor", paramMap));
			//} else if ( "CompanyTutor".equals(ddKinds[i]) ) {
		    //	hm.put(ddKinds[i], sqlSession.selectList("axComm.axDdCompanyTutor", paramMap));
			} else if ( "QuestGroup".equals(ddKinds[i]) ) {
		    	hm.put(ddKinds[i], sqlSession.selectList("axComm.axDdQuestGroup", paramMap));
			} else if ( "CourseCode".equals(ddKinds[i]) ) {
		    	hm.put(ddKinds[i], sqlSession.selectList("axComm.axDdCourseCode", paramMap));
			} else if ( "UnregisteredCourseCode".equals(ddKinds[i]) ) {
		    	hm.put(ddKinds[i], sqlSession.selectList("axComm.UnregisteredCourseCode", paramMap));
			} else if ( "ExamCourseCode".equals(ddKinds[i]) ) {
		    	hm.put(ddKinds[i], sqlSession.selectList("axComm.axDdExamCourseCode", paramMap));
			} else if ( "Company".equals(ddKinds[i]) ) {
		    	hm.put(ddKinds[i], sqlSession.selectList("axComm.axDdCompany", paramMap));
			} else if ( "Company1".equals(ddKinds[i]) ) {
		    	hm.put(ddKinds[i], sqlSession.selectList("axComm.axDdCompany1", paramMap));
			} else if ( "Company2".equals(ddKinds[i]) ) {
		    	hm.put(ddKinds[i], sqlSession.selectList("axComm.axDdCompany2", paramMap));
			} else if ( "CompanyKind".equals(ddKinds[i]) ) {
				paramMap.put("DD_MAIN", "COMPANY_KIND");
		    	hm.put(ddKinds[i], sqlSession.selectList("axComm.axDdCode", paramMap));
			} else if ( "ExamType".equals(ddKinds[i]) ) {
		    	hm.put(ddKinds[i], sqlSession.selectList("axComm.axDdExamType", paramMap));
			} else if ( "ReportCourseCode".equals(ddKinds[i]) ) {
		    	hm.put(ddKinds[i], sqlSession.selectList("axComm.axDdReportCourseCode", paramMap));
			} else if ( "Job".equals(ddKinds[i]) ) {
				paramMap.put("DD_MAIN", "JOB");
		    	hm.put(ddKinds[i], sqlSession.selectList("axComm.axDdCode", paramMap));
			} else if ( "Sex".equals(ddKinds[i]) ) {
				paramMap.put("DD_MAIN", "SEX");
		    	hm.put(ddKinds[i], sqlSession.selectList("axComm.axDdCode", paramMap));
			//} else if ( "AdminAuth".equals(ddKinds[i]) ) {
			//	paramMap.put("DD_MAIN", "ADMIN_AUTH");
		    //	hm.put(ddKinds[i], sqlSession.selectList("axComm.axDdCode", paramMap));
			} else if ( "ApprovalStatus".equals(ddKinds[i]) ) {
				paramMap.put("DD_MAIN", "APPROVAL_STATUS");
		    	hm.put(ddKinds[i], sqlSession.selectList("axComm.axDdCode", paramMap));
			} else if ( "ApprovalCardStatus".equals(ddKinds[i]) ) {
				paramMap.put("DD_MAIN", "APPROVAL_CARD_STATUS");
		    	hm.put(ddKinds[i], sqlSession.selectList("axComm.axDdCode", paramMap));
			} else if ( "PaymentKind".equals(ddKinds[i]) ) {
				paramMap.put("DD_MAIN", "PAYMENT_KIND");
		    	hm.put(ddKinds[i], sqlSession.selectList("axComm.axDdCode", paramMap));
			} else if ( "Bank".equals(ddKinds[i]) ) {
		    	hm.put(ddKinds[i], sqlSession.selectList("axComm.axDdBank", paramMap));
			} else if ( "CourseReport".equals(ddKinds[i]) ) {
		    	hm.put(ddKinds[i], sqlSession.selectList("axComm.axDdCourseReport", paramMap));
			} else if ( "B2CFaqCategory".equals(ddKinds[i]) ) {
				paramMap.put("DD_MAIN", "FAQ_B2C");
		    	hm.put(ddKinds[i], sqlSession.selectList("axComm.axDdCode", paramMap));
			} else if ( "B2BFaqCategory".equals(ddKinds[i]) ) {
				paramMap.put("DD_MAIN", "FAQ_B2B");
		    	hm.put(ddKinds[i], sqlSession.selectList("axComm.axDdCode", paramMap));
			} else if ( "C2CFaqCategory".equals(ddKinds[i]) ) {
				paramMap.put("DD_MAIN", "FAQ_C2C");
		    	hm.put(ddKinds[i], sqlSession.selectList("axComm.axDdCode", paramMap));
			} else if ( "AllFaqCategory".equals(ddKinds[i]) ) {
				hm.put(ddKinds[i], sqlSession.selectList("axComm.axDdAllFaqCategory", paramMap));
			} else if ( "ZipcodeUrl".equals(ddKinds[i]) ) {
				paramMap.put("OPTION_KEY", "ZIPCODE_URL");
		    	hm.put(ddKinds[i], sqlSession.selectList("axComm.axDdSetting", paramMap));
			} else if ( "OpenKind".equals(ddKinds[i]) ) {
				paramMap.put("DD_MAIN", "OPEN_KIND");
		    	hm.put(ddKinds[i], sqlSession.selectList("axComm.axDdCode", paramMap));
			} else if ( "Year".equals(ddKinds[i]) ) {
				paramMap.put("OPTION_KEY", "FROM_YEAR");
				HashMap<String, Object> from = sqlSession.selectOne("axComm.axDdSetting", paramMap);
				paramMap.put("OPTION_KEY", "TO_YEAR");
				HashMap<String, Object> to = sqlSession.selectOne("axComm.axDdSetting", paramMap);
				
				List<HashMap<String, Object>> list = new ArrayList<HashMap<String, Object>>();
						
				int fromYear = Integer.parseInt((String)from.get("text")); 
				int toYear = Integer.parseInt((String)to.get("text")); 
				for ( int m = fromYear; m <= toYear; m++ ) {
					HashMap<String, Object> row = new HashMap<String, Object>();
					row.put("value", m);
					row.put("text", m);
					list.add(row);
				}
				hm.put(ddKinds[i], list);
			} else if ( "Year2".equals(ddKinds[i]) ) {
				paramMap.put("OPTION_KEY", "FROM_YEAR");
				HashMap<String, Object> from = sqlSession.selectOne("axComm.axDdSetting", paramMap);
				
				List<HashMap<String, Object>> list = new ArrayList<HashMap<String, Object>>();
						
				int fromYear = Integer.parseInt((String)from.get("text")); 
				int toYear = Calendar.getInstance().get(Calendar.YEAR); 
				for ( int m = fromYear; m <= toYear; m++ ) {
					HashMap<String, Object> row = new HashMap<String, Object>();
					row.put("value", m);
					row.put("text", m);
					list.add(row);
				}
				hm.put(ddKinds[i], list);
			} else if ( "ContentsManager".equals(ddKinds[i]) ) {
		    	hm.put(ddKinds[i], sqlSession.selectList("axComm.axDdContentsManager", paramMap));
			} else if ( "CourseTutor".equals(ddKinds[i]) ) {
		    	hm.put(ddKinds[i], sqlSession.selectList("axComm.axDdCourseTutor", paramMap));
			} else if ( "InquiryCategory".equals(ddKinds[i]) ) {
				paramMap.put("DD_MAIN", "INQUIRY_KIND");
		    	hm.put(ddKinds[i], sqlSession.selectList("axComm.axDdCode", paramMap));
			} else if ( "MainpageKind".equals(ddKinds[i]) ) {
				paramMap.put("DD_MAIN", "MAINPAGE_KIND");
		    	hm.put(ddKinds[i], sqlSession.selectList("axComm.axDdCode", paramMap));
			} else if ( "QuestProgressRatio".equals(ddKinds[i]) ) {
				paramMap.put("OPTION_KEY", "QUEST_PROGRESS_RATIO");
		    	hm.put(ddKinds[i], sqlSession.selectList("axComm.axDdSetting", paramMap));
			} else if ( "AgainStudyDay".equals(ddKinds[i]) ) {
				paramMap.put("OPTION_KEY", "AGAIN_STUDY_DAY");
		    	hm.put(ddKinds[i], sqlSession.selectList("axComm.axDdSetting", paramMap));
			} else if ( "PointKind".equals(ddKinds[i]) ) {
		    	hm.put(ddKinds[i], sqlSession.selectList("axComm.axDdPointKind", paramMap));
			} else if ( "FrameKind".equals(ddKinds[i]) ) {
				paramMap.put("DD_MAIN", "FRAME_KIND");
		    	hm.put(ddKinds[i], sqlSession.selectList("axComm.axDdCode", paramMap));
			} else if ( "ChannelKind".equals(ddKinds[i]) ) {
		    	hm.put(ddKinds[i], sqlSession.selectList("axComm.axDdChannelKind", paramMap));
			}
		}
		
    	return hm;
    }
		
	public HashMap<String, Object> axMaxCourseCode(HashMap<String, Object> paramMap) throws Exception {
		HashMap<String, Object> hm = new HashMap<String, Object>();
		
		List<HashMap<String, Object>> list = sqlSession.selectList("axComm.axMaxCourseCode", paramMap);
    	hm.put("list", list);
		
    	return hm;
    }
	
    public String axCompCdFromSubDomain(String subDomain) throws Exception {
    	HashMap<String, Object> params = new HashMap<String, Object>();
    	params.put("SUB_DOMAIN", subDomain);
    	
    	HashMap<String, Object> row = sqlSession.selectOne("axComm.axCompCdFromSubDomain", params);
    	
        return ( row == null ? "B2C" : (String)row.get("COMP_CD") );
    }
    
    public String axCompTypeFromSubDomain(String subDomain) throws Exception {
    	HashMap<String, Object> params = new HashMap<String, Object>();
    	params.put("SUB_DOMAIN", subDomain);
    	
    	HashMap<String, Object> row = sqlSession.selectOne("axComm.axCompCdFromSubDomain", params);
    	
    	String compType = "";
    	if ( row == null ) {
    		compType = "B2C";
    	} else if ( CommUtil.isEqual((String)row.get("C2C_YN"), "Y") ) {
    		compType = "C2C";
    	} else {
    		compType = "B2B";
    	}
    	
        return compType;
    }
    
    public String axCompUseYnFromSubDomain(String subDomain) throws Exception {
    	HashMap<String, Object> params = new HashMap<String, Object>();
    	params.put("SUB_DOMAIN", subDomain);
    	
    	HashMap<String, Object> row = sqlSession.selectOne("axComm.axCompCdFromSubDomain", params);
    	
        return ( row == null ? "N" : (String)row.get("USE_YN") );
    }
    
    public HashMap<String, Object> axCompInfoFromSubDomain(String subDomain) throws Exception {
    	HashMap<String, Object> params = new HashMap<String, Object>();
    	params.put("SUB_DOMAIN", subDomain);
    	
    	HashMap<String, Object> compInfo = new HashMap<String, Object>();

    	HashMap<String, Object> row = sqlSession.selectOne("axComm.axCompCdFromSubDomain", params);
   		if ( row == null ) {
   			compInfo.put("COMP_CD", "B2C");
   			compInfo.put("COMP_TYPE", "B2C");
   			compInfo.put("USE_YN", "N");
   			compInfo.put("COMP_NAME", "");
   			
   			row = sqlSession.selectOne("axComm.axMainNaverClientInfo", params);
   			if ( row != null ) {
	   			compInfo.put("NAVER_CLIENT_ID", (String)row.get("NAVER_CLIENT_ID"));
	   			compInfo.put("NAVER_CLIENT_SECRET", (String)row.get("NAVER_CLIENT_SECRET"));
   			} else {
	   			compInfo.put("NAVER_CLIENT_ID", "");
	   			compInfo.put("NAVER_CLIENT_SECRET", "");
   			}
    	} else if ( CommUtil.isEqual((String)row.get("C2C_YN"), "Y") ) {
   			compInfo.put("COMP_CD", (String)row.get("COMP_CD"));
    		compInfo.put("COMP_TYPE", "C2C");
   			compInfo.put("USE_YN", (String)row.get("USE_YN"));
   			compInfo.put("COMP_NAME", (String)row.get("COMP_NAME"));
   			compInfo.put("NAVER_CLIENT_ID", (String)row.get("NAVER_CLIENT_ID"));
   			compInfo.put("NAVER_CLIENT_SECRET", (String)row.get("NAVER_CLIENT_SECRET"));
    	} else {
   			compInfo.put("COMP_CD", (String)row.get("COMP_CD"));
    		compInfo.put("COMP_TYPE", "B2B");
   			compInfo.put("USE_YN", (String)row.get("USE_YN"));
   			compInfo.put("COMP_NAME", (String)row.get("COMP_NAME"));
   			compInfo.put("NAVER_CLIENT_ID", "");
   			compInfo.put("NAVER_CLIENT_SECRET", "");
    	}
    	
        return compInfo;
    }
    
	public HashMap<String, Object> axUserSearchList(HashMap<String, Object> paramMap) throws Exception {
		HashMap<String, Object> hm = new HashMap<String, Object>();
		
    	List<HashMap<String, Object>> list = sqlSession.selectList("axComm.axUserSearchList", paramMap);
    	hm.put("list", list);
        
    	return hm;
    }
    
	public HashMap<String, Object> axCourseSearchList(HashMap<String, Object> paramMap) throws Exception {
		HashMap<String, Object> hm = new HashMap<String, Object>();
		
    	List<HashMap<String, Object>> list = sqlSession.selectList("axComm.axCourseSearchList", paramMap);
    	hm.put("list", list);
        
    	return hm;
    }
	
	public void axMailSave(String userId, String email, String title, String contents) throws Exception {
		HashMap<String, Object> hm = new HashMap<String, Object>();
		
		hm.put("USER_ID", userId);
		hm.put("EMAIL", email);
		hm.put("TITLE", title);
		hm.put("CONTENTS", contents);

		sqlSession.insert("axMailSend.axMailContentsInsert", hm);
	}
	
	public boolean axSendMail(HashMap<String, Object> paramMap) throws Exception {
		boolean isError = false;
		
		int mailCnt = 0;
		int smtpSeq = 0;
		
		//일자별 smtp를 가져온다.
    	HashMap<String, Object> smtpInfo = sqlSession.selectOne("axMailSend.axMailSmtp", paramMap);
    	//없으면 생성
    	if ( CommUtil.getIntValue(smtpInfo.get("CNT")) == 0 ) {
    		sqlSession.insert("axMailSend.axMailSmtpInsert", paramMap);
    	}
    	smtpInfo = sqlSession.selectOne("axMailSend.axMailSmtp", paramMap);
    	if ( CommUtil.isEqual((String)smtpInfo.get("MAIL_USER_ID"), "") ) {
    		isError = true;
    		return isError;
    	} else {
    		mailCnt = CommUtil.getIntValue(smtpInfo.get("MAIL_CNT"));
    		smtpSeq = CommUtil.getIntValue(smtpInfo.get("SMTP_SEQ"));
    	}
    	
    	PlainMail mail = new PlainMail((String)smtpInfo.get("MAIL_SERVER"), (String)smtpInfo.get("MAIL_USER_ID"), (String)smtpInfo.get("MAIL_PASSWORD"));
    	
    	List<HashMap<String, Object>> list = sqlSession.selectList("axMailSend.axMailList", paramMap);
    	for ( int i = 0; i < list.size(); i++ ) {
    		try {
		    	mail.setSubject((String)list.get(i).get("TITLE"));
		    	mail.setReceiver((String)list.get(i).get("EMAIL"));
    	    	mail.setContent((String)list.get(i).get("CONTENTS"));
	
	        	mail.SendMail();
	        	
	        	++mailCnt; 
	    	} catch ( Exception e ) {
	    		e.printStackTrace();
	    		
	    		smtpInfo.put("MAIL_CNT", mailCnt);
	    		sqlSession.update("axMailSend.axMailSmtpBlockUpdate", smtpInfo);

	    		//오류시 다른 smtp로 전송
	    		smtpInfo = sqlSession.selectOne("axMailSend.axMailSmtp", paramMap);
	    		if ( CommUtil.isEqual((String)smtpInfo.get("MAIL_USER_ID"), "") ) {
	        		isError = true;
	        		return isError;
	        	} else {
	        		mailCnt = CommUtil.getIntValue(smtpInfo.get("MAIL_CNT"));
	        		smtpSeq = CommUtil.getIntValue(smtpInfo.get("SMTP_SEQ"));
	        	}
	    		
	    		try {
		    		mail = new PlainMail((String)smtpInfo.get("MAIL_SERVER"), (String)smtpInfo.get("MAIL_USER_ID"), (String)smtpInfo.get("MAIL_PASSWORD"));
		    		
			    	mail.setSubject((String)list.get(i).get("TITLE"));
			    	mail.setReceiver((String)list.get(i).get("EMAIL"));
	    	    	mail.setContent((String)list.get(i).get("CONTENTS"));
		
		        	mail.SendMail();
		        	
		        	++mailCnt; 
		    	} catch ( Exception e2 ) {
		    		e2.printStackTrace();
		    		isError = true;

		    		smtpInfo.put("MAIL_CNT", mailCnt);
		    		sqlSession.update("axMailSend.axMailSmtpBlockUpdate", smtpInfo);
		    		
		    		//두번째에서 오류가 발생을 하면 발송 종료
		    		break;
		    	}
	    	}
        	
        	//발송저장
        	list.get(i).put("SMTP_SEQ", smtpSeq);
        	sqlSession.insert("axMailSend.axMailContentsUpdate", list.get(i));
    	}
    	
    	//일자별 smtp 수정(갯수)
		smtpInfo.put("MAIL_CNT", mailCnt);
    	sqlSession.update("axMailSend.axMailSmtpUpdate", smtpInfo);
        
    	return isError;
    }

}
