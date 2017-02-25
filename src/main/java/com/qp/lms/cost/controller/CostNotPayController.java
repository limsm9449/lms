package com.qp.lms.cost.controller;

import net.sf.json.JSONObject;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.qp.lms.common.CommUtil;
import com.qp.lms.cost.model.CostNotPaySet;
import com.qp.lms.cost.model.CostNotPayVO;
import com.qp.lms.cost.service.CostNotPayService;

/**
 * 비용 미지급 리스트
 * @author limsm
 *
 */

@Controller
public class CostNotPayController {

	 private static final Logger logger = LoggerFactory.getLogger(CostNotPayController.class);

	    @Autowired
	    private CostNotPayService svr;

	    /**
	     * 미지급 비용 리스트
	     * @param vo
	     * @param model
	     * @return
	     * @throws Exception
	     */
	    @RequestMapping(value = "/cost/costNotPayList")
	    public String costNotPayList(@ModelAttribute CostNotPayVO vo, Model model) throws Exception {
	    	try { 
		    	CostNotPaySet set = new CostNotPaySet();
		    	set.setCondiVO(vo);
	
		    	set = svr.costNotPayList(set);
		    	
		        model.addAttribute("set", set );
	    	} catch ( Exception e ) {
	    		e.printStackTrace();
	    	}

	        return "/cost/CostNotPayList";
	    }

	    /**
	     * 미지금 비용 상세
	     * @param vo
	     * @param model
	     * @return
	     * @throws Exception
	     */
	    @RequestMapping(value = "/cost/costNotPayU")
	    public String costNotPayU(@ModelAttribute CostNotPayVO vo, Model model) throws Exception {
	    	try {
		    	CostNotPaySet set = new CostNotPaySet();
		    	set.setCondiVO(vo);
		    	
		    	set = svr.costNotPayU(set);
		    	
		    	model.addAttribute("set", set );
	    	} catch ( Exception e ) {
	    		e.printStackTrace();
	    	}

	        return "/cost/CostNotPayU";
	    }

	    
	    /**
	     * 지급할 금액 확인
	     * @param vo
	     * @param model
	     * @return
	     * @throws Exception
	     */
	    @RequestMapping(value = "/cost/costCheck")
	    public String costCheck(@ModelAttribute CostNotPayVO vo, Model model) throws Exception {
	    	try {
		    	CostNotPaySet set = new CostNotPaySet();
		    	set.setCondiVO(vo);
		    	
		    	set = svr.costCheck(set);
		    	
		    	model.addAttribute("json", JSONObject.fromObject(set.getPaymentData()) );
	    	} catch ( Exception e ) {
	    		e.printStackTrace();
	    	}

	    	return "/common/json";
	    }
	    
	    ///////////////////////////////////////////////// Transaction ////////////////////////////////////////////////////

	    /**
	     * 과정코드 수정 
	     * @param vo
	     * @param model
	     * @return
	     * @throws Exception
	     */
	    @RequestMapping(value = "/cost/costNotPayUUpd", method = RequestMethod.POST)
	    public String costNotPayUUpd(@ModelAttribute CostNotPayVO vo, Model model) throws Exception {
	    	try {
		    	CostNotPaySet set = new CostNotPaySet();
		    	set.setCondiVO(vo);
		    	
		    	set = svr.costNotPayUUpd(set);
		    	
		    	model.addAttribute("json", CommUtil.getJsonObject(set.getRtnMode(),""));
	    	} catch ( Exception e ) {
	    		e.printStackTrace();
	    	}

	        return "/common/json";
	    }


	    
}
