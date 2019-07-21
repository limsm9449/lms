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

import com.qp.lms.ax.common.service.AxCommService;
import com.qp.lms.common.CommUtil;
import com.qp.lms.common.LoginManager;
import com.qp.lms.common.SessionUtil;
import com.qp.lms.common.SessionVO;
import com.qp.lms.common.service.CommService;
import com.qp.lms.login.model.LoginSet;
import com.qp.lms.login.model.LoginVO;
import com.qp.lms.login.service.LoginService;

@Controller
public class LoginController {
	private static final Logger logger = LoggerFactory.getLogger(LoginController.class);

    @Autowired
    private LoginService service;

    @Autowired
    private AxCommService axCommService;
    
    @Autowired
    private CommService commSvr;

    /*
     * Log In 화면 호출 
     */
    @RequestMapping(value = "/login", method = RequestMethod.GET)
    public String login(Model model) throws Exception {
        return CommUtil.getCompTypePage("login/login");
    } 

    @RequestMapping(value = "/dupLoginCheck", method = RequestMethod.POST)
    public String dupLoginCheck(@ModelAttribute LoginVO loginVO, Model model,HttpServletRequest request) throws Exception {
    	loginVO.setLoginIp(request.getRemoteAddr());

    	LoginSet set = new LoginSet();
    	set.setCondiVO(loginVO);

    	set = service.loginCheck(set);
    	if ( !"Y".equals(set.getIsNotExistUserId()) && !"Y".equals(set.getIsWrongPassword()) ) {
	    	LoginManager loginManager = LoginManager.getInstance();
	 		if ( loginManager.isUsing(loginVO.getUserId()) ) {
	 			set.setIsLogin("Y");
	 		} else {
	 			set.setIsLogin("N");
	 		}
    	}
    	
   	 	model.addAttribute("set", set );
   	 	
    	return "/login/loginTran";
    }

    @RequestMapping(value = "/loginConfirm", method = RequestMethod.GET)
    public String loginConfirm(@ModelAttribute LoginVO loginVO, Model model) throws Exception {
    	LoginSet set = new LoginSet();
    	set.setCondiVO(loginVO);
    	
    	model.addAttribute("set", set );
    	
    	LoginManager loginManager = LoginManager.getInstance();
    	model.addAttribute("loginTime", loginManager.getLoginTime(loginVO.getUserId()));
    	
        return CommUtil.getCompTypePage("/login/loginConfirm");
    } 

