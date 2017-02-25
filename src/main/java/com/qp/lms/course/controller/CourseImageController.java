package com.qp.lms.course.controller;



import java.io.File;
import java.util.Map;

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

import com.qp.lms.common.service.CommService;
import com.qp.lms.course.model.CourseImageSet;
import com.qp.lms.course.model.CourseImageVO;
import com.qp.lms.course.service.CourseImageService;

/**
 * 과정 이미지 관리
 * @author limsm
 *
 */

@Controller
public class CourseImageController { 

	 private static final Logger logger = LoggerFactory.getLogger(CourseResourceController.class);

	    @Autowired
	    private CourseImageService svr;

	    @Autowired
	    private CommService commSvr;
	    
	    /**
	     * 과정 리스트
	     * @param vo
	     * @param model
	     * @return
	     * @throws Exception
	     */
	    @RequestMapping(value = "/courseImage/courseImageList")
	    public String courseImageList(@ModelAttribute CourseImageVO vo, Model model) throws Exception {
	    	try {
		    	CourseImageSet set = new CourseImageSet();
		    	set.setCondiVO(vo);
		    	
		    	set = svr.courseImageList(set);
		    	
		        model.addAttribute("set", set );
	    	} catch ( Exception e ) {
	    		e.printStackTrace();
	    	}

	        return "/course/CourseImageList";
	    }

	    /**
	     * 과정 주차 조회 화면
	     * @param vo
	     * @param model
	     * @return
	     * @throws Exception
	     */
	    @RequestMapping(value = "/courseImage/courseImageV")
	    public String courseImageV(@ModelAttribute CourseImageVO vo, Model model) throws Exception {
	    	try {
	    		CourseImageSet set = new CourseImageSet();
		    	set.setCondiVO(vo);
		    	
		    	set = svr.courseImageV(set);
		    	
		        model.addAttribute("set", set );
	    	} catch ( Exception e ) {
	    		e.printStackTrace();
	    	}

	        return "/course/CourseImageV";
	    }

	    
	    
	    
	    ///////////////////////////////////////////////// Transaction ////////////////////////////////////////////////////
	    
	    /**
	     * 이미지 업로드
	     * @param request
	     * @param vo
	     * @param model
	     * @return
	     * @throws Exception
	     */
	    @RequestMapping(value = "/courseImage/uploadImage", method = RequestMethod.POST)
	    public String uploadImage(MultipartHttpServletRequest request, @ModelAttribute CourseImageVO vo, Model model) throws Exception {
	    	
	    	try {
	    		CourseImageSet set = new CourseImageSet();
		    	set.setCondiVO(vo);
		    	
		    	String folder = commSvr.getSetting("COURSE_IMG_FOLDER");
		    	
		    	File attachDir = new File(folder);
		    	if ( !attachDir.exists() )
		    		attachDir.mkdir();
		    	
		    	attachDir = new File(folder + "//" + vo.getCourseCode());
		    	if ( !attachDir.exists() )
		    		attachDir.mkdir();
		    	
		    	// 파일 처리
		    	Map<String, MultipartFile> files = request.getFileMap();
		        CommonsMultipartFile cmf = null;
		        
		        String fileName = "";
		        if ( "SWF".equals(vo.getKind()) ) {
		        	fileName = "swf.swf";
		        	cmf = (CommonsMultipartFile) files.get("swfFile");
		        } else if ( "B_IMG".equals(vo.getKind()) ) {
		        	fileName = "bImg.jpg";
		        	cmf = (CommonsMultipartFile) files.get("bImgFile");
		        } else if ( "C_IMG".equals(vo.getKind()) ) {
		        	fileName = "cImg.jpg";
		        	cmf = (CommonsMultipartFile) files.get("cImgFile");
		        } else if ( "M_IMG1".equals(vo.getKind()) ) {
		        	fileName = "mImg1.jpg";
		        	cmf = (CommonsMultipartFile) files.get("mImg1File");
		        } else if ( "M_IMG2".equals(vo.getKind()) ) {
		        	fileName = "mImg2.jpg";
		        	cmf = (CommonsMultipartFile) files.get("mImg2File");
		        } else if ( "M_IMG3".equals(vo.getKind()) ) {
		        	fileName = "mImg3.jpg";
		        	cmf = (CommonsMultipartFile) files.get("mImg3File");
		        } else if ( "S_IMG1".equals(vo.getKind()) ) {
		        	fileName = "sImg1.jpg";
		        	cmf = (CommonsMultipartFile) files.get("sImg1File");
		        } else if ( "S_IMG2".equals(vo.getKind()) ) {
		        	fileName = "sImg2.jpg";
		        	cmf = (CommonsMultipartFile) files.get("sImg2File");
		        } else if ( "S_IMG3".equals(vo.getKind()) ) {
		        	fileName = "sImg3.jpg";
		        	cmf = (CommonsMultipartFile) files.get("sImg3File");
		        }
		        
		        System.out.println("Image Directory : " + attachDir + "/" + fileName);
		        
		        
		    	//파일 저장
		        File f = new File(attachDir + "//" + fileName);
		        cmf.transferTo(f);
		
		        //파일 정보를 DB에 저장
		    	set = svr.courseImageUpload(set);
		
		    	model.addAttribute("set", set );
	    	} catch ( Exception e ) {
	    		e.printStackTrace();
	    	}

	        return "/course/CourseImageUploadT";
	    }



}
