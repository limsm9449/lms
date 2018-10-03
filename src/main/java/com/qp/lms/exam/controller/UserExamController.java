package com.qp.lms.exam.controller;



import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.qp.lms.common.CommUtil;
import com.qp.lms.exam.model.ExamSet;
import com.qp.lms.exam.model.ExamVO;
import com.qp.lms.exam.service.UserExamService;
import com.qp.lms.quest.model.QuestVO;

/**
 * 사용자 시험
 * @author limsm
 *
 */
@Controller
public class UserExamController {

	private static final Logger logger = LoggerFactory.getLogger(UserExamController.class);

    @Autowired
    private UserExamService svr;



    /**
     *  시험 입력 화면
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/exam/userExam")
    public String userExam(@ModelAttribute ExamVO vo, Model model) throws Exception {
    	try {
    		ExamSet set = new ExamSet();
    		set.setCondiVO(vo);
    		
	    	set = svr.userExam(set);
	    	
	        model.addAttribute("set", set );
    	} catch ( Exception e ) {
    		e.printStackTrace();
    	}

        return "/exam/UserExam";
    }

    @RequestMapping(value = "/exam/userExamIns", method = RequestMethod.POST)
    public String questIns(@ModelAttribute ExamVO vo, Model model) throws Exception {
    	try {
    		ExamSet set = new ExamSet();
	    	set.setCondiVO(vo);
	    	
	    	set = svr.userExamIns(set);
	    	
	    	model.addAttribute("json", CommUtil.getJsonObject(set.getRtnMode(),""));
    	} catch ( Exception e ) {
    		e.printStackTrace();
    	}

        return "/common/json";
    }

    @RequestMapping(value = "/exam/userExamResult")
    public String userExamResult(@ModelAttribute ExamVO vo, Model model) throws Exception {
    	try {
    		ExamSet set = new ExamSet();
    		set.setCondiVO(vo);
    		
	    	set = svr.userExamResult(set);
	    	
	        model.addAttribute("set", set );
    	} catch ( Exception e ) {
    		e.printStackTrace();
    	}

        return "/exam/UserExamResult";
    }

    
}
