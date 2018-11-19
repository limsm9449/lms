package com.qp.lms.ax.log.controller;



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

import com.qp.lms.ax.log.service.AxLogService;
import com.qp.lms.common.service.CommService;

@Controller
public class AxLogController {

	private static final Logger logger = LoggerFactory.getLogger(AxLogController.class);

	@Autowired
    private AxLogService svr;

    @Autowired
    private CommService commSvr;

    @RequestMapping(value = "/log/axLogList", method = RequestMethod.POST, consumes = "application/json" )
    public @ResponseBody HashMap<String,Object> axLogList(@RequestBody HashMap<String, Object> paramMap, HttpServletRequest request, HttpServletResponse response) throws Exception {
    	HashMap<String, Object> hm = new HashMap<String, Object>();

    	try {
    		hm = svr.axLogList(paramMap);
    	} catch ( Exception e ) {
    		e.printStackTrace();
    	}

        return hm;
    }

    @RequestMapping(value = "/log/axLoginLogList", method = RequestMethod.POST, consumes = "application/json" )
    public @ResponseBody HashMap<String,Object> axLoginLogList(@RequestBody HashMap<String, Object> paramMap, HttpServletRequest request, HttpServletResponse response) throws Exception {
    	HashMap<String, Object> hm = new HashMap<String, Object>();

    	try {
    		hm = svr.axLoginLogList(paramMap);
    	} catch ( Exception e ) {
    		e.printStackTrace();
    	}

        return hm;
    }

    @RequestMapping(value = "/log/axLoginMonthLogList", method = RequestMethod.POST, consumes = "application/json" )
    public @ResponseBody HashMap<String,Object> axLoginMonthLogList(@RequestBody HashMap<String, Object> paramMap, HttpServletRequest request, HttpServletResponse response) throws Exception {
    	HashMap<String, Object> hm = new HashMap<String, Object>();

    	try {
    		hm = svr.axLoginMonthLogList(paramMap);
    	} catch ( Exception e ) {
    		e.printStackTrace();
    	}

        return hm;
    }


}
