package com.qp.lms.course.controller;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.qp.lms.common.CommUtil;
import com.qp.lms.course.model.CourseCodeSet;
import com.qp.lms.course.model.CourseCodeVO;
import com.qp.lms.course.service.CourseCodeService;

/**
 * 과정 코드 관리 
 * @author limsm
 *
 */

@Controller
public class CourseCodeController {

	 private static final Logger logger = LoggerFactory.getLogger(CourseCodeController.class);

	    @Autowired
	    private CourseCodeService svr;

	    /**
	     * 과정 코드 리스트
	     * @param vo
	     * @param model
	     * @return
	     * @throws Exception
	     */
	    @RequestMapping(value = "/courseCode/courseCodeList")
	    public String courseCodeList(@ModelAttribute CourseCodeVO vo, Model model) throws Exception {
	    	try { 
		    	CourseCodeSet set = new CourseCodeSet();
		    	set.setCondiVO(vo);
	
		    	set = svr.getCourseCode(set);
		    	
		        model.addAttribute("set", set );
	    	} catch ( Exception e ) {
	    		e.printStackTrace();
	    	}

	        return "/course/CourseCodeList";
	    }

	    /**
	     * 과정코드 생성 화면
	     * @param model
	     * @return
	     * @throws Exception
	     */
	    @RequestMapping(value = "/courseCode/courseCodeN")
	    public String courseCodeN(Model model) throws Exception {
	    	try {
		    	CourseCodeSet set = new CourseCodeSet();
		    	
		    	set = svr.courseCodeN(set);
		    	
		        model.addAttribute("set", set );
	    	} catch ( Exception e ) {
	    		e.printStackTrace();
	    	}

	        return "/course/CourseCodeN";
	    }

	    /**
	     * 과정코드 조회 화면
	     * @param vo
	     * @param model
	     * @return
	     * @throws Exception
	     */
	    @RequestMapping(value = "/courseCode/courseCodeV")
	    public String courseCodeV(@ModelAttribute CourseCodeVO vo, Model model) throws Exception {
	    	try {
		    	CourseCodeSet set = new CourseCodeSet();
		    	set.setCondiVO(vo);
		    	
		    	set = svr.courseCodeV(set);
		    	
		    	model.addAttribute("set", set );
	    	} catch ( Exception e ) {
	    		e.printStackTrace();
	    	}

	        return "/course/CourseCodeV";
	    }

	    /**
	     * 과정코드 수정 화면
	     * @param vo
	     * @param model
	     * @return
	     * @throws Exception
	     */
	    @RequestMapping(value = "/courseCode/courseCodeU")
	    public String courseCodeU(@ModelAttribute CourseCodeVO vo, Model model) throws Exception {
	    	try {
		    	CourseCodeSet set = new CourseCodeSet();
		    	set.setCondiVO(vo);
		    	
		    	set = svr.courseCodeU(set);
		    	
		    	model.addAttribute("set", set );
	    	} catch ( Exception e ) {
	    		e.printStackTrace();
	    	}

	        return "/course/CourseCodeU";
	    }

	    
	    
	    
	    
	    ///////////////////////////////////////////////// Transaction ////////////////////////////////////////////////////
	    /**
	     * 과정코드 생성
	     * @param vo
	     * @param model
	     * @return
	     * @throws Exception
	     */
	    @RequestMapping(value = "/courseCode/courseCodeNIns", method = RequestMethod.POST)
	    public String courseCodeNIns(@ModelAttribute CourseCodeVO vo, Model model) throws Exception {
	    	try {
		    	CourseCodeSet set = new CourseCodeSet();
		    	set.setCondiVO(vo);
		    	
		    	set = svr.courseCodeNIns(set);
		    	
		    	model.addAttribute("json", CommUtil.getJsonObject(set.getRtnMode(),""));
	    	} catch ( Exception e ) {
	    		e.printStackTrace();
	    	}

	        return "/common/json";
	    }

	    /**
	     * 과정코드 수정 
	     * @param vo
	     * @param model
	     * @return
	     * @throws Exception
	     */
	    @RequestMapping(value = "/courseCode/courseCodeUUpd", method = RequestMethod.POST)
	    public String courseCodeUUpd(@ModelAttribute CourseCodeVO vo, Model model) throws Exception {
	    	try {
		    	CourseCodeSet set = new CourseCodeSet();
		    	set.setCondiVO(vo);
		    	
		    	set = svr.courseCodeUUpd(set);
		    	
		    	model.addAttribute("json", CommUtil.getJsonObject(set.getRtnMode(),""));
	    	} catch ( Exception e ) {
	    		e.printStackTrace();
	    	}

	        return "/common/json";
	    }

	    /**
	     * 과정코드 삭제
	     * @param vo
	     * @param model
	     * @return
	     * @throws Exception
	     */
	    @RequestMapping(value = "/courseCode/courseCodeUDel", method = RequestMethod.POST)
	    public String delCourseCode(@ModelAttribute CourseCodeVO vo, Model model) throws Exception {
	    	try {
		    	CourseCodeSet set = new CourseCodeSet();
		    	set.setCondiVO(vo);
		    	
		    	set = svr.courseCodeUDel(set);
		    	
		    	model.addAttribute("json", CommUtil.getJsonObject(set.getRtnMode(),""));
	    	} catch ( Exception e ) {
	    		e.printStackTrace();
	    	}

	        return "/common/json";
	    }


	    
}
