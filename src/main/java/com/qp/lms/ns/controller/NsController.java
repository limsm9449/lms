package com.qp.lms.ns.controller;

import java.io.UnsupportedEncodingException;

import javax.mail.MessagingException;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.qp.lms.common.CommUtil;
import com.qp.lms.common.PlainMail;
import com.qp.lms.member.model.MemberVO;
import com.qp.lms.ns.model.MailVO;
import com.qp.lms.ns.model.NsSet;
import com.qp.lms.ns.model.NsVO;
import com.qp.lms.ns.service.NsService;

@Controller
public class NsController {
	private static final Logger logger = LoggerFactory.getLogger(NsController.class);

    @Autowired
    private NsService svr;

    /*
     * ZipCode 화면 호출 
     */
    @RequestMapping(value = "/ns/getZipcode")
    public String getZipcode(@ModelAttribute NsVO vo, Model model) throws Exception {
    	try {
	    	NsSet set = new NsSet();
	    	set.setCondiVO(vo);
	    	
	    	set = svr.getZipcode(set);
	
	    	model.addAttribute("set", set );
    	} catch ( Exception e ) {
    		e.printStackTrace();
    	}
    	
        return "/ns/Zipcode";
    }

    /*
     * 회원 ID 확인 화면
     */
    @RequestMapping(value = "/ns/searchUserIdV")
    public String findUser(@ModelAttribute NsVO vo, Model model) throws Exception {
   	    return "/ns/SearchUserIdV";
    }

    /*
     * 회원 ID 검색
     */
    @RequestMapping(value = "/ns/searchUserId", method = RequestMethod.POST)
    public String searchUserId(@ModelAttribute NsVO vo, Model model) throws Exception {
    	try {
	    	NsSet set = new NsSet();
	    	set.setCondiVO(vo);
	    	
	    	set = svr.searchUserId(set);
	    	
	    	if ( set.getData() != null ) {
	    		model.addAttribute("json", CommUtil.getJsonObject(set.getRtnMode(),set.getData().getUserId()));
	    	} else {
	    		model.addAttribute("json", CommUtil.getJsonObject(set.getRtnMode(),""));
	    	}
    	} catch ( Exception e ) {
    		e.printStackTrace();
    	}

    	return "/common/json";
    }

    /*
     * Password 확인 화면
     */
    @RequestMapping(value = "/ns/searchPasswordV")
    public String findPassword(@ModelAttribute NsVO vo, Model model) throws Exception {
		return "/ns/SearchPasswordV";
    }

    /*
     * Password 변경
     */
    @RequestMapping(value = "/ns/searchPassword", method = RequestMethod.POST)
    public String searchPassword(@ModelAttribute NsVO vo, Model model) throws Exception {
    	try {
	    	NsSet set = new NsSet();
	    	set.setCondiVO(vo);
	    	
	    	set = svr.searchPassword(set);
	    	
	    	model.addAttribute("json", CommUtil.getJsonObject(set.getRtnMode(),""));
    	} catch ( Exception e ) {
    		e.printStackTrace();
    	}

    	return "/common/json";
    }
 
    @RequestMapping(value = "/ns/goNsJsp")
    public String goPage(@ModelAttribute NsVO vo,Model model) throws Exception {

        return "/homepage/" + vo.getJspPage();
    }

    @RequestMapping(value = "/ns/sendMailQuestion", method = RequestMethod.POST)
    public String sendMailQuestion(@ModelAttribute MailVO vo,Model model) throws Exception {
    	try {
        	//메일 발송
    		PlainMail mail = new PlainMail();
    		
	    	mail.setSubject(vo.getMailSubject());
	    	mail.setReceiver(vo.getCategory());
	    	mail.setContent("이름 : " + vo.getUserName() + "<br>" + 
	    					"메일주소 : " + vo.getEmail() + "<br>" +
	    					"전화번호 : " + vo.getMobile() + "<br><br>" +
	    					"내용 : " + vo.getMailContents());

        	mail.SendMail();

	    	model.addAttribute("json", CommUtil.getJsonObject("OK",""));
    	} catch ( UnsupportedEncodingException e ) {
    		e.printStackTrace();
    		throw e;
    	} catch ( MessagingException e ) {
    		e.printStackTrace();
    		throw e;
    	}

    	return "/common/json";
    }
}
