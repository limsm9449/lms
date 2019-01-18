package com.qp.lms.counsel.controller;



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
import com.qp.lms.counsel.model.CounselSet;
import com.qp.lms.counsel.model.CounselVO;
import com.qp.lms.counsel.service.CounselService;

/**
 * 상담관리
 * @author limsm
 *
 */
@Controller
public class CounselController {

	private static final Logger logger = LoggerFactory.getLogger(CounselController.class);

    @Autowired
    private CounselService svr;

    /**
     *  사용자별 상담 리스트
     * @param vo
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/counsel/userCounselList")
    public String userCounselList(@ModelAttribute CounselVO vo, Model model) throws Exception {
    	try {
    		vo.setCompCd((String)SessionUtil.getAttribute("compCd"));
    		
	    	CounselSet set = new CounselSet();
	    	set.setCondiVO(vo);
	    	
	    	set.getCondiVO().setUserId(SessionUtil.getSessionUserId());
	    	
	    	set = svr.userCounselList(set);
	    	
	        model.addAttribute("set", set );
    	} catch ( Exception e ) {
    		e.printStackTrace();
    	}

        return CommUtil.getCompTypePage("/counsel/UserCounselList");
    }

    /**
     *  사용자별 상담 생성
     * @param vo
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/counsel/userCounselN")
    public String userCounselN(@ModelAttribute CounselVO vo, Model model) throws Exception {
    	try {
	    	CounselSet set = new CounselSet();
	    	set.setCondiVO(vo);
	
	    	set = svr.userCounselN(set);
	    	
	        model.addAttribute("set", set );
    	} catch ( Exception e ) {
    		e.printStackTrace();
    	}

        return CommUtil.getCompTypePage("/counsel/UserCounselN");
    }

    /**
     *  사용자별 상담 조회
     * @param vo
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/counsel/userCounselV")
    public String userCounselV(@ModelAttribute CounselVO vo, Model model) throws Exception {
    	try {
	    	CounselSet set = new CounselSet();
	    	set.setCondiVO(vo);
	
	    	set = svr.userCounselV(set);
	    	
	        model.addAttribute("set", set );
    	} catch ( Exception e ) {
    		e.printStackTrace();
    	}

        return CommUtil.getCompTypePage("/counsel/UserCounselV");
    }

    /**
     *  사용자별 상담 수정
     * @param vo
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/counsel/userCounselU")
    public String userCounselU(@ModelAttribute CounselVO vo, Model model) throws Exception {
    	try {
	    	CounselSet set = new CounselSet();
	    	set.setCondiVO(vo);
	
	    	set = svr.userCounselU(set);
	    	
	        model.addAttribute("set", set );
    	} catch ( Exception e ) {
    		e.printStackTrace();
    	}

        return CommUtil.getCompTypePage("/counsel/UserCounselU");
    }

    /**
     *  상담 리스트
     * @param vo
     * @param model
     * @return
     * @throws Exception
     */
    /*
    @RequestMapping(value = "/counsel/counselList")
    public String counselList(@ModelAttribute CounselVO vo, Model model) throws Exception {
    	try {
	    	CounselSet set = new CounselSet();
	    	set.setCondiVO(vo);
	
	    	set = svr.counselList(set);
	    	
	        model.addAttribute("set", set );
    	} catch ( Exception e ) {
    		e.printStackTrace();
    	}

        return "/counsel/CounselList";
    }

    /**
     *  상담 조회
     * @param vo
     * @param model
     * @return
     * @throws Exception
     */
    /*
    @RequestMapping(value = "/counsel/counselV")
    public String counselV(@ModelAttribute CounselVO vo, Model model) throws Exception {
    	try {
	    	CounselSet set = new CounselSet();
	    	set.setCondiVO(vo);
	
	    	set = svr.counselAnswer(set);
	    	
	        model.addAttribute("set", set );
    	} catch ( Exception e ) {
    		e.printStackTrace();
    	}

        return "/counsel/CounselV";
    }
    */
    
    /**
     *  상담 답변 화면
     * @param vo
     * @param model
     * @return
     * @throws Exception
     */
    /*@RequestMapping(value = "/counsel/counselAnswer")
    public String counselAnswer(@ModelAttribute CounselVO vo, Model model) throws Exception {
    	try {
	    	CounselSet set = new CounselSet();
	    	set.setCondiVO(vo);
	
	    	set = svr.counselAnswer(set);
	    	
	        model.addAttribute("set", set );
    	} catch ( Exception e ) {
    		e.printStackTrace();
    	}

        return "/counsel/CounselAnswer";
    }*/
    

    
    
    /******************************************* 저장 부분 *****************************************************/
    

    /**
     *  사용자 상담 등록
     * @param vo
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/counsel/userCounselIns", method = RequestMethod.POST)
    public String userCounselIns(@ModelAttribute CounselVO vo, Model model) throws Exception {
    	try {
    		CounselSet set = new CounselSet();
	    	set.setCondiVO(vo);
	    	
	    	set = svr.userCounselIns(set);
	    	
	    	model.addAttribute("json", CommUtil.getJsonObject(set.getRtnMode(),""));
    	} catch ( Exception e ) {
    		e.printStackTrace();
    	}

        return "/common/json";
    }

    /**
     *  사용자 상담 수정
     * @param vo
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/counsel/userCounselUpd", method = RequestMethod.POST)
    public String userCounselUpd(@ModelAttribute CounselVO vo, Model model) throws Exception {
    	try {
	    	CounselSet set = new CounselSet();
	    	set.setCondiVO(vo);
	    	
	    	set = svr.userCounselUpd(set);
	    	
	    	model.addAttribute("json", CommUtil.getJsonObject(set.getRtnMode(),""));
    	} catch ( Exception e ) {
    		e.printStackTrace();
    	}

        return "/common/json";
    }

    /**
     *  사용자 상담 삭제
     * @param vo
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/counsel/userCounselDel", method = RequestMethod.POST)
    public String userCounselDel(@ModelAttribute CounselVO vo, Model model) throws Exception {
    	try {
	    	CounselSet set = new CounselSet();
	    	set.setCondiVO(vo);
	    	
	    	set = svr.userCounselDel(set);
	    	
	    	model.addAttribute("json", CommUtil.getJsonObject(set.getRtnMode(),""));
    	} catch ( Exception e ) {
    		e.printStackTrace();
    	}

        return "/common/json";
    }


    
    /**
     *  상담 답변 저장
     * @param vo
     * @param model
     * @return
     * @throws Exception
     */
    /*@RequestMapping(value = "/counsel/counselAnswerUpd", method = RequestMethod.POST)
    public String counselAnswerUpd(@ModelAttribute CounselVO vo, Model model) throws Exception {
    	try {
	    	CounselSet set = new CounselSet();
	    	set.setCondiVO(vo);
	    	
	    	set = svr.counselAnswerUpd(set);
	    	
	    	model.addAttribute("json", CommUtil.getJsonObject(set.getRtnMode(),""));
    	} catch ( Exception e ) {
    		e.printStackTrace();
    	}

        return "/common/json";
    }
*/

    
}
