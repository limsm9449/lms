// FINAL 
package com.qp.lms.common;

import java.io.FileInputStream;
import java.net.URLEncoder;
import java.util.Arrays;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.Map;
import java.util.Map.Entry;
import java.util.Properties;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import com.qp.lms.ax.common.service.AxCommService;
import com.qp.lms.common.service.CommService;

public class SessionInterceptor extends HandlerInterceptorAdapter {
	private static final Logger logger = LoggerFactory.getLogger(SessionInterceptor.class);

    @Autowired
    private CommService commSvr;

    @Autowired
    private AxCommService axCommService;

	/*
	 * .do 호출시 선처리 작업
	 */
    public boolean preHandle(HttpServletRequest request,HttpServletResponse response, Object handler) throws Exception {
    	try {
	    	request.setAttribute("startTime", System.currentTimeMillis());
	
	    	// 기본적으로 제외 되어야 할 URL
	    	String[] urls = {
	    		"/login.do",
    			"/dupLoginCheck.do",
    			"/loginConfirm.do",
				"/loginCheck.do",
				"/sessionContinue.do",
	    		"/backdorLoginCheck.do",
				"/manageLogin.do",
				"/companyLogin.do",
				"/cms",
				"/postscript/postscriptList.do",
				"/postscript/postscriptV.do",
				"/naverLogin.do",
				"/naverCallback.do"
	    	};
	    	
	    	// Session이 있을 수도 있고 없을 수도 있는 URL
	    	String[] exceptUrls = {
		    		"/common/ddCategory2Depth.do","/common/ddCategory3Depth.do",
		    		"/goIndex.do"
		    	};
	    	
	    	String url = request.getRequestURI();
	    	if ( url.indexOf("/resources/") < 0 ) {
	    		System.out.println("URL ===================> " + url);
	    	}
	    	
	    	if ( url.indexOf("/resources/") > -1 ) {
	    		return true;
	    	} else {
		    	// request 로그 
	    		if ( url.indexOf("/axA") < 0 && url.indexOf("/axB") < 0 && url.indexOf("/axC") < 0 && url.indexOf("/axD") < 0 && url.indexOf("/axE") < 0 &&
	    				url.indexOf("/axF") < 0 && url.indexOf("/axG") < 0 && url.indexOf("/axH") < 0 && url.indexOf("/axI") < 0 && url.indexOf("/axJ") < 0 &&
	    				url.indexOf("/axK") < 0 && url.indexOf("/axL") < 0 && url.indexOf("/axM") < 0 && url.indexOf("/axN") < 0 && url.indexOf("/axO") < 0 &&
	    				url.indexOf("/axP") < 0 && url.indexOf("/axQ") < 0 && url.indexOf("/axR") < 0 && url.indexOf("/axS") < 0 && url.indexOf("/axT") < 0 &&
	    				url.indexOf("/axU") < 0 && url.indexOf("/axV") < 0 && url.indexOf("/axW") < 0 && url.indexOf("/axX") < 0 && url.indexOf("/axY") < 0 && url.indexOf("/axZ") < 0 &&
	    				url.indexOf("/home/adminHome") < 0 &&
	    				url.indexOf("/adminLeft") < 0 ) {
			    	String reqParam = "";
			    	
			    	if ( request.getMethod().equals("POST") ) {
			    		Map<String, String[]> map = request.getParameterMap();
			    		for (Entry<String, String[]> entry : map.entrySet()) {
			    		    String name = entry.getKey();
			    		    String[] values = entry.getValue();
			    		    reqParam += name + "=" + Arrays.toString(values) + "&";
			    		}
			    	} else {
			    		Enumeration e = request.getParameterNames();
				        while ( e.hasMoreElements() ) {
				        	String name = (String)e.nextElement();
			            	reqParam += ("".equals(reqParam) ? "" : "&" ) + name + "=";
			
			            	String[] values = request.getParameterValues(name);
				            for ( int i = 0; i < values.length; i++) {
				            	reqParam += ( i == 0 ? "" : ",") + values[i];
				            }
				        }
			    	} 
				    if ( (SessionVO)SessionUtil.getSession() == null) {
			        	commSvr.requestLog("Guest", url, reqParam, request.getRemoteAddr());
			        } else {
			        	commSvr.requestLog(SessionUtil.getSessionUserId(), url, reqParam, request.getRemoteAddr());
			        }
	    		}

	    		//sub 도메인으로 회사 접속여부 체크
	        	String compCd = "";
	        	String compType = "";
	        	String compName = "";
	        	String compUseYn = "";
	        	
	        	//처음 도메인 체크
	        	String[] domains = request.getServerName().split("[.]");
	   	 		if ( SessionUtil.getAttribute("domain") == null ) {
		        	SessionUtil.setAttribute("domain", domains[0]);

		        	HashMap<String, Object> compInfo = axCommService.axCompInfoFromSubDomain(domains[0]);
	        		compCd = (String)compInfo.get("COMP_CD");
	        		compType = (String)compInfo.get("COMP_TYPE");
	        		compName = (String)compInfo.get("COMP_NAME");
	        		compUseYn = (String)compInfo.get("USE_YN");
		        	SessionUtil.setAttribute("compCd", compCd);
		        	SessionUtil.setAttribute("compType", compType);
		        	SessionUtil.setAttribute("compName", compName);

		        	SessionUtil.setAttribute("NAVER_CLIENT_ID", (String)compInfo.get("NAVER_CLIENT_ID"));
		        	SessionUtil.setAttribute("NAVER_CLIENT_SECRET", (String)compInfo.get("NAVER_CLIENT_SECRET"));
	   	 		} else {
	   	 			compCd = (String)SessionUtil.getAttribute("compCd");
	   	 			compType = (String)SessionUtil.getAttribute("compType");
	   	 			compName = (String)SessionUtil.getAttribute("compName");
	   	 			compUseYn = (String)SessionUtil.getAttribute("compUseYn");
	   	 		}
	   	 		
	   	 		/* 필요한 로직인가?	
	   	 		if ( SessionUtil.getAttribute("NAVER_CLIENT_ID") == null ) {
	   	 			System.out.println("GET NAVER_CLIENT_ID...");
		        	HashMap<String, Object> compInfo = axCommService.axCompInfoFromSubDomain(domains[0]);
		        	SessionUtil.setAttribute("NAVER_CLIENT_ID", (String)compInfo.get("NAVER_CLIENT_ID"));
		        	SessionUtil.setAttribute("NAVER_CLIENT_SECRET", (String)compInfo.get("NAVER_CLIENT_SECRET"));
	   	 		}
	   	 		*/
	   	 		
   	 			System.out.println("---------------------------> " + RequestContextHolder.getRequestAttributes().getSessionId() + ", " + compCd + ", " + compType + ", " + compName + ", " + SessionUtil.getAttribute("compCd") + ", " + SessionUtil.getAttribute("compType") + ", " + SessionUtil.getAttribute("compName"));

	        	//회사 도메인이면서 등록이 안되었거나, 사용불가인 경우 에러 페이지로 이동
	        	if ( !url.equals("/main/errorNotUseCompany.do") ) {
		        	if ( ( domains.length > 3 && !"www".equals(domains[0].toLowerCase()) && "B2C".equals(compType) ) ||
			        	( !"B2C".equals(compType) && "N".equals(compUseYn) ) ) {
			        		System.out.println("not use company ================================== ");
				        	response.sendRedirect("/main/errorNotUseCompany.do");
				        	return false;
		        	}
	        	}
	        	
	   	 		// 시스템에서 사용할 설정값을 가져와 Session에 넣어둔다.
	   	 		if ( SessionUtil.getAttribute("properties") == null ) {
			    	FileInputStream fis = new FileInputStream(request.getRealPath("//WEB-INF//lms.properties"));
			    	Properties prop = new Properties();
			    	prop.load(fis);
			    	SessionUtil.setAttribute("properties",prop.clone());
	   	 		}

	    		//환경설정을 가져온다.
	   	 		if ( SessionUtil.getAttribute("settingList") == null ) {
	   	 			SessionUtil.setAttribute("settingList", commSvr.getSettingList());
	   	 		}

	    		//마지막 접속 로그를 남긴다.
			    if ( (SessionVO)SessionUtil.getSession() != null) {
		        	commSvr.lastLog(SessionUtil.getSessionUserId());
		        }

	   	 		//과정 카테고리
		   	 	if ( CommUtil.isEqual("B2C", compType) && SessionUtil.getCourseCategoryList() == null ) {
	   	 			SessionUtil.setAttribute("courseCategoryList", commSvr.getCourseCategoryList());
	   	 		}

		   	 	if ( CommUtil.isEqual("C2C", compType) && SessionUtil.getAttribute("pChannelInfo") == null ) {
	   	 			SessionUtil.setAttribute("pChannelInfo", commSvr.getPChannelInfo());
	   	 		}

		    	if ( url.equals("/") || 
		    			url.equals("/lms") || 
		    			CommUtil.isMatchUrl(urls, url) || 
		    			CommUtil.isMatchUrl(exceptUrls, url) || 
		    			url.indexOf("/guest/") > -1 || 
		    			url.indexOf("/ns/") > -1 || 
		    			url.indexOf("/main/") > -1 ) {
		    		return true;
		    	} else {
		    		SessionVO sess = (SessionVO)SessionUtil.getSession();
			        if ( sess == null ) {
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
