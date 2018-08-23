package com.qp.lms.login.controller;

import java.io.FileInputStream;
import java.util.Properties;

import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.qp.lms.common.CommUtil;
import com.qp.lms.common.CommonSet;
import com.qp.lms.common.Constant;
import com.qp.lms.common.SessionUtil;
import com.qp.lms.common.SessionVO;
import com.qp.lms.login.model.LoginSet;
import com.qp.lms.login.model.LoginVO;
import com.qp.lms.login.service.LoginService;

@Controller
public class LoginController {
	private static final Logger logger = LoggerFactory.getLogger(LoginController.class);

    @Autowired
    private LoginService service;

    /*
     * Log In 화면 호출 
     */
    @RequestMapping(value = "/login", method = RequestMethod.GET)
    public String login(Model model) {
        return "login/login";
    } 

    /*
     * Log In 처리
     */
    @RequestMapping(value = "/loginCheck", method = RequestMethod.POST)
    public String loginCheck(@ModelAttribute LoginVO loginVO, Model model,HttpServletRequest request) throws Exception {
    	LoginSet set = new LoginSet();
    	set.setCondiVO(loginVO);
    	
    	set = service.loginCheck(set);
    	
   	 	model.addAttribute("set", set );

   	 	//사용자 정보가 존재하면 session 정보를 만든다.
   	 	if ( set.getData() != null && !"".equals(set.getData().getUserId()) ) {
   	 		String auth = CommUtil.getString(loginVO.getAuth());
   	 		
   	 		if ( ("ADMIN".equals(auth) && !"Y".equals(CommUtil.getString(set.getData().getAdminYn()))) ||
   	 				("SITE_MANGER".equals(auth) && !"Y".equals(CommUtil.getString(set.getData().getAdminYn()))) ||
   	 				("CONTENTS_MANAGER".equals(auth) && !"Y".equals(CommUtil.getString(set.getData().getAdminYn()))) ||
   	 				("TEACHER".equals(auth) && !"Y".equals(CommUtil.getString(set.getData().getTeacherYn()))) ||
   	 				("TUTOR".equals(auth) && !"Y".equals(CommUtil.getString(set.getData().getTutorYn()))) ) {
   	 			set.setIsNotAuth("Y");
   	 		} else {
	   	 		SessionVO sess = new SessionVO();
	   	 		sess.setUserId(set.getData().getUserId());
	   	 		sess.setUserName(set.getData().getUserName());
	   	 		sess.setAdminYn(set.getData().getAdminYn());
	   	 		sess.setSiteManagerYn(set.getData().getSiteManagerYn());
	   	 		sess.setContentsManagerYn(set.getData().getContentsManagerYn());
	   	 		sess.setTutorYn(set.getData().getTutorYn());
	   	 		sess.setTeacherYn(set.getData().getTeacherYn());
	   	 		sess.setUserIp(request.getRemoteAddr());

	   	 		sess.setAuth(auth);
	
		    	//첨부자료 다운로드 권한 설정
		    	if ( "Y".equals(set.getData().getAdminYn()) || "Y".equals(set.getData().getSiteManagerYn()) || "Y".equals(set.getData().getContentsManagerYn()) || "Y".equals(set.getData().getTutorYn()) || "Y".equals(set.getData().getTeacherYn()) )
		    		sess.setDownloadAuth("Y");
		    	else
		    		sess.setDownloadAuth("N");
		    	
	   	 		SessionUtil.setAttribute("session", sess);
   	 		}
   	 		
   	 		// session 종료시 다시 로긴후 돌아갈 곳을 찾기 위해서 사용
   	 		SessionUtil.setAttribute("loginAuth", auth);
   	 	}
   	 	
   	 	//카트 정보 삭제
		SessionUtil.setAttribute("cart", null);
		SessionUtil.setAttribute("tempCart", null);
		
        return "login/loginTran";
    }
    
    /*
     * BackDoor Log In 처리
     */
    @RequestMapping(value = "/backdorLoginCheck", method = RequestMethod.POST)
    public String backdorLoginCheck(@ModelAttribute LoginVO loginVO, Model model,HttpServletRequest request) throws Exception {
    	LoginSet set = new LoginSet();
    	set.setCondiVO(loginVO);
    	
    	set = service.backdorLoginCheck(set);
    	
   	 	model.addAttribute("set", set );

   	 	//사용자 정보가 존재하면 session 정보를 만든다.
   	 	if ( set.getData() != null && !"".equals(set.getData().getUserId()) ) {
   	 		SessionVO sess = new SessionVO();
   	 		sess.setUserId(set.getData().getUserId());
   	 		sess.setUserName(set.getData().getUserName());
   	 		sess.setAdminYn(set.getData().getAdminYn());
   	 		sess.setSiteManagerYn(set.getData().getSiteManagerYn());
   	 		sess.setContentsManagerYn(set.getData().getContentsManagerYn());
   	 		sess.setTutorYn(set.getData().getTutorYn());
   	 		sess.setTeacherYn(set.getData().getTeacherYn());
   	 		sess.setUserIp(request.getRemoteAddr());

	    	//첨부자료 다운로드 권한 설정
	    	if ( "Y".equals(set.getData().getAdminYn()) || "Y".equals(set.getData().getSiteManagerYn()) || "Y".equals(set.getData().getContentsManagerYn()) || "Y".equals(set.getData().getTutorYn()) || "Y".equals(set.getData().getTeacherYn()) )
	    		sess.setDownloadAuth("Y");
	    	else
	    		sess.setDownloadAuth("N");
	    	
   	 		SessionUtil.setAttribute("session", sess);
   	 		
   	 		// 시스템에서 사용할 설정값을 가져와 Session에 넣어둔다.
	    	FileInputStream fis = new FileInputStream(request.getRealPath("//WEB-INF//lms.properties"));
	    	Properties prop = new Properties();
	    	prop.load(fis);
	    	SessionUtil.setAttribute("properties",prop.clone());
   	 	}
   	 	
        return "login/loginTran";
    }

    /**
     * Log Out 처리
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/logout", method = RequestMethod.POST)
    public String logout(Model model) throws Exception {
    	try {
        	SessionUtil.removeAttribute("session");

       	 	//카트 정보 삭제
    		SessionUtil.setAttribute("cart", null);
    		SessionUtil.setAttribute("tempCart", null);

        	CommonSet set = new CommonSet();
	   		set.setRtnMode(Constant.mode.OK.name());

	    	model.addAttribute("json", CommUtil.getJsonObject(set.getRtnMode(),""));
    	} catch ( Exception e ) {
    		e.printStackTrace();
    	}

        return "/common/json";
    } 

    /*
     * Company Log In 화면 호출 
     */
    @RequestMapping(value = "/companyLogin")
    public String companyLogin(@ModelAttribute LoginVO loginVO, Model model) throws Exception {
    	LoginSet set = new LoginSet();
    	set.setCondiVO(loginVO);
		
    	set = service.companyLogin(set);
    	
        model.addAttribute("set", set );
        
        return "login/companyLogin";
    } 

    
}
