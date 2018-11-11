package com.qp.lms.ax.board.controller;



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

import com.qp.lms.ax.board.service.AxBoardNoticeService;
import com.qp.lms.common.Constant;
import com.qp.lms.common.service.CommService;

@Controller
public class AxBoardNoticeController {

	private static final Logger logger = LoggerFactory.getLogger(AxBoardNoticeController.class);

    @Autowired
    private AxBoardNoticeService svr;
    
    @Autowired
    private CommService commSvr;

    @RequestMapping(value = "/board/axBoardNoticeList", method = RequestMethod.POST, consumes = "application/json" )
    public @ResponseBody HashMap<String,Object> axBoardNoticeList(@RequestBody HashMap<String, Object> paramMap, HttpServletRequest request, HttpServletResponse response) throws Exception {
    	HashMap<String, Object> hm = new HashMap<String, Object>();

    	try {
    		hm = svr.axBoardNoticeList(paramMap);
    	} catch ( Exception e ) {
    		e.printStackTrace();
    	}

        return hm;
    }

    @RequestMapping(value = "/board/axBoardNoticeOne", method = RequestMethod.POST, consumes = "application/json" )
    public @ResponseBody HashMap<String,Object> axBoardReporOne(@RequestBody HashMap<String, Object> paramMap, HttpServletRequest request, HttpServletResponse response) throws Exception {
    	HashMap<String, Object> hm = new HashMap<String, Object>();

    	try {
    		hm = svr.axBoardNoticeOne(paramMap);
    	} catch ( Exception e ) {
    		e.printStackTrace();
    	}

        return hm;
    }

    @RequestMapping(value = "/board/axBoardNoticeSave", method = RequestMethod.POST, consumes = "application/json" )
    public @ResponseBody HashMap<String,Object> axBoardNoticeSave(@RequestBody HashMap<String, Object> paramMap, HttpServletRequest request, HttpServletResponse response) throws Exception {
    	HashMap<String, Object> hm = new HashMap<String, Object>();
    	
		try {
    		hm = svr.axBoardNoticeSave(paramMap);
    	} catch ( Exception e ) {
    		e.printStackTrace();
    		hm.put("RtnMode", Constant.mode.ERROR.name());
    	}

        return hm;
    }

    @RequestMapping(value = "/board/axBoardNoticeImageList", method = RequestMethod.POST, consumes = "application/json" )
    public @ResponseBody HashMap<String,Object> axBoardNoticeImageList(@RequestBody HashMap<String, Object> paramMap, HttpServletRequest request, HttpServletResponse response) throws Exception {
    	HashMap<String, Object> hm = new HashMap<String, Object>();

    	try {
    		hm = svr.axBoardNoticeImageList(paramMap);
    	} catch ( Exception e ) {
    		e.printStackTrace();
    	}

        return hm;
    }
    
    @RequestMapping(value = "/board/axBoardNoticeImageUpload", method = RequestMethod.POST)
    public String axBoardEventImageUpload(@RequestParam("kind") String kind, @RequestParam("seq") String seq, MultipartHttpServletRequest request, Model model) throws Exception {
    	HashMap<String, Object> hm = new HashMap<String, Object>();

    	try {
	    	String folder = commSvr.getSetting("NOTICE_IMG_FOLDER");
	    	
	    	File attachDir = new File(folder);
	    	if ( !attachDir.exists() )
	    		attachDir.mkdir();
	    	
	    	// 파일 처리
	    	Map<String, MultipartFile> files = request.getFileMap();
	        CommonsMultipartFile cmf = null;
	        
	        String fileName = seq + "_" + kind + ".jpg";
        	cmf = (CommonsMultipartFile) files.get(kind + "File");
	        
	        System.out.println("Image Directory : " + attachDir + "/" + fileName);
	        
	    	//파일 저장
	        File f = new File(attachDir + "//" + fileName);
	        cmf.transferTo(f);
	
	        //파일 정보를 DB에 저장
	        HashMap<String, Object> paramMap = new HashMap<String, Object>();
	        paramMap.put("kind", kind);
	        paramMap.put("SEQ", seq);
	        
	        hm = svr.axBoardNoticeImageUpload(paramMap);
	        
    	} catch ( Exception e ) {
    		e.printStackTrace();
    		hm.put("RtnMode", Constant.mode.ERROR.name());
    	}

    	model.addAttribute("set", hm );

        return "/ax/board/axBoardNoticeImagePopupRtn";
    }


	    
	    

}
