package com.qp.lms.company.controller;



import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.qp.lms.common.CommUtil;
import com.qp.lms.company.model.CompanyCourseSet;
import com.qp.lms.company.model.CompanyCourseVO;
import com.qp.lms.company.service.CompanyCourseService;

/**
 * 기업 강좌 관리
 * @author limsm
 *
 */
@Controller
public class CompanyCourseController {

	private static final Logger logger = LoggerFactory.getLogger(CompanyCourseController.class);

    @Autowired
    private CompanyCourseService svr;

    /**
     * 강좌 리스트 화면
     * @param vo
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/companyCourse/companyCourseList")
    public String courseList(@ModelAttribute CompanyCourseVO vo, Model model) throws Exception {
    	try {
    		CompanyCourseSet set = new CompanyCourseSet();
	    	set.setCondiVO(vo);
	
	    	set = svr.courseList(set);
	    	
	        model.addAttribute("set", set );
    	} catch ( Exception e ) {
    		e.printStackTrace();
    	}

        return "/company/CompanyCourseList";
    }
 
    /**
     * 강좌 등록 화면
     * @param vo
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/companyCourse/companyCourseN")
    public String courseN(@ModelAttribute CompanyCourseVO vo, Model model) throws Exception {
    	try {
    		CompanyCourseSet set = new CompanyCourseSet();
	    	set.setCondiVO(vo);
	    	
	    	set = svr.courseN(set);
	    	
	        model.addAttribute("set", set );
    	} catch ( Exception e ) {
    		e.printStackTrace();
    	}

        return "/company/CompanyCourseN";
    }

    /**
     * 강좌 조회 화면
     * @param vo
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/companyCourse/companyCourseV")
    public String courseV(@ModelAttribute CompanyCourseVO vo, Model model) throws Exception {
    	try {
    		CompanyCourseSet set = new CompanyCourseSet();
	    	set.setCondiVO(vo);
	    	
	    	set = svr.courseV(set);
	    	
	        model.addAttribute("set", set );
    	} catch ( Exception e ) {
    		e.printStackTrace();
    	}

        return "/company/CompanyCourseV";
    }
    
    /**
     * 강좌 수정 화면
     * @param vo
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/companyCourse/companyCourseU")
    public String courseU(@ModelAttribute CompanyCourseVO vo, Model model) throws Exception {
    	try {
    		CompanyCourseSet set = new CompanyCourseSet();
	    	set.setCondiVO(vo);
	    	
	    	set = svr.courseU(set);
	    	
	        model.addAttribute("set", set );
    	} catch ( Exception e ) {
    		e.printStackTrace();
    	}

        return "/company/CompanyCourseU";
    }

    
    
    ///////////////////////////////////////////////// Transaction ////////////////////////////////////////////////////
    /**
     * 과정 Master 생성
     * @param vo
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/companyCourse/companyCourseNIns", method = RequestMethod.POST)
    public String courseNIns(@ModelAttribute CompanyCourseVO vo, Model model) throws Exception {
    	try {
    		CompanyCourseSet set = new CompanyCourseSet();
	    	set.setCondiVO(vo);
	    	
	    	set = svr.courseNIns(set);
	    	
	    	model.addAttribute("json", CommUtil.getJsonObject(set.getRtnMode(),""));
    	} catch ( Exception e ) {
    		e.printStackTrace();
    	}
    	
        return "/common/json";
    }

    
    /**
     * 강좌 수정
     * @param vo
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/companyCourse/companyCourseUUpd", method = RequestMethod.POST)
    public String courseUUpd(@ModelAttribute CompanyCourseVO vo, Model model) throws Exception {
    	try {
    		CompanyCourseSet set = new CompanyCourseSet();
	    	set.setCondiVO(vo);
	    	
	    	set = svr.courseUUpd(set);
	    	
	    	model.addAttribute("json", CommUtil.getJsonObject(set.getRtnMode(),""));
    	} catch ( Exception e ) {
    		e.printStackTrace();
    	}

    	return "/common/json";
    }
    
    /**
     * 과정 Master 삭제
     * @param vo
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/companyCourse/companyCourseDel", method = RequestMethod.POST)
    public String courseDel(@ModelAttribute CompanyCourseVO vo, Model model) throws Exception {
    	try {
    		CompanyCourseSet set = new CompanyCourseSet();
	    	set.setCondiVO(vo);
	    	
	    	set = svr.courseDel(set);
	    	
	    	model.addAttribute("json", CommUtil.getJsonObject(set.getRtnMode(),""));
    	} catch ( Exception e ) {
    		e.printStackTrace();
    	}

        return "/common/json";
    }

}
