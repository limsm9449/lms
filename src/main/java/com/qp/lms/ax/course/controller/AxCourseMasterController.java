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
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.multipart.commons.CommonsMultipartFile;

import com.qp.lms.ax.course.service.AxCourseMasterService;
import com.qp.lms.common.Constant;
import com.qp.lms.common.service.CommService;
import com.qp.lms.course.model.CourseImageSet;
import com.qp.lms.course.model.CourseImageVO;

@Controller
public class AxCourseMasterController {

	private static final Logger logger = LoggerFactory.getLogger(AxCourseMasterController.class);

    @Autowired
    private AxCourseMasterService svr;

    @Autowired
    private CommService commSvr;

    @RequestMapping(value = "/course/axCourseMasterList", method = RequestMethod.POST, consumes = "application/json" )
    public @ResponseBody HashMap<String,Object> axCourseMasterList(@RequestBody HashMap<String, Object> paramMap, HttpServletRequest request, HttpServletResponse response) throws Exception {
    	HashMap<String, Object> hm = new HashMap<String, Object>();

    	try {
    		hm = svr.axCourseMasterList(paramMap);
    	} catch ( Exception e ) {
    		e.printStackTrace();
    	}

        return hm;
    }
    
    @RequestMapping(value = "/course/axCourseMasterSave", method = RequestMethod.POST, consumes = "application/json" )
    public @ResponseBody HashMap<String,Object> axCourseMasterSave(@RequestBody HashMap<String, Object> paramMap, HttpServletRequest request, HttpServletResponse response) throws Exception {
    	HashMap<String, Object> hm = new HashMap<String, Object>();
    	
		try {
    		hm = svr.axCourseMasterSave(paramMap);
    	} catch ( Exception e ) {
    		e.printStackTrace();
    		hm.put("RtnMode", Constant.mode.ERROR.name());
    	}

        return hm;
    }

    @RequestMapping(value = "/course/axCourseMasterContentsList", method = RequestMethod.POST, consumes = "application/json" )
    public @ResponseBody HashMap<String,Object> axCourseMasterContentsList(@RequestBody HashMap<String, Object> paramMap, HttpServletRequest request, HttpServletResponse response) throws Exception {
    	HashMap<String, Object> hm = new HashMap<String, Object>();

    	try {
    		hm = svr.axCourseMasterContentsList(paramMap);
    	} catch ( Exception e ) {
    		e.printStackTrace();
    	}

        return hm;
    }
    
    @RequestMapping(value = "/course/axCourseMasterContentsSave", method = RequestMethod.POST, consumes = "application/json" )
    public @ResponseBody HashMap<String,Object> axCourseMasterContentsSave(@RequestBody HashMap<String, Object> paramMap, HttpServletRequest request, HttpServletResponse response) throws Exception {
    	HashMap<String, Object> hm = new HashMap<String, Object>();
    	
		try {
    		hm = svr.axCourseMasterContentsSave(paramMap);
    	} catch ( Exception e ) {
    		e.printStackTrace();
    		hm.put("RtnMode", Constant.mode.ERROR.name());
    	}

        return hm;
    }

    @RequestMapping(value = "/course/axCourseMasterImageList", method = RequestMethod.POST, consumes = "application/json" )
    public @ResponseBody HashMap<String,Object> axCourseMasterImageList(@RequestBody HashMap<String, Object> paramMap, HttpServletRequest request, HttpServletResponse response) throws Exception {
    	HashMap<String, Object> hm = new HashMap<String, Object>();

    	try {
    		hm = svr.axCourseMasterImageList(paramMap);
    	} catch ( Exception e ) {
    		e.printStackTrace();
    	}

        return hm;
    }
    
    @RequestMapping(value = "/course/axCourseMasterImageUpload", method = RequestMethod.POST)
    public String axCourseMasterImageUpload(@RequestParam("kind") String kind, @RequestParam("courseCode") String courseCode, MultipartHttpServletRequest request, Model model) throws Exception {
    	HashMap<String, Object> hm = new HashMap<String, Object>();

    	try {
	    	String folder = commSvr.getSetting("COURSE_IMG_FOLDER");
	    	
	    	File attachDir = new File(folder);
	    	if ( !attachDir.exists() )
	    		attachDir.mkdir();
	    	
	    	attachDir = new File(folder + "//" + courseCode);
	    	if ( !attachDir.exists() )
	    		attachDir.mkdir();
	    	
	    	// 파일 처리
	    	Map<String, MultipartFile> files = request.getFileMap();
	        CommonsMultipartFile cmf = null;
	        
	        String fileName = "";
	        if ( "SWF".equals(kind) ) {
	        	fileName = "swf.swf";
	        	cmf = (CommonsMultipartFile) files.get("swfFile");
	        } else if ( "B_IMG".equals(kind) ) {
	        	fileName = "bImg.jpg";
	        	cmf = (CommonsMultipartFile) files.get("bImgFile");
	        } else if ( "C_IMG".equals(kind) ) {
	        	fileName = "cImg.jpg";
	        	cmf = (CommonsMultipartFile) files.get("cImgFile");
	        } else if ( "M_IMG1".equals(kind) ) {
	        	fileName = "mImg1.jpg";
	        	cmf = (CommonsMultipartFile) files.get("mImg1File");
	        } else if ( "M_IMG2".equals(kind) ) {
	        	fileName = "mImg2.jpg";
	        	cmf = (CommonsMultipartFile) files.get("mImg2File");
	        } else if ( "M_IMG3".equals(kind) ) {
	        	fileName = "mImg3.jpg";
	        	cmf = (CommonsMultipartFile) files.get("mImg3File");
	        } else if ( "S_IMG1".equals(kind) ) {
	        	fileName = "sImg1.jpg";
	        	cmf = (CommonsMultipartFile) files.get("sImg1File");
	        } else if ( "S_IMG2".equals(kind) ) {
	        	fileName = "sImg2.jpg";
	        	cmf = (CommonsMultipartFile) files.get("sImg2File");
	        } else if ( "S_IMG3".equals(kind) ) {
	        	fileName = "sImg3.jpg";
	        	cmf = (CommonsMultipartFile) files.get("sImg3File");
	        }
	        
	        System.out.println("Image Directory : " + attachDir + "/" + fileName);
	        
	        
	    	//파일 저장
	        File f = new File(attachDir + "//" + fileName);
	        cmf.transferTo(f);
	
	        //파일 정보를 DB에 저장
	        HashMap<String, Object> paramMap = new HashMap<String, Object>();
	        paramMap.put("kind", kind);
	        paramMap.put("COURSE_CODE", courseCode);
	        
	        hm = svr.axCourseMasterImageUpload(paramMap);
	        
    	} catch ( Exception e ) {
    		e.printStackTrace();
    		hm.put("RtnMode", Constant.mode.ERROR.name());
    	}

    	model.addAttribute("set", hm );

        return "/ax/course/axCourseMasterImagePopupRtn";
    }

    
}
