package com.qp.lms.ax.account.controller;



import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.qp.lms.ax.account.service.AxAccountService;
import com.qp.lms.common.Constant;

@Controller
public class AxAccountController {

	 private static final Logger logger = LoggerFactory.getLogger(AxAccountController.class);

	    @Autowired
	    private AxAccountService svr;

	    @RequestMapping(value = "/account/axAccountList", method = RequestMethod.POST, consumes = "application/json" )
	    public @ResponseBody HashMap<String,Object> axAccountList(@RequestBody HashMap<String, Object> paramMap, HttpServletRequest request, HttpServletResponse response) throws Exception {
	    	HashMap<String, Object> hm = new HashMap<String, Object>();

	    	try {
	    		hm = svr.axAccountList(paramMap);
	    	} catch ( Exception e ) {
	    		e.printStackTrace();
	    	}

	        return hm;
	    }
	    
	    @RequestMapping(value = "/account/axAccountSave", method = RequestMethod.POST, consumes = "application/json" )
	    public @ResponseBody HashMap<String,Object> axAccountSave(@RequestBody HashMap<String, Object> paramMap, HttpServletRequest request, HttpServletResponse response) throws Exception {
	    	HashMap<String, Object> hm = new HashMap<String, Object>();
	    	
    		try {
	    		hm = svr.axAccountSave(paramMap);
	    	} catch ( Exception e ) {
	    		e.printStackTrace();
	    		hm.put("RtnMode", Constant.mode.ERROR.name());
	    	}

	        return hm;
	    }
	    
	    @RequestMapping(value = "/account/axPasswordReset", method = RequestMethod.POST, consumes = "application/json" )
	    public @ResponseBody HashMap<String,Object> axPasswordReset(@RequestBody HashMap<String, Object> paramMap, HttpServletRequest request, HttpServletResponse response) throws Exception {
	    	HashMap<String, Object> hm = new HashMap<String, Object>();

	    	try {
	    		hm = svr.axPasswordReset(paramMap);
	    	} catch ( Exception e ) {
	    		e.printStackTrace();
	    	}

	        return hm;
	    }
	    
	    @RequestMapping(value = "/account/axReSendCertification", method = RequestMethod.POST, consumes = "application/json" )
	    public @ResponseBody HashMap<String,Object> axReSendCertification(@RequestBody HashMap<String, Object> paramMap, HttpServletRequest request, HttpServletResponse response) throws Exception {
	    	HashMap<String, Object> hm = new HashMap<String, Object>();

	    	try {
	    		hm = svr.axReSendCertification(paramMap);
	    	} catch ( Exception e ) {
	    		e.printStackTrace();
	    	}

	        return hm;
	    }
	    
	    
	    

}
