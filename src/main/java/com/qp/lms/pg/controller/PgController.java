package com.qp.lms.pg.controller;



import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.context.WebApplicationContext;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;
import org.springframework.web.context.support.WebApplicationContextUtils;

import com.qp.lms.common.CommUtil;
import com.qp.lms.common.SessionUtil;
import com.qp.lms.common.service.CommService;
import com.qp.lms.pg.model.PgSet;
import com.qp.lms.pg.model.PgVO;
import com.qp.lms.pg.service.PgService;

@Controller
public class PgController {

	private static final Logger logger = LoggerFactory.getLogger(PgController.class);

    @Autowired
    private PgService svr;

    @Autowired
    private CommService commSvr;

    @RequestMapping(value = "/paymentGateway/pay", method = RequestMethod.POST)
    public String pay(HttpServletRequest request, @ModelAttribute PgVO vo, Model model) throws Exception {
    	try {
	    	PgSet set = new PgSet();
			set.setCondiVO(vo);
			
			set.getCondiVO().setUserId(SessionUtil.getSessionUserId());
	
			set = svr.payInfo(set);
	    	
	        model.addAttribute("set", set );
	
	    	request.setAttribute("g_CST_MID", commSvr.getSetting("g_CST_MID"));
	    	request.setAttribute("g_CST_PLATFORM", commSvr.getSetting("g_CST_PLATFORM"));
    	} catch ( Exception e ) {
    		e.printStackTrace();
    	}

        return CommUtil.getCompTypePage("/pg/payInfo");
    }

    @RequestMapping(value = "/paymentGateway/cartPay", method = RequestMethod.POST)
    public String cartPay(HttpServletRequest request, @ModelAttribute PgVO vo, Model model) throws Exception {
    	try {
    		PgSet set = new PgSet();
    		set.setCondiVO(vo);

    		set.getCondiVO().setUserId(SessionUtil.getSessionUserId());

			set = svr.payInfo(set);
	    	
	        model.addAttribute("set", set );

	    	request.setAttribute("g_CST_MID", commSvr.getSetting("g_CST_MID"));
	    	request.setAttribute("g_CST_PLATFORM", commSvr.getSetting("g_CST_PLATFORM"));
    	} catch ( Exception e ) {
    		e.printStackTrace();
    	}

        return CommUtil.getCompTypePage("/pg/payInfo");
    }
    
    @RequestMapping(value = "/paymentGateway/payreqCrossplatform", method = RequestMethod.POST)
    public String payreqCrossplatform(HttpServletRequest request, Model model) throws Exception {
    	request.setAttribute("serverMode", commSvr.getSetting("SERVER_MODE"));

    	request.setAttribute("g_LGD_CASNOTEURL", commSvr.getSetting("g_LGD_CASNOTEURL"));
    	request.setAttribute("g_LGD_RETURNURL", commSvr.getSetting("g_LGD_RETURNURL"));
    	request.setAttribute("g_LGD_MERTKEY", commSvr.getSetting("g_LGD_MERTKEY"));
    	request.setAttribute("g_xpay_js", commSvr.getSetting("g_xpay_js"));
    	
        return "/pg/payreq_crossplatform";
    }
    
    @RequestMapping(value = "/paymentGateway/casNoteUrl")
    public String casNoteUrl(HttpServletRequest request, Model model) throws Exception {
        return "/pg/cas_noteurl";
    }

    @RequestMapping(value = "/paymentGateway/returnUrl")
    public String returnUrl(HttpServletRequest request, Model model) throws Exception {
        return "/pg/returnurl";
    }

    @RequestMapping(value = "/paymentGateway/payres")
    public String payres(HttpServletRequest request, Model model) throws Exception {
    	request.setAttribute("g_configPath", commSvr.getSetting("g_configPath"));

        return "/pg/payres";
    }

    @RequestMapping(value = "/paymentGateway/cashApproval")
    public String cashApproval(HttpServletRequest request, @ModelAttribute PgVO vo, Model model) throws Exception {
    	try {
    		PgSet set = new PgSet();
    		set.setCondiVO(vo);

    		set = svr.approval(set);
    		
	    	model.addAttribute("json", CommUtil.getJsonObject(set.getRtnMode(),""));
    	} catch ( Exception e ) {
    		e.printStackTrace();
    	}

        return "/common/json";
    }

    @RequestMapping(value = "/paymentGateway/cancelInfo", method = RequestMethod.POST)
    public String cancelInfo(HttpServletRequest request, Model model) throws Exception {
    	request.setAttribute("g_CST_MID", commSvr.getSetting("g_CST_MID"));
    	request.setAttribute("g_CST_PLATFORM", commSvr.getSetting("g_CST_PLATFORM"));
    	
        return "/pg/CancelInfo";
    }

    @RequestMapping(value = "/paymentGateway/cancel", method = RequestMethod.POST)
    public String cancel(HttpServletRequest request, Model model) throws Exception {
    	request.setAttribute("g_configPath", commSvr.getSetting("g_configPath"));

    	return "/pg/Cancel";
    }

    @RequestMapping(value = "/paymentGateway/complete", method = RequestMethod.POST)
    public String complete(HttpServletRequest request, @ModelAttribute PgVO vo, Model model) throws Exception {
        return CommUtil.getCompTypePage("/pg/complete");
    }

}
