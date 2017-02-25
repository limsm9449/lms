package com.qp.lms.evaluation.controller;



import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;

import com.qp.lms.evaluation.model.EvaluationSet;
import com.qp.lms.evaluation.model.EvaluationVO;
import com.qp.lms.evaluation.service.EvaluationService;

@Controller
public class EvaluationController {

	private static final Logger logger = LoggerFactory.getLogger(EvaluationController.class);

    @Autowired
    private EvaluationService svr;

    /**
     * 과정 리스트 데이타를 가져온다.
     * @param vo
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/evaluation/courseList")
    public String courseList(@ModelAttribute EvaluationVO vo, Model model) throws Exception {
    	try {
	    	EvaluationSet set = new EvaluationSet();
	    	set.setCondiVO(vo);
	    	
	    	set = svr.courseList(set);
	    	
	        model.addAttribute("set", set );
    	} catch ( Exception e ) {
    		e.printStackTrace();
    	}
    	
        return "/evaluation/CourseList";
    }

    /**
     * 평가 리스트 데이타를 가져온다.
     * @param vo
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/evaluation/courseEvalList")
    public String courseEvalList(@ModelAttribute EvaluationVO vo, Model model) throws Exception {
    	try {
	    	EvaluationSet set = new EvaluationSet();
	    	set.setCondiVO(vo);
	    	
	    	set = svr.courseEvalList(set);
	    	
	        model.addAttribute("set", set );
    	} catch ( Exception e ) {
    		e.printStackTrace();
    	}
    	
        return "/evaluation/CourseEvalList";
    }

    /**
     * 사용자별 평가 데이타를 가져온다.
     * @param vo
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/evaluation/courseEvalV")
    public String courseEvalV(@ModelAttribute EvaluationVO vo, Model model) throws Exception {
    	try {
	    	EvaluationSet set = new EvaluationSet();
	    	set.setCondiVO(vo);
	    	
	    	set = svr.courseEvalV(set);
	    	
	        model.addAttribute("set", set );
    	} catch ( Exception e ) {
    		e.printStackTrace();
    	}
    	
        return "/evaluation/CourseEvalV";
    }

}
