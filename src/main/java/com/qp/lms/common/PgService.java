package com.qp.lms.common;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import com.qp.lms.main.model.MainVO;


public class PgService {
	 


    /**
     * 결재
     * @param vo
     * @throws Exception
     */
	public void approval(HttpServletRequest request) throws Exception {
		Connection conn = null;
		PreparedStatement stmt = null;

		System.out.println("=====================> PgService Start");
		
		try {
    		String courseId = CommUtil.getString(request.getParameter("courseId"));
    		String approvalId = CommUtil.getString(request.getParameter("approvalId"));
    		String paymentKind = CommUtil.getString(request.getParameter("paymentKind"));
    		String paymentBank = CommUtil.getString(request.getParameter("paymentBank"));
    		String paymentPoint = CommUtil.getString(request.getParameter("paymentPoint"));
    		String paymentCost = CommUtil.getString(request.getParameter("paymentCost"));
    		String totalCost = CommUtil.getString(request.getParameter("totalCost"));
    		String userId = SessionUtil.getSessionUserId();
    		    
    		System.out.println("courseId : " + courseId 
    				+ ", approvalId : " + approvalId
    				+ ", paymentKind : " + paymentKind
    				+ ", paymentBank : " + paymentBank
    				+ ", paymentPoint : " + paymentPoint
    				+ ", paymentCost : " + paymentCost
    				+ ", totalCost : " + totalCost
    			);
    		
    		try {
   		        Class.forName("com.mysql.jdbc.Driver");     
    		} catch ( ClassNotFoundException e ) {
    			System.out.println("Where is your mysql jdbc driver?");
    			e.printStackTrace();
    			return;
    		}
    		   
    		conn = DriverManager.getConnection(SessionUtil.getProperties("pg_url"), SessionUtil.getProperties("pg_userId"), SessionUtil.getProperties("pg_password"));
    		conn.setAutoCommit(false);
    		System.out.println("Connect");

    		
    		//결재 내용 입력.
    		stmt = conn.prepareStatement(approvalIns);
    		int idx = 1;
    		stmt.setString(idx++, approvalId);
    		stmt.setString(idx++, userId);
    		stmt.setString(idx++, paymentKind);
    		stmt.setString(idx++, totalCost);
    		stmt.setString(idx++, paymentPoint);
    		stmt.setString(idx++, paymentCost);
    		stmt.setString(idx++, paymentKind);
    		stmt.setString(idx++, paymentBank);
    		stmt.setString(idx++, userId);
    		stmt.executeUpdate();

    		HashMap cart = (HashMap)SessionUtil.getAttribute("cart");
    		if ( cart == null ) {
        		//바로 신청할 경우....
        		cart = (HashMap)SessionUtil.getAttribute("tempCart");
        	}
    		
    		String[] courseIds = courseId.split(",");
    		for ( int i = 0; i < courseIds.length; i++ ) {
    			//반려된 케이스가 있으면 삭제를 해준다.
    			stmt = conn.prepareStatement(rejectCourseRegisterDel);
    			idx = 1;
    			stmt.setString(idx++, courseIds[i]);
    			stmt.setString(idx++, userId);
    			stmt.executeUpdate();

    			stmt = conn.prepareStatement(rejectCourseEvalDel);
    			idx = 1;
    			stmt.setString(idx++, courseIds[i]);
    			stmt.setString(idx++, userId);
    			stmt.executeUpdate();

    			stmt = conn.prepareStatement(rejectCourseWeekDel);
    			idx = 1;
    			stmt.setString(idx++, courseIds[i]);
    			stmt.setString(idx++, userId);
    			stmt.executeUpdate();

    			if ( CommUtil.isEqual((String)cart.get(courseIds[i]), "") ) {
    				stmt = conn.prepareStatement(courseRegisterIns);
        			idx = 1;
        			stmt.setString(idx++, userId);
        			stmt.setString(idx++, paymentKind);
        			stmt.setString(idx++, approvalId);
        			stmt.setString(idx++, paymentKind);
        			stmt.setString(idx++, userId);
        			stmt.setString(idx++, courseIds[i]);
        			stmt.executeUpdate();

    		    	//평가 데이타 생성
    				stmt = conn.prepareStatement(courseEvalIns);
        			idx = 1;
        			stmt.setString(idx++, courseIds[i]);
        			stmt.setString(idx++, userId);
        			stmt.setString(idx++, userId);
        			stmt.executeUpdate();
   		    	
    		    	//주차별 진도 데이타 생성
    				stmt = conn.prepareStatement(courseWeekIns);
        			idx = 1;
        			stmt.setString(idx++, courseIds[i]);
        			stmt.setString(idx++, userId);
        			stmt.setString(idx++, courseIds[i]);
        			stmt.executeUpdate();
    			} else {
    				//주별 평가 데이타 생성
    		    	//평가 데이타 생성
    				stmt = conn.prepareStatement(courseEvalIns);
        			idx = 1;
        			stmt.setString(idx++, courseIds[i]);
        			stmt.setString(idx++, userId);
        			stmt.setString(idx++, userId);
        			stmt.executeUpdate();
    		    	
    		    	//주차별 진도 데이타 생성
        			String[] weeks = ((String)cart.get(courseIds[i])).split(",");
        			for ( int k = 0; k < weeks.length; k++ ) {
            			stmt = conn.prepareStatement(courseWeekPartIns);
            			idx = 1;
            			stmt.setString(idx++, courseIds[i]);
            			stmt.setString(idx++, userId);
            			stmt.setString(idx++, courseIds[i]);
            			stmt.setString(idx++, weeks[k]);
            			stmt.executeUpdate();
        			}
        			
        			//과정 신청 및 금액 데이타 생성
        			stmt = conn.prepareStatement(courseRegisterPartIns);
        			idx = 1;
        			stmt.setString(idx++, userId);
        			stmt.setString(idx++, paymentKind);
        			stmt.setString(idx++, approvalId);
        			stmt.setString(idx++, paymentKind);
        			stmt.setString(idx++, userId);
        			stmt.setString(idx++, courseIds[i]);
        			stmt.setString(idx++, courseIds[i]);
        			stmt.setString(idx++, userId);
        			stmt.setString(idx++, courseIds[i]);
        			stmt.executeUpdate();
    			}
    		}
    		
    		conn.commit();

    		System.out.println("=====================> PgService End");
    	} catch ( Exception e ) {
    		conn.rollback();
    		e.printStackTrace();
    		
    		throw e;
    	} finally {
    		try {
    			if ( stmt != null )
    				stmt.close();
    			if ( conn != null )
    				conn.close();
    		} catch ( SQLException e ) {
    			e.printStackTrace();
    		}
    	}
    }
	
