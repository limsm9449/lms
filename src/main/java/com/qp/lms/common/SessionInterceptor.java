// FINAL 
package com.qp.lms.common;

import java.io.FileInputStream;
import java.net.URLEncoder;
import java.util.Enumeration;
import java.util.Iterator;
import java.util.Map;
import java.util.Properties;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import com.qp.lms.common.service.CommService;

public class SessionInterceptor extends HandlerInterceptorAdapter {
	private static final Logger logger = LoggerFactory.getLogger(SessionInterceptor.class);


    @Autowired
    private CommService commSvr;
    
	/*
	 * .do 호출시 선처리 작업
	 */
    public boolean preHandle(HttpServletRequest request,HttpServletResponse response, Object handler) throws Exception {
    	try {
	    	request.setAttribute("startTime", System.currentTimeMillis());
	
	    	// 기본적으로 제외 되어야 할 URL
	    	String[] urls = {
				"/login.do",
	    		"/loginCheck.do",
	    		"/backdorLoginCheck.do",
				"/manageLogin.do",
				"/companyLogin.do",
				"/cms"
	    	};
	    	
	    	// Session이 있을 수도 있고 없을 수도 있는 URL
	    	String[] exceptUrls = {
					"/user/noticeList.do", "/user/noticeV.do", "/user/nextNotice.do", "/user/prevNotice.do",
		    		"/user/faqList.do", "/user/faqV.do",
		    		"/user/courseList.do",
		    		"/common/ddCategory2Depth.do","/common/ddCategory3Depth.do",
		    		"/goIndex.do"
		    	};
	    	
	    	String url = request.getRequestURI();
	    	System.out.println(" =============> " + url);

	    	if ( url.indexOf("/resources/") > -1 ) {
	    		return true;
	    	} else {
		    	// request 로그 
		    	String reqParam = "";
		    	Enumeration e = request.getParameterNames();
		        while ( e.hasMoreElements() ) {
		        	String   name   = (String)e.nextElement();
	            	reqParam += ("".equals(reqParam) ? "" : "&" ) + name + "=";
	
	            	String[] values = request.getParameterValues(name);
		            for ( int i = 0; i < values.length; i++) {
		            	reqParam += ( i == 0 ? "" : ",") + values[i];
		            }
		        }
		        if ( (SessionVO)SessionUtil.getSession() == null) {
		        	commSvr.requestLog("Guest", url, reqParam, request.getRemoteAddr());
		        } else {
		        	commSvr.requestLog(SessionUtil.getSessionUserId(), url, reqParam, request.getRemoteAddr());
		        	
		        }
		        
		    	//인기과정
	   	 		if ( SessionUtil.getFavorityCourseList() == null ) {
	   	 			SessionUtil.setAttribute("favorityCourseList", commSvr.getFavorityCourseList());
	   	 		}
	   	 		
	   	 		// 시스템에서 사용할 설정값을 가져와 Session에 넣어둔다.
	   	 		if ( SessionUtil.getAttribute("properties") == null ) {
			    	FileInputStream fis = new FileInputStream(request.getRealPath("//WEB-INF//lms.properties"));
			    	Properties prop = new Properties();
			    	prop.load(fis);
			    	SessionUtil.setAttribute("properties",prop.clone());
	   	 		}
	
		    	if ( url.equals("/") || CommUtil.isMatchUrl(urls, url) || CommUtil.isMatchUrl(exceptUrls, url) || url.indexOf("/guest/") > -1 || url.indexOf("/ns/") > -1  || url.indexOf("/main/") > -1  ) {
		    		return true;
		    	} else {
		    		SessionVO sess = (SessionVO)SessionUtil.getSession();
			        if ( sess == null ) {
			        	
			        	/*
			        	//개발시 임시로 만들어줌
			        	sess =  new SessionVO();
			        	sess.setAdminYn("Y");
			        	sess.setUserId("admin");
			        	sess.setUserName("관리자");
			        	SessionUtil.setAttribute("session",sess);
			        	*/
			        	System.out.println("No Session ================================== url => " + "/goIndex.jsp?preUrl=" + URLEncoder.encode(url + "?" + CommUtil.getParameters(request),"UTF-8") + "&loginAuth=" + SessionUtil.getAttribute("loginAuth"));
			        	response.sendRedirect("/goIndex.do?preUrl=" + URLEncoder.encode(url + "?" + CommUtil.getParameters(request),"UTF-8") + "&loginAuth=" + SessionUtil.getAttribute("loginAuth"));
			        	return false;
			        }
		    	}
	    	}
    	} catch ( Exception e ) {
    		e.printStackTrace();
    	}
        return true;
    }

	/*
	 * .do 호출시 후처리 작업
	 */
    public void postHandle(HttpServletRequest request,HttpServletResponse response, Object handler,ModelAndView modelAndView) throws Exception {

    	//long startTime = (Long) request.getAttribute("startTime");
        //long endTime = System.currentTimeMillis();

        request.removeAttribute("startTime");

    	logger.debug(" =============> End");
    	
        //modelAndView.addObject("handlingTime", endTime - startTime);
    }
}
