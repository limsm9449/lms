package com.qp.lms.course.controller;



import java.io.File;
import java.util.Map;
import java.util.UUID;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.multipart.commons.CommonsMultipartFile;

import com.qp.lms.course.model.CourseResourceSet;
import com.qp.lms.course.model.CourseResourceVO;
import com.qp.lms.course.service.CourseResourceService;
import com.qp.lms.common.CommUtil;
import com.qp.lms.compManager.model.CompUserSet;
import com.qp.lms.compManager.model.CompUserVO;

/**
 * 과정 주차 관리
 * @author limsm
 *
 */

@Controller
public class CourseResourceController { 

	 private static final Logger logger = LoggerFactory.getLogger(CourseResourceController.class);

	    @Autowired
	    private CourseResourceService svr;

	    /**
	     * 과정 주차 리스트
	     * @param vo
	     * @param model
	     * @return
	     * @throws Exception
	     */
	    @RequestMapping(value = "/courseResource/courseResourceList")
	    public String courseResourceList(@ModelAttribute CourseResourceVO vo, Model model) throws Exception {
	    	try {
		    	CourseResourceSet set = new CourseResourceSet();
		    	set.setCondiVO(vo);
		    	
		    	set = svr.courseResourceList(set);
		    	
		        model.addAttribute("set", set );
	    	} catch ( Exception e ) {
	    		e.printStackTrace();
	    	}

	        return "/course/CourseResourceList";
	    }

	    /**
	     * 과정 주차 입력 화면
	     * @param vo
	     * @param model
	     * @return
	     * @throws Exception
	     */
	    @RequestMapping(value = "/courseResource/courseResourceN")
	    public String courseResourceN(@ModelAttribute CourseResourceVO vo, Model model) throws Exception {
	    	try {
		    	CourseResourceSet set = new CourseResourceSet();
		    	set.setCondiVO(vo);
		    	
		    	set = svr.courseResourceN(set);
		    	
		        model.addAttribute("set", set );
	    	} catch ( Exception e ) {
	    		e.printStackTrace();
	    	}

	        return "/course/CourseResourceN";
	    }

	    /**
	     * 과정 주차 조회 화면
	     * @param vo
	     * @param model
	     * @return
	     * @throws Exception
	     */
	    @RequestMapping(value = "/courseResource/courseResourceV")
	    public String courseResourceV(@ModelAttribute CourseResourceVO vo, Model model) throws Exception {
	    	try {
		    	CourseResourceSet set = new CourseResourceSet();
		    	set.setCondiVO(vo);
		    	
		    	set = svr.courseResourceV(set);
		    	
		        model.addAttribute("set", set );
	    	} catch ( Exception e ) {
	    		e.printStackTrace();
	    	}

	        return "/course/CourseResourceV";
	    }

	    /**
	     * 과정 주차 수정 화면
	     * @param vo
	     * @param model
	     * @return
	     * @throws Exception
	     */
	    @RequestMapping(value = "/courseResource/courseResourceU")
	    public String courseResourceU(@ModelAttribute CourseResourceVO vo, Model model) throws Exception {
	    	try {
		    	CourseResourceSet set = new CourseResourceSet();
		    	set.setCondiVO(vo);
		    	
		    	set = svr.courseResourceU(set);
		    	
		        model.addAttribute("set", set );
	    	} catch ( Exception e ) {
	    		e.printStackTrace();
	    	}

	        return "/course/CourseResourceU";
	    }

	    /**
	     * 양식 다운로드
	     * @param request
	     * @param vo
	     * @param model
	     * @return
	     * @throws Exception
	     */
	    @RequestMapping(value = "/courseResource/excelFormCourseResource")
	    public String excelFormCourseResource(@ModelAttribute CourseResourceVO vo, Model model) throws Exception {
	    	try {
	    	} catch ( Exception e ) {
	    		e.printStackTrace();
	    	}

    		return "ExcelFormCourseResourceView";
	    }

	    /**
	     * 엑셀 업로드
	     * @param request
	     * @param vo
	     * @param model
	     * @return
	     * @throws Exception
	     */
	    @RequestMapping(value = "/courseResource/excelUpload", method = RequestMethod.POST)
	    public String excelUpload(MultipartHttpServletRequest request, @ModelAttribute CourseResourceVO vo, Model model) throws Exception {
	    	CourseResourceSet set = new CourseResourceSet();
	    	try {
		    	set.setCondiVO(vo);
		    	
		    	//첨부화일 저장
		    	String saveFileName = CommUtil.saveFile(request);
		    	
		    	set.getCondiVO().setFileName(saveFileName);

		    	set = svr.excelUpload(set);
		
		    	model.addAttribute("set", set );
	    	} catch ( Exception e ) {
	    		e.printStackTrace();
	    	}

    		return "/common/Tran";
	    	
	    }
	    
	    
	    ///////////////////////////////////////////////// Transaction ////////////////////////////////////////////////////
	    
	    /**
	     * 과정 주차 입력
	     * @param vo
	     * @param model
	     * @return
	     * @throws Exception
	     */
	    @RequestMapping(value = "/courseResource/courseResourceNIns", method = RequestMethod.POST)
	    public String courseResourceNIns(@ModelAttribute CourseResourceVO vo, Model model) throws Exception {
	    	try {
		    	CourseResourceSet set = new CourseResourceSet();
		    	set.setCondiVO(vo);
		    	
		    	set = svr.courseResourceNIns(set);
		    	
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
	    @RequestMapping(value = "/courseResource/courseResourceUUpd", method = RequestMethod.POST)
	    public String courseResourceUUpd(@ModelAttribute CourseResourceVO vo, Model model) throws Exception {
	    	try {
		    	CourseResourceSet set = new CourseResourceSet();
		    	set.setCondiVO(vo);
		    	
		    	set = svr.courseResourceUUpd(set);
	
		    	model.addAttribute("json", CommUtil.getJsonObject(set.getRtnMode(),""));
	    	} catch ( Exception e ) {
	    		e.printStackTrace();
	    	}

	        return "/common/json";
	    }


}