	/**
     * 회사 결재
     * @param vo
     * @throws Exception
     */
	public void compApproval(HttpServletRequest request) throws Exception {
		Connection conn = null;
		PreparedStatement stmt = null;

		System.out.println("=====================> Company PgService Start");
		
		try {
    		String courseId = CommUtil.getString(request.getParameter("courseId"));
    		String approvalId = CommUtil.getString(request.getParameter("approvalId"));
    		String paymentKind = CommUtil.getString(request.getParameter("paymentKind"));
    		String paymentBank = CommUtil.getString(request.getParameter("paymentBank"));
    		String paymentPoint = CommUtil.getString(request.getParameter("paymentPoint"));
    		String paymentCost = CommUtil.getString(request.getParameter("paymentCost"));
    		String totalCost = CommUtil.getString(request.getParameter("totalCost"));
    		String userId = SessionUtil.getSessionUserId();
    		String selIds = CommUtil.getString(request.getParameter("selIds"));
    		
    		System.out.println("courseId : " + courseId 
    				+ ", approvalId : " + approvalId
    				+ ", paymentKind : " + paymentKind
    				+ ", paymentBank : " + paymentBank
    				+ ", paymentPoint : " + paymentPoint
    				+ ", paymentCost : " + paymentCost
    				+ ", totalCost : " + totalCost
    				+ ", selIds : " + selIds
    			);
    		
    		try {
   		        Class.forName("com.mysql.jdbc.Driver");     
    		} catch ( ClassNotFoundException e ) {
    			System.out.println("Where is your mysql jdbc driver?");
    			e.printStackTrace();
    			return;
    		}
    		   
    		conn = DriverManager.getConnection(SessionUtil.getProperties("pg_url"), SessionUtil.getProperties("pg_userId"), SessionUtil.getProperties("pg_password"));
    		conn.setAutoCommit(false);
    		System.out.println("Connect");

    		
    		//결재 내용 입력.
    		stmt = conn.prepareStatement(approvalIns);
    		int idx = 1;
    		stmt.setString(idx++, approvalId);
    		stmt.setString(idx++, userId);
    		stmt.setString(idx++, paymentKind);
    		stmt.setString(idx++, totalCost);
    		stmt.setString(idx++, paymentPoint);
    		stmt.setString(idx++, paymentCost);
    		stmt.setString(idx++, paymentKind);
    		stmt.setString(idx++, paymentBank);
    		stmt.setString(idx++, userId);
    		stmt.executeUpdate();

    		String[] userIds = selIds.split(",");
    		for ( int i = 0; i < userIds.length; i++ ) {
    			//반려된 케이스가 있으면 삭제를 해준다.
    			stmt = conn.prepareStatement(rejectCourseEvalDel);
    			idx = 1;
    			stmt.setString(idx++, courseId);
    			stmt.setString(idx++, userIds[i]);
    			stmt.executeUpdate();

    			stmt = conn.prepareStatement(rejectCourseWeekDel);
    			idx = 1;
    			stmt.setString(idx++, courseId);
    			stmt.setString(idx++, userIds[i]);
    			stmt.executeUpdate();

				stmt = conn.prepareStatement(courseRegisterUpd);
    			idx = 1;
    			stmt.setString(idx++, paymentKind);
    			stmt.setString(idx++, approvalId);
    			stmt.setString(idx++, paymentKind);
    			stmt.setString(idx++, userIds[i]);
    			stmt.setString(idx++, courseId);
    			stmt.setString(idx++, userId);
    			stmt.executeUpdate();

		    	//평가 데이타 생성
				stmt = conn.prepareStatement(courseEvalIns);
    			idx = 1;
    			stmt.setString(idx++, courseId);
    			stmt.setString(idx++, userIds[i]);
    			stmt.setString(idx++, userId);
    			stmt.executeUpdate();
	    	
		    	//주차별 진도 데이타 생성
				stmt = conn.prepareStatement(courseWeekIns);
    			idx = 1;
    			stmt.setString(idx++, courseId);
    			stmt.setString(idx++, userIds[i]);
    			stmt.setString(idx++, courseId);
    			stmt.executeUpdate();
    		}
    		
    		conn.commit();

    		System.out.println("=====================> PgService End");
    	} catch ( Exception e ) {
    		conn.rollback();
    		e.printStackTrace();
    		
    		throw e;
    	} finally {
    		try {
    			if ( stmt != null )
    				stmt.close();
    			if ( conn != null )
    				conn.close();
    		} catch ( SQLException e ) {
    			e.printStackTrace();
    		}
    	}
    }
	
