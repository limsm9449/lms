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

import com.qp.lms.ax.board.service.AxMainBoardEventService;
import com.qp.lms.common.Constant;
import com.qp.lms.common.service.CommService;

@Controller
public class AxMainBoardEventController {

	private static final Logger logger = LoggerFactory.getLogger(AxMainBoardEventController.class);

    @Autowired
    private AxMainBoardEventService svr;
    
    @Autowired
    private CommService commSvr;
    
    @RequestMapping(value = "/board/axMainBoardEventList", method = RequestMethod.POST, consumes = "application/json" )
    public @ResponseBody HashMap<String,Object> axBoardEventList(@RequestBody HashMap<String, Object> paramMap, HttpServletRequest request, HttpServletResponse response) throws Exception {
    	HashMap<String, Object> hm = new HashMap<String, Object>();

    	try {
    		hm = svr.axBoardEventList(paramMap);
    	} catch ( Exception e ) {
    		e.printStackTrace();
    	}

        return hm;
    }

    @RequestMapping(value = "/board/axMainBoardEventOne", method = RequestMethod.POST, consumes = "application/json" )
    public @ResponseBody HashMap<String,Object> axMainBoardEventOne(@RequestBody HashMap<String, Object> paramMap, HttpServletRequest request, HttpServletResponse response) throws Exception {
    	HashMap<String, Object> hm = new HashMap<String, Object>();

    	try {
    		hm = svr.axBoardEventOne(paramMap);
    	} catch ( Exception e ) {
    		e.printStackTrace();
    	}

        return hm;
    }

    @RequestMapping(value = "/board/axMainBoardEventSave", method = RequestMethod.POST, consumes = "application/json" )
    public @ResponseBody HashMap<String,Object> axBoardEventSave(@RequestBody HashMap<String, Object> paramMap, HttpServletRequest request, HttpServletResponse response) throws Exception {
    	HashMap<String, Object> hm = new HashMap<String, Object>();
    	
		try {
    		hm = svr.axBoardEventSave(paramMap);
    	} catch ( Exception e ) {
    		e.printStackTrace();
    		hm.put("RtnMode", Constant.mode.ERROR.name());
    	}

        return hm;
    }

    @RequestMapping(value = "/board/axMainBoardEventImageList", method = RequestMethod.POST, consumes = "application/json" )
    public @ResponseBody HashMap<String,Object> axBoardEventImageList(@RequestBody HashMap<String, Object> paramMap, HttpServletRequest request, HttpServletResponse response) throws Exception {
    	HashMap<String, Object> hm = new HashMap<String, Object>();

    	try {
    		hm = svr.axBoardEventImageList(paramMap);
    	} catch ( Exception e ) {
    		e.printStackTrace();
    	}

        return hm;
    }
    
    @RequestMapping(value = "/board/axMainBoardEventImageUpload", method = RequestMethod.POST)
    public String axBoardEventImageUpload(@RequestParam("kind") String kind, @RequestParam("seq") String seq, @RequestParam("compCd") String compCd, MultipartHttpServletRequest request, Model model) throws Exception {
    	HashMap<String, Object> hm = new HashMap<String, Object>();

    	try {
	    	String folder = commSvr.getSetting("EVENT_IMG_FOLDER");
	    	
	    	File attachDir = new File(folder);
	    	if ( !attachDir.exists() )
	    		attachDir.mkdir();

	    	attachDir = new File(folder + "//" + compCd);
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
	        paramMap.put("COMP_CD", compCd);
	        
	        hm = svr.axBoardEventImageUpload(paramMap);
	        
    	} catch ( Exception e ) {
    		e.printStackTrace();
    		hm.put("RtnMode", Constant.mode.ERROR.name());
    	}

    	model.addAttribute("set", hm );

        return "/ax/board/axMainBoardEventImagePopupRtn";
    }
	    

}
