package com.qp.lms.system.controller;



import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;

import com.qp.lms.system.model.SystemSet;
import com.qp.lms.system.model.SystemVO;
import com.qp.lms.system.service.SystemService;

@Controller
public class SystemController {

	 private static final Logger logger = LoggerFactory.getLogger(SystemController.class);

	    @Autowired
	    private SystemService svr;
	    
	    /**
	     * Log 리스트
	     * @param vo
	     * @param model
	     * @return
	     * @throws Exception
	     */
	    @RequestMapping(value = "/system/logList")
	    public String logList(@ModelAttribute SystemVO vo, Model model) throws Exception {
	    	try {
		    	SystemSet set = new SystemSet();
		    	set.setCondiVO(vo);
		    	
		    	set = svr.logList(set);
		    	
		    	model.addAttribute("set", set );
	    	} catch ( Exception e ) {
	    		e.printStackTrace();
	    	}

	        return "/system/LogList";
	    }


}
