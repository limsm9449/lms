package com.qp.lms.ax.account.controller;



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

import com.qp.lms.ax.account.service.AxCompanyService;
import com.qp.lms.common.Constant;
import com.qp.lms.common.service.CommService;

@Controller
public class AxCompanyController {

	private static final Logger logger = LoggerFactory.getLogger(AxCompanyController.class);

    @Autowired
    private AxCompanyService svr;

    @Autowired
    private CommService commSvr;

    @RequestMapping(value = "/account/axCompanyList", method = RequestMethod.POST, consumes = "application/json" )
    public @ResponseBody HashMap<String,Object> axCompanyList(@RequestBody HashMap<String, Object> paramMap, HttpServletRequest request, HttpServletResponse response) throws Exception {
    	HashMap<String, Object> hm = new HashMap<String, Object>();

    	try {
    		hm = svr.axCompanyList(paramMap);
    	} catch ( Exception e ) {
    		e.printStackTrace();
    	}

        return hm;
    }
    
    @RequestMapping(value = "/account/axCompanySave", method = RequestMethod.POST, consumes = "application/json" )
    public @ResponseBody HashMap<String,Object> axCompanySave(@RequestBody HashMap<String, Object> paramMap, HttpServletRequest request, HttpServletResponse response) throws Exception {
    	HashMap<String, Object> hm = new HashMap<String, Object>();
    	
		try {
    		hm = svr.axCompanySave(paramMap);
    	} catch ( Exception e ) {
    		e.printStackTrace();
    		hm.put("RtnMode", Constant.mode.ERROR.name());
    	}

        return hm;
    }
    
    @RequestMapping(value = "/account/axCompanyImageList", method = RequestMethod.POST, consumes = "application/json" )
    public @ResponseBody HashMap<String,Object> axCompanyImageList(@RequestBody HashMap<String, Object> paramMap, HttpServletRequest request, HttpServletResponse response) throws Exception {
    	HashMap<String, Object> hm = new HashMap<String, Object>();

    	try {
    		hm = svr.axCompanyImageList(paramMap);
    	} catch ( Exception e ) {
    		e.printStackTrace();
    	}

        return hm;
    }
    
    @RequestMapping(value = "/account/axCompanyImageUpload", method = RequestMethod.POST)
    public String axCompanyImageUpload(@RequestParam("kind") String kind, @RequestParam("COMP_CD") String COMP_CD, MultipartHttpServletRequest request, Model model) throws Exception {
    	HashMap<String, Object> hm = new HashMap<String, Object>();

    	try {
	    	String folder = commSvr.getSetting("COMPANY_FOLDER");
	    	
	    	File attachDir = new File(folder);
	    	if ( !attachDir.exists() )
	    		attachDir.mkdir();
	    	
	    	// 파일 처리
	    	Map<String, MultipartFile> files = request.getFileMap();
	        CommonsMultipartFile cmf = null;
	        
	        String fileName = "";
	        if ( "LOGIN".equals(kind) ) {
	        	fileName = COMP_CD + "_login.jpg";
	        	cmf = (CommonsMultipartFile) files.get("loginImgFile");
	        } else if ( "GNB".equals(kind) ) {
	        	fileName = COMP_CD + "_gnb.jpg";
	        	cmf = (CommonsMultipartFile) files.get("gnbImgFile");
	        }
	        
	        System.out.println("Image Directory : " + attachDir + "/" + fileName);
	        
	        
	    	//파일 저장
	        File f = new File(attachDir + "//" + fileName);
	        cmf.transferTo(f);
	
	        //파일 정보를 DB에 저장
	        HashMap<String, Object> paramMap = new HashMap<String, Object>();
	        paramMap.put("kind", kind);
	        paramMap.put("COMP_CD", COMP_CD);
	        
	        hm = svr.axCompanyImageUpload(paramMap);
	        
    	} catch ( Exception e ) {
    		e.printStackTrace();
    		hm.put("RtnMode", Constant.mode.ERROR.name());
    	}

    	model.addAttribute("set", hm );

        return "/ax/common/axReturnPage";
    }
	    
    @RequestMapping(value = "/account/axCompanyC2cList", method = RequestMethod.POST, consumes = "application/json" )
    public @ResponseBody HashMap<String,Object> axCompanyC2cList(@RequestBody HashMap<String, Object> paramMap, HttpServletRequest request, HttpServletResponse response) throws Exception {
    	HashMap<String, Object> hm = new HashMap<String, Object>();

    	try {
    		hm = svr.axCompanyC2cList(paramMap);
    	} catch ( Exception e ) {
    		e.printStackTrace();
    	}

        return hm;
    }
	    
	    
	    

}
