package com.qp.lms.ax.pg.controller;

import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.qp.lms.ax.pg.service.AxPgService;
import com.qp.lms.common.CommUtil;
import com.qp.lms.common.SessionUtil;
import com.qp.lms.common.service.CommService;

@Controller
public class AxPgController {

	private static final Logger logger = LoggerFactory.getLogger(AxPgController.class);

    @Autowired
    private AxPgService svr;

    @Autowired
    private CommService commSvr;

    @RequestMapping(value = "/paymentGateway/axApplication", method = RequestMethod.POST )
    public String axApplication(@RequestParam HashMap<String,Object> paramMap, HttpServletRequest request, HttpServletResponse response, Model model) throws Exception {
    	try {
    		svr.axApplication(paramMap, model);

    		request.setAttribute("KIND", paramMap.get("KIND"));

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

    	return "/pg/axApplication";
    }

    @RequestMapping(value = "/paymentGateway/axApproval", method = RequestMethod.POST )
    public String axApproval(@RequestParam HashMap<String,Object> paramMap, HttpServletRequest request, HttpServletResponse response, Model model) throws Exception {
    	HashMap<String, Object> hm = new HashMap<String, Object>();

    	try {
    		hm = svr.axApproval(paramMap);
    		
    		model.addAttribute("json", CommUtil.getJsonObject((String)hm.get("RtnMode"), ""));
    	} catch ( Exception e ) {
    		e.printStackTrace();
    	}

    	return "/common/json";
    }

    @RequestMapping(value = "/paymentGateway/ppAxHub", method = RequestMethod.POST)
    public String ppAxHub(@RequestParam HashMap<String,Object> paramMap, HttpServletRequest request, HttpServletResponse response, Model model) throws Exception {

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

    	model.addAttribute("courseId" , paramMap.get("courseId"));
    	model.addAttribute("totalCost" , paramMap.get("totalCost"));
    	model.addAttribute("paymentPoint" , paramMap.get("paymentPoint"));
    	model.addAttribute("paymentCost" , paramMap.get("paymentCost"));
    	model.addAttribute("paymentKind" , paramMap.get("paymentKind"));
    	model.addAttribute("paymentBank" , paramMap.get("paymentBank"));
    	model.addAttribute("approvalId" , paramMap.get("approvalId"));
		
    	if ( "REAL".equals(serverMode) ) {
    		return "/pg/pp_ax_hub_linux";
    	} else {
    		return "/pg/pp_ax_hub_win";
    	}
    }

    @RequestMapping(value = "/paymentGateway/result", method = RequestMethod.POST)
    public String result(@RequestParam HashMap<String,Object> paramMap, HttpServletRequest request, HttpServletResponse response, Model model) throws Exception {
   		return "/pg/pp_result";
    }
}
