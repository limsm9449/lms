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
import com.qp.lms.course.model.CourseManageSet;
import com.qp.lms.course.model.CourseManageVO;
import com.qp.lms.course.model.CourseMasterVO;
import com.qp.lms.course.service.CourseManageService;

/**
 * 기간이 있는 강좌 관리 -- 나중에 로직 변경 필요
 * @author limsm
 *
 */
@Controller
public class CourseManageController {

	private static final Logger logger = LoggerFactory.getLogger(CourseManageController.class);

    @Autowired
    private CourseManageService svr;

    /**
     * 강좌 리스트 화면
     * @param vo
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/courseManage/courseManageList")
    public String courseManageList(@ModelAttribute CourseManageVO vo, Model model) throws Exception {
    	try {
	    	CourseManageSet set = new CourseManageSet();
	    	set.setCondiVO(vo);
	
	    	set = svr.courseManageList(set);
	    	
	        model.addAttribute("set", set );
    	} catch ( Exception e ) {
    		e.printStackTrace();
    	}

        return "/course/CourseManageList";
    }
 
    /**
     * 강좌 등록 화면
     * @param vo
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/courseManage/courseManageN")
    public String courseManageN(@ModelAttribute CourseManageVO vo, Model model) throws Exception {
    	try {
	    	CourseManageSet set = new CourseManageSet();
	    	set.setCondiVO(vo);
	    	
	    	set = svr.courseManageN(set);
	    	
	        model.addAttribute("set", set );
    	} catch ( Exception e ) {
    		e.printStackTrace();
    	}

        return "/course/CourseManageN";
    }

    /**
     * 강좌 조회 화면
     * @param vo
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/courseManage/courseManageV")
    public String courseManageV(@ModelAttribute CourseManageVO vo, Model model) throws Exception {
    	try {
	    	CourseManageSet set = new CourseManageSet();
	    	set.setCondiVO(vo);
	    	
	    	set = svr.courseManageV(set);
	    	
	        model.addAttribute("set", set );
    	} catch ( Exception e ) {
    		e.printStackTrace();
    	}

        return "/course/CourseManageV";
    }
    
    /**
     * 강좌 조회 팝업 화면
     * @param vo
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/courseManage/courseManagePV")
    public String courseManagePV(@ModelAttribute CourseManageVO vo, Model model) throws Exception {
    	try {
	    	CourseManageSet set = new CourseManageSet();
	    	set.setCondiVO(vo);
	    	
	    	set = svr.courseManageV(set);
	    	
	        model.addAttribute("set", set );
    	} catch ( Exception e ) {
    		e.printStackTrace();
    	}

        return "/course/CourseManagePV";
    }

    /**
     * 강좌 수정 화면
     * @param vo
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/courseManage/courseManageU")
    public String courseManageU(@ModelAttribute CourseManageVO vo, Model model) throws Exception {
    	try {
    		CourseManageSet set = new CourseManageSet();
	    	set.setCondiVO(vo);
	    	
	    	set = svr.courseManageU(set);
	    	
	        model.addAttribute("set", set );
    	} catch ( Exception e ) {
    		e.printStackTrace();
    	}

        return "/course/CourseManageU";
    }

    
    
    ///////////////////////////////////////////////// Transaction ////////////////////////////////////////////////////
    /**
     * 과정 Master 생성
     * @param vo
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/courseManage/courseManageNIns", method = RequestMethod.POST)
    public String courseManageNIns(@ModelAttribute CourseManageVO vo, Model model) throws Exception {
    	try {
    		CourseManageSet set = new CourseManageSet();
	    	set.setCondiVO(vo);
	    	
	    	set = svr.courseManageNIns(set);
	    	
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
    @RequestMapping(value = "/courseManage/courseManageUUpd", method = RequestMethod.POST)
    public String courseManageUUpd(@ModelAttribute CourseManageVO vo, Model model) throws Exception {
    	try {
	    	CourseManageSet set = new CourseManageSet();
	    	set.setCondiVO(vo);
	    	
	    	set = svr.courseManageUUpd(set);
	    	
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
    @RequestMapping(value = "/courseManage/courseManageDel", method = RequestMethod.POST)
    public String courseManageDel(@ModelAttribute CourseManageVO vo, Model model) throws Exception {
    	try {
    		CourseManageSet set = new CourseManageSet();
	    	set.setCondiVO(vo);
	    	
	    	set = svr.courseManageDel(set);
	    	
	    	model.addAttribute("json", CommUtil.getJsonObject(set.getRtnMode(),""));
    	} catch ( Exception e ) {
    		e.printStackTrace();
    	}

        return "/common/json";
    }

}
