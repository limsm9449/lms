package com.qp.lms.guest.controller;



import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.qp.lms.board.model.BoardFaqSet;
import com.qp.lms.board.model.BoardFaqVO;
import com.qp.lms.board.model.BoardSet;
import com.qp.lms.board.model.BoardVO;
import com.qp.lms.board.service.BoardFaqService;
import com.qp.lms.board.service.BoardNoticeService;
import com.qp.lms.common.CommUtil;
import com.qp.lms.common.service.CommService;
import com.qp.lms.common.service.DdService;
import com.qp.lms.education.model.EducationSet;
import com.qp.lms.education.model.EducationVO;
import com.qp.lms.education.service.EducationService;
import com.qp.lms.guest.model.GuestSet;
import com.qp.lms.guest.model.GuestVO;
import com.qp.lms.guest.service.GuestService;
import com.qp.lms.main.model.MainSet;
import com.qp.lms.main.model.MainVO;
import com.qp.lms.member.model.MemberSet;
import com.qp.lms.member.model.MemberVO;
import com.qp.lms.member.service.MemberService;
import com.qp.lms.pg.model.PgSet;
import com.qp.lms.pg.model.PgVO;

import net.sf.json.JSONObject;

/*
 * Guest를 위한 Controller
 * 
 * guest용 홈 : 과정리스트 보기, 과정상세보기
 * 
 */

@Controller
public class GuestController {

    @Autowired
    private CommService commSvr;

    private static final Logger logger = LoggerFactory.getLogger(GuestController.class);

    @Autowired
    private GuestService svr;
    @Autowired
    private MemberService memberSvr;
    @Autowired
    private BoardNoticeService boardNoticeSvr;
    @Autowired
    private BoardFaqService boardFaqSvr;
    @Autowired
    private EducationService educationSvr;
	@Autowired
	private DdService ddService;

    /*
     * 과정코드를 가져온다.
     */
    @RequestMapping(value = "/guest/courseCode")
    public String getCourseCode(Model model) throws Exception {
    	try {
	    	GuestSet set = new GuestSet();
	    	
	    	set = svr.getCourseCode(set);
	    	
	        model.addAttribute("set", set );
    	} catch ( Exception e ) {
    		e.printStackTrace();
    	}
    	
        return "guest/GuestCourseCode";
    }

    /*
     * 과정을 가져온다.(준비완료, 모집시작)
     */
    @RequestMapping(value = "/guest/course")
    public String getCourse(@ModelAttribute GuestVO vo,Model model) throws Exception {
    	try {
	    	GuestSet set = new GuestSet();
	    	set.setCondiVO(vo);
	    	
	    	set = svr.getCourse(set);
	    	
	        model.addAttribute("set", set );
    	} catch ( Exception e ) {
    		e.printStackTrace();
    	}
    	
        return "guest/GuestCourse";
    }

    /*
     * 과정정보를 가져온다.
     */
    @RequestMapping(value = "/guest/courseInfo")
    public String getCourseInfo(@ModelAttribute GuestVO vo,Model model) throws Exception {
    	try {
	    	GuestSet set = new GuestSet();
	    	set.setCondiVO(vo);
	    	
	    	set = svr.getCourseInfo(set);
	    	
	        model.addAttribute("set", set );
    	} catch ( Exception e ) {
    		e.printStackTrace();
    	}
    	
        return "guest/GuestCourseV";
    }
    
    @RequestMapping(value = "/guest/join")
    public String join(@ModelAttribute MemberVO vo, Model model) throws Exception {
    	try {
	    	MemberSet set = new MemberSet();
	    	set.setCondiVO(vo);
	    	
	        model.addAttribute("set", set );
    	} catch ( Exception e ) {
    		e.printStackTrace();
    	}
    	
        return "/guest/Join"; 
    }

