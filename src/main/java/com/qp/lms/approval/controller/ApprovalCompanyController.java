package com.qp.lms.approval.controller;



import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.qp.lms.approval.model.ApprovalCompanySet;
import com.qp.lms.approval.model.ApprovalCompanyVO;
import com.qp.lms.approval.service.ApprovalCompanyService;
import com.qp.lms.common.CommUtil;

/**
 * 회사 비용관리
 * @author limsm
 *
 */

@Controller  
public class ApprovalCompanyController {

	 private static final Logger logger = LoggerFactory.getLogger(ApprovalCompanyController.class);

    @Autowired
    private ApprovalCompanyService svr;

    /**
     * 입금 리스트
     * @param vo
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/approvalCompany/approvalCompanyList")
    public String approvalCompanyList(@ModelAttribute ApprovalCompanyVO vo, Model model) throws Exception {
    	try {
	    	ApprovalCompanySet set = new ApprovalCompanySet();
	    	set.setCondiVO(vo);
	    	
	    	set = svr.approvalCompanyList(set);
	    	
	        model.addAttribute("set", set );
    	} catch ( Exception e ) {
    		e.printStackTrace();
    	}
    	
        return "/approval/ApprovalCompanyList";
    }

    /**
     * 환불 처리화면
     * @param vo
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/approvalCompany/approvalCompanyRefundP")
    public String approvalCompanyRefundP(@ModelAttribute ApprovalCompanyVO vo, Model model) throws Exception {
    	try {
	    	ApprovalCompanySet set = new ApprovalCompanySet();
	    	set.setCondiVO(vo);
	    	
	    	set = svr.approvalCompanyRefundP(set);
	    	
	        model.addAttribute("set", set );
    	} catch ( Exception e ) {
    		e.printStackTrace();
    	}
    	
        return "/approval/ApprovalCompanyRefundP";
    }
    
    /**
     * 미입금 리스트
     * @param vo
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/approvalCompany/waitingApprovalCompanyList")
    public String waitingApprovalCompanyList(@ModelAttribute ApprovalCompanyVO vo, Model model) throws Exception {
    	try {
	    	ApprovalCompanySet set = new ApprovalCompanySet();
	    	set.setCondiVO(vo);
	    	
	    	set = svr.waitingApprovalCompanyList(set);
	    	
	        model.addAttribute("set", set );
    	} catch ( Exception e ) {
    		e.printStackTrace();
    	}
    	
        return "/approval/WaitingApprovalCompanyList";
    }

    /**
     * 환불 리스트
     * @param vo
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/approvalCompany/refundCompanyList")
    public String refundCompanyList(@ModelAttribute ApprovalCompanyVO vo, Model model) throws Exception {
    	try {
	    	ApprovalCompanySet set = new ApprovalCompanySet();
	    	set.setCondiVO(vo);
	    	
	    	set = svr.refundCompanyList(set);
	    	
	        model.addAttribute("set", set );
    	} catch ( Exception e ) {
    		e.printStackTrace();
    	}
    	
        return "/approval/RefundCompanyList";
    }
    
    ///////////////////////////////////////////////// Transaction ////////////////////////////////////////////////////
    
    
    /**
     * 입금 확인처리를 한다.
     * @param vo
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/approvalCompany/paymentConfrm", method = RequestMethod.POST)
    public String paymentConfrm(@ModelAttribute ApprovalCompanyVO vo, Model model) throws Exception {
    	try {
	    	ApprovalCompanySet set = new ApprovalCompanySet();
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
    @RequestMapping(value = "/approvalCompany/approvalCompanyRefundUpd", method = RequestMethod.POST)
    public String approvalCompanyRefundUpd(@ModelAttribute ApprovalCompanyVO vo, Model model) throws Exception {
    	try {
	    	ApprovalCompanySet set = new ApprovalCompanySet();
	    	set.setCondiVO(vo);
	    	
	    	set = svr.approvalCompanyRefundUpd(set);
	    	
	    	model.addAttribute("json", CommUtil.getJsonObject(set.getRtnMode(),""));
    	} catch ( Exception e ) {
    		e.printStackTrace();
    	}

    	return "/common/json";
    }

}
