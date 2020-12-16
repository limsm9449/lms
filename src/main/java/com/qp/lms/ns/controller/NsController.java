package com.qp.lms.ns.controller;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.qp.lms.ax.common.service.AxCommService;
import com.qp.lms.common.CommUtil;
import com.qp.lms.common.SessionUtil;
import com.qp.lms.ns.model.MailVO;
import com.qp.lms.ns.model.NsSet;
import com.qp.lms.ns.model.NsVO;
import com.qp.lms.ns.service.NsService;

@Controller
public class NsController {
	private static final Logger logger = LoggerFactory.getLogger(NsController.class);

    @Autowired
    private NsService svr;
	
	@Autowired
	private AxCommService axCommService;

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
   	    return CommUtil.getCompTypePage("/ns/SearchUserIdV");
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
		return CommUtil.getCompTypePage("/ns/SearchPasswordV");
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
    	StringBuffer contents = new StringBuffer();
    	contents.append("<div style='font-size: 12px; width: 650px; height:500px; margin:0 auto;' align='center'>");
    	contents.append("  <div align='left'>");
    	contents.append("    <a href='" + SessionUtil.getAttribute("serverDomain") + "'><img src='http://www.qlearning.co.kr/resources/images/common/toplogo.png' style='border:0;' /></a>");
    	contents.append("  </div>");
    	contents.append("  <div style='text-align: left;margin: 30px 10px 30px;'>");
    	contents.append("이름 : " + vo.getUserName() + "<br>"); 
    	contents.append("메일주소 : " + vo.getEmail() + "<br>");
    	contents.append("전화번호 : " + vo.getMobile() + "<br><br>");
    	contents.append("내용 : " + vo.getMailContents());
    	contents.append("  </div>");
    	contents.append("  <div style='margin: 40px 0 0;'>");
    	contents.append("    <div style='float: left;'><img src='http://www.qlearning.co.kr/resources/images/admin/common/bottom_logo.png' alt='Qpeople' /></div>");
    	contents.append("    <div style='float: left;margin-left: 20px;'><p style='font-size: 11px;'>Copyrights 2017 Qpeople Academy. ALL Right Reserved</p></div>");
    	contents.append("  </div>");
    	contents.append("</div>");

    	axCommService.axMailSave("메일문의", vo.getCategory(), vo.getMailSubject(), contents.toString());
		axCommService.axSendMail(null);

    	model.addAttribute("json", CommUtil.getJsonObject("OK",""));

    	return "/common/json";
    }
}
