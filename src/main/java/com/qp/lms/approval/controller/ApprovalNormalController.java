package com.qp.lms.approval.controller;



import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.qp.lms.approval.model.ApprovalNormalSet;
import com.qp.lms.approval.model.ApprovalNormalVO;
import com.qp.lms.approval.service.ApprovalNormalService;
import com.qp.lms.common.CommUtil;

/**
 * 일반강좌 비용관리
 * @author limsm
 *
 */

@Controller  
public class ApprovalNormalController {

	 private static final Logger logger = LoggerFactory.getLogger(ApprovalNormalController.class);

    @Autowired
    private ApprovalNormalService svr;

    /**
     * 입금 리스트
     * @param vo
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/approvalNormal/approvalNormalList")
    public String approvalNormalList(@ModelAttribute ApprovalNormalVO vo, Model model) throws Exception {
    	try {
	    	ApprovalNormalSet set = new ApprovalNormalSet();
	    	set.setCondiVO(vo);
	    	
	    	set = svr.approvalNormalList(set);
	    	
	        model.addAttribute("set", set );
    	} catch ( Exception e ) {
    		e.printStackTrace();
    	}
    	
        return "/approval/ApprovalNormalList";
    }

    /**
     * 환불 처리화면
     * @param vo
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/approvalNormal/approvalNormalRefundP")
    public String approvalNormalRefundP(@ModelAttribute ApprovalNormalVO vo, Model model) throws Exception {
    	try {
	    	ApprovalNormalSet set = new ApprovalNormalSet();
	    	set.setCondiVO(vo);
	    	
	    	set = svr.approvalNormalRefundP(set);
	    	
	        model.addAttribute("set", set );
    	} catch ( Exception e ) {
    		e.printStackTrace();
    	}
    	
        return "/approval/ApprovalNormalRefundP";
    }
    
    /**
     * 미입금 리스트
     * @param vo
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/approvalNormal/waitingApprovalNormalList")
    public String waitingApprovalNormalList(@ModelAttribute ApprovalNormalVO vo, Model model) throws Exception {
    	try {
	    	ApprovalNormalSet set = new ApprovalNormalSet();
	    	set.setCondiVO(vo);
	    	
	    	set = svr.waitingApprovalNormalList(set);
	    	
	        model.addAttribute("set", set );
    	} catch ( Exception e ) {
    		e.printStackTrace();
    	}
    	
        return "/approval/WaitingApprovalNormalList";
    }

    /**
     * 환불 리스트
     * @param vo
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/approvalNormal/refundNormalList")
    public String refundNormalList(@ModelAttribute ApprovalNormalVO vo, Model model) throws Exception {
    	try {
	    	ApprovalNormalSet set = new ApprovalNormalSet();
	    	set.setCondiVO(vo);
	    	
	    	set = svr.refundNormalList(set);
	    	
	        model.addAttribute("set", set );
    	} catch ( Exception e ) {
    		e.printStackTrace();
    	}
    	
        return "/approval/RefundNormalList";
    }
    
    ///////////////////////////////////////////////// Transaction ////////////////////////////////////////////////////
    
    
    /**
     * 입금 확인처리를 한다.
     * @param vo
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/approvalNormal/paymentConfrm", method = RequestMethod.POST)
    public String paymentConfrm(@ModelAttribute ApprovalNormalVO vo, Model model) throws Exception {
    	try {
	    	ApprovalNormalSet set = new ApprovalNormalSet();
	    	set.setCondiVO(vo);
	    	
	    	set = svr.paymentConfrm(set);
	    	
	    	model.addAttribute("json", CommUtil.getJsonObject(set.getRtnMode(),""));
    	} catch ( Exception e ) {
    		e.printStackTrace();
    	}

    	return "/common/json";
    }

    /**
     * 한불처리를 한다.
     * @param vo
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/approvalNormal/approvalNormalRefundUpd", method = RequestMethod.POST)
    public String approvalNormalRefundUpd(@ModelAttribute ApprovalNormalVO vo, Model model) throws Exception {
    	try {
	    	ApprovalNormalSet set = new ApprovalNormalSet();
	    	set.setCondiVO(vo);
	    	
	    	set = svr.approvalNormalRefundUpd(set);
	    	
	    	model.addAttribute("json", CommUtil.getJsonObject(set.getRtnMode(),""));
    	} catch ( Exception e ) {
    		e.printStackTrace();
    	}

    	return "/common/json";
    }

}
