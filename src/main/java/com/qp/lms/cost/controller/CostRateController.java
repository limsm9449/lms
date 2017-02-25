package com.qp.lms.cost.controller;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.qp.lms.common.CommUtil;
import com.qp.lms.cost.model.CostRateSet;
import com.qp.lms.cost.model.CostRateVO;
import com.qp.lms.cost.service.CostRateService;

/**
 * 비용 비율 관리 
 * @author limsm
 *
 */

@Controller
public class CostRateController {

	 private static final Logger logger = LoggerFactory.getLogger(CostRateController.class);

	    @Autowired
	    private CostRateService svr;

	    /**
	     * 비용 비율 리스트
	     * @param vo
	     * @param model
	     * @return
	     * @throws Exception
	     */
	    @RequestMapping(value = "/cost/costRateList")
	    public String costRateList(@ModelAttribute CostRateVO vo, Model model) throws Exception {
	    	try { 
		    	CostRateSet set = new CostRateSet();
		    	set.setCondiVO(vo);
	
		    	set = svr.costRateList(set);
		    	
		        model.addAttribute("set", set );
	    	} catch ( Exception e ) {
	    		e.printStackTrace();
	    	}

	        return "/cost/CostRateList";
	    }

	    /**
	     * 과정코드 수정 화면
	     * @param vo
	     * @param model
	     * @return
	     * @throws Exception
	     */
	    @RequestMapping(value = "/cost/costRateU")
	    public String costRateU(@ModelAttribute CostRateVO vo, Model model) throws Exception {
	    	try {
		    	CostRateSet set = new CostRateSet();
		    	set.setCondiVO(vo);
		    	
		    	set = svr.costRateU(set);
		    	
		    	model.addAttribute("set", set );
	    	} catch ( Exception e ) {
	    		e.printStackTrace();
	    	}

	        return "/cost/CostRateU";
	    }

	    
	    
	    ///////////////////////////////////////////////// Transaction ////////////////////////////////////////////////////

	    /**
	     * 과정코드 수정 
	     * @param vo
	     * @param model
	     * @return
	     * @throws Exception
	     */
	    @RequestMapping(value = "/cost/costRateUUpd", method = RequestMethod.POST)
	    public String costRateUUpd(@ModelAttribute CostRateVO vo, Model model) throws Exception {
	    	try {
		    	CostRateSet set = new CostRateSet();
		    	set.setCondiVO(vo);
		    	
		    	set = svr.costRateUUpd(set);
		    	
		    	model.addAttribute("json", CommUtil.getJsonObject(set.getRtnMode(),""));
	    	} catch ( Exception e ) {
	    		e.printStackTrace();
	    	}

	        return "/common/json";
	    }


	    
}
