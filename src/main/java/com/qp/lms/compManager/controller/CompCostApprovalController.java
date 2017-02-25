package com.qp.lms.compManager.controller;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;

import com.qp.lms.compManager.model.CompCostApprovalSet;
import com.qp.lms.compManager.model.CompCostApprovalVO;
import com.qp.lms.compManager.service.CompCostApprovalService;

/**
 * 회사 비용 결재 리스트
 * @author limsm
 *
 */

@Controller
public class CompCostApprovalController {

	 private static final Logger logger = LoggerFactory.getLogger(CompCostApprovalController.class);

	    @Autowired
	    private CompCostApprovalService svr;

	    /**
	     * 과정비용 입금 리스트
	     * @param vo
	     * @param model
	     * @return
	     * @throws Exception
	     */
	    @RequestMapping(value = "/compCost/compCostApprovalList")
	    public String compCostApprovalList(@ModelAttribute CompCostApprovalVO vo, Model model) throws Exception {
	    	try { 
	    		CompCostApprovalSet set = new CompCostApprovalSet();
		    	set.setCondiVO(vo);
	
		    	set = svr.compCostApprovalList(set);
		    	
		        model.addAttribute("set", set );
	    	} catch ( Exception e ) {
	    		e.printStackTrace();
	    	}

	        return "/compManager/CompCostApprovalList";
	    }
	    
	    
	    

		
}
