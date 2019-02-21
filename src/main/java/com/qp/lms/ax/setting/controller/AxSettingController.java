package com.qp.lms.ax.setting.controller;



import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.qp.lms.ax.setting.service.AxSettingService;
import com.qp.lms.common.Constant;
import com.qp.lms.common.service.CommService;

@Controller
public class AxSettingController {

	private static final Logger logger = LoggerFactory.getLogger(AxSettingController.class);

	@Autowired
    private AxSettingService svr;

    @Autowired
    private CommService commSvr;

    @RequestMapping(value = "/setting/axSettingBankList", method = RequestMethod.POST, consumes = "application/json" )
    public @ResponseBody HashMap<String,Object> axSettingBankList(@RequestBody HashMap<String, Object> paramMap, HttpServletRequest request, HttpServletResponse response) throws Exception {
    	HashMap<String, Object> hm = new HashMap<String, Object>();

    	try {
    		hm = svr.axSettingBankList(paramMap);
    	} catch ( Exception e ) {
    		e.printStackTrace();
    	}

        return hm;
    }
    
    @RequestMapping(value = "/setting/axSettingBankSave", method = RequestMethod.POST, consumes = "application/json" )
    public @ResponseBody HashMap<String,Object> axSettingBankSave(@RequestBody HashMap<String, Object> paramMap, HttpServletRequest request, HttpServletResponse response) throws Exception {
    	HashMap<String, Object> hm = new HashMap<String, Object>();
    	
		try {
    		hm = svr.axSettingBankSave(paramMap);
    	} catch ( Exception e ) {
    		e.printStackTrace();
    		hm.put("RtnMode", Constant.mode.ERROR.name());
    	}

        return hm;
    }

    @RequestMapping(value = "/setting/axSettingMailList", method = RequestMethod.POST, consumes = "application/json" )
    public @ResponseBody HashMap<String,Object> axSettingMailList(@RequestBody HashMap<String, Object> paramMap, HttpServletRequest request, HttpServletResponse response) throws Exception {
    	HashMap<String, Object> hm = new HashMap<String, Object>();

    	try {
    		hm = svr.axSettingMailList(paramMap);
    	} catch ( Exception e ) {
    		e.printStackTrace();
    	}

        return hm;
    }
    
    @RequestMapping(value = "/setting/axSettingMailSave", method = RequestMethod.POST, consumes = "application/json" )
    public @ResponseBody HashMap<String,Object> axSettingMailSave(@RequestBody HashMap<String, Object> paramMap, HttpServletRequest request, HttpServletResponse response) throws Exception {
    	HashMap<String, Object> hm = new HashMap<String, Object>();
    	
		try {
    		hm = svr.axSettingMailSave(paramMap);
    	} catch ( Exception e ) {
    		e.printStackTrace();
    		hm.put("RtnMode", Constant.mode.ERROR.name());
    	}

        return hm;
    }

    @RequestMapping(value = "/setting/axSettingConfigList", method = RequestMethod.POST, consumes = "application/json" )
    public @ResponseBody HashMap<String,Object> axSettingConfigList(@RequestBody HashMap<String, Object> paramMap, HttpServletRequest request, HttpServletResponse response) throws Exception {
    	HashMap<String, Object> hm = new HashMap<String, Object>();

    	try {
    		hm = svr.axSettingConfigList(paramMap);
    	} catch ( Exception e ) {
    		e.printStackTrace();
    	}

        return hm;
    }
    
    @RequestMapping(value = "/setting/axSettingConfigSave", method = RequestMethod.POST, consumes = "application/json" )
    public @ResponseBody HashMap<String,Object> axSettingConfigSave(@RequestBody HashMap<String, Object> paramMap, HttpServletRequest request, HttpServletResponse response) throws Exception {
    	HashMap<String, Object> hm = new HashMap<String, Object>();
    	
		try {
    		hm = svr.axSettingConfigSave(paramMap);
    	} catch ( Exception e ) {
    		e.printStackTrace();
    		hm.put("RtnMode", Constant.mode.ERROR.name());
    	}

        return hm;
    }

    @RequestMapping(value = "/setting/axSettingCodeList", method = RequestMethod.POST, consumes = "application/json" )
    public @ResponseBody HashMap<String,Object> axSettingCodeList(@RequestBody HashMap<String, Object> paramMap, HttpServletRequest request, HttpServletResponse response) throws Exception {
    	HashMap<String, Object> hm = new HashMap<String, Object>();

    	try {
    		hm = svr.axSettingCodeList(paramMap);
    	} catch ( Exception e ) {
    		e.printStackTrace();
    	}

        return hm;
    }
    
    @RequestMapping(value = "/setting/axSettingCodeSave", method = RequestMethod.POST, consumes = "application/json" )
    public @ResponseBody HashMap<String,Object> axSettingCodeSave(@RequestBody HashMap<String, Object> paramMap, HttpServletRequest request, HttpServletResponse response) throws Exception {
    	HashMap<String, Object> hm = new HashMap<String, Object>();
    	
		try {
    		hm = svr.axSettingCodeSave(paramMap);
    	} catch ( Exception e ) {
    		e.printStackTrace();
    		hm.put("RtnMode", Constant.mode.ERROR.name());
    	}

        return hm;
    }

