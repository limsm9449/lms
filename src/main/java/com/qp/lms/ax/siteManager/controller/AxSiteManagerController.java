package com.qp.lms.ax.siteManager.controller;

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
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.qp.lms.ax.siteManager.service.AxSiteManagerService;
import com.qp.lms.common.CommUtil;
import com.qp.lms.common.Constant;
import com.qp.lms.common.service.CommService;
import com.qp.lms.main.model.MainSet;
import com.qp.lms.main.model.MainVO;

@Controller
public class AxSiteManagerController {

	private static final Logger logger = LoggerFactory.getLogger(AxSiteManagerController.class);

    @Autowired
    private AxSiteManagerService svr;

    @Autowired
    private CommService commSvr;

    @RequestMapping(value = "/siteManager/axSiteManagerCourseUserList", method = RequestMethod.POST, consumes = "application/json" )
    public @ResponseBody HashMap<String,Object> axSiteManagerCourseUserList(@RequestBody HashMap<String, Object> paramMap, HttpServletRequest request, HttpServletResponse response) throws Exception {
    	HashMap<String, Object> hm = new HashMap<String, Object>();

    	try {
    		hm = svr.axSiteManagerCourseUserList(paramMap);
    	} catch ( Exception e ) {
    		e.printStackTrace();
    	}

        return hm;
    }

    @RequestMapping(value = "/siteManager/axSiteManagerCourseUserSave", method = RequestMethod.POST, consumes = "application/json" )
    public @ResponseBody HashMap<String,Object> axSiteManagerCourseUserSave(@RequestBody HashMap<String, Object> paramMap, HttpServletRequest request, HttpServletResponse response) throws Exception {
    	HashMap<String, Object> hm = new HashMap<String, Object>();
    	
		try {
    		hm = svr.axSiteManagerCourseUserSave(paramMap);
    	} catch ( Exception e ) {
    		e.printStackTrace();
    		hm.put("RtnMode", Constant.mode.ERROR.name());
    	}

        return hm;
    }

    @RequestMapping(value = "/siteManager/axUserCourseRegister", method = RequestMethod.POST )
    public String axUserCourseRegister(@RequestParam HashMap<String,Object> paramMap, HttpServletRequest request, HttpServletResponse response, Model model) throws Exception {
    	HashMap<String, Object> hm = new HashMap<String, Object>();

    	try {
    		hm = svr.axUserCourseRegister(paramMap);
    		
    		model.addAttribute("json", CommUtil.getJsonObject((String)hm.get("RtnMode"), ""));
    	} catch ( Exception e ) {
    		e.printStackTrace();
    	}

    	return "/common/json";
    }

    @RequestMapping(value = "/siteManager/axApprovalList", method = RequestMethod.POST )
    public @ResponseBody HashMap<String,Object> axApprovalList(@RequestBody HashMap<String, Object> paramMap, HttpServletRequest request, HttpServletResponse response) throws Exception {
    	HashMap<String, Object> hm = new HashMap<String, Object>();

    	try {
    		hm = svr.axApprovalList(paramMap);
    	} catch ( Exception e ) {
    		e.printStackTrace();
    	}

        return hm;
    }

    @RequestMapping(value = "/siteManager/axApprovalUserList", method = RequestMethod.POST )
    public @ResponseBody HashMap<String,Object> axApprovalUserList(@RequestBody HashMap<String, Object> paramMap, HttpServletRequest request, HttpServletResponse response) throws Exception {
    	HashMap<String, Object> hm = new HashMap<String, Object>();

    	try {
    		hm = svr.axApprovalUserList(paramMap);
    	} catch ( Exception e ) {
    		e.printStackTrace();
    	}

        return hm;
    }

}
