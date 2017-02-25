package com.qp.lms.exam.controller;



import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;

import com.qp.lms.exam.model.ExamSet;
import com.qp.lms.exam.model.ExamVO;
import com.qp.lms.exam.service.ExamManageService;

/**
 * 강좌별 시험 통계
 * @author limsm
 *
 */
@Controller
public class ExamManageController {

	private static final Logger logger = LoggerFactory.getLogger(ExamManageController.class);

    @Autowired
    private ExamManageService svr;



    /**
     *  강좌별 시험 통계 리스트
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/exam/examManageList")
    public String examManageList(@ModelAttribute ExamVO vo, Model model) throws Exception {
    	try {
    		ExamSet set = new ExamSet();
    		set.setCondiVO(vo);
    		
	    	set = svr.examManageList(set);
	    	
	        model.addAttribute("set", set );
    	} catch ( Exception e ) {
    		e.printStackTrace();
    	}

        return "/exam/ExamManageList";
    }

    /**
     * 강좌별 시험 상세
     * @param vo
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/exam/examUserManageList")
    public String examUserManageList(@ModelAttribute ExamVO vo, Model model) throws Exception {
    	try {
    		ExamSet set = new ExamSet();
    		set.setCondiVO(vo);
    		
	    	set = svr.examUserManageList(set);
	    	
	        model.addAttribute("set", set );
    	} catch ( Exception e ) {
    		e.printStackTrace();
    	}

        return "/exam/ExamUserManageList";
    }

    /**
     * 강좌별 시험 사용자 상세
     * @param vo
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/exam/examUserManageV")
    public String examUserManageV(@ModelAttribute ExamVO vo, Model model) throws Exception {
    	try {
    		ExamSet set = new ExamSet();
    		set.setCondiVO(vo);
    		
	    	set = svr.examUserManageV(set);
	    	
	        model.addAttribute("set", set );
    	} catch ( Exception e ) {
    		e.printStackTrace();
    	}

        return "/exam/ExamUserManageV";
    }

}
