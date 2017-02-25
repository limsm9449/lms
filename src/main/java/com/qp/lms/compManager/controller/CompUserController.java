package com.qp.lms.compManager.controller;



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

import com.qp.lms.common.CommUtil;
import com.qp.lms.common.SessionUtil;
import com.qp.lms.compManager.model.CompUserSet;
import com.qp.lms.compManager.model.CompUserVO;
import com.qp.lms.compManager.service.CompUserService;
import com.qp.lms.course.model.CourseResourceVO;
import com.qp.lms.member.model.MemberSet;
import com.qp.lms.member.model.MemberVO;
import com.qp.lms.member.service.MemberService;

/**
 * 회사 직원 관리
 * @author limsm
 *
 */
@Controller
public class CompUserController {

	private static final Logger logger = LoggerFactory.getLogger(CompUserController.class);

    @Autowired
    private CompUserService svr;
    @Autowired
    private MemberService memberSvr;

    /**
     * 회사 직원 화면
     * @param vo
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/compUser/compUserList")
    public String compManagerList(@ModelAttribute CompUserVO vo, Model model) throws Exception {
    	try {
    		CompUserSet set = new CompUserSet();
	    	set.setCondiVO(vo);
	
	    	set.getCondiVO().setUserId(SessionUtil.getSessionUserId());
	    	
	    	set = svr.compUserList(set);
	    	
	        model.addAttribute("set", set );
    	} catch ( Exception e ) {
    		e.printStackTrace();
    	}

        return "/compManager/CompUserList";
    }
 
    /**
     * 양식 다운로드
     * @param request
     * @param vo
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/compUser/ExcelFormCompanyUser")
    public String excelFormCourseResource(@ModelAttribute CompUserVO vo, Model model) throws Exception {
    	try {
    	} catch ( Exception e ) {
    		e.printStackTrace();
    	}

		return "ExcelFormCompanyUserView";
    }

    /**
     * 엑셀 업로드
     * @param request
     * @param vo
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/compUser/excelUpload", method = RequestMethod.POST)
    public String excelUpload(MultipartHttpServletRequest request, @ModelAttribute CompUserVO vo, Model model) throws Exception {
		CompUserSet set = new CompUserSet();
    	try {
	    	set.setCondiVO(vo);
	    	
	    	// 첨부할 루트 디렉토리
	    	String attachFolder = CommUtil.getFileFolder();
	
	    	//년별, 월별 디렉토리 존재여부 체크
	    	File attachDir = new File(attachFolder + "temp");
	    	if ( !attachDir.exists() )
	    		attachDir.mkdir();

	        set.getCondiVO().setFileName(attachDir + "//" + UUID.randomUUID().toString());

	    	// 파일 처리
	    	Map<String, MultipartFile> files = request.getFileMap();
	        CommonsMultipartFile cmf = (CommonsMultipartFile) files.get("newFile");
	        
	    	//파일 저장
	        File f = new File(set.getCondiVO().getFileName());
	        cmf.transferTo(f);
	
	    	set = svr.excelUpload(set);
	
	    	model.addAttribute("set", set );
    	} catch ( Exception e ) {
    		e.printStackTrace();
    	}

    	if ( "DUPLICATION".equals(set.getRtnMode()) )
    		return "uploadInvalidExcel";
    	else
    		return "/common/Tran";
    	
    }
    
    /**
     * 회사 직원 삭제
     * @param vo
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/compUser/compUserDel", method = RequestMethod.POST)
    public String compUserDel(@ModelAttribute MemberVO vo, Model model) throws Exception {
    	try {
    		MemberSet set = new MemberSet();
	    	set.setCondiVO(vo);
	    	
	    	set = memberSvr.memberDel(set);
	    	
	    	model.addAttribute("json", CommUtil.getJsonObject(set.getRtnMode(),""));
    	} catch ( Exception e ) {
    		e.printStackTrace();
    	}
    	
        return "/common/json";
    }
    
}
