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

/**
 * 사용자 설문지
 * @author limsm
 *
 */
@Controller
public class UserQuestController {

	private static final Logger logger = LoggerFactory.getLogger(QuestController.class);

    @Autowired
    private UserQuestService svr;



    /**
     *  설문지 입력 화면
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/quest/userQuestN")
    public String userQuestN(@ModelAttribute QuestVO vo, Model model) throws Exception {
    	try {
    		QuestSet set = new QuestSet();
    		set.setCondiVO(vo);
    		
	    	set = svr.userQuestN(set);
	    	
	        model.addAttribute("set", set );
    	} catch ( Exception e ) {
    		e.printStackTrace();
    	}

        return "/quest/UserQuestN";
    }

    ///////////////////////////////////////////////// Transaction ////////////////////////////////////////////////////
    /**
     * 사용자 설문지 저장
     * @param vo
     * @param model
     * @return
     * @throws Exception
     */
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
    
    
}
