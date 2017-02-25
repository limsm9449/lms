package com.qp.lms.compManager.controller;



import java.util.ArrayList;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.qp.lms.common.CommUtil;
import com.qp.lms.common.SessionUtil;
import com.qp.lms.common.SessionVO;
import com.qp.lms.compManager.model.CompCourseRegSet;
import com.qp.lms.compManager.model.CompCourseRegVO;
import com.qp.lms.compManager.model.CompCourseSet;
import com.qp.lms.compManager.model.CompCourseVO;
import com.qp.lms.compManager.service.CompCourseService;
import com.qp.lms.main.model.MainSet;
import com.qp.lms.main.model.MainVO;
import com.qp.lms.member.model.MemberSet;
import com.qp.lms.member.model.MemberVO;

/**
 * 회사 강좌 관리
 * @author limsm
 *
 */
@Controller
public class CompCourseController {

	private static final Logger logger = LoggerFactory.getLogger(CompCourseController.class);

    @Autowired
    private CompCourseService svr;

    /**
     * 회사 강좌 리스트 화면
     * @param vo
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/compCourse/compCourseList")
    public String compCourseList(@ModelAttribute CompCourseVO vo, Model model) throws Exception {
    	try {
    		CompCourseSet set = new CompCourseSet();
	    	set.setCondiVO(vo);
	
	    	set.getCondiVO().setUserId(SessionUtil.getSessionUserId());
	    	
	    	set = svr.compCourseList(set);
	    	
	        model.addAttribute("set", set );
    	} catch ( Exception e ) {
    		e.printStackTrace();
    	}

        return "/compManager/CompCourseList";
    }

    
}
