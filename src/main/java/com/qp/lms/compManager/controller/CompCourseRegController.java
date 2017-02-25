package com.qp.lms.compManager.controller;



import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.qp.lms.common.CommUtil;
import com.qp.lms.common.SessionUtil;
import com.qp.lms.common.service.CommService;
import com.qp.lms.compManager.model.CompCourseRegSet;
import com.qp.lms.compManager.model.CompCourseRegVO;
import com.qp.lms.compManager.service.CompCourseRegService;
import com.qp.lms.main.model.MainSet;
import com.qp.lms.main.model.MainVO;

/**
 * 회사 강좌 신청 관리
 * @author limsm
 *
 */
@Controller
public class CompCourseRegController {

	private static final Logger logger = LoggerFactory.getLogger(CompCourseRegController.class);

    @Autowired
    private CompCourseRegService svr;

    @Autowired
    private CommService commSvr;

    /**
     * 회사 강좌 리스트 화면
     * @param vo
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/compCourseReg/compCourseRegList")
    public String compCourseRegList(@ModelAttribute CompCourseRegVO vo, Model model) throws Exception {
    	try {
    		CompCourseRegSet set = new CompCourseRegSet();
	    	set.setCondiVO(vo);
	
	    	set.getCondiVO().setUserId(SessionUtil.getSessionUserId());
	    	
	    	set = svr.compCourseRegList(set);
	    	
	        model.addAttribute("set", set );
    	} catch ( Exception e ) {
    		e.printStackTrace();
    	}

        return "/compManager/CompCourseRegList";
    }

    /**
     * 회사 강좌 신청 화면
     * @param vo
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/compCourseReg/compCourseRegU")
    public String compCourseRegU(@ModelAttribute CompCourseRegVO vo, Model model) throws Exception {
    	try {
    		CompCourseRegSet set = new CompCourseRegSet();
	    	set.setCondiVO(vo);
	
	    	set.getCondiVO().setUserId(SessionUtil.getSessionUserId());
	    	
	    	set = svr.compCourseRegU(set);
	    	
	        model.addAttribute("set", set );
    	} catch ( Exception e ) {
    		e.printStackTrace();
    	}

        return "/compManager/CompCourseRegU";
    }

    /**
     * 직원 강좌 신청
     * @param vo
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/compCourseReg/compCourseRegister", method = RequestMethod.POST)
    public String compCourseRegister(@ModelAttribute CompCourseRegVO vo, Model model) throws Exception {
    	try {
    		CompCourseRegSet set = new CompCourseRegSet();
	    	set.setCondiVO(vo);
	    	
	    	set = svr.compCourseRegister(set);
	    	
	    	model.addAttribute("json", CommUtil.getJsonObject(set.getRtnMode(),""));
    	} catch ( Exception e ) {
    		e.printStackTrace();
    	}
    	
        return "/common/json";
    }

    /**
     * 직원 강좌 신청 취소
     * @param vo
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/compCourseReg/compCourseRegisterCancel", method = RequestMethod.POST)
    public String compCourseRegisterCancel(@ModelAttribute CompCourseRegVO vo, Model model) throws Exception {
    	try {
    		CompCourseRegSet set = new CompCourseRegSet();
	    	set.setCondiVO(vo);
	    	
	    	set = svr.compCourseRegisterCancel(set);
	    	
	    	model.addAttribute("json", CommUtil.getJsonObject(set.getRtnMode(),""));
    	} catch ( Exception e ) {
    		e.printStackTrace();
    	}
    	
        return "/common/json";
    }

    /**
     * 결재 신청
     * @param vo
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/compCourseReg/application")
    public String application(HttpServletRequest request, @ModelAttribute CompCourseRegVO vo, Model model) throws Exception {
    	try {
    		CompCourseRegSet set = new CompCourseRegSet();
	    	set.setCondiVO(vo);

			set = svr.application(set);
		    	
	        model.addAttribute("set", set );
	        
	        request.setAttribute("serverMode", commSvr.getSetting("SERVER_MODE"));
	    	request.setAttribute("g_conf_home_dir", commSvr.getSetting("g_conf_home_dir"));
	    	request.setAttribute("g_conf_key_dir", commSvr.getSetting("g_conf_key_dir"));
	    	request.setAttribute("g_conf_log_dir", commSvr.getSetting("g_conf_log_dir"));
	    	request.setAttribute("g_conf_gw_url", commSvr.getSetting("g_conf_gw_url"));
	    	request.setAttribute("g_conf_js_url", commSvr.getSetting("g_conf_js_url"));
	    	request.setAttribute("g_conf_server", commSvr.getSetting("g_conf_server"));
	    	request.setAttribute("g_conf_site_cd", commSvr.getSetting("g_conf_site_cd"));
	    	request.setAttribute("g_conf_site_key", commSvr.getSetting("g_conf_site_key"));
	    	request.setAttribute("g_conf_site_name", commSvr.getSetting("g_conf_site_name"));
    	} catch ( Exception e ) {
    		e.printStackTrace();
    	}

    	return "/compManager/Application";
    }
    
    /**
     * 결재 요청...
     * @param vo
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/compCourseReg/ppAxHub")
    public String ppAxHub(HttpServletRequest request, @ModelAttribute MainVO vo, Model model) throws Exception {
		MainSet set = new MainSet();
    	try {
    		set.setCondiVO(vo);
    		
	        model.addAttribute("set", set );
    	} catch ( Exception e ) {
    		e.printStackTrace();
    	}

    	String serverMode = commSvr.getSetting("SERVER_MODE");
    	request.setAttribute("serverMode", serverMode);

    	request.setAttribute("g_conf_home_dir", commSvr.getSetting("g_conf_home_dir"));
    	request.setAttribute("g_conf_key_dir", commSvr.getSetting("g_conf_key_dir"));
    	request.setAttribute("g_conf_log_dir", commSvr.getSetting("g_conf_log_dir"));
    	request.setAttribute("g_conf_gw_url", commSvr.getSetting("g_conf_gw_url"));
    	request.setAttribute("g_conf_js_url", commSvr.getSetting("g_conf_js_url"));
    	request.setAttribute("g_conf_server", commSvr.getSetting("g_conf_server"));
    	request.setAttribute("g_conf_site_cd", commSvr.getSetting("g_conf_site_cd"));
    	request.setAttribute("g_conf_site_key", commSvr.getSetting("g_conf_site_key"));
    	request.setAttribute("g_conf_site_name", commSvr.getSetting("g_conf_site_name"));
    	
    	if ( "REAL".equals(serverMode) ) {
    		return "/compManager/pp_ax_hub_linux";
    	} else {
    		return "/compManager/pp_ax_hub_win";
    	}
    }

    /**
     * 카드등 결재 완료후 처리
     * @param vo
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/compCourseReg/result")
    public String result(MainVO vo) throws Exception {
    	try {
    		MainSet set = new MainSet();
    		set.setCondiVO(vo);

    	} catch ( Exception e ) {
    		e.printStackTrace();
    	}
    	
    	return "/compManager/result";
    }
    

    /**
     * 결재팝업
     * @param vo
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/compCourseReg/approvalP")
    public String approvalP(@ModelAttribute CompCourseRegVO vo, Model model) throws Exception {
    	try {
    		CompCourseRegSet set = new CompCourseRegSet();
	    	set.setCondiVO(vo);

	        model.addAttribute("set", set );
    	} catch ( Exception e ) {
    		e.printStackTrace();
    	}

    	return "/compManager/ApprovalP";
    }

    /**
     * 결재
     * @param vo
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/compCourseReg/approval", method = RequestMethod.POST)
    public String approval(@ModelAttribute CompCourseRegVO vo, Model model) throws Exception {
    	try {
    		CompCourseRegSet set = new CompCourseRegSet();
	    	set.setCondiVO(vo);

    		set = svr.approval(set);
    		
	    	model.addAttribute("json", CommUtil.getJsonObject(set.getRtnMode(),""));
    	} catch ( Exception e ) {
    		e.printStackTrace();
    	}

        return "/common/json";
    }
    
}
