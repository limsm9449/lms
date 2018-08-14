package com.qp.lms.ax.board.controller;



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

import com.qp.lms.ax.board.service.AxBoardReportService;
import com.qp.lms.common.Constant;

@Controller
public class AxBoardReportController {

	private static final Logger logger = LoggerFactory.getLogger(AxBoardReportController.class);

    @Autowired
    private AxBoardReportService svr;

    @RequestMapping(value = "/board/axBoardReportList", method = RequestMethod.POST, consumes = "application/json" )
    public @ResponseBody HashMap<String,Object> axBoardReportList(@RequestBody HashMap<String, Object> paramMap, HttpServletRequest request, HttpServletResponse response) throws Exception {
    	HashMap<String, Object> hm = new HashMap<String, Object>();

    	try {
    		hm = svr.axBoardReportList(paramMap);
    	} catch ( Exception e ) {
    		e.printStackTrace();
    	}

        return hm;
    }

    @RequestMapping(value = "/board/axBoardReportOne", method = RequestMethod.POST, consumes = "application/json" )
    public @ResponseBody HashMap<String,Object> axBoardReporOne(@RequestBody HashMap<String, Object> paramMap, HttpServletRequest request, HttpServletResponse response) throws Exception {
    	HashMap<String, Object> hm = new HashMap<String, Object>();

    	try {
    		hm = svr.axBoardReportOne(paramMap);
    	} catch ( Exception e ) {
    		e.printStackTrace();
    	}

        return hm;
    }

    @RequestMapping(value = "/board/axBoardReportSave", method = RequestMethod.POST, consumes = "application/json" )
    public @ResponseBody HashMap<String,Object> axAccountSave(@RequestBody HashMap<String, Object> paramMap, HttpServletRequest request, HttpServletResponse response) throws Exception {
    	HashMap<String, Object> hm = new HashMap<String, Object>();
    	
		try {
    		hm = svr.axBoardReportSave(paramMap);
    	} catch ( Exception e ) {
    		e.printStackTrace();
    		hm.put("RtnMode", Constant.mode.ERROR.name());
    	}

        return hm;
    }


	    
	    

}
