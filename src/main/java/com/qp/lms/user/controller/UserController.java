package com.qp.lms.user.controller;



import java.util.HashMap;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;

import com.qp.lms.ax.common.service.AxCommService;
import com.qp.lms.common.CommUtil;
import com.qp.lms.common.SessionUtil;
import com.qp.lms.education.model.EducationSet;
import com.qp.lms.education.model.EducationVO;
import com.qp.lms.user.model.UserSet;
import com.qp.lms.user.model.UserVO;
import com.qp.lms.user.service.UserService;

import net.sf.json.JSONObject;


@Controller
public class UserController {

	 private static final Logger logger = LoggerFactory.getLogger(UserController.class);

    @Autowired
    private UserService svr;

    @Autowired
    private AxCommService axCommService;
    
    /**
     * 강좌정보
     * @param vo
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/user/studyroom")
    public String studyroom(@ModelAttribute UserVO vo,Model model) throws Exception {
    	try {
	    	UserSet set = new UserSet();
	    	set.setCondiVO(vo);
	    	
	    	set.getCondiVO().setUserId(SessionUtil.getSessionUserId());
	    	
	    	set = svr.studyroom(set);
	    	
	        model.addAttribute("set", set ); 
    	} catch ( Exception e ) {
    		e.printStackTrace();
    	}

        return CommUtil.getCompTypePage("/user/Studyroom");
    }
    
    @RequestMapping(value = "/user/studyroomQch")
    public String studyroomQch(@ModelAttribute UserVO vo,Model model) throws Exception {
    	try {
	    	UserSet set = new UserSet();
	    	set.setCondiVO(vo);
	    	
	    	set.getCondiVO().setUserId(SessionUtil.getSessionUserId());
	    	
	    	set = svr.studyroomQch(set);
	    	
	        model.addAttribute("set", set ); 
    	} catch ( Exception e ) {
    		e.printStackTrace();
    	}

        return CommUtil.getCompTypePage("/user/Studyroom");
    }

    @RequestMapping(value = "/goPage")
    public String goPage(@ModelAttribute UserVO vo,Model model) throws Exception {

        return "/homepage/" + vo.getPageUrl();
    }
    
    @RequestMapping(value = "/user/courseAttendanceV")
    public String courseAttendanceV(@ModelAttribute UserVO vo,Model model) throws Exception {
    	try {
	    	UserSet set = new UserSet();
	    	set.setCondiVO(vo);
	    	
	    	set.getCondiVO().setUserId(SessionUtil.getSessionUserId());
	    	
	    	set = svr.courseAttendanceV(set);
	    	
	        model.addAttribute("set", set ); 
    	} catch ( Exception e ) {
    		e.printStackTrace();
    	}

        return "/user/courseAttendanceV";
    }

    /*@RequestMapping(value = "/user/studyroomDataList")
    public String studyroomDataList(@ModelAttribute UserVO vo,Model model) throws Exception {
    	try {
	    	UserSet set = new UserSet();
	    	set.setCondiVO(vo);
	    	
	    	set.getCondiVO().setUserId(SessionUtil.getSessionUserId());
	    	
	    	set = svr.studyroomDataList(set);
	    	
	        model.addAttribute("set", set ); 
    	} catch ( Exception e ) {
    		e.printStackTrace();
    	}

        return "/user/StudyroomDataList";
    }


    @RequestMapping(value = "/user/studyroomDataV")
    public String studyroomDataV(@ModelAttribute UserVO vo,Model model) throws Exception {
    	try {
	    	UserSet set = new UserSet();
	    	set.setCondiVO(vo);
	    	
	    	set.getCondiVO().setUserId(SessionUtil.getSessionUserId());
	    	
	    	set = svr.studyroomDataV(set);
	    	
	        model.addAttribute("set", set ); 
    	} catch ( Exception e ) {
    		e.printStackTrace();
    	}

        return "/user/StudyroomDataV";
    }

    @RequestMapping(value = "/user/studyroomQnaList")
    public String studyroomQnaList(@ModelAttribute UserVO vo,Model model) throws Exception {
    	try {
	    	UserSet set = new UserSet();
	    	set.setCondiVO(vo);
	    	
	    	set = svr.studyroomQnaList(set);
	    	
	        model.addAttribute("set", set ); 
    	} catch ( Exception e ) {
    		e.printStackTrace();
    	}

        return "/user/StudyroomQnaList";
    }
    
    @RequestMapping(value = "/user/studyroomQnaV")
    public String studyroomQnaV(@ModelAttribute UserVO vo,Model model) throws Exception {
    	try {
	    	UserSet set = new UserSet();
	    	set.setCondiVO(vo);
	    	
	    	set.getCondiVO().setUserId(SessionUtil.getSessionUserId());

	    	set = svr.studyroomQnaV(set);
	    	
	        model.addAttribute("set", set ); 
    	} catch ( Exception e ) {
    		e.printStackTrace();
    	}

        return "/user/StudyroomQnaV";
    }

    @RequestMapping(value = "/user/studyroomQnaU")
    public String studyroomQnaU(@ModelAttribute UserVO vo,Model model) throws Exception {
    	try {
	    	UserSet set = new UserSet();
	    	set.setCondiVO(vo);
	    	
	    	set = svr.studyroomQnaU(set);
	    	
	        model.addAttribute("set", set ); 
    	} catch ( Exception e ) {
    		e.printStackTrace();
    	}

        return "/user/StudyroomQnaU";
    }

    @RequestMapping(value = "/user/studyroomQnaN")
    public String studyroomQnaN(@ModelAttribute UserVO vo,Model model) throws Exception {
    	try {
	    	UserSet set = new UserSet();
	    	set.setCondiVO(vo);
	    	
	    	set = svr.studyroomQnaN(set);
	    	
	        model.addAttribute("set", set ); 
    	} catch ( Exception e ) {
    		e.printStackTrace();
    	}

        return "/user/StudyroomQnaN";
    }
    
    @RequestMapping(value = "/user/studyroomQnaAnswerN")
    public String studyroomQnaAnswerN(@ModelAttribute UserVO vo,Model model) throws Exception {
    	try {
	    	UserSet set = new UserSet();
	    	set.setCondiVO(vo);
	    	
	    	set = svr.studyroomQnaAnswerN(set);
	    	
	        model.addAttribute("set", set ); 
    	} catch ( Exception e ) {
    		e.printStackTrace();
    	}

        return "/user/StudyroomQnaAnswerN";
    }

    @RequestMapping(value = "/user/studyroomQnaAnswerU")
    public String studyroomQnaAnswerU(@ModelAttribute UserVO vo,Model model) throws Exception {
    	try {
	    	UserSet set = new UserSet();
	    	set.setCondiVO(vo);
	    	
	    	set = svr.studyroomQnaAnswerU(set);
	    	
	        model.addAttribute("set", set ); 
    	} catch ( Exception e ) {
    		e.printStackTrace();
    	}

        return "/user/StudyroomQnaAnswerU";
    }

    @RequestMapping(value = "/user/studyroomQnaIns")
    public String studyroomQnaIns(@ModelAttribute UserVO vo,Model model) throws Exception {
    	try {
	    	UserSet set = new UserSet();
	    	set.setCondiVO(vo);
	    	
	    	set = svr.studyroomQnaIns(set);
	    	
	    	model.addAttribute("json", CommUtil.getJsonObject(set.getRtnMode(),""));
    	} catch ( Exception e ) {
    		e.printStackTrace();
    	}

    	return "/common/json";
    }

    @RequestMapping(value = "/user/studyroomQnaUpd")
    public String studyroomQnaUpd(@ModelAttribute UserVO vo,Model model) throws Exception {
    	try {
	    	UserSet set = new UserSet();
	    	set.setCondiVO(vo);
	    	
	    	set = svr.studyroomQnaUpd(set);
	    	
	    	model.addAttribute("json", CommUtil.getJsonObject(set.getRtnMode(),""));
    	} catch ( Exception e ) {
    		e.printStackTrace();
    	}

    	return "/common/json";
    }


    @RequestMapping(value = "/user/studyroomQnaDel")
    public String studyroomQnaDel(@ModelAttribute UserVO vo,Model model) throws Exception {
    	try {
	    	UserSet set = new UserSet();
	    	set.setCondiVO(vo);
	    	
	    	set = svr.studyroomQnaDel(set);
	    	
	    	model.addAttribute("json", CommUtil.getJsonObject(set.getRtnMode(),""));
    	} catch ( Exception e ) {
    		e.printStackTrace();
    	}

    	return "/common/json";
    }
    
    @RequestMapping(value = "/user/studyroomQnaAnswerIns")
    public String studyroomQnaAnswerIns(@ModelAttribute UserVO vo,Model model) throws Exception {
    	try {
	    	UserSet set = new UserSet();
	    	set.setCondiVO(vo);
	    	
	    	set = svr.studyroomQnaAnswerIns(set);
	    	
	    	model.addAttribute("json", CommUtil.getJsonObject(set.getRtnMode(),""));
    	} catch ( Exception e ) {
    		e.printStackTrace();
    	}

    	return "/common/json";
    }

    @RequestMapping(value = "/user/studyroomQnaAnswerUpd")
    public String studyroomQnaAnswerUpd(@ModelAttribute UserVO vo,Model model) throws Exception {
    	try {
	    	UserSet set = new UserSet();
	    	set.setCondiVO(vo);
	    	
	    	set = svr.studyroomQnaAnswerUpd(set);
	    	
	    	model.addAttribute("json", CommUtil.getJsonObject(set.getRtnMode(),""));
    	} catch ( Exception e ) {
    		e.printStackTrace();
    	}

    	return "/common/json";
    }

    @RequestMapping(value = "/user/studyroomQnaAnswerDel")
    public String studyroomQnaAnswerDel(@ModelAttribute UserVO vo,Model model) throws Exception {
    	try {
	    	UserSet set = new UserSet();
	    	set.setCondiVO(vo);
	    	
	    	set = svr.studyroomQnaAnswerDel(set);
	    	
	    	model.addAttribute("json", CommUtil.getJsonObject(set.getRtnMode(),""));
    	} catch ( Exception e ) {
    		e.printStackTrace();
    	}

    	return "/common/json";
    }
*/


