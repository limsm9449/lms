package com.qp.lms.cost.controller;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;

import com.qp.lms.cost.model.CostPaySet;
import com.qp.lms.cost.model.CostPayVO;
import com.qp.lms.cost.service.CostPayService;

/**
 * 비용 지급 리스트
 * @author limsm
 *
 */

@Controller
public class CostPayController {

	 private static final Logger logger = LoggerFactory.getLogger(CostPayController.class);

	    @Autowired
	    private CostPayService svr;

	    /**
	     * 지급 비용 리스트
	     * @param vo
	     * @param model
	     * @return
	     * @throws Exception
	     */
	    @RequestMapping(value = "/cost/costPayList")
	    public String costPayList(@ModelAttribute CostPayVO vo, Model model) throws Exception {
	    	try { 
		    	CostPaySet set = new CostPaySet();
		    	set.setCondiVO(vo);
	
		    	set = svr.costPayList(set);
		    	
		        model.addAttribute("set", set );
	    	} catch ( Exception e ) {
	    		e.printStackTrace();
	    	}

	        return "/cost/CostPayList";
	    }

	    /**
	     * 지급 비용 상세
	     * @param vo
	     * @param model
	     * @return
	     * @throws Exception
	     */
	    @RequestMapping(value = "/cost/costPayV")
	    public String costPayV(@ModelAttribute CostPayVO vo, Model model) throws Exception {
	    	try {
		    	CostPaySet set = new CostPaySet();
		    	set.setCondiVO(vo);
		    	
		    	set = svr.costPayV(set);
		    	
		    	model.addAttribute("set", set );
	    	} catch ( Exception e ) {
	    		e.printStackTrace();
	    	}

	        return "/cost/CostPayV";
	    }

	    /**
	     * Tutor 지급 비용 리스트
	     * @param vo
	     * @param model
	     * @return
	     * @throws Exception
	     */
	    @RequestMapping(value = "/cost/tutorCostPayList")
	    public String tutorCostPayList(@ModelAttribute CostPayVO vo, Model model) throws Exception {
	    	try { 
		    	CostPaySet set = new CostPaySet();
		    	set.setCondiVO(vo);
	
		    	set = svr.tutorCostPayList(set);
		    	
		        model.addAttribute("set", set );
	    	} catch ( Exception e ) {
	    		e.printStackTrace();
	    	}

	        return "/cost/TutorCostPayList";
	    }

	    /**
	     * Tutor 지급 비용 상세
	     * @param vo
	     * @param model
	     * @return
	     * @throws Exception
	     */
	    @RequestMapping(value = "/cost/tutorCostPayV")
	    public String tutorCostPayV(@ModelAttribute CostPayVO vo, Model model) throws Exception {
	    	try {
		    	CostPaySet set = new CostPaySet();
		    	set.setCondiVO(vo);
		    	
		    	set = svr.costPayV(set);
		    	
		    	model.addAttribute("set", set );
	    	} catch ( Exception e ) {
	    		e.printStackTrace();
	    	}

	        return "/cost/TutorCostPayV";
	    }

	    /**
	     * Teacher 지급 비용 리스트
	     * @param vo
	     * @param model
	     * @return
	     * @throws Exception
	     */
	    @RequestMapping(value = "/cost/teacherCostPayList")
	    public String teacherCostPayList(@ModelAttribute CostPayVO vo, Model model) throws Exception {
	    	try { 
		    	CostPaySet set = new CostPaySet();
		    	set.setCondiVO(vo);
	
		    	set = svr.teacherCostPayList(set);
		    	
		        model.addAttribute("set", set );
	    	} catch ( Exception e ) {
	    		e.printStackTrace();
	    	}

	        return "/cost/TeacherCostPayList";
	    }

	    /**
	     * Teacher 지급 비용 상세
	     * @param vo
	     * @param model
	     * @return
	     * @throws Exception
	     */
	    @RequestMapping(value = "/cost/teacherCostPayV")
	    public String teacherCostPayV(@ModelAttribute CostPayVO vo, Model model) throws Exception {
	    	try {
		    	CostPaySet set = new CostPaySet();
		    	set.setCondiVO(vo);
		    	
		    	set = svr.costPayV(set);
		    	
		    	model.addAttribute("set", set );
	    	} catch ( Exception e ) {
	    		e.printStackTrace();
	    	}

	        return "/cost/TeacherCostPayV";
	    }
	    
}
