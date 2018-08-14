package com.qp.lms.ax.common.service;

import java.io.File;
import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.qp.lms.board.model.AttachVO;
import com.qp.lms.category.model.CategorySet;
import com.qp.lms.common.CodeVO;
import com.qp.lms.common.CommUtil;
import com.qp.lms.common.Constant;
import com.qp.lms.common.SessionUtil;
import com.qp.lms.common.model.CommSet;
import com.qp.lms.common.model.CommVO;
import com.qp.lms.common.model.LogVO;
import com.qp.lms.course.model.CourseVO;
import com.qp.lms.member.model.MemberVO;

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
			} else if ( "CompanyTutor".equals(ddKinds[i]) ) {
		    	hm.put(ddKinds[i], sqlSession.selectList("axComm.axDdCompanyTutor", paramMap));
			} else if ( "QuestGroup".equals(ddKinds[i]) ) {
		    	hm.put(ddKinds[i], sqlSession.selectList("axComm.axDdQuestGroup", paramMap));
			} else if ( "CourseCode".equals(ddKinds[i]) ) {
		    	hm.put(ddKinds[i], sqlSession.selectList("axComm.axDdCourseCode", paramMap));
			} else if ( "ExamCourseCode".equals(ddKinds[i]) ) {
		    	hm.put(ddKinds[i], sqlSession.selectList("axComm.axDdExamCourseCode", paramMap));
			} else if ( "Company".equals(ddKinds[i]) ) {
		    	hm.put(ddKinds[i], sqlSession.selectList("axComm.axDdCompany", paramMap));
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
			} else if ( "AdminAuth".equals(ddKinds[i]) ) {
				paramMap.put("DD_MAIN", "ADMIN_AUTH");
		    	hm.put(ddKinds[i], sqlSession.selectList("axComm.axDdCode", paramMap));
			} else if ( "ApprovalStatus".equals(ddKinds[i]) ) {
				paramMap.put("DD_MAIN", "APPROVAL_STATUS");
		    	hm.put(ddKinds[i], sqlSession.selectList("axComm.axDdCode", paramMap));
			} else if ( "PaymentKind".equals(ddKinds[i]) ) {
				paramMap.put("DD_MAIN", "PAYMENT_KIND");
		    	hm.put(ddKinds[i], sqlSession.selectList("axComm.axDdCode", paramMap));
			} else if ( "Bank".equals(ddKinds[i]) ) {
		    	hm.put(ddKinds[i], sqlSession.selectList("axComm.axDdBank", paramMap));
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
	
}
