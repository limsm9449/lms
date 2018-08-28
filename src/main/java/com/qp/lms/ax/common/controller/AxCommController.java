package com.qp.lms.ax.common.controller;



import java.io.FileInputStream;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.ss.usermodel.WorkbookFactory;
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
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.qp.lms.ax.common.model.CommonVO;
import com.qp.lms.ax.common.service.AxCommService;
import com.qp.lms.common.CommUtil;
import com.qp.lms.common.Constant;
import com.qp.lms.common.SessionUtil;
import com.qp.lms.common.SessionVO;

@Controller
public class AxCommController {

	private static final Logger logger = LoggerFactory.getLogger(AxCommController.class);

    @Autowired
    private AxCommService svr;
    
   
    @RequestMapping(value = "/common/axOpenPage", method = RequestMethod.POST)
    public String axOpenPage(@RequestParam("page") String page, HttpServletRequest request, HttpServletResponse response, Model model) throws Exception {

    	SessionVO sess = (SessionVO)SessionUtil.getSession();
    	model.addAttribute("auth",sess.getAuth());
    	model.addAttribute("compCd",sess.getUserCompCd());
    	
        return page;
    }
    
    @RequestMapping(value = "/common/axDd", method = RequestMethod.POST, consumes = "application/json" )
    public @ResponseBody HashMap<String,Object> axGetDd(@RequestBody HashMap<String, Object> paramMap, HttpServletRequest request, HttpServletResponse response) throws Exception {
    	HashMap<String, Object> hm = new HashMap<String, Object>();
    	
		try {
    		hm = svr.axDd(paramMap);
    	} catch ( Exception e ) {
    		e.printStackTrace();
    		hm.put("RtnMode", Constant.mode.ERROR.name());
    	}

        return hm;
    }
    
    @RequestMapping(value = "/common/axMaxCourseCode", method = RequestMethod.POST, consumes = "application/json" )
    public @ResponseBody HashMap<String,Object> axMaxCourseCode(@RequestBody HashMap<String, Object> paramMap, HttpServletRequest request, HttpServletResponse response) throws Exception {
    	HashMap<String, Object> hm = new HashMap<String, Object>();
    	
		try {
    		hm = svr.axMaxCourseCode(paramMap);
    	} catch ( Exception e ) {
    		e.printStackTrace();
    		hm.put("RtnMode", Constant.mode.ERROR.name());
    	}

        return hm;
    }

    /**
     * 엑셀 업로드
     * @param request
     * @param vo
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/common/axExcelUpload", method = RequestMethod.POST)
    public String excelUpload(MultipartHttpServletRequest request, @ModelAttribute CommonVO vo,  Model model) throws Exception {
    	try {
	    	//첨부화일 저장
	    	String saveFileName = CommUtil.saveFile(request);

	    	String[] columns = vo.getColumns().split(",");
	    	
	    	List<HashMap<String, Object>> list = new ArrayList<HashMap<String, Object>>(); 
	    	
			Workbook wb = WorkbookFactory.create(new FileInputStream(saveFileName));
	    	Sheet sheet = wb.getSheetAt(0);
	        int rows = sheet.getPhysicalNumberOfRows(); 
	        for (int i = 1; i < rows; i++) { 
	            Row row = sheet.getRow(i);

	            if ( row != null ) {
	            	HashMap<String, Object> hm = new HashMap<String, Object>();
	            	
	            	for ( int m = 0; m < columns.length; m++ ) {
	            		hm.put(columns[m], CommUtil.getCell(row, m));
	            	}
	            	list.add(hm);
	            }
	        }
	
	        ObjectMapper mapper = new ObjectMapper();
	        String listJson = mapper.writeValueAsString(list);
	        
	    	model.addAttribute("rtnMode", Constant.mode.OK.name() );
	    	model.addAttribute("listJson", listJson );
    	} catch ( Exception e ) {
    		e.printStackTrace();
    	}

		return "/ax/common/axExcelUploadReturnPage";
    	
    }
}
