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
import com.qp.lms.quest.service.QuestGroupService;

/**
 * 설문지 그룹 관리
 * @author limsm
 *
 */
@Controller
public class QuestGroupController {

	private static final Logger logger = LoggerFactory.getLogger(QuestController.class);

    @Autowired
    private QuestGroupService svr;


    /**
     * 설문지 그룹 리스트
     * @param vo
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/quest/questGroupList")
    public String questGroupList(@ModelAttribute QuestVO vo,Model model) throws Exception {
    	try {
    		QuestSet set = new QuestSet();
	    	set.setCondiVO(vo);
	    	
	    	set = svr.questGroupList(set);
	    	
	        model.addAttribute("set", set );
    	} catch ( Exception e ) {
    		e.printStackTrace();
    	}

    	return "/quest/QuestGroupList";
    }

    /**
     *  설문지 그룹 생성 화면
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/quest/questGroupN")
    public String questGroupN(Model model) throws Exception {
    	try {
    		QuestSet set = new QuestSet();
	    	
	    	set = svr.questGroupN(set);
	    	
	        model.addAttribute("set", set );
    	} catch ( Exception e ) {
    		e.printStackTrace();
    	}

        return "/quest/QuestGroupN";
    }

    /**
     * 설문지 그룹 조회 화면
     * @param vo
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/quest/questGroupV")
    public String questGroupV(@ModelAttribute QuestVO vo, Model model) throws Exception {
    	try {
    		QuestSet set = new QuestSet();
	    	set.setCondiVO(vo);
	    	
	    	set = svr.questGroupV(set);
	    	
	    	model.addAttribute("set", set );
    	} catch ( Exception e ) {
    		e.printStackTrace();
    	}

        return "/quest/QuestGroupV";
    }

    /**
     * 설문지 그룹 수정 화면
     * @param vo
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/quest/questGroupU")
    public String questGroupU(@ModelAttribute QuestVO vo, Model model) throws Exception {
    	try {
    		QuestSet set = new QuestSet();
	    	set.setCondiVO(vo);
	    	
	    	set = svr.questGroupU(set);
	    	
	    	model.addAttribute("set", set );
    	} catch ( Exception e ) {
    		e.printStackTrace();
    	}

        return "/quest/QuestGroupU";
    }
    
    
    ///////////////////////////////////////////////// Transaction ////////////////////////////////////////////////////
    /**
     * 설문지 그룹 생성
     * @param vo
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/quest/questGroupIns", method = RequestMethod.POST)
    public String questGroupIns(@ModelAttribute QuestVO vo, Model model) throws Exception {
    	try {
    		QuestSet set = new QuestSet();
	    	set.setCondiVO(vo);
	    	
	    	set = svr.questGroupIns(set);
	    	
	    	model.addAttribute("json", CommUtil.getJsonObject(set.getRtnMode(),""));
    	} catch ( Exception e ) {
    		e.printStackTrace();
    	}

        return "/common/json";
    }

    /**
     * 설문지 그룹 수정 
     * @param vo
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/quest/questGroupUpd", method = RequestMethod.POST)
    public String questGroupUpd(@ModelAttribute QuestVO vo, Model model) throws Exception {
    	try {
    		QuestSet set = new QuestSet();
	    	set.setCondiVO(vo);
	    	
	    	set = svr.questGroupUpd(set);
	    	
	    	model.addAttribute("json", CommUtil.getJsonObject(set.getRtnMode(),""));
    	} catch ( Exception e ) {
    		e.printStackTrace();
    	}

        return "/common/json";
    }

    /**
     * 설문지 그룹 삭제
     * @param vo
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/quest/questGroupDel", method = RequestMethod.POST)
    public String questGroupDel(@ModelAttribute QuestVO vo, Model model) throws Exception {
    	try {
    		QuestSet set = new QuestSet();
	    	set.setCondiVO(vo);
	    	
	    	set = svr.questGroupDel(set);
	    	
	    	model.addAttribute("json", CommUtil.getJsonObject(set.getRtnMode(),""));
    	} catch ( Exception e ) {
    		e.printStackTrace();
    	}

        return "/common/json";
    }

    
}
