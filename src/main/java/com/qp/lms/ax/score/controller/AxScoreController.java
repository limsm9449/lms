package com.qp.lms.ax.score.controller;



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

import com.qp.lms.ax.score.service.AxScoreService;
import com.qp.lms.common.Constant;

@Controller
public class AxScoreController {

	 private static final Logger logger = LoggerFactory.getLogger(AxScoreController.class);

	    @Autowired
	    private AxScoreService svr;

	    @RequestMapping(value = "/score/axScoreList", method = RequestMethod.POST, consumes = "application/json" )
	    public @ResponseBody HashMap<String,Object> axScoreList(@RequestBody HashMap<String, Object> paramMap, HttpServletRequest request, HttpServletResponse response) throws Exception {
	    	HashMap<String, Object> hm = new HashMap<String, Object>();

	    	try {
	    		hm = svr.axScoreList(paramMap);
	    	} catch ( Exception e ) {
	    		e.printStackTrace();
	    	}

	        return hm;
	    }
	    
	    @RequestMapping(value = "/score/axUserScoreList", method = RequestMethod.POST, consumes = "application/json" )
	    public @ResponseBody HashMap<String,Object> axUserScoreList(@RequestBody HashMap<String, Object> paramMap, HttpServletRequest request, HttpServletResponse response) throws Exception {
	    	HashMap<String, Object> hm = new HashMap<String, Object>();

	    	try {
	    		hm = svr.axUserScoreList(paramMap);
	    	} catch ( Exception e ) {
	    		e.printStackTrace();
	    	}

	        return hm;
	    }
	    
	    @RequestMapping(value = "/score/axUserScoreSave", method = RequestMethod.POST, consumes = "application/json" )
	    public @ResponseBody HashMap<String,Object> axUserScoreUpdateReportDiscussion(@RequestBody HashMap<String, Object> paramMap, HttpServletRequest request, HttpServletResponse response) throws Exception {
	    	HashMap<String, Object> hm = new HashMap<String, Object>();

	    	try {
	    		hm = svr.axUserScoreSave(paramMap);
	    	} catch ( Exception e ) {
	    		e.printStackTrace();
	    	}

	        return hm;
	    }
	    
	    @RequestMapping(value = "/score/axUserScoreWeekList", method = RequestMethod.POST, consumes = "application/json" )
	    public @ResponseBody HashMap<String,Object> axUserScoreWeekList(@RequestBody HashMap<String, Object> paramMap, HttpServletRequest request, HttpServletResponse response) throws Exception {
	    	HashMap<String, Object> hm = new HashMap<String, Object>();

	    	try {
	    		hm = svr.axUserScoreWeekList(paramMap);
	    	} catch ( Exception e ) {
	    		e.printStackTrace();
	    	}

	        return hm;
	    }
	    
	    

}
