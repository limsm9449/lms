package com.qp.lms.teacher.controller;



import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.qp.lms.common.CommUtil;
import com.qp.lms.course.service.CourseMasterService;
import com.qp.lms.evaluation.model.EvaluationSet;
import com.qp.lms.evaluation.model.EvaluationVO;
import com.qp.lms.evaluation.service.EvaluationService;
import com.qp.lms.teacher.model.TeacherSet;
import com.qp.lms.teacher.model.TeacherVO;
import com.qp.lms.teacher.service.TeacherService;

/*
 * Teacher를  위한 Controller
 */

@Controller
public class TeacherController {

	private static final Logger logger = LoggerFactory.getLogger(TeacherController.class);

    @Autowired
    private TeacherService svr;
    @Autowired
    private CourseMasterService courseMasterSvr;
    @Autowired
    private EvaluationService evaluationSvr;

    
    /*
     * 나의 담당 과정 리스트
     */
    @RequestMapping(value = "/teacher/myCourse")
    public String myCourse(@ModelAttribute TeacherVO vo,Model model) throws Exception {
    	try {
	    	TeacherSet set = new TeacherSet();
	    	set.setCondiVO(vo);
	    	
	    	set = svr.myCourse(set);
	    	
	        model.addAttribute("set", set );
    	} catch ( Exception e ) {
    		e.printStackTrace();
    	}

    	return "/teacher/MyCourse";
    }
    
    /*
     * 평가 리스트 데이타를 가져온다.
     */
    @RequestMapping(value = "/teacher/courseEval")
    public String courseEval(@ModelAttribute TeacherVO vo, Model model) throws Exception {
    	try {
	    	TeacherSet set = new TeacherSet();
	    	set.setCondiVO(vo);
	    	
	    	set = svr.courseEval(set);
	    	
	        model.addAttribute("set", set );
    	} catch ( Exception e ) {
    		e.printStackTrace();
    	}

        return "/teacher/CourseEval";
    }

    /*
     * 사용자별 평가 데이타를 가져온다.
     */
    @RequestMapping(value = "/teacher/courseEvalV")
    public String courseEvalV(@ModelAttribute EvaluationVO vo, Model model) throws Exception {
    	try {
	    	EvaluationSet set = new EvaluationSet();
	    	set.setCondiVO(vo);
	    	
	    	set = evaluationSvr.courseEvalV(set);
	    	
	        model.addAttribute("set", set );
    	} catch ( Exception e ) {
    		e.printStackTrace();
    	}

        return "/teacher/CourseEvalV";
    }
    
    /*
     * 사용자별 평가 데이타를 저장한다.
     */
    @RequestMapping(value = "/teacher/updCourseEvalForEval", method = RequestMethod.POST)
    public String updCourseEvalForEval(@ModelAttribute EvaluationVO vo, Model model) throws Exception {
    	try {
	    	TeacherSet set = new TeacherSet();
	    	set.setCourseEval(vo);
	    	
	    	set = svr.updCourseEvalForEval(set);
	    	
	        model.addAttribute("json", CommUtil.getJsonObject(set.getRtnMode(),""));
    	} catch ( Exception e ) {
    		e.printStackTrace();
    	}

        return "/common/json";
    }

    /*
     * 사용자별 평가 완료처리를 한다.
     */
    @RequestMapping(value = "/teacher/evalCompleteUpd", method = RequestMethod.POST)
    public String evalCompleteUpd(@ModelAttribute TeacherVO vo, Model model) throws Exception {
    	try {
	    	TeacherSet set = new TeacherSet();
	    	set.setCondiVO(vo);
	    	
	    	set = svr.evalCompleteUpd(set);
	    	
	        model.addAttribute("json", CommUtil.getJsonObject(set.getRtnMode(),""));
    	} catch ( Exception e ) {
    		e.printStackTrace();
    	}

        return "/common/json";
    }
    
}
