package com.qp.lms.ax.account.controller;



import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.qp.lms.ax.account.service.AxPointService;
import com.qp.lms.common.Constant;
import com.qp.lms.common.SessionUtil;

@Controller
public class AxPointController {

	 private static final Logger logger = LoggerFactory.getLogger(AxPointController.class);

	    @Autowired
	    private AxPointService svr;

	    @RequestMapping(value = "/point/axPointCodeList", method = RequestMethod.POST, consumes = "application/json" )
	    public @ResponseBody HashMap<String,Object> axPointCodeList(@RequestBody HashMap<String, Object> paramMap, HttpServletRequest request, HttpServletResponse response) throws Exception {
	    	HashMap<String, Object> hm = new HashMap<String, Object>();

	    	try {
	    		hm = svr.axPointCodeList(paramMap);
	    	} catch ( Exception e ) {
	    		e.printStackTrace();
	    	}

	        return hm;
	    }
	    
	    @RequestMapping(value = "/point/axPointCodeSave", method = RequestMethod.POST, consumes = "application/json" )
	    public @ResponseBody HashMap<String,Object> axPointCodeSave(@RequestBody HashMap<String, Object> paramMap, HttpServletRequest request, HttpServletResponse response) throws Exception {
	    	HashMap<String, Object> hm = new HashMap<String, Object>();
	    	
			try {
	    		hm = svr.axPointCodeSave(paramMap);
	    	} catch ( Exception e ) {
	    		e.printStackTrace();
	    		hm.put("RtnMode", Constant.mode.ERROR.name());
	    	}

	        return hm;
	    }

	    @RequestMapping(value = "/point/axPointList", method = RequestMethod.POST, consumes = "application/json" )
	    public @ResponseBody HashMap<String,Object> axPointList(@RequestBody HashMap<String, Object> paramMap, HttpServletRequest request, HttpServletResponse response) throws Exception {
	    	HashMap<String, Object> hm = new HashMap<String, Object>();

	    	try {
	    		hm = svr.axPointList(paramMap);
	    	} catch ( Exception e ) {
	    		e.printStackTrace();
	    	}

	        return hm;
	    }
	    
	    @RequestMapping(value = "/point/axPointDetailList", method = RequestMethod.POST, consumes = "application/json" )
	    public @ResponseBody HashMap<String,Object> axPointDetailList(@RequestBody HashMap<String, Object> paramMap, HttpServletRequest request, HttpServletResponse response) throws Exception {
	    	HashMap<String, Object> hm = new HashMap<String, Object>();

	    	try {
	    		hm = svr.axPointDetailList(paramMap);
	    	} catch ( Exception e ) {
	    		e.printStackTrace();
	    	}

	        return hm;
	    }
	    
	    @RequestMapping(value = "/point/axPointEventMemberList", method = RequestMethod.POST, consumes = "application/json" )
	    public @ResponseBody HashMap<String,Object> axPointEventMemberList(@RequestBody HashMap<String, Object> paramMap, HttpServletRequest request, HttpServletResponse response) throws Exception {
	    	HashMap<String, Object> hm = new HashMap<String, Object>();

	    	try {
	    		hm = svr.axPointEventMemberList(paramMap);
	    	} catch ( Exception e ) {
	    		e.printStackTrace();
	    	}

	        return hm;
	    }
	    
	    @RequestMapping(value = "/point/axPointEventMemberSave", method = RequestMethod.POST, consumes = "application/json" )
	    public @ResponseBody HashMap<String,Object> axPointEventMemberSave(@RequestBody HashMap<String, Object> paramMap, HttpServletRequest request, HttpServletResponse response) throws Exception {
	    	HashMap<String, Object> hm = new HashMap<String, Object>();
	    	
			try {
	    		hm = svr.axPointEventMemberSave(paramMap);
	    	} catch ( Exception e ) {
	    		e.printStackTrace();
	    		hm.put("RtnMode", Constant.mode.ERROR.name());
	    	}

	        return hm;
	    }

	    
	    
	    

}
