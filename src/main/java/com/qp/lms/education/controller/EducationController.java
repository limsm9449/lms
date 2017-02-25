package com.qp.lms.education.controller;



import net.sf.json.JSONObject;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.qp.lms.common.CommUtil;
import com.qp.lms.education.model.EducationSet;
import com.qp.lms.education.model.EducationVO;
import com.qp.lms.education.service.EducationService;
import com.qp.lms.evaluation.model.EvaluationSet;
import com.qp.lms.evaluation.model.EvaluationVO;

/**
 * 교육관리를 위한 Controller
 * @author limsm
 *
 */

@Controller
public class EducationController {

	private static final Logger logger = LoggerFactory.getLogger(EducationController.class);

    @Autowired
    private EducationService svr;

    /**
     * 교육 팝업 Home
     * @param vo
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/education/eduHome")
    public String eduHome(@ModelAttribute EducationVO vo, Model model) throws Exception {
    	try {
	    	EducationSet set = new EducationSet();
	    	set.setCondiVO(vo);
	    	
	    	set = svr.eduHome(set);
	
	    	model.addAttribute("set", set );
    	} catch ( Exception e ) {
    		e.printStackTrace();
    	}

        return "/education/Home";
    }

    /*
     * 점수...
     */
    @RequestMapping(value = "/education/progress")
    public String progress(@ModelAttribute EducationVO vo, Model model) throws Exception {
    	try {
	    	EducationSet set = new EducationSet();
	    	set.setCondiVO(vo);
	    	
	    	set = svr.progress(set);
	    	
	        model.addAttribute("set", set);
    	} catch ( Exception e ) {
    		e.printStackTrace();
    	}

        return "/education/Progress";
    }
    
    /*
     * 점수...
     */
    @RequestMapping(value = "/education/userProgress")
    public String userProgress(@ModelAttribute EducationVO vo, Model model) throws Exception {
    	try {
	    	EducationSet set = new EducationSet();
	    	set.setCondiVO(vo);
	    	
	    	set = svr.progress(set);
	    	
	        model.addAttribute("set", set);
    	} catch ( Exception e ) {
    		e.printStackTrace();
    	}

        return "/education/UserProgress";
    }
    
    /*
     * 이전 페이지 시작 및 점수 평가....
     */
    @RequestMapping(value = "/education/updPrevPage", method = RequestMethod.POST)
    public String updPrevPage(@ModelAttribute EvaluationVO vo, Model model) throws Exception {
    	try {
	    	EvaluationSet set = new EvaluationSet();
	    	set.setCondiVO(vo);
	    	
	    	set = svr.updPrevPage(set);
	    	
	    	model.addAttribute("json", CommUtil.getJsonObject(set.getRtnMode(),""));
    	} catch ( Exception e ) {
    		e.printStackTrace();
    	}

        return "common/json";
    }

    /*
     * 현재 페이지 시작 및 점수 평가....
     */
    @RequestMapping(value = "/education/updPage", method = RequestMethod.POST)
    public String updPage(@ModelAttribute EvaluationVO vo, Model model) throws Exception {
    	try {
	    	EvaluationSet set = new EvaluationSet();
	    	set.setCondiVO(vo);
	    	
	    	set = svr.updPage(set);
	    	
	    	model.addAttribute("json", CommUtil.getJsonObject(set.getRtnMode(),""));
    	} catch ( Exception e ) {
    		e.printStackTrace();
    	}

        return "common/json";
    }

    /**
     * 교육 팝업 Home ( 관리자 조회용 )
     * @param vo
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/education/viewHome")
    public String viewHome(@ModelAttribute EducationVO vo, Model model) throws Exception {
    	try {
	    	EducationSet set = new EducationSet();
	    	set.setCondiVO(vo);
	    	
	    	set = svr.eduSampleHome(set);
	
	    	model.addAttribute("set", set );
    	} catch ( Exception e ) {
    		e.printStackTrace();
    	}

        return "/education/ViewHome";
    }
 
    /**
     * 컨텐츠 팝업 Home
     * @param vo
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/education/contentsHome")
    public String contentsHome(@ModelAttribute EducationVO vo, Model model) throws Exception {
    	try {
	    	EducationSet set = new EducationSet();
	    	set.setCondiVO(vo);
	    	
	    	set = svr.contentsHome(set);
	
	    	model.addAttribute("set", set );
    	} catch ( Exception e ) {
    		e.printStackTrace();
    	}

        return "/education/ContentsHome";
    }
  

    
}