    @RequestMapping(value = "/setting/axMainFrameList", method = RequestMethod.POST, consumes = "application/json" )
    public @ResponseBody HashMap<String,Object> axMainFrameList(@RequestBody HashMap<String, Object> paramMap, HttpServletRequest request, HttpServletResponse response) throws Exception {
    	HashMap<String, Object> hm = new HashMap<String, Object>();

    	try {
    		hm = svr.axMainFrameList(paramMap);
    	} catch ( Exception e ) {
    		e.printStackTrace();
    	}

        return hm;
    }
    
    @RequestMapping(value = "/setting/axMainFrameSave", method = RequestMethod.POST, consumes = "application/json" )
    public @ResponseBody HashMap<String,Object> axMainFrameSave(@RequestBody HashMap<String, Object> paramMap, HttpServletRequest request, HttpServletResponse response) throws Exception {
    	HashMap<String, Object> hm = new HashMap<String, Object>();
    	
		try {
    		hm = svr.axMainFrameSave(paramMap);
    	} catch ( Exception e ) {
    		e.printStackTrace();
    		hm.put("RtnMode", Constant.mode.ERROR.name());
    	}

        return hm;
    }


    @RequestMapping(value = "/setting/axMainFrameDetailList", method = RequestMethod.POST, consumes = "application/json" )
    public @ResponseBody HashMap<String,Object> axMainFrameDetailList(@RequestBody HashMap<String, Object> paramMap, HttpServletRequest request, HttpServletResponse response) throws Exception {
    	HashMap<String, Object> hm = new HashMap<String, Object>();

    	try {
    		hm = svr.axMainFrameDetailList(paramMap);
    	} catch ( Exception e ) {
    		e.printStackTrace();
    	}

        return hm;
    }
    
    @RequestMapping(value = "/setting/axMainFrameDetailSave", method = RequestMethod.POST, consumes = "application/json" )
    public @ResponseBody HashMap<String,Object> axMainFrameDetailSave(@RequestBody HashMap<String, Object> paramMap, HttpServletRequest request, HttpServletResponse response) throws Exception {
    	HashMap<String, Object> hm = new HashMap<String, Object>();
    	
		try {
    		hm = svr.axMainFrameDetailSave(paramMap);
    	} catch ( Exception e ) {
    		e.printStackTrace();
    		hm.put("RtnMode", Constant.mode.ERROR.name());
    	}

        return hm;
    }

    @RequestMapping(value = "/setting/axMainFrameApply", method = RequestMethod.POST, consumes = "application/json" )
    public @ResponseBody HashMap<String,Object> axMainFrameApply(@RequestBody HashMap<String, Object> paramMap, HttpServletRequest request, HttpServletResponse response) throws Exception {
    	HashMap<String, Object> hm = new HashMap<String, Object>();
    	
		try {
    		hm = svr.axMainFrameApply(paramMap);
    	} catch ( Exception e ) {
    		e.printStackTrace();
    		hm.put("RtnMode", Constant.mode.ERROR.name());
    	}

        return hm;
    }

    @RequestMapping(value = "/setting/axMainFrameCompanyDomain", method = RequestMethod.POST, consumes = "application/json" )
    public @ResponseBody HashMap<String,Object> axMainFrameCompanyDomain(@RequestBody HashMap<String, Object> paramMap, HttpServletRequest request, HttpServletResponse response) throws Exception {
    	HashMap<String, Object> hm = new HashMap<String, Object>();

    	try {
    		hm = svr.axMainFrameCompanyDomain(paramMap);
    	} catch ( Exception e ) {
    		e.printStackTrace();
    	}

        return hm;
    }

    @RequestMapping(value = "/setting/axSettingSmtpList", method = RequestMethod.POST, consumes = "application/json" )
    public @ResponseBody HashMap<String,Object> axSettingSmtpList(@RequestBody HashMap<String, Object> paramMap, HttpServletRequest request, HttpServletResponse response) throws Exception {
    	HashMap<String, Object> hm = new HashMap<String, Object>();

    	try {
    		hm = svr.axSettingSmtpList(paramMap);
    	} catch ( Exception e ) {
    		e.printStackTrace();
    	}

        return hm;
    }
    
    @RequestMapping(value = "/setting/axSettingSmtpSave", method = RequestMethod.POST, consumes = "application/json" )
    public @ResponseBody HashMap<String,Object> axSettingSmtpSave(@RequestBody HashMap<String, Object> paramMap, HttpServletRequest request, HttpServletResponse response) throws Exception {
    	HashMap<String, Object> hm = new HashMap<String, Object>();
    	
		try {
    		hm = svr.axSettingSmtpSave(paramMap);
    	} catch ( Exception e ) {
    		e.printStackTrace();
    		hm.put("RtnMode", Constant.mode.ERROR.name());
    	}

        return hm;
    }
}
