package com.qp.lms.user.controller;



import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;

import com.qp.lms.common.CommUtil;
import com.qp.lms.common.SessionUtil;
import com.qp.lms.member.model.MemberSet;
import com.qp.lms.member.model.MemberVO;
import com.qp.lms.user.model.UserSet;
import com.qp.lms.user.model.UserVO;
import com.qp.lms.user.service.NormalUserService;

/**
 * Noraml User를 위한 Controller
 * @author limsm
 *
 */

@Controller
public class NormalUserController {

	 private static final Logger logger = LoggerFactory.getLogger(NormalUserController.class);

    @Autowired
    private NormalUserService svr;

    /**
     * 수강현황
     * @param vo
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/normalUser/attendCourseList")
    public String attendCourseList(@ModelAttribute UserVO vo,Model model) throws Exception {
    	try {
	    	UserSet set = new UserSet();
	    	set.setCondiVO(vo);
	    	
	    	set = svr.attendCourseList(set);
	    	
	        model.addAttribute("set", set ); 
    	} catch ( Exception e ) {
    		e.printStackTrace();
    	}

        return CommUtil.getCompTypePage("/user/NormalAttendCourseList");
    }

    /**
     * 승인대기과목
     * @param vo
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/normalUser/waitingCourseList")
    public String waitingCourseList(@ModelAttribute UserVO vo,Model model) throws Exception {
    	try {
	    	UserSet set = new UserSet();
	    	set.setCondiVO(vo);
	    	
	    	set = svr.waitingCourseList(set);
	    	
	        model.addAttribute("set", set );
    	} catch ( Exception e ) {
    		e.printStackTrace();
    	}

        return CommUtil.getCompTypePage("/user/NormalWaitingCourseList");
    }

    /**
     *  취소과목
     * @param vo
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/normalUser/cancelCourseList")
    public String cancelCourseList(@ModelAttribute UserVO vo,Model model) throws Exception {
    	try {
	    	UserSet set = new UserSet();
	    	set.setCondiVO(vo);
	    	
	    	set = svr.cancelCourseList(set);
	    	
	        model.addAttribute("set", set );
    	} catch ( Exception e ) {
    		e.printStackTrace();
    	}

        return CommUtil.getCompTypePage("/user/NormalCancelCourseList");
    }

    /**
     * 수강내역
     * @param vo
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/normalUser/myCourseList")
    public String myCourseList(@ModelAttribute UserVO vo,Model model) throws Exception {
    	try {
	    	UserSet set = new UserSet();
	    	set.setCondiVO(vo);
	    	
	    	set = svr.myCourseList(set);
	    	
	        model.addAttribute("set", set );
    	} catch ( Exception e ) {
    		e.printStackTrace();
    	}

        return CommUtil.getCompTypePage("/user/NormalMyCourseList");
    }

    @RequestMapping(value = "/normalUser/interestCourseList")
    public String interestCourseList(@ModelAttribute UserVO vo,Model model) throws Exception {
    	try {
	    	UserSet set = new UserSet();
	    	set.setCondiVO(vo);
	    	
	    	set = svr.interestCourseList(set);
	    	
	        model.addAttribute("set", set );
    	} catch ( Exception e ) {
    		e.printStackTrace();
    	}

        return "/user/NormalInterestCourseList";
    }

    /**
     * 수강취소
     * @param vo
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/normalUser/courseRegCancel")
    public String courseRegCancel(@ModelAttribute UserVO vo, Model model) throws Exception {
    	try {
    		UserSet set = new UserSet();
	    	set.setCondiVO(vo);
	    	
	    	set.getCondiVO().setUserId(SessionUtil.getSessionUserId());
	    	set.getCondiVO().setUpdateUser(SessionUtil.getSessionUserId());
	    	
	    	set = svr.courseRegCancel(set);
	    	
	    	
	    	model.addAttribute("json", CommUtil.getJsonObject(set.getRtnMode(),""));
    	} catch ( Exception e ) {
    		e.printStackTrace();
    	}

        return "/common/json";
    }
    

}
