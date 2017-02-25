package com.qp.lms.home.controller;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.qp.lms.common.SessionUtil;
import com.qp.lms.common.SessionVO;
import com.qp.lms.home.model.HomeSet;
import com.qp.lms.home.model.HomeVO;
import com.qp.lms.home.service.HomeService;

@Controller
public class HomeController {
	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);

    @Autowired
    private HomeService svr;

    @RequestMapping(value = "/")
    public String home(Model model) {

        return "index";
    }
    
    @RequestMapping(value = "/goIndex")
    public String goIndex(Model model) {

        return "goIndex";
    }

    @RequestMapping(value = "/cms")
    public String cms(Model model) {

        return "cms/index";
    }

    /**
     * 濡쒓렇�씤 �썑�뿉 �솃
     * @param model
     * @return
     */
    @RequestMapping(value = "/loginHome")
    public String loginHome(Model model) {

        return "home/loginHome";
    }
    
    @RequestMapping(value = "/home/adminHome")
    public String adminHome(@ModelAttribute HomeVO vo, Model model) throws Exception {
        return "/home/adminHome";
    }

    @RequestMapping(value = "/home/userHome")
    public String userHome(@ModelAttribute HomeVO vo, Model model) throws Exception {
    	try {
	    	HomeSet set = new HomeSet();
	    	
	    	set = svr.aLeft(set);
	    	
	   	 	model.addAttribute("set", set );
    	} catch ( Exception e ) {
    		e.printStackTrace();
    	}
        return "/home/userHome";
    }

    @RequestMapping(value = "/home/tutorHome")
    public String tutorHome(@ModelAttribute HomeVO vo, Model model) throws Exception {
        return "/home/tutorHome";
    }

    @RequestMapping(value = "/home/teacherHome")
    public String teacherHome(@ModelAttribute HomeVO vo, Model model) throws Exception {
        return "/home/teacherHome";
    }

    @RequestMapping(value = "/home/compManagerHome")
    public String compManagerHome(@ModelAttribute HomeVO vo, Model model) throws Exception {
        return "/home/compManagerHome";
    }


    /*
     * �긽�떒
     */
    @RequestMapping(value = "/top")
    public String top(@ModelAttribute HomeVO vo, Model model) throws Exception {
    	String jspName = "";
    	SessionVO sess = (SessionVO)SessionUtil.getSession();

    	if ( sess != null ) {
	    	model.addAttribute("sess",sess);
	
	    	if ( "Y".equals(sess.getAdminYn()) )
	    		jspName = "home/aTop";
	    	else if ( "Y".equals(sess.getTeacherYn()) )
	    		jspName = "home/tTop";
	    	else if ( "Y".equals(sess.getTutorYn()) )
	    		jspName = "home/tTop";
	    	else 
	    		jspName = "home/uTop";
    	}
    	
        return jspName;
    }

    /**
     * 愿�由ъ옄 硫붾돱
     * @param vo
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/adminLeft")
    public String adminLeft(@ModelAttribute HomeVO vo, Model model) throws Exception {
    	try {
	    	HomeSet set = new HomeSet();
	    	
	    	set = svr.aLeft(set);
	    	
	    	model.addAttribute("set", set );
    	} catch ( Exception e ) {
    		e.printStackTrace();
    	}
    	 
        return "home/adminLeft";
    }

    /**
     * �궗�슜�옄 硫붾돱
     * @param vo
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/userLeft")
    public String userLeft(@ModelAttribute HomeVO vo, Model model) throws Exception {
    	HomeSet set = new HomeSet();
    	
    	set = svr.aLeft(set);
    	
    	 model.addAttribute("set", set );
    	 
        return "home/userLeft";
    }

    /**
     * Tutor 硫붾돱
     * @param vo
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/tutorLeft")
    public String tutorLeft(@ModelAttribute HomeVO vo, Model model) throws Exception {
    	try {
	    	HomeSet set = new HomeSet();
	    	
	    	set = svr.aLeft(set);
	    	
	    	model.addAttribute("set", set );
    	} catch ( Exception e ) {
    		e.printStackTrace();
    	}

        return "home/tutorLeft";
    }

    /**
     * 媛뺤궗 硫붾돱
     * @param vo
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/teacherLeft")
    public String teacherLeft(@ModelAttribute HomeVO vo, Model model) throws Exception {
    	try {
	    	HomeSet set = new HomeSet();
	    	
	    	set = svr.aLeft(set);
	    	
	    	model.addAttribute("set", set );
    	} catch ( Exception e ) {
    		e.printStackTrace();
    	}

        return "home/teacherLeft";
    }

    /**
     * �쉶�궗 愿�由ъ옄 硫붾돱
     * @param vo
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/compManagerLeft")
    public String compManagerLeft(@ModelAttribute HomeVO vo, Model model) throws Exception {
    	try {
	    	HomeSet set = new HomeSet();
	    	
	    	set = svr.aLeft(set);
	    	
	    	model.addAttribute("set", set );
    	} catch ( Exception e ) {
    		e.printStackTrace();
    	}
 
        return "home/compManagerLeft";
    }
    
    /*
     * �븯�떒
     */
    @RequestMapping(value = "/bottom")
    public String bottom(Model model) throws Exception {
        return "home/bottom";
    }
    
    /*
     * �븯�떒
     */
    @RequestMapping(value = "/adminBottom")
    public String adminBottom(Model model) throws Exception {
        return "home/adminBottom";
    }

    /*
     * �궡�슜
     */
    @RequestMapping(value = "/content")
    public String content(Model model) {

        return "home/content";
    }

    
}