    @RequestMapping(value = "/guest/join2")
    public String join2(@ModelAttribute MemberVO vo, Model model) throws Exception {
    	try {
	    	MemberSet set = new MemberSet();
	    	set.setCondiVO(vo);
	    	
	    	set.setBirthFromYear((String)ddService.getSettingData(CommUtil.getParamsHashMap("OPTION_KEY=BIRTH_FROM_YEAR")).get("OPTION_VALUE"));
	    	set.setBirthToYear((String)ddService.getSettingData(CommUtil.getParamsHashMap("OPTION_KEY=BIRTH_TO_YEAR")).get("OPTION_VALUE"));

	        model.addAttribute("set", set );
    	} catch ( Exception e ) {
    		e.printStackTrace();
    	}
    	
        return "/guest/Join2"; 
    }

    @RequestMapping(value = "/guest/joinCheck")
    public String joinCheck(@ModelAttribute MemberVO vo, Model model) throws Exception {
    	try {
	    	MemberSet set = new MemberSet();
	    	set.setCondiVO(vo);
	    	
	    	set = memberSvr.joinCheck(set);
	    	
	    	model.addAttribute("json", CommUtil.getJsonObject(set.getRtnMode(),""));
    	} catch ( Exception e ) {
    		e.printStackTrace();
    	}
    	
        return "/common/json";
    }


    @RequestMapping(value = "/guest/join3")
    public String join3(@ModelAttribute MemberVO vo, Model model) throws Exception {
    	try {
	    	MemberSet set = new MemberSet();
	    	set.setCondiVO(vo);
	    	
	    	set.setZipcodeUrl((String)ddService.getSettingData(CommUtil.getParamsHashMap("OPTION_KEY=ZIPCODE_URL")).get("OPTION_VALUE"));
	    	set.setBirthFromYear((String)ddService.getSettingData(CommUtil.getParamsHashMap("OPTION_KEY=BIRTH_FROM_YEAR")).get("OPTION_VALUE"));
	    	set.setBirthToYear((String)ddService.getSettingData(CommUtil.getParamsHashMap("OPTION_KEY=BIRTH_TO_YEAR")).get("OPTION_VALUE"));
	    	
	        model.addAttribute("set", set );
    	} catch ( Exception e ) {
    		e.printStackTrace();
    	}
    	
        return "/guest/Join3"; 
    }

    @RequestMapping(value = "/guest/joinFinal")
    public String joinFinal(@ModelAttribute MemberVO vo, Model model) throws Exception {
    	try {
    		MemberSet set = new MemberSet();
	    	set.setCondiVO(vo);
	    	
	        model.addAttribute("set", set );
    	} catch ( Exception e ) {
    		e.printStackTrace();
    	}
    	
        return "/guest/JoinFinal"; 
    }

    
    /*
     * 사용자 ID가 있는지 확인
     * 
     */
    @RequestMapping(value = "/guest/isExistUserId")
    public String isExistUserId(@ModelAttribute MemberVO vo, Model model) throws Exception {
    	try {
	    	MemberSet set = new MemberSet();
	    	set.setCondiVO(vo);
	    	
	    	set = memberSvr.isExistUserId(set);

	    	model.addAttribute("json", CommUtil.getJsonObject(set.getRtnMode(),""));
    	} catch ( Exception e ) {
    		e.printStackTrace();
    	}
    	
        return "/common/json";
    }

    /*
     * 사용자 등록
     */
    @RequestMapping(value = "/guest/joinMemberInsert")
    public String memberInsert(@ModelAttribute MemberVO vo, Model model) throws Exception {
    	try {
	    	MemberSet set = new MemberSet();
	    	set.setCondiVO(vo);
	    	
	    	set = memberSvr.joinMemberInsert(set);
	    	
	    	model.addAttribute("json", CommUtil.getJsonObject(set.getRtnMode(),""));
    	} catch ( Exception e ) {
    		e.printStackTrace();
    	}

    	return "/common/json";
    }

    /*
     * 공지사항 리스트
     */
    @RequestMapping(value = "/guest/boardNotice")
    public String boardNotice(@ModelAttribute BoardVO vo, Model model) throws Exception {
    	try {
	    	BoardSet set = new BoardSet();
	    	set.setCondiVO(vo);
	    	
	    	//set = boardNoticeSvr.boardNotice(set);
	    	
	    	model.addAttribute("set", set );
    	} catch ( Exception e ) {
    		e.printStackTrace();
    	}

        return "/guest/BoardNotice";
    }

