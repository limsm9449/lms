package com.qp.lms.ax.course.controller;

import java.io.File;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.multipart.commons.CommonsMultipartFile;

import com.qp.lms.ax.course.service.AxMainPageService;
import com.qp.lms.common.Constant;
import com.qp.lms.common.SessionUtil;
import com.qp.lms.common.service.CommService;

@Controller
public class AxMainPageController {

	private static final Logger logger = LoggerFactory.getLogger(AxMainPageController.class);

    @Autowired
    private AxMainPageService svr;
    
    @Autowired
    private CommService commSvr;
    
    @RequestMapping(value = "/mainPage/axMainPageList", method = RequestMethod.POST, consumes = "application/json" )
    public @ResponseBody HashMap<String,Object> axCourseList(@RequestBody HashMap<String, Object> paramMap, HttpServletRequest request, HttpServletResponse response) throws Exception {
    	HashMap<String, Object> hm = new HashMap<String, Object>();

    	commSvr.requestLog(SessionUtil.getSessionUserId(), request.getRequestURI(), paramMap.toString(), request.getRemoteAddr());
    	
    	try {
    		hm = svr.axMainPageList(paramMap);
    	} catch ( Exception e ) {
    		e.printStackTrace();
    	}

        return hm;
    }
    
    @RequestMapping(value = "/mainPage/axMainPageSave", method = RequestMethod.POST, consumes = "application/json" )
    public @ResponseBody HashMap<String,Object> axCourseSave(@RequestBody HashMap<String, Object> paramMap, HttpServletRequest request, HttpServletResponse response) throws Exception {
    	HashMap<String, Object> hm = new HashMap<String, Object>();

    	commSvr.requestLog(SessionUtil.getSessionUserId(), request.getRequestURI(), paramMap.toString(), request.getRemoteAddr());

		try {
    		hm = svr.axMainPageSave(paramMap);
    	} catch ( Exception e ) {
    		e.printStackTrace();
    		hm.put("RtnMode", Constant.mode.ERROR.name());
    	}

        return hm;
    }

    @RequestMapping(value = "/mainPage/axMainPageImageList", method = RequestMethod.POST, consumes = "application/json" )
    public @ResponseBody HashMap<String,Object> axCourseMasterImageList(@RequestBody HashMap<String, Object> paramMap, HttpServletRequest request, HttpServletResponse response) throws Exception {
    	HashMap<String, Object> hm = new HashMap<String, Object>();

    	try {
    		hm = svr.axMainPageImageList(paramMap);
    	} catch ( Exception e ) {
    		e.printStackTrace();
    	}

        return hm;
    }
    
    @RequestMapping(value = "/mainPage/axMainPageImageUpload", method = RequestMethod.POST)
    public String axCourseMasterImageUpload(@RequestParam("kind") String kind, @RequestParam("compCd") String compCd, @RequestParam("courseId") String courseId, MultipartHttpServletRequest request, Model model) throws Exception {
    	HashMap<String, Object> hm = new HashMap<String, Object>();

    	try {
	    	String folder = commSvr.getSetting("MAIN_IMG_FOLDER");
	    	
	    	File attachDir = new File(folder);
	    	if ( !attachDir.exists() )
	    		attachDir.mkdir();
	    	
	    	attachDir = new File(folder + "//" + compCd);
	    	if ( !attachDir.exists() )
	    		attachDir.mkdir();
	    	
	    	// 파일 처리
	    	Map<String, MultipartFile> files = request.getFileMap();
	        CommonsMultipartFile cmf = null;
	        
	        String fileName = courseId + "_" + kind + ".jpg";
        	cmf = (CommonsMultipartFile) files.get(kind + "File");
	        
	        System.out.println("Image Directory : " + attachDir + "/" + fileName);
	        
	    	//파일 저장
	        File f = new File(attachDir + "//" + fileName);
	        cmf.transferTo(f);
	
	        //파일 정보를 DB에 저장
	        HashMap<String, Object> paramMap = new HashMap<String, Object>();
	        paramMap.put("kind", kind);
	        paramMap.put("COMP_CD", compCd);
	        paramMap.put("COURSE_ID", courseId);
	        
	        hm = svr.axMainPageImageUpload(paramMap);
	        
    	} catch ( Exception e ) {
    		e.printStackTrace();
    		hm.put("RtnMode", Constant.mode.ERROR.name());
    	}

    	model.addAttribute("set", hm );

        return "/ax/course/axMainPageImagePopupRtn";
    }


}
