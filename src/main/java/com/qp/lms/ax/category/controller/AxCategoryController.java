package com.qp.lms.ax.category.controller;



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

import com.qp.lms.ax.category.service.AxCategoryService;
import com.qp.lms.common.Constant;

@Controller
public class AxCategoryController {

	 private static final Logger logger = LoggerFactory.getLogger(AxCategoryController.class);

	    @Autowired
	    private AxCategoryService svr;

	    @RequestMapping(value = "/category/axCategoryLevel1List", method = RequestMethod.POST, consumes = "application/json" )
	    public @ResponseBody HashMap<String,Object> axCategoryLevel1List(@RequestBody HashMap<String, Object> paramMap, HttpServletRequest request, HttpServletResponse response) throws Exception {
	    	HashMap<String, Object> hm = new HashMap<String, Object>();

	    	try {
	    		hm = svr.axCategoryLevel1List(paramMap);
	    	} catch ( Exception e ) {
	    		e.printStackTrace();
	    	}

	        return hm;
	    }
	    
	    @RequestMapping(value = "/category/axCategoryLevel1Save", method = RequestMethod.POST, consumes = "application/json" )
	    public @ResponseBody HashMap<String,Object> axCategoryLevel1Save(@RequestBody HashMap<String, Object> paramMap, HttpServletRequest request, HttpServletResponse response) throws Exception {
	    	HashMap<String, Object> hm = new HashMap<String, Object>();
	    	
    		try {
	    		hm = svr.axCategoryLevel1Save(paramMap);
	    	} catch ( Exception e ) {
	    		e.printStackTrace();
	    		hm.put("RtnMode", Constant.mode.ERROR.name());
	    	}

	        return hm;
	    }
	    
	    @RequestMapping(value = "/category/axCategoryLevel2List", method = RequestMethod.POST, consumes = "application/json" )
	    public @ResponseBody HashMap<String,Object> axCategoryLevel2List(@RequestBody HashMap<String, Object> paramMap, HttpServletRequest request, HttpServletResponse response) throws Exception {
	    	HashMap<String, Object> hm = new HashMap<String, Object>();

	    	try {
	    		hm = svr.axCategoryLevel2List(paramMap);
	    	} catch ( Exception e ) {
	    		e.printStackTrace();
	    	}

	        return hm;
	    }
	    
	    @RequestMapping(value = "/category/axCategoryLevel2Save", method = RequestMethod.POST, consumes = "application/json" )
	    public @ResponseBody HashMap<String,Object> axCategoryLevel2Save(@RequestBody HashMap<String, Object> paramMap, HttpServletRequest request, HttpServletResponse response) throws Exception {
	    	HashMap<String, Object> hm = new HashMap<String, Object>();
	    	
    		try {
	    		hm = svr.axCategoryLevel2Save(paramMap);
	    	} catch ( Exception e ) {
	    		e.printStackTrace();
	    		hm.put("RtnMode", Constant.mode.ERROR.name());
	    	}

	        return hm;
	    }
	    
	    @RequestMapping(value = "/category/axCategoryLevel3List", method = RequestMethod.POST, consumes = "application/json" )
	    public @ResponseBody HashMap<String,Object> axCategoryLevel3List(@RequestBody HashMap<String, Object> paramMap, HttpServletRequest request, HttpServletResponse response) throws Exception {
	    	HashMap<String, Object> hm = new HashMap<String, Object>();

	    	try {
	    		hm = svr.axCategoryLevel3List(paramMap);
	    	} catch ( Exception e ) {
	    		e.printStackTrace();
	    	}

	        return hm;
	    }
	    
	    @RequestMapping(value = "/category/axCategoryLevel3Save", method = RequestMethod.POST, consumes = "application/json" )
	    public @ResponseBody HashMap<String,Object> axCategoryLevel3Save(@RequestBody HashMap<String, Object> paramMap, HttpServletRequest request, HttpServletResponse response) throws Exception {
	    	HashMap<String, Object> hm = new HashMap<String, Object>();
	    	
    		try {
	    		hm = svr.axCategoryLevel3Save(paramMap);
	    	} catch ( Exception e ) {
	    		e.printStackTrace();
	    		hm.put("RtnMode", Constant.mode.ERROR.name());
	    	}

	        return hm;
	    }
	    
	    
	    
	    
	    
	    

}
