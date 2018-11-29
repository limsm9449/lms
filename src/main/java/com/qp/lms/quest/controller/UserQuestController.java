package com.qp.lms.quest.controller;



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
import com.qp.lms.quest.service.UserQuestService;

@Controller
public class UserQuestController {

	private static final Logger logger = LoggerFactory.getLogger(UserQuestController.class);

    @Autowired
    private UserQuestService svr;

    @RequestMapping(value = "/quest/userQuest")
    public String userQuest(@ModelAttribute QuestVO vo, Model model) throws Exception {
    	try {
    		QuestSet set = new QuestSet();
    		set.setCondiVO(vo);
    		
	    	set = svr.userQuest(set);
	    	
	        model.addAttribute("set", set );
    	} catch ( Exception e ) {
    		e.printStackTrace();
    	}

        return "/quest/UserQuest";
    }

    @RequestMapping(value = "/quest/userQuestIns", method = RequestMethod.POST)
    public String userQuestIns(@ModelAttribute QuestVO vo, Model model) throws Exception {
    	try {
    		QuestSet set = new QuestSet();
	    	set.setCondiVO(vo);
	    	
	    	set = svr.userQuestIns(set);
	    	
	    	model.addAttribute("json", CommUtil.getJsonObject(set.getRtnMode(),""));
    	} catch ( Exception e ) {
    		e.printStackTrace();
    	}

        return "/common/json";
    }
    
    @RequestMapping(value = "/quest/userQuestResult")
    public String userQuestResult(@ModelAttribute QuestVO vo, Model model) throws Exception {
    	try {
    		QuestSet set = new QuestSet();
    		set.setCondiVO(vo);
    		
	    	set = svr.userQuestResult(set);
	    	
	        model.addAttribute("set", set );
    	} catch ( Exception e ) {
    		e.printStackTrace();
    	}

        return "/quest/UserQuestResult";
    }
    
    
}
