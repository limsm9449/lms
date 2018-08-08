package com.qp.lms.quest.controller;



import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.qp.lms.common.CommUtil;
import com.qp.lms.common.Constant;
import com.qp.lms.course.model.CourseCodeSet;
import com.qp.lms.course.model.CourseCodeVO;
import com.qp.lms.quest.model.QuestSet;
import com.qp.lms.quest.model.QuestVO;
import com.qp.lms.quest.service.QuestService;

/**
 * 설문지 관리
 * @author limsm
 *
 */
@Controller
public class QuestController {

	private static final Logger logger = LoggerFactory.getLogger(QuestController.class);

    @Autowired
    private QuestService svr;

    
    
    
    
    /**
     * 설문지 리스트
     * @param vo
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/quest/questList")
    public String questList(@ModelAttribute QuestVO vo,Model model) throws Exception {
    	try {
    		QuestSet set = new QuestSet();
	    	set.setCondiVO(vo);
	    	
	    	set = svr.questList(set);
	    	
	        model.addAttribute("set", set );
    	} catch ( Exception e ) {
    		e.printStackTrace();
    	}

    	return "/quest/QuestList";
    }

    /**
     *  설문지 생성 화면
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/quest/questN")
    public String questN(Model model) throws Exception {
    	try {
    		QuestSet set = new QuestSet();
	    	
	    	set = svr.questN(set);
	    	
	        model.addAttribute("set", set );
    	} catch ( Exception e ) {
    		e.printStackTrace();
    	}

        return "/quest/QuestN";
    }

    /**
     * 설문지 조회 화면
     * @param vo
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/quest/questV")
    public String questV(@ModelAttribute QuestVO vo, Model model) throws Exception {
    	try {
    		QuestSet set = new QuestSet();
	    	set.setCondiVO(vo);
	    	
	    	set = svr.questV(set);
	    	
	    	model.addAttribute("set", set );
    	} catch ( Exception e ) {
    		e.printStackTrace();
    	}

        return "/quest/QuestV";
    }

    /**
     * 설문지 수정 화면
     * @param vo
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/quest/questU")
    public String questU(@ModelAttribute QuestVO vo, Model model) throws Exception {
    	try {
    		QuestSet set = new QuestSet();
	    	set.setCondiVO(vo);
	    	
	    	set = svr.questU(set);
	    	
	    	model.addAttribute("set", set );
    	} catch ( Exception e ) {
    		e.printStackTrace();
    	}

        return "/quest/QuestU";
    }
    
    
    ///////////////////////////////////////////////// Transaction ////////////////////////////////////////////////////
    /**
     * 설문지 그룹 생성
     * @param vo
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/quest/questIns", method = RequestMethod.POST)
    public String questIns(@ModelAttribute QuestVO vo, Model model) throws Exception {
    	try {
    		QuestSet set = new QuestSet();
	    	set.setCondiVO(vo);
	    	
	    	set = svr.questIns(set);
	    	
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
    @RequestMapping(value = "/quest/questUpd", method = RequestMethod.POST)
    public String questUpd(@ModelAttribute QuestVO vo, Model model) throws Exception {
    	try {
    		QuestSet set = new QuestSet();
	    	set.setCondiVO(vo);
	    	
	    	set = svr.questUpd(set);
	    	
	    	model.addAttribute("json", CommUtil.getJsonObject(set.getRtnMode(),""));
    	} catch ( Exception e ) {
    		e.printStackTrace();
    	}

        return "/common/json";
    }

    
}
