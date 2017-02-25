package com.qp.lms.quest.controller;



import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;

import com.qp.lms.quest.model.QuestSet;
import com.qp.lms.quest.model.QuestVO;
import com.qp.lms.quest.service.QuestManageService;

/**
 * 강좌별 설문지 통계
 * @author limsm
 *
 */
@Controller
public class QuestManageController {

	private static final Logger logger = LoggerFactory.getLogger(QuestController.class);

    @Autowired
    private QuestManageService svr;



    /**
     *  강좌별 설문지 통계 리스트
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/quest/questManageList")
    public String questManageList(@ModelAttribute QuestVO vo, Model model) throws Exception {
    	try {
    		QuestSet set = new QuestSet();
    		set.setCondiVO(vo);
    		
	    	set = svr.questManageList(set);
	    	
	        model.addAttribute("set", set );
    	} catch ( Exception e ) {
    		e.printStackTrace();
    	}

        return "/quest/QuestManageList";
    }

    /**
     * 강좌별 설문지 상세
     * @param vo
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/quest/questUserManageList")
    public String questUserManageList(@ModelAttribute QuestVO vo, Model model) throws Exception {
    	try {
    		QuestSet set = new QuestSet();
    		set.setCondiVO(vo);
    		
	    	set = svr.questUserManageList(set);
	    	
	        model.addAttribute("set", set );
    	} catch ( Exception e ) {
    		e.printStackTrace();
    	}

        return "/quest/QuestUserManageList";
    }

    /**
     * 강좌별 설문지 사용자 상세
     * @param vo
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/quest/questUserManageV")
    public String questUserManageV(@ModelAttribute QuestVO vo, Model model) throws Exception {
    	try {
    		QuestSet set = new QuestSet();
    		set.setCondiVO(vo);
    		
	    	set = svr.questUserManageV(set);
	    	
	        model.addAttribute("set", set );
    	} catch ( Exception e ) {
    		e.printStackTrace();
    	}

        return "/quest/QuestUserManageV";
    }

}