    /*
     * Log In 처리
     */
    @RequestMapping(value = "/loginCheck", method = RequestMethod.POST)
    public String loginCheck(@ModelAttribute LoginVO loginVO, Model model,HttpServletRequest request) throws Exception {
    	loginVO.setLoginIp(request.getRemoteAddr());
    	
    	LoginSet set = new LoginSet();
    	set.setCondiVO(loginVO);
    	
    	set.getCondiVO().setCompCd(SessionUtil.getSessionCompCd());
    	set.getCondiVO().setCompType(SessionUtil.getSessionCompType());
			
    	set = service.loginCheck(set);
    	
   	 	model.addAttribute("set", set );

   	 	//사용자 정보가 존재하면 session 정보를 만든다.
   	 	if ( set.getData() != null && !"".equals(set.getData().getUserId()) && "N".equals(set.getData().getRetiredYn()) ) {
   	 		String auth = CommUtil.getString(loginVO.getAuth());
   	 		
   	 		if ( ("ADMIN".equals(auth) && !"Y".equals(CommUtil.getString(set.getData().getAdminYn()))) ||
   	 				("SITE_MANAGER".equals(auth) && !"Y".equals(CommUtil.getString(set.getData().getSiteManagerYn()))) ||
   	 				("CONTENTS_MANAGER".equals(auth) && !"Y".equals(CommUtil.getString(set.getData().getContentsManagerYn()))) ||
   	 				("TEACHER".equals(auth) && !"Y".equals(CommUtil.getString(set.getData().getTeacherYn()))) ||
   	 				("TUTOR".equals(auth) && !"Y".equals(CommUtil.getString(set.getData().getTutorYn()))) ||
   	 				("CHANNEL".equals(auth) && CommUtil.isEqual(set.getCompCd(), "")) ) {
   	 			set.setIsNotAuth("Y");
   	 		} else {
   	 			/* 사용안함 2019.7.10
	   	 		LoginManager loginManager = LoginManager.getInstance();
	   	 		if ( loginManager.isUsing(set.getData().getUserId()) ) {
	   	 			//기존의 접속(세션)을 끊는다.
	   	 			loginManager.removeSession(set.getData().getUserId());
	   	 		}
	   	 		*/

	   	 		SessionVO sess = new SessionVO();
	   	 		sess.setUserId(set.getData().getUserId());
	   	 		sess.setUserName(set.getData().getUserName());
	   	 		sess.setAdminYn(set.getData().getAdminYn());
	   	 		sess.setSiteManagerYn(set.getData().getSiteManagerYn());
	   	 		sess.setContentsManagerYn(set.getData().getContentsManagerYn());
	   	 		sess.setTutorYn(set.getData().getTutorYn());
	   	 		sess.setTeacherYn(set.getData().getTeacherYn());
	   	 		sess.setUserIp(request.getRemoteAddr());
	   	 		sess.setMobile(set.getData().getMobile());
	   	 		sess.setEmail(set.getData().getEmail());
	   	 		sess.setCompName(set.getData().getCompName());
	   	 		sess.setPassword(set.getCondiVO().getPassword());

	   	 		//C2C로 로그인시 TEACHER이면 권한을 부여한다.
	   	 		if ( CommUtil.isEqual(auth, "") && CommUtil.isEqual(SessionUtil.getSessionCompType(), "C2C") && CommUtil.isEqual(set.getData().getUserId(), set.getData().getC2cUserId()) ) {
   	 				auth = "CHANNEL";
	   	 		}

	   	 		if ( "".equals(CommUtil.getString(set.getData().getCompCd())) ) {
	   	 			sess.setCompCd("B2C");
	   	 		} else if ( auth.equals("CHANNEL") ) {
	   	 			sess.setCompCd(set.getCompCd());
		   	 		sess.setCompName("개인채널");
	   	 			sess.setC2cYn("Y");
	   	 		} else {
	   	 			sess.setCompCd(set.getData().getCompCd());
	   	 			sess.setC2cYn(set.getData().getC2cYn());
	   	 		}
	   	 		
	   	 		sess.setAuth(auth);
	
		    	//첨부자료 다운로드 권한 설정
		    	if ( "Y".equals(set.getData().getAdminYn()) || "Y".equals(set.getData().getSiteManagerYn()) || "Y".equals(set.getData().getContentsManagerYn()) || "Y".equals(set.getData().getTutorYn()) || "Y".equals(set.getData().getTeacherYn()) )
		    		sess.setDownloadAuth("Y");
		    	else
		    		sess.setDownloadAuth("N");

 	 			//sess.setCompCd(set.getCondiVO().getCompCd());

	   	 		SessionUtil.setAttribute("session", sess);
	   	         
	   	 		/* 사용안함 2019.7.10
   	 			//새로운 세션을 등록한다. setSession함수를 수행하면 valueBound()함수가 호출된다.
   	 			loginManager.setSession(request.getSession(), set.getData().getUserId());
   	 			*/
   	 		}
   	 		
   	 		//session 종료시 다시 로긴후 돌아갈 곳을 찾기 위해서 사용
   	 		SessionUtil.setAttribute("loginAuth", auth);
   	 	}
   	 	
   	 	//카트 정보 삭제
		SessionUtil.setAttribute("cart", null);
		SessionUtil.setAttribute("tempCart", null);

    	//임시 파일들을 삭제한다.
    	commSvr.delAttachTemp();

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
    		LoginVO loginVO = new LoginVO();
    		loginVO.setUserId(SessionUtil.getSessionUserId());
    		
    		//LoginManager loginManager = LoginManager.getInstance();
    		//loginManager.removeSession(loginVO.getUserId());
    		
        	LoginSet set = new LoginSet();
        	set.setCondiVO(loginVO);
        	
        	set = service.logout(set);

        	SessionUtil.removeAttribute("session");

       	 	//카트 정보 삭제
    		SessionUtil.setAttribute("cart", null);
    		SessionUtil.setAttribute("tempCart", null);

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

    @RequestMapping(value = "/openChannel")
    public String openChannel(@ModelAttribute LoginVO loginVO, Model model) throws Exception {
    	LoginSet set = new LoginSet();
    	set.setCondiVO(loginVO);
		
        model.addAttribute("set", set );
        
        return "login/openChannel";
    }
    
    
}
