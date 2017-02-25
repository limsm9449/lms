package com.qp.lms.board.controller;

import java.io.File;
import java.io.FileInputStream;
import java.io.OutputStream;
import java.net.URLEncoder;
import java.util.Calendar;
import java.util.Map;
import java.util.UUID;

import javax.servlet.http.HttpServletResponse;

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
import org.springframework.web.servlet.ModelAndView;

import com.qp.lms.board.model.AttachSet;
import com.qp.lms.board.model.AttachVO;
import com.qp.lms.board.service.AttachService;
import com.qp.lms.common.CommUtil;
import com.qp.lms.common.SessionUtil;
import com.qp.lms.common.service.CommService;

@Controller
public class AttachController {

	private static final Logger logger = LoggerFactory.getLogger(AttachController.class);

    @Autowired
    private AttachService svr;

    /**
     * 첨부파일 입력 조회
     * @param vo
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/board/attachI")
    public String attachI( @ModelAttribute AttachVO vo, Model model) throws Exception {
    	try {
	    	AttachSet set = new AttachSet();
	    	set.setCondiVO(vo);
	    	
	    	set = svr.attachI(set);
	
	    	model.addAttribute("set", set );
    	} catch ( Exception e ) {
    		e.printStackTrace();
    	}

        return "/board/AttachI";
    }

    
    /**
     * 첨부파일 조회
     * @param vo
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/board/attachV")
    public String attachV( @ModelAttribute AttachVO vo, Model model) throws Exception {
    	try {
	    	AttachSet set = new AttachSet();
	    	set.setCondiVO(vo);
	    	
	    	set = svr.attachV(set);
	    	
	    	//다운로드 권한
	    	set.setDownloadAuth(SessionUtil.getDownloadAuth());
	    	
	    	model.addAttribute("set", set );
    	} catch ( Exception e ) {
    		e.printStackTrace();
    	}

    	return "/board/AttachV";
    }

    /**
     * 첨부파일 수정 조회
     * @param vo
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/board/attachU")
    public String attachU( @ModelAttribute AttachVO vo, Model model) throws Exception {
    	try {
	    	AttachSet set = new AttachSet();
	    	set.setCondiVO(vo);
	    	
	    	set = svr.attachV(set);
	    	
	    	model.addAttribute("set", set );
    	} catch ( Exception e ) {
    		e.printStackTrace();
    	}
    	
    	return "/board/AttachU";
    }

    
    
    /**
     * 첨부파일 입력
     * @param request
     * @param vo
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/board/attachIns", method = RequestMethod.POST)
    public String attachIns(MultipartHttpServletRequest request, @ModelAttribute AttachVO vo, Model model) throws Exception {
    	try {
	    	AttachSet set = new AttachSet();
	    	set.setCondiVO(vo);
	    	
	    	Calendar cal = Calendar.getInstance();
	    	String year = Integer.toString(cal.get(Calendar.YEAR));
	    	String month = Integer.toString(cal.get(Calendar.MONTH) + 1);
	    	
	    	if ( month.length() == 1 )
	    		month = "0" + month;
	    	
	    	// 첨부할 루트 디렉토리
	    	String attachFolder = CommUtil.getFileFolder();
	
	    	//년별, 월별 디렉토리 존재여부 체크
	    	File attachDir = new File(attachFolder + year);
	    	if ( !attachDir.exists() )
	    		attachDir.mkdir();
	    	attachDir = new File(attachFolder + year + "//" + month);
	    	if ( !attachDir.exists() )
	    		attachDir.mkdir();
	    	
	    	// 파일 처리
	    	Map<String, MultipartFile> files = request.getFileMap();
	        CommonsMultipartFile cmf = (CommonsMultipartFile) files.get("newFile");
	        
	    	vo.setFileSize(cmf.getFileItem().getSize());
	    	vo.setFileName(UUID.randomUUID().toString());
	    	vo.setFilePath(year + "//" + month + "//");
	    	vo.setOrgFileName(CommUtil.getFileName(cmf.getFileItem().getName()));
	    
	    	//파일 저장
	        File f = new File(attachDir + "//" + vo.getFileName());
	        cmf.transferTo(f);
	
	        //파일 정보를 DB에 저장
	    	set = svr.attachIns(set);
	
	    	model.addAttribute("set", set );
    	} catch ( Exception e ) {
    		e.printStackTrace();
    	}

        return "/board/AttachT";
    }

    /**
     * 첨부파일 삭제
     * @param request
     * @param vo
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/board/attachDel", method = RequestMethod.POST)
    public String attachDel(MultipartHttpServletRequest request, @ModelAttribute AttachVO vo, Model model) throws Exception {
    	try {
	    	AttachSet set = new AttachSet();
	    	set.setCondiVO(vo);
	    	
	    	set = svr.attachDel(set);
	    	
	    	// 파일을 삭제한다.
	    	if ( set.getData() != null ) {
	            String fullFileName = CommUtil.getFileFolder() + set.getData().getFilePath() + set.getData().getFileName();
	
	            File f = new File(fullFileName);
	            f.delete();
	    	}
	     
	    	model.addAttribute("set", set );
    	} catch ( Exception e ) {
    		e.printStackTrace();
    	}

    	return "/board/AttachT";
    }

    @RequestMapping(value = "/board/attachDownload")
    public void attachDownload(MultipartHttpServletRequest request, HttpServletResponse response,@ModelAttribute AttachVO vo, Model model) throws Exception {
    	try {
	    	AttachSet set = new AttachSet();
	    	set.setCondiVO(vo);
	    	
	    	set = svr.attachDownload(set);
	
	    	File downloadFile = new File(CommUtil.getFileFolder() + set.getData().getFilePath() + set.getData().getFileName());
	        FileInputStream inputStream = new FileInputStream(downloadFile);
	         
	        // get MIME type of the file
	        String mimeType = "application/octet-stream";
	 
	        // set content attributes for the response
	        response.setContentType(mimeType);
	        response.setContentLength((int) downloadFile.length());
	 
	        // set headers for the response
	        String headerKey = "Content-Disposition";
	        String headerValue = String.format("attachment; filename=\"%s\"",URLEncoder.encode(set.getData().getOrgFileName(), "utf-8"));
	        response.setHeader(headerKey, headerValue);
	 
	        // get output stream of the response
	        OutputStream outStream = response.getOutputStream();
	 
	        byte[] buffer = new byte[4096];
	        int bytesRead = -1;
	 
	        // write bytes read from the input stream into the output stream
	        while ((bytesRead = inputStream.read(buffer)) != -1) {
	            outStream.write(buffer, 0, bytesRead);
	        }
	 
	        inputStream.close();
	        outStream.close();
    	} catch ( Exception e ) {
    		e.printStackTrace();
    	}
	        
    }
    

}
