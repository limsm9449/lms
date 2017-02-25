package com.qp.lms.course.controller;



import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.qp.lms.common.CommUtil;
import com.qp.lms.course.model.CourseMasterSet;
import com.qp.lms.course.model.CourseMasterVO;
import com.qp.lms.course.service.CourseMasterService;

/**
 * 과정 Master 관리
 * @author limsm
 *
 */

@Controller
public class CourseMasterController {

	 private static final Logger logger = LoggerFactory.getLogger(CourseMasterController.class);

	    @Autowired
	    private CourseMasterService svr;

	    /**
	     * 과정 Master 리스트
	     * @param vo
	     * @param model
	     * @return
	     * @throws Exception
	     */
	    @RequestMapping(value = "/courseMaster/courseMasterList")
	    public String courseMaster(@ModelAttribute CourseMasterVO vo, Model model) throws Exception {
	    	try {
		    	CourseMasterSet set = new CourseMasterSet();
		    	set.setCondiVO(vo);
		    	
		    	set = svr.courseMasterList(set);
		    	
		        model.addAttribute("set", set );
	    	} catch ( Exception e ) {
	    		e.printStackTrace();
	    	}
	    	
	        return "/course/CourseMasterList";
	    }

	    /**
	     * 과정 Master 생성 화면
	     * @param vo
	     * @param model
	     * @return
	     * @throws Exception
	     */
	    @RequestMapping(value = "/courseMaster/courseMasterN")
	    public String courseMasterN(@ModelAttribute CourseMasterVO vo, Model model) throws Exception {
	    	try {
		    	CourseMasterSet set = new CourseMasterSet();
		    	set.setCondiVO(vo);
		    	
		    	set = svr.courseMasterN(set);
		    	
		        model.addAttribute("set", set );
	    	} catch ( Exception e ) {
	    		e.printStackTrace();
	    	}
	        
	        return "/course/CourseMasterN";
	    }
	    
	    /**
	     * 과정 Master 상세 화면
	     * @param vo
	     * @param model
	     * @return
	     * @throws Exception
	     */
	    @RequestMapping(value = "/courseMaster/courseMasterV")
	    public String courseMasterV(@ModelAttribute CourseMasterVO vo, Model model) throws Exception {
	    	try {
		    	CourseMasterSet set = new CourseMasterSet();
		    	set.setCondiVO(vo);
	
		    	set = svr.courseMasterV(set);
		    	
		        model.addAttribute("set", set );
	    	} catch ( Exception e ) {
	    		e.printStackTrace();
	    	}
	    	
	        return "/course/CourseMasterV";
	    }

	    /**
	     * 과정 Master 상세 팝업 화면
	     * @param vo
	     * @param model
	     * @return
	     * @throws Exception
	     */
	    @RequestMapping(value = "/courseMaster/courseMasterPV")
	    public String courseMasterPV(@ModelAttribute CourseMasterVO vo, Model model) throws Exception {
	    	try {
		    	CourseMasterSet set = new CourseMasterSet();
		    	set.setCondiVO(vo);
	
		    	set = svr.courseMasterV(set);
		    	
		        model.addAttribute("set", set );
	    	} catch ( Exception e ) {
	    		e.printStackTrace();
	    	}
	    	
	        return "/course/CourseMasterPV";
	    }

	    /**
	     * 과정 Master 수정 화면
	     * @param vo
	     * @param model
	     * @return
	     * @throws Exception
	     */
	    @RequestMapping(value = "/courseMaster/courseMasterU")
	    public String courseMasterU(@ModelAttribute CourseMasterVO vo, Model model) throws Exception {
	    	try {
		    	CourseMasterSet set = new CourseMasterSet();
		    	set.setCondiVO(vo);
		    	
		    	set = svr.courseMasterU(set);
		    	
		        model.addAttribute("set", set );
	    	} catch ( Exception e ) {
	    		e.printStackTrace();
	    	}
	    	
	        return "/course/CourseMasterU";
	    }

	    

	    
	    
	    
	    
	    ///////////////////////////////////////////////// Transaction ////////////////////////////////////////////////////
	    
	    /**
	     * 과정 Master 생성
	     * @param vo
	     * @param model
	     * @return
	     * @throws Exception
	     */
	    @RequestMapping(value = "/courseMaster/courseMasterNIns", method = RequestMethod.POST)
	    public String courseMasterNIns(@ModelAttribute CourseMasterVO vo, Model model) throws Exception {
	    	try {
		    	CourseMasterSet set = new CourseMasterSet();
		    	set.setCondiVO(vo);
		    	
		    	set = svr.courseMasterNIns(set);
		    	
		    	model.addAttribute("json", CommUtil.getJsonObject(set.getRtnMode(),""));
	    	} catch ( Exception e ) {
	    		e.printStackTrace();
	    	}
	    	
	        return "/common/json";
	    }

	    /**
	     * 과정 Master 수정
	     * @param vo
	     * @param model
	     * @return
	     * @throws Exception
	     */
	    @RequestMapping(value = "/courseMaster/courseMasterUUpd", method = RequestMethod.POST)
	    public String courseMasterUUpd(@ModelAttribute CourseMasterVO vo, Model model) throws Exception {
	    	try {
		    	CourseMasterSet set = new CourseMasterSet();
		    	set.setCondiVO(vo);
		    	
		    	set = svr.courseMasterUUpd(set);
		    	
		    	model.addAttribute("json", CommUtil.getJsonObject(set.getRtnMode(),""));
	    	} catch ( Exception e ) {
	    		e.printStackTrace();
	    	}

	        return "/common/json";
	    }

	    /**
	     * 과정 Master 삭제
	     * @param vo
	     * @param model
	     * @return
	     * @throws Exception
	     */
	    @RequestMapping(value = "/courseMaster/courseMasterDel", method = RequestMethod.POST)
	    public String courseMasterDel(@ModelAttribute CourseMasterVO vo, Model model) throws Exception {
	    	try {
		    	CourseMasterSet set = new CourseMasterSet();
		    	set.setCondiVO(vo);
		    	
		    	set = svr.courseMasterDel(set);
		    	
		    	model.addAttribute("json", CommUtil.getJsonObject(set.getRtnMode(),""));
	    	} catch ( Exception e ) {
	    		e.printStackTrace();
	    	}

	        return "/common/json";
	    }

}
