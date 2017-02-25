package com.qp.lms.postscript.controller;



import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.qp.lms.common.CommUtil;
import com.qp.lms.postscript.model.PostScriptSet;
import com.qp.lms.postscript.model.PostScriptVO;
import com.qp.lms.postscript.service.PostScriptService;

/**
 * 수강후기 관리
 * @author limsm
 *
 */
@Controller
public class PostScriptController {

	private static final Logger logger = LoggerFactory.getLogger(PostScriptController.class);

    @Autowired
    private PostScriptService svr;


    /**
     * 수강후기 리스트
     * @param vo
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/postscript/postscriptList")
    public String postscriptList(@ModelAttribute PostScriptVO vo,Model model) throws Exception {
    	try {
    		PostScriptSet set = new PostScriptSet();
	    	set.setCondiVO(vo);
	    	
	    	set = svr.postscriptList(set);
	    	
	        model.addAttribute("set", set );
    	} catch ( Exception e ) {
    		e.printStackTrace();
    	}

    	return "/postscript/PostScriptList";
    }

    /**
     * 수강후기 사용자 조회 화면
     * @param vo
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/postscript/postscriptUserList")
    public String postscriptUserList(@ModelAttribute PostScriptVO vo, Model model) throws Exception {
    	try {
    		PostScriptSet set = new PostScriptSet();
	    	set.setCondiVO(vo);
	    	
	    	set = svr.postscriptUserList(set);
	    	
	    	model.addAttribute("set", set );
    	} catch ( Exception e ) {
    		e.printStackTrace();
    	}

        return "/postscript/PostScriptUserList";
    }

    /**
     *  수강후기 작성 화면
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/postscript/postscriptN")
    public String postscriptN(@ModelAttribute PostScriptVO vo, Model model) throws Exception {
    	try {
    		PostScriptSet set = new PostScriptSet();
	    	set.setCondiVO(vo);
	    	
	        model.addAttribute("set", set );
    	} catch ( Exception e ) {
    		e.printStackTrace();
    	}
    	
        return "/postscript/PostScriptNew";
    }

    /**
     *  수강후기 작성 화면
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/postscript/postscriptV")
    public String postscriptV(@ModelAttribute PostScriptVO vo, Model model) throws Exception {
    	try {
    		PostScriptSet set = new PostScriptSet();
	    	set.setCondiVO(vo);
	    	
	    	set = svr.postscriptV(set);
	    	
	        model.addAttribute("set", set );
    	} catch ( Exception e ) {
    		e.printStackTrace();
    	}
    	
        return "/postscript/PostScriptView";
    }

 
    ///////////////////////////////////////////////// Transaction ////////////////////////////////////////////////////
    /**
     * 수강후기 입력
     * @param vo
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/postscript/postscriptIns", method = RequestMethod.POST)
    public String postscriptIns(@ModelAttribute PostScriptVO vo, Model model) throws Exception {
    	try {
    		PostScriptSet set = new PostScriptSet();
	    	set.setCondiVO(vo);
	    	
	    	set = svr.postscriptIns(set);
	    	
	    	model.addAttribute("json", CommUtil.getJsonObject(set.getRtnMode(),""));
    	} catch ( Exception e ) {
    		e.printStackTrace();
    	}

        return "/common/json";
    }
    
}
