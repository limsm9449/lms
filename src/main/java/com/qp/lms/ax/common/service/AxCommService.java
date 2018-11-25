package com.qp.lms.ax.common.service;

import java.util.ArrayList;
import java.util.Calendar;
import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

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
			} else if ( "FaqCategory".equals(ddKinds[i]) ) {
				paramMap.put("DD_MAIN", "FAQ");
		    	hm.put(ddKinds[i], sqlSession.selectList("axComm.axDdCode", paramMap));
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
    	
    	String compCd = sqlSession.selectOne("axComm.axCompCdFromSubDomain", params);
    	
        return ( compCd == null ? "B2C" : compCd );
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

}
