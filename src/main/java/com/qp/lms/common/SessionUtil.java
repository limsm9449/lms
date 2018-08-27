package com.qp.lms.common;

import java.io.File;
import java.io.FileInputStream;
import java.util.Hashtable;
import java.util.List;
import java.util.Properties;

import org.springframework.web.context.request.RequestAttributes;
import org.springframework.web.context.request.RequestContextHolder;

import com.qp.lms.course.model.CourseVO;

public class SessionUtil {
	/**
	  * attribute 값을 가져 오기 위한 method
	  * 
	  * @return Object attribute obj
	 */
	public static Object getAttribute(String attr) throws Exception {
		return (Object)RequestContextHolder.getRequestAttributes().getAttribute(attr, RequestAttributes.SCOPE_SESSION);
	}

	/**
	  * attribute 설정 method
	  * 
	  * @param Object  attribute obj
	  * @return void
	 */
	public static void setAttribute(String attr, Object object) throws Exception {
		RequestContextHolder.getRequestAttributes().setAttribute(attr, object, RequestAttributes.SCOPE_SESSION);
	}

	/**
	  * 설정한 attribute 삭제 
	  * 
	  * @return void
	 */
	public static void removeAttribute(String attr) throws Exception {
		RequestContextHolder.getRequestAttributes().removeAttribute(attr, RequestAttributes.SCOPE_SESSION);
	}
	 
	/**
	  * session id 
	  * 
	  * @return String SessionId 값
	 */
	public static String getSessionId() throws Exception  {
		return RequestContextHolder.getRequestAttributes().getSessionId();
	}

	/**
	  * Properties에서 값을 가져온다.
	  * 
	  * @return String 특정 Properties 값.
	 */
	public static String getProperties(String name) throws Exception  {
		Hashtable ht = (Hashtable)RequestContextHolder.getRequestAttributes().getAttribute("properties", RequestAttributes.SCOPE_SESSION);
		
		String str =  str = (String)ht.get(name);
		
		return ( str == null ? "" : str); 
	}

	public static Object getSession() throws Exception {
		return (Object)RequestContextHolder.getRequestAttributes().getAttribute("session", RequestAttributes.SCOPE_SESSION);
	}

	/*
	 * Session을 제거한다.
	 */
	public static void getSessionDestory() throws Exception {
		RequestContextHolder.getRequestAttributes().setAttribute("session", null, RequestAttributes.SCOPE_SESSION);
	}

	/**
	  * session User id 
	  * 
	  * @return String User id  값
	 */
	public static String getSessionUserId() throws Exception  {
		 SessionVO sess = (SessionVO)RequestContextHolder.getRequestAttributes().getAttribute("session", RequestAttributes.SCOPE_SESSION);
		 
		 if ( sess == null)
			 return "";
		 else
			 return sess.getUserId();
	}

	/**
	  * session User Ip 
	  * 
	  * @return String User Ip  값
	 */
	public static String getSessionUserIp() throws Exception  {
		 SessionVO sess = (SessionVO)RequestContextHolder.getRequestAttributes().getAttribute("session", RequestAttributes.SCOPE_SESSION);
		return sess.getUserIp();
	}

	/**
	 * 다운로드 권한을 가져온다.
	 * @return
	 * @throws Exception
	 */
	public static String getDownloadAuth() throws Exception  {
		 SessionVO sess = (SessionVO)RequestContextHolder.getRequestAttributes().getAttribute("session", RequestAttributes.SCOPE_SESSION);
		return sess.getDownloadAuth();
	}

	/**
	 * 어드민 여부
	 * @return
	 * @throws Exception
	 */
	public static boolean isAdmin() throws Exception  {
		 SessionVO sess = (SessionVO)RequestContextHolder.getRequestAttributes().getAttribute("session", RequestAttributes.SCOPE_SESSION);
		 
		 if ( "Y".equals(sess.getAdminYn()) )
			 return true;
		 else
			 return false;
	}

	/**
	 * 어드민 여부
	 * @return
	 * @throws Exception
	 */
	public static String isAdminYn() throws Exception  {
		 SessionVO sess = (SessionVO)RequestContextHolder.getRequestAttributes().getAttribute("session", RequestAttributes.SCOPE_SESSION);
		 
		 return sess.getAdminYn();
	}

	public static boolean isSiteManager() throws Exception  {
		 SessionVO sess = (SessionVO)RequestContextHolder.getRequestAttributes().getAttribute("session", RequestAttributes.SCOPE_SESSION);
		 
		 if ( "Y".equals(sess.getSiteManagerYn()) )
			 return true;
		 else
			 return false;
	}

	public static boolean isContentsManager() throws Exception  {
		 SessionVO sess = (SessionVO)RequestContextHolder.getRequestAttributes().getAttribute("session", RequestAttributes.SCOPE_SESSION);
		 
		 if ( "Y".equals(sess.getContentsManagerYn()) )
			 return true;
		 else
			 return false;
	}

	/**
	 * 강사 여부
	 * @return
	 * @throws Exception
	 */
	public static boolean isTeacher() throws Exception  {
		 SessionVO sess = (SessionVO)RequestContextHolder.getRequestAttributes().getAttribute("session", RequestAttributes.SCOPE_SESSION);
		 
		 if ( "Y".equals(sess.getTeacherYn()) )
			 return true;
		 else
			 return false;
	}
	
	/**
	 * 튜터 여부
	 * @return
	 * @throws Exception
	 */
	public static boolean isTutor() throws Exception  {
		 SessionVO sess = (SessionVO)RequestContextHolder.getRequestAttributes().getAttribute("session", RequestAttributes.SCOPE_SESSION);
		 
		 if ( "Y".equals(sess.getTutorYn()) )
			 return true;
		 else
			 return false;
	}

	
	/**
	 * 인기과정
	 * @return
	 * @throws Exception
	 */
	public static List<CourseVO> getFavorityCourseList() throws Exception  {
		return (List<CourseVO>)RequestContextHolder.getRequestAttributes().getAttribute("favorityCourseList", RequestAttributes.SCOPE_SESSION);
	}

}