	public String approvalIns = "INSERT INTO APPROVAL(APPROVAL_ID,USER_ID,STATUS,TOTAL_COST,PAYMENT_POINT,PAYMENT_COST,PAYMENT_KIND,PAYMENT_BANK,PAYMENT_DATE,CREATE_DATE,CREATE_USER)" +
										"VALUES (?, ?, if(? = 'CASH','B','A'), ?, ?, ?, ?, ?, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, ?)";
	
	public String rejectCourseRegisterDel = "DELETE FROM COURSE_REGISTER WHERE COURSE_ID = ? AND USER_ID = ?";

	public String rejectCourseEvalDel = "DELETE FROM COURSE_EVAL WHERE COURSE_ID = ? AND USER_ID = ?";
			
	public String rejectCourseWeekDel = "DELETE FROM COURSE_WEEK WHERE COURSE_ID = ? AND USER_ID = ?";
			
	public String courseRegisterIns =  "INSERT INTO COURSE_REGISTER(COURSE_ID,USER_ID,STATUS,COURSE_COST,COMPANY_COST,TEACHER_COST,TUTOR_COST,APPROVAL_ID,CONFIRM_DATE,CREATE_DATE,CREATE_USER) " +
										"SELECT A.COURSE_ID,  " +
										"       ?, " +
										"       if(? = 'CASH','B','A'), " +
										"       A.COURSE_COST, " +
										"       A.COURSE_COST * ( B.COMPANY_RATE / 100), " +
										"       A.COURSE_COST * ( B.TEACHER_RATE / 100), " +
										"       A.COURSE_COST * ( B.TUTOR_RATE / 100), " +
										"       ?, " +
										"       if(? = 'CASH',NULL,CURRENT_TIMESTAMP), " +
										"       CURRENT_TIMESTAMP, " +
										"       ? " +
										"  FROM COURSE A LEFT OUTER JOIN COURSE_CODE B ON A.COURSE_CODE = B.COURSE_CODE " +
										" WHERE COURSE_ID = ?	";

