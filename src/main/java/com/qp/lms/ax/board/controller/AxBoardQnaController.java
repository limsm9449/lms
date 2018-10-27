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

import com.qp.lms.ax.board.service.AxBoardQnaService;
import com.qp.lms.common.Constant;

@Controller
public class AxBoardQnaController {

	private static final Logger logger = LoggerFactory.getLogger(AxBoardQnaController.class);

    @Autowired
    private AxBoardQnaService svr;

    @RequestMapping(value = "/board/axBoardQnaList", method = RequestMethod.POST, consumes = "application/json" )
    public @ResponseBody HashMap<String,Object> axBoardQnaList(@RequestBody HashMap<String, Object> paramMap, HttpServletRequest request, HttpServletResponse response) throws Exception {
    	HashMap<String, Object> hm = new HashMap<String, Object>();

    	try {
    		hm = svr.axBoardQnaList(paramMap);
    	} catch ( Exception e ) {
    		e.printStackTrace();
    	}

        return hm;
    }

    @RequestMapping(value = "/board/axBoardQnaOne", method = RequestMethod.POST, consumes = "application/json" )
    public @ResponseBody HashMap<String,Object> axBoardReporOne(@RequestBody HashMap<String, Object> paramMap, HttpServletRequest request, HttpServletResponse response) throws Exception {
    	HashMap<String, Object> hm = new HashMap<String, Object>();

    	try {
    		hm = svr.axBoardQnaOne(paramMap);
    	} catch ( Exception e ) {
    		e.printStackTrace();
    	}

        return hm;
    }

    @RequestMapping(value = "/board/axBoardQnaSave", method = RequestMethod.POST, consumes = "application/json" )
    public @ResponseBody HashMap<String,Object> axBoardQnaSave(@RequestBody HashMap<String, Object> paramMap, HttpServletRequest request, HttpServletResponse response) throws Exception {
    	HashMap<String, Object> hm = new HashMap<String, Object>();
    	
		try {
    		hm = svr.axBoardQnaSave(paramMap);
    	} catch ( Exception e ) {
    		e.printStackTrace();
    		hm.put("RtnMode", Constant.mode.ERROR.name());
    	}

        return hm;
    }

    @RequestMapping(value = "/board/axBoardQnaAnswerSave", method = RequestMethod.POST, consumes = "application/json" )
    public @ResponseBody HashMap<String,Object> axBoardQnaAnswerSave(@RequestBody HashMap<String, Object> paramMap, HttpServletRequest request, HttpServletResponse response) throws Exception {
    	HashMap<String, Object> hm = new HashMap<String, Object>();
    	
		try {
    		hm = svr.axBoardQnaAnswerSave(paramMap);
    	} catch ( Exception e ) {
    		e.printStackTrace();
    		hm.put("RtnMode", Constant.mode.ERROR.name());
    	}

        return hm;
    }

	    
	    

}