    /*
     * 공지사항 조회 화면 
     */
    @RequestMapping(value = "/guest/boardNoticeV")
    public String boardNoticeV(@ModelAttribute BoardVO vo, Model model) throws Exception {
    	try {
	    	BoardSet set = new BoardSet();
	    	set.setCondiVO(vo);
	    	
	    	set = boardNoticeSvr.boardNoticeV(set);
	    	
	   		set.setIsAuth("N");
	    	
	    	model.addAttribute("set", set );
    	} catch ( Exception e ) {
    		e.printStackTrace();
    	}

        return "/guest/BoardNoticeV";
    }

    /*
     * FAQ 리스트
     */
    @RequestMapping(value = "/guest/boardFaq")
    public String boardFaq(@ModelAttribute BoardFaqVO vo, Model model) throws Exception {
    	try {
	    	BoardFaqSet set = new BoardFaqSet();
	    	set.setCondiVO(vo);
	    	
	    	//set = boardFaqSvr.boardFaq(set);
	    	
	   		//set.setIsAuth("N");
	    	
	    	model.addAttribute("set", set );
    	} catch ( Exception e ) {
    		e.printStackTrace();
    	}

        return "/guest/BoardFaq";
    }

    /*
     * FAQ 조회 화면 
     */
    @RequestMapping(value = "/guest/boardFaqV")
    public String boardFaqV(@ModelAttribute BoardFaqVO vo, Model model) throws Exception {
    	try {
	    	BoardFaqSet set = new BoardFaqSet();
	    	set.setCondiVO(vo);
	    	
	    	set = boardFaqSvr.boardFaqV(set);
	    	
	   		//set.setIsAuth("N");
	    	
	    	model.addAttribute("set", set );
    	} catch ( Exception e ) {
    		e.printStackTrace();
    	}

        return "/guest/BoardFaqV";
    }
    