	public String courseRegisterUpd =  "UPDATE COURSE_REGISTER " +
										"   SET STATUS = if(? = 'CASH','B','A'),  " +
										"       APPROVAL_ID = ?, " +
										"       CONFIRM_DATE = if(? = 'CASH',NULL,CURRENT_TIMESTAMP), " +
										"       UPDATE_DATE = CURRENT_TIMESTAMP, " +
										"       UPDATE_USER = ? " +
										" WHERE COURSE_ID = ?	" +
										"   AND USER_ID = ?	";

	public String courseEvalIns = "INSERT INTO COURSE_EVAL(COURSE_ID,USER_ID,REPORT,EXAM,DISCUSSION,PROGRESS,TOTAL,LAST_WEEK,LAST_PAGE,CREATE_DATE,CREATE_USER) " +
					"VALUES (?,?,0,0,0,0,0,1,1,CURRENT_TIMESTAMP,?)";
			
	public String courseWeekIns = "INSERT INTO COURSE_WEEK(COURSE_ID,USER_ID,WEEK,PROGRESS_RATE,STUDY_START,STUDY_END) " +
					"SELECT ?,?,WEEK,0,NULL,NULL " +
					"  FROM COURSE_RESOURCE " +
					" WHERE COURSE_CODE = ( SELECT COURSE_CODE FROM COURSE WHERE COURSE_ID = ? ) ";

	public String courseRegisterPartIns = 
				"INSERT INTO COURSE_REGISTER(COURSE_ID,USER_ID,STATUS,COURSE_COST,COMPANY_COST,TEACHER_COST,TUTOR_COST,APPROVAL_ID,CONFIRM_DATE,CREATE_DATE,CREATE_USER) " +
				"SELECT A.COURSE_ID,  " +
				"       ?, " +
				"       if(? = 'CASH','B','A'), " +
				"       IFNULL(C.COURSE_COST,0), " +
				"       IFNULL(C.COURSE_COST * ( B.COMPANY_RATE / 100),0), " +
				"       IFNULL(C.COURSE_COST * ( B.TEACHER_RATE / 100),0), " +
				"       IFNULL(C.COURSE_COST * ( B.TUTOR_RATE / 100),0), " +
				"       ?, " +
				"       if(? = 'CASH',NULL,CURRENT_TIMESTAMP), " +
				"       CURRENT_TIMESTAMP, " +
				"       ? " +
				"  FROM COURSE A LEFT OUTER JOIN COURSE_CODE B ON A.COURSE_CODE = B.COURSE_CODE " +
				"                LEFT OUTER JOIN (SELECT COURSE_ID, SUM(WEEK_COST) COURSE_COST " +
				"                                   FROM COURSE_WEEK_COST " +
				"                                  WHERE COURSE_ID = ? " +
				"                                    AND WEEK IN (SELECT WEEK FROM COURSE_WEEK WHERE COURSE_ID = ? AND USER_ID = ?) " +
				"                                  GROUP BY COURSE_ID) C ON A.COURSE_ID = C.COURSE_ID	   " +
				" WHERE A.COURSE_ID = ?";
	
	public String courseWeekPartIns = 
				"INSERT INTO COURSE_WEEK(COURSE_ID,USER_ID,WEEK,PROGRESS_RATE,STUDY_START,STUDY_END) " +
				"SELECT ?,?,WEEK,0,NULL,NULL " +
				"  FROM COURSE_RESOURCE " +
				" WHERE COURSE_CODE = ( SELECT COURSE_CODE FROM COURSE WHERE COURSE_ID = ? ) " + 
				"   AND WEEK = ? "; 
}


