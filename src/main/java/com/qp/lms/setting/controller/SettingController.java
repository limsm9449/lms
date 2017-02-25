package com.qp.lms.setting.controller;



import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.qp.lms.common.CommUtil;
import com.qp.lms.setting.model.SettingSet;
import com.qp.lms.setting.model.SettingVO;
import com.qp.lms.setting.service.SettingService;

@Controller
public class SettingController {

	 private static final Logger logger = LoggerFactory.getLogger(SettingController.class);

	    @Autowired
	    private SettingService svr;
	    
	    /**
	     * 메일 분류 리스트
	     * @param vo
	     * @param model
	     * @return
	     * @throws Exception
	     */
	    @RequestMapping(value = "/set/settingList")
	    public String settingList(@ModelAttribute SettingVO vo, Model model) throws Exception {
	    	try {
		    	SettingSet set = new SettingSet();
		    	set.setCondiVO(vo);
		    	
		    	set = svr.settingList(set);
		    	
		    	model.addAttribute("set", set );
	    	} catch ( Exception e ) {
	    		e.printStackTrace();
	    	}

	        return "/setting/SettingList";
	    }

	    /**
	     * 메일 분류 입력/수정/삭제
	     * @param vo
	     * @param model
	     * @return
	     * @throws Exception
	     */
	    @RequestMapping(value = "/set/settingSave", method = RequestMethod.POST)
	    public String settingSave(@ModelAttribute SettingVO vo, Model model) throws Exception {
	    	try {
	    		SettingSet set = new SettingSet();
		    	set.setCondiVO(vo);
		    	
		    	set = svr.settingSave(set);
		    	model.addAttribute("json", CommUtil.getJsonObject(set.getRtnMode(),""));
	    	} catch ( Exception e ) {
	    		e.printStackTrace();
	    	}

	    	return "/common/json";
	    }
	    
	    /**
	     * 메일 분류 리스트
	     * @param vo
	     * @param model
	     * @return
	     * @throws Exception
	     */
	    @RequestMapping(value = "/set/mailList")
	    public String mailList(@ModelAttribute SettingVO vo, Model model) throws Exception {
	    	try {
		    	SettingSet set = new SettingSet();
		    	set.setCondiVO(vo);
		    	
		    	set = svr.mailList(set);
		    	
		    	model.addAttribute("set", set );
	    	} catch ( Exception e ) {
	    		e.printStackTrace();
	    	}

	        return "/setting/MailList";
	    }
	    
	    /**
	     * 메일 분류 입력/수정/삭제
	     * @param vo
	     * @param model
	     * @return
	     * @throws Exception
	     */
	    @RequestMapping(value = "/set/mailSave", method = RequestMethod.POST)
	    public String mailSave(@ModelAttribute SettingVO vo, Model model) throws Exception {
	    	try {
	    		SettingSet set = new SettingSet();
		    	set.setCondiVO(vo);
		    	
		    	set = svr.mailSave(set);
		    	model.addAttribute("json", CommUtil.getJsonObject(set.getRtnMode(),""));
	    	} catch ( Exception e ) {
	    		e.printStackTrace();
	    	}

	    	return "/common/json";
	    }

	    /**
	     * 은행 리스트
	     * @param vo
	     * @param model
	     * @return
	     * @throws Exception
	     */
	    @RequestMapping(value = "/set/bankList")
	    public String bankList(@ModelAttribute SettingVO vo, Model model) throws Exception {
	    	try {
		    	SettingSet set = new SettingSet();
		    	set.setCondiVO(vo);
		    	
		    	set = svr.bankList(set);
		    	
		    	model.addAttribute("set", set );
	    	} catch ( Exception e ) {
	    		e.printStackTrace();
	    	}

	        return "/setting/BankList";
	    }
	    
	    /**
	     * 은행 저장
	     * @param vo
	     * @param model
	     * @return
	     * @throws Exception
	     */
	    @RequestMapping(value = "/set/bankSave", method = RequestMethod.POST)
	    public String bankSave(@ModelAttribute SettingVO vo, Model model) throws Exception {
	    	try {
	    		SettingSet set = new SettingSet();
		    	set.setCondiVO(vo);
		    	
		    	set = svr.bankSave(set);
		    	model.addAttribute("json", CommUtil.getJsonObject(set.getRtnMode(),""));
	    	} catch ( Exception e ) {
	    		e.printStackTrace();
	    	}

	    	return "/common/json";
	    }

}