    /**
     * 교육 팝업 Home
     * @param vo
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/guest/eduSampleHome")
    public String eduSampleHome(@ModelAttribute EducationVO vo, Model model) throws Exception {
    	try {
	    	EducationSet set = new EducationSet();
	    	set.setCondiVO(vo);
	    	
	    	set = educationSvr.eduSampleHome(set);
	
	    	model.addAttribute("set", set );
    	} catch ( Exception e ) {
    		e.printStackTrace();
    	}

        return "/education/SampleHome";
    }

    @RequestMapping(value = "/guest/eduSampleHomeMobile")
    public String eduSampleHomeMobile(@ModelAttribute EducationVO vo, Model model) throws Exception {
    	try {
	    	EducationSet set = new EducationSet();
	    	set.setCondiVO(vo);
	    	
	    	set = educationSvr.eduSampleHome(set);
	
	    	model.addAttribute("set", set );
    	} catch ( Exception e ) {
    		e.printStackTrace();
    	}

        return "/education/SampleHomeMobile";
    }

    /**
     * 사용자 인증
     * @param vo
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/guest/certification")
    public String certification(@ModelAttribute MemberVO vo, Model model) throws Exception {
    	try {
	    	MemberSet set = new MemberSet();
	    	set.setCondiVO(vo);
	    	
	    	set = memberSvr.certification(set);
	    	
	    	set = svr.boardFaqList(set);
	    	
	    	model.addAttribute("set", set );
    	} catch ( Exception e ) {
    		e.printStackTrace();
    	}

    	return "/guest/Certification";
    }
    

    @RequestMapping(value = "/guest/termsconditions")
    public String termsconditions(@ModelAttribute MemberVO vo, Model model) throws Exception {
        return "/guest/termsconditions"; 
    }

    @RequestMapping(value = "/guest/privacy")
    public String privacy(@ModelAttribute MemberVO vo, Model model) throws Exception {
        return "/guest/privacy"; 
    }

    /**
     * 은행정보
     * @param vo
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/guest/bankInfo")
    public String bankInfo(@ModelAttribute GuestVO vo,Model model) throws Exception {
    	try {
	    	GuestSet set = new GuestSet();
	    	set.setCondiVO(vo);
	    	
	    	set = svr.bankInfo(set);
	    	
	        model.addAttribute("set", set );
    	} catch ( Exception e ) {
    		e.printStackTrace();
    	}
    	
        return "/guest/BankInfo";
    }

    
    @RequestMapping(value = "/guest/checkCourse")
    public String checkCourse(@ModelAttribute GuestVO vo,Model model) throws Exception {
    	try {
    		GuestSet set = new GuestSet();
	    	set.setCondiVO(vo);
	    	
	    	set = svr.checkCourse(set);
	    	
	    	HashMap hm = new HashMap();
	    	hm.put("mobileYn", set.getCourseInfo().getMobileYn());
	    	
	    	model.addAttribute("json", JSONObject.fromObject(hm));
    	} catch ( Exception e ) {
    		e.printStackTrace();
    	}

    	return "/common/json";
    }

    @RequestMapping(value = "/guest/install")
    public String install(@ModelAttribute GuestVO vo, Model model) throws Exception {
        return "/guest/install";
    }

    @RequestMapping(value = "/guest/dbInstall")
    public String dbInstall(@ModelAttribute GuestVO vo,Model model) throws Exception {
    	HashMap hm = new HashMap();
    	
    	try {
    		GuestSet set = new GuestSet();
	    	set.setCondiVO(vo);
	    	
	    	if ( "1".equals(vo.getUserId()) && "1".equals(vo.getPassword()) ) { 
	    		set = svr.dbInstall(set);
	    		hm.put("rtnMode", "INSTALL_OK");
	    	} else {
	    		hm.put("rtnMode", "NO_AUTH");
	    	}
    	} catch ( Exception e ) {
    		hm.put("rtnMode", "ERROR");
    		e.printStackTrace();
    	}
    	model.addAttribute("json", JSONObject.fromObject(hm));

    	return "/common/json";
    }

    @RequestMapping(value = "/guest/isExistCompAuth")
    public String isExistCompAuth(@ModelAttribute MainVO vo, Model model) throws Exception {
    	try {
    		MainSet set = new MainSet();
	    	set.setCondiVO(vo);
	    	
	    	set = svr.isExistCompAuth(set);

	    	model.addAttribute("json", CommUtil.getJsonObject(set.getRtnMode(),""));
    	} catch ( Exception e ) {
    		e.printStackTrace();
    	}
    	
        return "/common/json";
    }

    @RequestMapping(value = "/guest/authOnly", method = RequestMethod.GET)
    public String authOnly(HttpServletRequest request, @ModelAttribute MemberVO vo, Model model) throws Exception {
    	try {
	    	MemberSet set = new MemberSet();
	    	set.setCondiVO(vo);
	    	
	        model.addAttribute("set", set );
    	} catch ( Exception e ) {
    		e.printStackTrace();
    	}

    	request.setAttribute("g_CST_MID", commSvr.getSetting("g_CST_MID"));
    	request.setAttribute("g_CST_PLATFORM", commSvr.getSetting("g_CST_PLATFORM"));

        return "/pg/AuthOnly";
    }

    @RequestMapping(value = "/guest/authOnlyReq", method = RequestMethod.POST)
    public String authOnlyReq(HttpServletRequest request, @ModelAttribute GuestVO vo, Model model) throws Exception {
    	request.setAttribute("g_LGD_MERTKEY", commSvr.getSetting("g_LGD_MERTKEY"));
    	request.setAttribute("g_LGD_AUTH_RETURNURL", commSvr.getSetting("g_LGD_AUTH_RETURNURL"));

        return "/pg/AuthOnlyReq";
    }

    @RequestMapping(value = "/guest/authOnlyRes", method = RequestMethod.POST)
    public String authOnlyRes(HttpServletRequest request, @ModelAttribute GuestVO vo, Model model) throws Exception {
    	request.setAttribute("g_configPath", commSvr.getSetting("g_configPath"));

        return "/pg/AuthOnlyRes";
    }

    @RequestMapping(value = "/guest/AuthOnlyReturnurl", method = RequestMethod.POST)
    public String AuthOnlyReturnurl(HttpServletRequest request, @ModelAttribute GuestVO vo, Model model) throws Exception {
        return "/pg/AuthOnlyReturnurl";
    }
}
