package com.qp.lms.company.controller;



import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.qp.lms.common.CommUtil;
import com.qp.lms.company.model.CompanySet;
import com.qp.lms.company.model.CompanyUserSet;
import com.qp.lms.company.model.CompanyUserVO;
import com.qp.lms.company.service.CompanyUserService;

/**
 * 회사 직원 관리
 * @author limsm
 *
 */
@Controller
public class CompanyUserController {

	private static final Logger logger = LoggerFactory.getLogger(CompanyController.class);

    @Autowired
    private CompanyUserService svr;

    /**
     * 회사 직원 리스트 화면
     * @param vo
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/companyUser/companyUserList")
    public String companyUserList(@ModelAttribute CompanyUserVO vo, Model model) throws Exception {
    	try {
    		CompanyUserSet set = new CompanyUserSet();
	    	set.setCondiVO(vo);
	
	    	set = svr.companyUserList(set);
	    	
	        model.addAttribute("set", set );
    	} catch ( Exception e ) {
    		e.printStackTrace();
    	}

        return "/company/CompanyUserList";
    }
 
   
    
    ///////////////////////////////////////////////// Transaction ////////////////////////////////////////////////////
       
    /**
     * 패스워드 변경
     * @param vo
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/companyUser/companyUserPwdReset", method = RequestMethod.POST)
    public String companyUserPwdReset(@ModelAttribute CompanyUserVO vo, Model model) throws Exception {
    	try {
    		CompanyUserSet set = new CompanyUserSet();
	    	set.setCondiVO(vo);
	    	
	    	set = svr.companyUserPwdReset(set);
	    	
	    	model.addAttribute("json", CommUtil.getJsonObject(set.getRtnMode(),""));
    	} catch ( Exception e ) {
    		e.printStackTrace();
    	}

    	return "/common/json";
    }

}
