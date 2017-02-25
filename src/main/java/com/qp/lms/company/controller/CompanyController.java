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
import com.qp.lms.company.model.CompanyVO;
import com.qp.lms.company.service.CompanyService;

/**
 * 회사 관리
 * @author limsm
 *
 */
@Controller
public class CompanyController {

	private static final Logger logger = LoggerFactory.getLogger(CompanyController.class);

    @Autowired
    private CompanyService svr;

    /**
     * 회사 리스트 화면
     * @param vo
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/company/companyList")
    public String companyList(@ModelAttribute CompanyVO vo, Model model) throws Exception {
    	try {
    		CompanySet set = new CompanySet();
	    	set.setCondiVO(vo);
	
	    	set = svr.companyList(set);
	    	
	        model.addAttribute("set", set );
    	} catch ( Exception e ) {
    		e.printStackTrace();
    	}

        return "/company/CompanyList";
    }
 
    /**
     * 회사 등록 화면
     * @param vo
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/company/companyN")
    public String companyN(@ModelAttribute CompanyVO vo, Model model) throws Exception {
    	try {
    		CompanySet set = new CompanySet();
	    	set.setCondiVO(vo);
	    	
	    	set = svr.companyN(set);
	    	
	        model.addAttribute("set", set );
    	} catch ( Exception e ) {
    		e.printStackTrace();
    	}

        return "/company/CompanyN";
    }

    /**
     * 회사 조회 화면
     * @param vo
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/company/companyV")
    public String companyV(@ModelAttribute CompanyVO vo, Model model) throws Exception {
    	try {
    		CompanySet set = new CompanySet();
	    	set.setCondiVO(vo);
	    	
	    	set = svr.companyV(set);
	    	
	        model.addAttribute("set", set );
    	} catch ( Exception e ) {
    		e.printStackTrace();
    	}

        return "/company/CompanyV";
    }
    
    /**
     * 회사 수정 화면
     * @param vo
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/company/companyU")
    public String companyU(@ModelAttribute CompanyVO vo, Model model) throws Exception {
    	try {
    		CompanySet set = new CompanySet();
	    	set.setCondiVO(vo);
	    	
	    	set = svr.companyU(set);
	    	
	        model.addAttribute("set", set );
    	} catch ( Exception e ) {
    		e.printStackTrace();
    	}

        return "/company/CompanyU";
    }

    
    
    ///////////////////////////////////////////////// Transaction ////////////////////////////////////////////////////
    /**
     * 회사 생성
     * @param vo
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/company/companyNIns", method = RequestMethod.POST)
    public String companyNIns(@ModelAttribute CompanyVO vo, Model model) throws Exception {
    	try {
    		CompanySet set = new CompanySet();
	    	set.setCondiVO(vo);
	    	
	    	set = svr.companyNIns(set);
	    	
	    	model.addAttribute("json", CommUtil.getJsonObject(set.getRtnMode(),""));
    	} catch ( Exception e ) {
    		e.printStackTrace();
    	}
    	
        return "/common/json";
    }

    
    /**
     * 회사 수정
     * @param vo
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/company/companyUUpd", method = RequestMethod.POST)
    public String companyUUpd(@ModelAttribute CompanyVO vo, Model model) throws Exception {
    	try {
    		CompanySet set = new CompanySet();
	    	set.setCondiVO(vo);
	    	
	    	set = svr.companyUUpd(set);
	    	
	    	model.addAttribute("json", CommUtil.getJsonObject(set.getRtnMode(),""));
    	} catch ( Exception e ) {
    		e.printStackTrace();
    	}

    	return "/common/json";
    }
    
    /**
     * 회사 삭제
     * @param vo
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/company/companyDel", method = RequestMethod.POST)
    public String companyDel(@ModelAttribute CompanyVO vo, Model model) throws Exception {
    	try {
    		CompanySet set = new CompanySet();
	    	set.setCondiVO(vo);
	    	
	    	set = svr.companyDel(set);
	    	
	    	model.addAttribute("json", CommUtil.getJsonObject(set.getRtnMode(),""));
    	} catch ( Exception e ) {
    		e.printStackTrace();
    	}

        return "/common/json";
    }

}
