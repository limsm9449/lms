package com.qp.lms.course.controller;



import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.qp.lms.course.model.CourseExamSet;
import com.qp.lms.course.model.CourseExamVO;
import com.qp.lms.course.service.CourseExamService;
import com.qp.lms.common.CommUtil;

/**
 * 과정 Exam 관리
 * @author limsm
 *
 */

@Controller
public class CourseExamController { 

	 private static final Logger logger = LoggerFactory.getLogger(CourseExamController.class);

	    @Autowired
	    private CourseExamService svr;

	    /**
	     * 과정 주차 리스트
	     * @param vo
	     * @param model
	     * @return
	     * @throws Exception
	     */
	    @RequestMapping(value = "/courseExam/courseExamList")
	    public String courseExamList(@ModelAttribute CourseExamVO vo, Model model) throws Exception {
	    	try {
		    	CourseExamSet set = new CourseExamSet();
		    	set.setCondiVO(vo);
		    	
		    	set = svr.courseExamList(set);
		    	
		        model.addAttribute("set", set );
	    	} catch ( Exception e ) {
	    		e.printStackTrace();
	    	}

	        return "/course/CourseExamList";
	    }

	    /**
	     * 과정 주차 입력 화면
	     * @param vo
	     * @param model
	     * @return
	     * @throws Exception
	     */
	    @RequestMapping(value = "/courseExam/courseExamN")
	    public String courseExamN(@ModelAttribute CourseExamVO vo, Model model) throws Exception {
	    	try {
		    	CourseExamSet set = new CourseExamSet();
		    	set.setCondiVO(vo);
		    	
		    	set = svr.courseExamN(set);
		    	
		        model.addAttribute("set", set );
	    	} catch ( Exception e ) {
	    		e.printStackTrace();
	    	}

	        return "/course/CourseExamN";
	    }

	    /**
	     * 과정 주차 조회 화면
	     * @param vo
	     * @param model
	     * @return
	     * @throws Exception
	     */
	    @RequestMapping(value = "/courseExam/courseExamV")
	    public String courseExamV(@ModelAttribute CourseExamVO vo, Model model) throws Exception {
	    	try {
		    	CourseExamSet set = new CourseExamSet();
		    	set.setCondiVO(vo);
		    	
		    	set = svr.courseExamV(set);
		    	
		        model.addAttribute("set", set );
	    	} catch ( Exception e ) {
	    		e.printStackTrace();
	    	}

	        return "/course/CourseExamV";
	    }

	    /**
	     * 과정 주차 수정 화면
	     * @param vo
	     * @param model
	     * @return
	     * @throws Exception
	     */
	    @RequestMapping(value = "/courseExam/courseExamU")
	    public String courseExamU(@ModelAttribute CourseExamVO vo, Model model) throws Exception {
	    	try {
		    	CourseExamSet set = new CourseExamSet();
		    	set.setCondiVO(vo);
		    	
		    	set = svr.courseExamU(set);
		    	
		        model.addAttribute("set", set );
	    	} catch ( Exception e ) {
	    		e.printStackTrace();
	    	}

	        return "/course/CourseExamU";
	    }

	    

	    
	    
	    ///////////////////////////////////////////////// Transaction ////////////////////////////////////////////////////
	    
	    /**
	     * 과정 주차 입력
	     * @param vo
	     * @param model
	     * @return
	     * @throws Exception
	     */
	    @RequestMapping(value = "/courseExam/courseExamNIns", method = RequestMethod.POST)
	    public String courseExamNIns(@ModelAttribute CourseExamVO vo, Model model) throws Exception {
	    	try {
		    	CourseExamSet set = new CourseExamSet();
		    	set.setCondiVO(vo);
		    	
		    	set = svr.courseExamNIns(set);
		    	
		    	model.addAttribute("json", CommUtil.getJsonObject(set.getRtnMode(),""));
	    	} catch ( Exception e ) {
	    		e.printStackTrace();
	    	}

	        return "/common/json";
	    }

	    /**
	     * 과정 주차 수정
	     * @param vo
	     * @param model
	     * @return
	     * @throws Exception
	     */
	    @RequestMapping(value = "/courseExam/courseExamUUpd", method = RequestMethod.POST)
	    public String courseExamUUpd(@ModelAttribute CourseExamVO vo, Model model) throws Exception {
	    	try {
		    	CourseExamSet set = new CourseExamSet();
		    	set.setCondiVO(vo);
		    	
		    	set = svr.courseExamUUpd(set);
	
		    	model.addAttribute("json", CommUtil.getJsonObject(set.getRtnMode(),""));
	    	} catch ( Exception e ) {
	    		e.printStackTrace();
	    	}

	        return "/common/json";
	    }


}
