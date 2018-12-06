package com.qp.lms.home.controller;

import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.qp.lms.common.Constant;
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
    
    @RequestMapping(value = "/lms")
    public String homeLms(Model model) {

        return "indexLms";
    }
    
    @RequestMapping(value = "/goIndex")
    public String goIndex(Model model) {

        return "goIndex";
    }
    
    @RequestMapping(value = "/errorNotUseCompany")
    public String errorNotUseCompany(Model model) {

        return "errorNotUseCompany";
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

    @RequestMapping(value = "/adminLeft")
    public String adminLeft(@ModelAttribute HomeVO vo, Model model) throws Exception {
    	try {
	    	HomeSet set = new HomeSet();
	    	
	    	set = svr.aLeft(set);
	    	
	    	model.addAttribute("set", set );

	    	SessionVO sess = (SessionVO)SessionUtil.getSession();
	    	model.addAttribute("auth",sess.getAuth());
	    	
    	} catch ( Exception e ) {
    		e.printStackTrace();
    	}
    	 
        return "home/adminLeft";
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

    @RequestMapping(value = "/content")
    public String content(Model model) {

        return "home/content";
    }

    @RequestMapping(value = "/sessionContinue", method = RequestMethod.POST, consumes = "application/json")
    public @ResponseBody HashMap<String,Object> sessionContinue(@RequestBody HashMap<String, Object> paramMap, HttpServletRequest request, HttpServletResponse response) {
    	HashMap<String, Object> hm = new HashMap<String, Object>();
    	hm.put("msg", "continue");
        return hm;
    }
    
    

    
}
