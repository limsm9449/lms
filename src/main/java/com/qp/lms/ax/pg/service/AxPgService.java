package com.qp.lms.ax.pg.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;

import com.qp.lms.common.CommUtil;
import com.qp.lms.common.Constant;
import com.qp.lms.common.SessionUtil;
import com.qp.lms.course.model.CourseVO;

@Service
public class AxPgService {
	
	@Autowired
	private SqlSession sqlSession;
	
	public Model axApplication(HashMap<String, Object> paramMap, Model model) throws Exception {
		HashMap<String, Object> hm = new HashMap<String, Object>();
		
		paramMap.put("USER_ID", SessionUtil.getSessionUserId());

		model.addAttribute("courseId", paramMap.get("COURSE_ID"));

		List<HashMap<String, Object>> applicationUserList = null;
		
		String kind = (String)paramMap.get("KIND");
		if ( "TYPE1".equals(kind) ) {
			// site manager가 선택해서 수강 신청하는 경우
			applicationUserList = sqlSession.selectList("axPg.axCourseApplicationUserList", paramMap);
		} else if ( "TYPE2".equals(kind) ) {
			// 직원이 직접 신청하여 비용만 결재하는 경우
			applicationUserList = sqlSession.selectList("axPg.axCourseNotApprovalUserList", paramMap);
		}
		model.addAttribute("applicationUserList", applicationUserList);
		model.addAttribute("applicationCnt", applicationUserList.size());
		
    	//결재금액
    	int paymentCost = 0;
    	String userIds = "";
    	String userNames = "";
    	
    	for ( int i = 0; i < applicationUserList.size(); i++ ) {
    		paymentCost += ((Integer)applicationUserList.get(i).get("COURSE_COST")).intValue();
    		
    		if ( i == 0 ) {
    			userIds += (String)applicationUserList.get(i).get("USER_ID");
    			userNames += (String)applicationUserList.get(i).get("USER_NAME");
    		} else {
    			userIds += "," + (String)applicationUserList.get(i).get("USER_ID");
    			userNames += "," + (String)applicationUserList.get(i).get("USER_NAME");
    		}
    	}
    	model.addAttribute("paymentCost", Integer.toString(paymentCost));
    	model.addAttribute("userIds" , userIds);
    	model.addAttribute("userNames" , userNames);

    	model.addAttribute("user" , sqlSession.selectOne("axAccount.axAccountOne", paramMap));

    	model.addAttribute("point" , sqlSession.selectOne("axPg.axUserPoint", paramMap));
    	
		model.addAttribute("bankList", sqlSession.selectList("axComm.axDdBank", paramMap));
		
    	return model;
    }
	
	@Transactional(propagation=Propagation.REQUIRED, rollbackFor={Throwable.class})
    public HashMap<String, Object> axApproval(HashMap<String, Object> paramMap) throws Exception {
		HashMap<String, Object> hm = new HashMap<String, Object>();
		
		paramMap.put("SESSION_USER_ID", SessionUtil.getSessionUserId());

		sqlSession.insert("axPg.axCourseApprovalInsert", paramMap);

		String kind = (String)paramMap.get("KIND");
		if ( "TYPE1".equals(kind) ) {
			// site manager가 선택해서 수강 신청하는 경우
			
			//튜터를 구한다.
			int courseUserCnt = sqlSession.selectOne("axPg.axCourseUserCnt", paramMap);
			List<HashMap<String, Object>> tutorList = sqlSession.selectList("axPg.axCourseTutors", paramMap);
			
			//레포트를 구한다.
			String courseReportYn = sqlSession.selectOne("axPg.axCourseReportExist", paramMap);
			
			String[] userIds = ((String)paramMap.get("selIds")).split(",");
			for ( int i = 0; i < userIds.length; i++ ) {
				paramMap.put("userId", userIds[i]);

				for ( int m = 0; m < tutorList.size(); m++ ) {
					if ( CommUtil.getIntValue(tutorList.get(m).get("FROM_CNT")) <= courseUserCnt + m && CommUtil.getIntValue(tutorList.get(m).get("TO_CNT")) >= courseUserCnt + m ) {
						paramMap.put("tutorId", tutorList.get(m).get("TUTOR_ID"));
						break;
					}
				}

				if ( "Y".equals(courseReportYn) ) {
					paramMap.put("reportSeq", sqlSession.selectOne("axPg.axCourseRandomReport", paramMap));
				}

				//반려된 케이스가 있으면 삭제를 해준다.
				sqlSession.delete("axPg.axRejectCourseEvalDel", paramMap);
				sqlSession.delete("axPg.axRejectCourseWeekDel", paramMap);

		    	sqlSession.update("axPg.axCourseRegisterUserUpdate",paramMap);

		    	sqlSession.insert("axPg.axCourseEvalInsert",paramMap);
		    	
		    	sqlSession.insert("axPg.axCourseWeekInsert",paramMap);
			}
		} else if ( "TYPE2".equals(kind) ) {
			// 직원이 직접 신청하여 비용만 결재하는 경우
			String[] userIds = ((String)paramMap.get("selIds")).split(",");
			for ( int i = 0; i < userIds.length; i++ ) {
				paramMap.put("userId", userIds[i]);
				
		    	sqlSession.update("axPg.axCourseNotApprovalUserUpdate",paramMap);
			}
		/*
		} else {
			HashMap cart = (HashMap)SessionUtil.getAttribute("cart");
			if ( cart == null ) {
	    		//바로 신청할 경우....
	    		cart = (HashMap)SessionUtil.getAttribute("tempCart");
	    	}
			
			String[] courseIds = ((String)paramMap.get("courseId")).split(",");
			for ( int i = 0; i < courseIds.length; i++ ) {
				paramMap.put("courseId", courseIds[i]);

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

				if ( CommUtil.isEqual((String)cart.get(courseIds[i]), "") ) {
			    	sqlSession.update("axPg.axCourseRegisterInsert",paramMap);
			    	sqlSession.insert("axPg.axCourseEvalInsert",paramMap);
			    	sqlSession.insert("axPg.axCourseWeekInsert",paramMap);
				} else {
					sqlSession.insert("axPg.axCourseEvalInsert",paramMap);
			    	
	    			String[] weeks = ((String)cart.get(courseIds[i])).split(",");
	    			for ( int k = 0; k < weeks.length; k++ ) {
	    				paramMap.put("week", weeks[i]);
		    			sqlSession.insert("axPg.axCourseWeekPartIns",paramMap);
	    			}
	    			
			    	sqlSession.insert("axPg.axCourseRegisterPartIns",paramMap);
				}
			}
		*/
		}

		hm.put("RtnMode", Constant.mode.OK.name());
		
    	return hm;
    }
	
}
