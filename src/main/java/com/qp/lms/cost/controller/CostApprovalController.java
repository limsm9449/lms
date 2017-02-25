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
import com.qp.lms.cost.model.CostApprovalSet;
import com.qp.lms.cost.model.CostApprovalVO;
import com.qp.lms.cost.service.CostApprovalService;
import com.qp.lms.course.model.CourseManageSet;
import com.qp.lms.course.model.CourseManageVO;

/**
 * 비용 결재 리스트
 * @author limsm
 *
 */

@Controller
public class CostApprovalController {

	 private static final Logger logger = LoggerFactory.getLogger(CostApprovalController.class);

	    @Autowired
	    private CostApprovalService svr;

	    /**
	     * 과정비용 입금 관리
	     * @param vo
	     * @param model
	     * @return
	     * @throws Exception
	     */
	    @RequestMapping(value = "/cost/costApprovalList")
	    public String costApprovalList(@ModelAttribute CostApprovalVO vo, Model model) throws Exception {
	    	try {
	    		if ( vo.getfDate() == null ) {
	    			vo.setfDate(CommUtil.getAddDay("yyyy-MM-dd", -7));
	    			vo.settDate(CommUtil.getCurrentDateString("yyyy-MM-dd"));
	    		}
		    	CostApprovalSet set = new CostApprovalSet();
		    	set.setCondiVO(vo);
	
		    	set = svr.costApprovalList(set);
		    	
		        model.addAttribute("set", set );
	    	} catch ( Exception e ) {
	    		e.printStackTrace();
	    	}

	        return "/cost/CostApprovalList";
	    }

	    /**
	     * 환불 화면
	     * @param vo
	     * @param model
	     * @return
	     * @throws Exception
	     */
	    @RequestMapping(value = "/cost/costApprovalRefundV")
	    public String costApprovalRefundV(@ModelAttribute CostApprovalVO vo, Model model) throws Exception {
	    	try { 
		    	CostApprovalSet set = new CostApprovalSet();
		    	set.setCondiVO(vo);
	
		    	set = svr.costApprovalRefundV(set);
		    	
		        model.addAttribute("set", set );
	    	} catch ( Exception e ) {
	    		e.printStackTrace();
	    	}

	        return "/cost/CostApprovalRefundV";
	    }
	    
	    /**
	     * 과정비용 은행입급 확인 관리
	     * @param vo
	     * @param model
	     * @return
	     * @throws Exception
	     */
	    @RequestMapping(value = "/cost/costBankList")
	    public String costBankList(@ModelAttribute CostApprovalVO vo, Model model) throws Exception {
	    	try { 
	    		CostApprovalSet set = new CostApprovalSet();
		    	set.setCondiVO(vo);
	
		    	set = svr.costBankList(set);
		    	
		        model.addAttribute("set", set );
	    	} catch ( Exception e ) {
	    		e.printStackTrace();
	    	}

	        return "/cost/CostBankList";
	    }

	    /**
	     * 과정비용 환불 관리
	     * @param vo
	     * @param model
	     * @return
	     * @throws Exception
	     */
	    @RequestMapping(value = "/cost/costRefundList")
	    public String costRefundList(@ModelAttribute CostApprovalVO vo, Model model) throws Exception {
	    	try { 
	    		if ( vo.getfDate() == null ) {
	    			vo.setfDate(CommUtil.getAddDay("yyyy-MM-dd", -7));
	    			vo.settDate(CommUtil.getCurrentDateString("yyyy-MM-dd"));
	    		}

	    		CostApprovalSet set = new CostApprovalSet();
		    	set.setCondiVO(vo);
	
		    	set = svr.costRefundList(set);
		    	
		        model.addAttribute("set", set );
	    	} catch ( Exception e ) {
	    		e.printStackTrace();
	    	}

	        return "/cost/CostRefundList";
	    }

	    /**
	     * 환불상세화면
	     * @param vo
	     * @param model
	     * @return
	     * @throws Exception
	     */
	    @RequestMapping(value = "/cost/costRefundV")
	    public String costRefundV(@ModelAttribute CostApprovalVO vo, Model model) throws Exception {
	    	try { 
		    	CostApprovalSet set = new CostApprovalSet();
		    	set.setCondiVO(vo);
	
		    	set = svr.costRefundV(set);
		    	
		        model.addAttribute("set", set );
	    	} catch ( Exception e ) {
	    		e.printStackTrace();
	    	}

	        return "/cost/CostRefundV";
	    }
	    
	    
	    
	    
		///////////////////////////////////////////////// Transaction ////////////////////////////////////////////////////
		/**
		* 환불처리
		* @param vo
		* @param model
		* @return
		* @throws Exception
		*/
		@RequestMapping(value = "/cost/costRefundUpd", method = RequestMethod.POST)
		public String costRefundUpd(@ModelAttribute CostApprovalVO vo, Model model) throws Exception {
			try {
				CostApprovalSet set = new CostApprovalSet();
				set.setCondiVO(vo);
				
				set = svr.costRefundUpd(set);
				
				model.addAttribute("json", CommUtil.getJsonObject(set.getRtnMode(),""));
			} catch ( Exception e ) {
				e.printStackTrace();
			}
			
			return "/common/json";
		}

		/**
		* 입금 확인처리
		* @param vo
		* @param model
		* @return
		* @throws Exception
		*/
		@RequestMapping(value = "/cost/costBankUpd", method = RequestMethod.POST)
		public String costBankUpd(@ModelAttribute CostApprovalVO vo, Model model) throws Exception {
			try {
				CostApprovalSet set = new CostApprovalSet();
				set.setCondiVO(vo);
				
				set = svr.costBankUpd(set);
				
				model.addAttribute("json", CommUtil.getJsonObject(set.getRtnMode(),""));
			} catch ( Exception e ) {
				e.printStackTrace();
			}
			
			return "/common/json";
		}

		
}
