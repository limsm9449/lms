package com.qp.lms.ax.common.controller;



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
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.qp.lms.ax.common.service.AxCommService;
import com.qp.lms.common.Constant;

@Controller
public class AxCommController {

	private static final Logger logger = LoggerFactory.getLogger(AxCommController.class);

    @Autowired
    private AxCommService svr;
    
   
    @RequestMapping(value = "/common/axOpenPage", method = RequestMethod.POST)
    public String axOpenPage(@RequestParam("page") String page, HttpServletRequest request, HttpServletResponse response) throws Exception {

        return page;
    }
    
    @RequestMapping(value = "/common/axDd", method = RequestMethod.POST, consumes = "application/json" )
    public @ResponseBody HashMap<String,Object> axGetDd(@RequestBody HashMap<String, Object> paramMap, HttpServletRequest request, HttpServletResponse response) throws Exception {
    	HashMap<String, Object> hm = new HashMap<String, Object>();
    	
		try {
    		hm = svr.axDd(paramMap);
    	} catch ( Exception e ) {
    		e.printStackTrace();
    		hm.put("RtnMode", Constant.mode.ERROR.name());
    	}

        return hm;
    }
    
    @RequestMapping(value = "/common/axMaxCourseCode", method = RequestMethod.POST, consumes = "application/json" )
    public @ResponseBody HashMap<String,Object> axMaxCourseCode(@RequestBody HashMap<String, Object> paramMap, HttpServletRequest request, HttpServletResponse response) throws Exception {
    	HashMap<String, Object> hm = new HashMap<String, Object>();
    	
		try {
    		hm = svr.axMaxCourseCode(paramMap);
    	} catch ( Exception e ) {
    		e.printStackTrace();
    		hm.put("RtnMode", Constant.mode.ERROR.name());
    	}

        return hm;
    }
    
}