    /**
     * 과정 리스트
     * @param vo
     * @param model
     * @return
     * @throws Exception
     */
    /*
    @RequestMapping(value = "/user/courseList")
    public String courseList(@ModelAttribute UserVO vo, Model model, HttpServletRequest request) throws Exception {
    	try {
    		UserSet set = new UserSet();
    		set.setCondiVO(vo);
    		
    		if ( SessionUtil.getSession() == null)
    			set.getCondiVO().setIsLogin("N");
    		else {
    			set.getCondiVO().setIsLogin("Y");
    			set.getCondiVO().setUserId(SessionUtil.getSessionUserId());
    		}
    		
    		String[] domains = request.getServerName().split("[.]");
    		set.getCondiVO().setCompCd(axCommService.axCompCdFromSubDomain(domains[0]));
 			
 			
			// 메인 페이지에 나올 과정 리스트
			set = svr.courseList(set);
			
	        model.addAttribute("set", set );
	        
	        model.addAttribute("compCd", SessionUtil.getCompCd() );
    	} catch ( Exception e ) {
    		e.printStackTrace();
    	}

        return "/user/CourseList";
    }
    */

    @RequestMapping(value = "/user/checkMyCourse")
    public String checkMyCourse(@ModelAttribute UserVO vo,Model model) throws Exception {
    	try {
    		UserSet set = new UserSet();
	    	set.setCondiVO(vo);
	    	
	    	set.getCondiVO().setUserId(SessionUtil.getSessionUserId());
	    	
	    	set = svr.checkMyCourse(set);
	    	
	    	model.addAttribute("json", JSONObject.fromObject(set.getCourseInfo()));
    	} catch ( Exception e ) {
    		e.printStackTrace();
    	}

    	return "/common/json";
    }
    

	    
	    
}
