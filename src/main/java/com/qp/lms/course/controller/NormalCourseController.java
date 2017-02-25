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
import com.qp.lms.course.model.NormalCourseSet;
import com.qp.lms.course.model.NormalCourseVO;
import com.qp.lms.course.service.NormalCourseService;

/**
 * 일반 강좌 관리
 * @author limsm
 *
 */
@Controller
public class NormalCourseController {

	private static final Logger logger = LoggerFactory.getLogger(NormalCourseController.class);

    @Autowired
    private NormalCourseService svr;

    /**
     * 강좌 리스트 화면
     * @param vo
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/normalCourse/normalCourseList")
    public String normalCourseList(@ModelAttribute NormalCourseVO vo, Model model) throws Exception {
    	try {
	    	NormalCourseSet set = new NormalCourseSet();
	    	set.setCondiVO(vo);
	
	    	set = svr.normalCourseList(set);
	    	
	        model.addAttribute("set", set );
    	} catch ( Exception e ) {
    		e.printStackTrace();
    	}

        return "/course/NormalCourseList";
    }
 
    /**
     * 강좌 등록 화면
     * @param vo
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/normalCourse/normalCourseN")
    public String normalCourseN(@ModelAttribute NormalCourseVO vo, Model model) throws Exception {
    	try {
	    	NormalCourseSet set = new NormalCourseSet();
	    	set.setCondiVO(vo);
	    	
	    	set = svr.normalCourseN(set);
	    	
	        model.addAttribute("set", set );
    	} catch ( Exception e ) {
    		e.printStackTrace();
    	}

        return "/course/NormalCourseN";
    }

    /**
     * 강좌 조회 화면
     * @param vo
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/normalCourse/normalCourseV")
    public String normalCourseV(@ModelAttribute NormalCourseVO vo, Model model) throws Exception {
    	try {
	    	NormalCourseSet set = new NormalCourseSet();
	    	set.setCondiVO(vo);
	    	
	    	set = svr.normalCourseV(set);
	    	
	        model.addAttribute("set", set );
    	} catch ( Exception e ) {
    		e.printStackTrace();
    	}

        return "/course/NormalCourseV";
    }
    
    /**
     * 강좌 조회 팝업 화면
     * @param vo
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/normalCourse/normalCoursePV")
    public String normalCoursePV(@ModelAttribute NormalCourseVO vo, Model model) throws Exception {
    	try {
	    	NormalCourseSet set = new NormalCourseSet();
	    	set.setCondiVO(vo);
	    	
	    	set = svr.normalCourseV(set);
	    	
	        model.addAttribute("set", set );
    	} catch ( Exception e ) {
    		e.printStackTrace();
    	}

        return "/course/NormalCoursePV";
    }

    /**
     * 강좌 수정 화면
     * @param vo
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/normalCourse/normalCourseU")
    public String normalCourseU(@ModelAttribute NormalCourseVO vo, Model model) throws Exception {
    	try {
    		NormalCourseSet set = new NormalCourseSet();
	    	set.setCondiVO(vo);
	    	
	    	set = svr.normalCourseU(set);
	    	
	        model.addAttribute("set", set );
    	} catch ( Exception e ) {
    		e.printStackTrace();
    	}

        return "/course/NormalCourseU";
    }

    
    
    ///////////////////////////////////////////////// Transaction ////////////////////////////////////////////////////
    /**
     * 과정 Master 생성
     * @param vo
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/normalCourse/normalCourseNIns", method = RequestMethod.POST)
    public String normalCourseNIns(@ModelAttribute NormalCourseVO vo, Model model) throws Exception {
    	try {
    		NormalCourseSet set = new NormalCourseSet();
	    	set.setCondiVO(vo);
	    	
	    	set = svr.normalCourseNIns(set);
	    	
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
    @RequestMapping(value = "/normalCourse/normalCourseUUpd", method = RequestMethod.POST)
    public String normalCourseUUpd(@ModelAttribute NormalCourseVO vo, Model model) throws Exception {
    	try {
	    	NormalCourseSet set = new NormalCourseSet();
	    	set.setCondiVO(vo);
	    	
	    	set = svr.normalCourseUUpd(set);
	    	
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
    @RequestMapping(value = "/normalCourse/normalCourseDel", method = RequestMethod.POST)
    public String normalCourseDel(@ModelAttribute NormalCourseVO vo, Model model) throws Exception {
    	try {
    		NormalCourseSet set = new NormalCourseSet();
	    	set.setCondiVO(vo);
	    	
	    	set = svr.normalCourseDel(set);
	    	
	    	model.addAttribute("json", CommUtil.getJsonObject(set.getRtnMode(),""));
    	} catch ( Exception e ) {
    		e.printStackTrace();
    	}

        return "/common/json";
    }

    /**
     * 인기 강좌 리스트 화면
     * @param vo
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/normalCourse/popularCourseList")
    public String popularCourseList(@ModelAttribute NormalCourseVO vo, Model model) throws Exception {
    	try {
	    	NormalCourseSet set = new NormalCourseSet();
	    	set.setCondiVO(vo);
	
	    	set = svr.popularCourseList(set);
	    	
	        model.addAttribute("set", set );
    	} catch ( Exception e ) {
    		e.printStackTrace();
    	}

        return "/course/PopularCourseList";
    }
    
    /**
     * 인기 강좌 등록
     * @param vo
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/normalCourse/popularCourseAdd", method = RequestMethod.POST)
    public String popularCourseAdd(@ModelAttribute NormalCourseVO vo, Model model) throws Exception {
    	try {
    		NormalCourseSet set = new NormalCourseSet();
	    	set.setCondiVO(vo);
	    	
	    	set = svr.popularCourseAdd(set);
	    	
	    	model.addAttribute("json", CommUtil.getJsonObject(set.getRtnMode(),""));
    	} catch ( Exception e ) {
    		e.printStackTrace();
    	}

        return "/common/json";
    }
    
    /**
     * 인기 강좌 해제
     * @param vo
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/normalCourse/popularCourseRemove", method = RequestMethod.POST)
    public String popularCourseRemove(@ModelAttribute NormalCourseVO vo, Model model) throws Exception {
    	try {
    		NormalCourseSet set = new NormalCourseSet();
	    	set.setCondiVO(vo);
	    	
	    	set = svr.popularCourseRemove(set);
	    	
	    	model.addAttribute("json", CommUtil.getJsonObject(set.getRtnMode(),""));
    	} catch ( Exception e ) {
    		e.printStackTrace();
    	}

        return "/common/json";
    }
    
    
}
