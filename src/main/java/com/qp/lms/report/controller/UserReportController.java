package com.qp.lms.report.controller;



import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.qp.lms.common.CommUtil;
import com.qp.lms.quest.model.QuestSet;
import com.qp.lms.quest.model.QuestVO;
import com.qp.lms.report.model.ReportSet;
import com.qp.lms.report.model.ReportVO;
import com.qp.lms.report.service.UserReportService;

@Controller
public class UserReportController {

	private static final Logger logger = LoggerFactory.getLogger(UserReportController.class);

    @Autowired
    private UserReportService svr;

    @RequestMapping(value = "/report/userReport")
    public String userReport(@ModelAttribute ReportVO vo, Model model) throws Exception {
    	try {
    		ReportSet set = new ReportSet();
    		set.setCondiVO(vo);
    		
	    	set = svr.userReport(set);
	    	
	        model.addAttribute("set", set );
    	} catch ( Exception e ) {
    		e.printStackTrace();
    	}

        return "/report/UserReport";
    }
    
    @RequestMapping(value = "/report/userReportResult")
    public String userReportResult(@ModelAttribute ReportVO vo, Model model) throws Exception {
    	try {
    		ReportSet set = new ReportSet();
    		set.setCondiVO(vo);
    		
	    	set = svr.userReportResult(set);
	    	
	        model.addAttribute("set", set );
    	} catch ( Exception e ) {
    		e.printStackTrace();
    	}

        return "/report/UserReportResult";
    }
    
    @RequestMapping(value = "/report/userReportScore")
    public String userReportScore(@ModelAttribute ReportVO vo, Model model) throws Exception {
    	try {
    		ReportSet set = new ReportSet();
    		set.setCondiVO(vo);
    		
	    	set = svr.userReportScore(set);
	    	
	        model.addAttribute("set", set );
    	} catch ( Exception e ) {
    		e.printStackTrace();
    	}

        return "/report/UserReportScore";
    }
    
    @RequestMapping(value = "/report/userReportIns", method = RequestMethod.POST)
    public String userQuestIns(@ModelAttribute ReportVO vo, Model model) throws Exception {
    	try {
    		ReportSet set = new ReportSet();
	    	set.setCondiVO(vo);
	    	
	    	set = svr.userReportIns(set);
	    	
	    	model.addAttribute("json", CommUtil.getJsonObject(set.getRtnMode(),""));
    	} catch ( Exception e ) {
    		e.printStackTrace();
    	}

        return "/common/json";
    }

    
    @RequestMapping(value = "/report/userReportScoreSave", method = RequestMethod.POST)
    public String userReportScoreSave(@ModelAttribute ReportVO vo, Model model) throws Exception {
    	try {
    		ReportSet set = new ReportSet();
	    	set.setCondiVO(vo);
	    	
	    	set = svr.userReportScoreSave(set);
	    	
	    	model.addAttribute("json", CommUtil.getJsonObject(set.getRtnMode(),""));
    	} catch ( Exception e ) {
    		e.printStackTrace();
    	}

        return "/common/json";
    }
}
