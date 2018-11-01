package com.qp.lms.member.controller;

import java.io.File;
import java.io.UnsupportedEncodingException;
import java.util.Map;
import java.util.UUID;

import javax.mail.MessagingException;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.multipart.commons.CommonsMultipartFile;

import com.qp.lms.board.model.AttachSet;
import com.qp.lms.board.model.AttachVO;
import com.qp.lms.common.CommUtil;
import com.qp.lms.common.Constant;
import com.qp.lms.common.PlainMail;
import com.qp.lms.common.SessionUtil;
import com.qp.lms.common.service.CommService;
import com.qp.lms.common.service.DdService;
import com.qp.lms.member.model.MemberSet;
import com.qp.lms.member.model.MemberVO;
import com.qp.lms.member.service.MemberService;

@Controller
public class MemberController {

	private static final Logger logger = LoggerFactory.getLogger(MemberController.class);

    @Autowired
    private MemberService svr;

    @Autowired
    private CommService commSvr;
	@Autowired
	private DdService ddService;

    /**
     * 사용자 리스트
     * @param vo
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/member/memberList")
    public String memberList(@ModelAttribute MemberVO vo, Model model) throws Exception {
    	try {
	    	MemberSet set = new MemberSet();
	    	set.setCondiVO(vo);
	    	
	    	set = svr.memberList(set);
	    	
	    	model.addAttribute("set", set );
    	} catch ( Exception e ) {
    		e.printStackTrace();
    	}
    	
    	if ( "Y".equals(CommUtil.getString(vo.getIsExcel())) ) 
    		return "memberExcelView";
    	else
    		return "/member/MemberList";
    }
    
    /**
     * 사용자 정보를 생성하는 화면 
     * @param vo
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/member/memberN")
    public String memberN(@ModelAttribute MemberVO vo, Model model) throws Exception {
    	try {
	    	MemberSet set = new MemberSet();
	    	set.setCondiVO(vo);
	    	
	    	set = svr.memberN(set);
	    	
	        model.addAttribute("set", set );
    	} catch ( Exception e ) {
    		e.printStackTrace();
    	}
    	
        return "/member/MemberN";
    }

    /**
     * 사용자 ID가 있는지 확인
     * @param vo
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/member/isExistUserId")
    public String isExistUserId(@ModelAttribute MemberVO vo, Model model) throws Exception {
    	try {
	    	MemberSet set = new MemberSet();
	    	set.setCondiVO(vo);
	    	
	    	set = svr.isExistUserId(set);
	    	
	    	model.addAttribute("json", CommUtil.getJsonObject(set.getRtnMode(),""));
    	} catch ( Exception e ) {
    		e.printStackTrace();
    	}

        return "/common/json";
    }
    
    /**
     * 사용자 신규 등록
     * @param vo
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/member/memberInsert")
    public String memberIns(@ModelAttribute MemberVO vo, Model model) throws Exception {
    	try {
	    	MemberSet set = new MemberSet();
	    	set.setCondiVO(vo);
	    	
	    	set = svr.memberInsert(set);

	    	model.addAttribute("set", set );
	        model.addAttribute("json", CommUtil.getJsonObject(set.getRtnMode(),""));
    	} catch ( Exception e ) {
    		e.printStackTrace();
    	}

        return "/common/json";
    }

    /**
     * 사용자 정보를 조회하는 화면 
     * @param vo
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/member/memberV")
    public String memberV(@ModelAttribute MemberVO vo, Model model) throws Exception {
    	try {
	    	MemberSet set = new MemberSet();
	    	set.setCondiVO(vo);
	    	
	    	set = svr.memberV(set);
	    	
	        model.addAttribute("set", set );
    	} catch ( Exception e ) {
    		e.printStackTrace();
    	}
    	
        return "/member/MemberV";
    }

    /**
     * 사용자 정보를 수정하는 화면
     * @param vo
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/member/memberU")
    public String memberU(@ModelAttribute MemberVO vo, Model model) throws Exception {
    	try {
	    	MemberSet set = new MemberSet();
	    	set.setCondiVO(vo);
	    	
	    	//없으면 사용자로 인식한다.
	    	if ( "".equals(CommUtil.getString(set.getCondiVO().getScreen())) )
	    		set.getCondiVO().setScreen("my");
	    	
	    	if ( "".equals(CommUtil.getString(vo.getUserId())) ) 
	    		set.getCondiVO().setUserId(SessionUtil.getSessionUserId());
	    	
	    	set = svr.memberU(set);
	    	
	        model.addAttribute("set", set );
    	} catch ( Exception e ) {
    		e.printStackTrace();
    	}
    	
        return "/member/MemberU";
    }

    /**
     * 패스워드 변경 화면
     * @param vo
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/member/memberChangePassword")
    public String memberChangePassword(@ModelAttribute MemberVO vo, Model model) throws Exception {
    	try {
	    	MemberSet set = new MemberSet();
	    	set.setCondiVO(vo);
    	} catch ( Exception e ) {
    		e.printStackTrace();
    	}
    	
        return "/member/ChangePassword";
    }

    /**
     * 탈퇴 화면 
     * @param vo
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/member/memberRetired")
    public String memberRetired(@ModelAttribute MemberVO vo, Model model) throws Exception {
    	try {
	    	MemberSet set = new MemberSet();
	    	set.setCondiVO(vo);
	    	
	    	
	        model.addAttribute("set", set );
    	} catch ( Exception e ) {
    		e.printStackTrace();
    	}
    	
        return "/member/Retired";
    }
    
    /**
     * 회원정보 수정
     * @param vo
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/member/memberUpd", method = RequestMethod.POST)
    public String memberUpd(@ModelAttribute MemberVO vo, Model model) throws Exception {
    	try {
	    	MemberSet set = new MemberSet();
	    	set.setCondiVO(vo);
	    	
	    	set = svr.memberUpd(set);
	    	
	        model.addAttribute("set", set );
	        model.addAttribute("json", CommUtil.getJsonObject(set.getRtnMode(),""));
    	} catch ( Exception e ) {
    		e.printStackTrace();
    	}

        return "/common/json";
    }

    
    /**
     * 패스워드 변경
     * @param vo
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/member/memberChangePasswordUpdate", method = RequestMethod.POST)
    public String memberChangePasswordUpdate(@ModelAttribute MemberVO vo, Model model) throws Exception {
    	try {
	    	MemberSet set = new MemberSet();
	    	set.setCondiVO(vo);
	    	
	    	set.getCondiVO().setUserId(SessionUtil.getSessionUserId());
	    	
	    	set = svr.memberChangePasswordUpdate(set);
	    	
	        model.addAttribute("json", CommUtil.getJsonObject(set.getRtnMode(),""));
    	} catch ( Exception e ) {
    		e.printStackTrace();
    	}

        return "/common/json";
    }

     /**
      * 탈퇴 저장
      * @param vo
      * @param model
      * @return
      * @throws Exception
      */
    @RequestMapping(value = "/member/memberRetiredUpdate", method = RequestMethod.POST)
    public String memberRetiredUpdate(@ModelAttribute MemberVO vo, Model model) throws Exception {
    	try {
	    	MemberSet set = new MemberSet();
	    	set.setCondiVO(vo);
	    	
	    	set.getCondiVO().setUserId(SessionUtil.getSessionUserId());
	    	
	    	set = svr.memberRetiredUpdate(set);
	    	
	    	model.addAttribute("json", CommUtil.getJsonObject(set.getRtnMode(),""));
    	} catch ( Exception e ) {
    		e.printStackTrace();
    	}

        return "/common/json";
    }

    /**
     * 탈퇴회원 재가입
     * @param vo
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/member/reJoin", method = RequestMethod.POST)
    public String reJoin(@ModelAttribute MemberVO vo, Model model) throws Exception {
    	try {
	    	MemberSet set = new MemberSet();
	    	set.setCondiVO(vo);
	    	
	    	set = svr.reJoin(set);
	    	
	    	model.addAttribute("json", CommUtil.getJsonObject(set.getRtnMode(),""));
    	} catch ( Exception e ) {
    		e.printStackTrace();
    	}

        return "/common/json";
    }

    /**
     * 패스워드 초기화 
     * @param vo
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/member/passwordReset", method = RequestMethod.POST)
    public String passwordReset(@ModelAttribute MemberVO vo, Model model) throws Exception {
    	try {
	    	MemberSet set = new MemberSet();
	    	set.setCondiVO(vo);
	    	
	    	set = svr.passwordReset(set);
	    	
	    	model.addAttribute("json", CommUtil.getJsonObject(set.getRtnMode(),""));
    	} catch ( Exception e ) {
    		e.printStackTrace();
    	}

        return "/common/json";
    }


    /**
     * 사용자 정보를 수정하는 화면
     * @param vo
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/member/userMemberU")
    public String userMemberU(@ModelAttribute MemberVO vo, Model model) throws Exception {
    	try {
	    	MemberSet set = new MemberSet();
	    	set.setCondiVO(vo);
	    	
	    	set.getCondiVO().setUserId(SessionUtil.getSessionUserId());
	    	
	    	set = svr.memberU(set);

	    	set.setZipcodeUrl((String)ddService.getSettingData(CommUtil.getParamsHashMap("OPTION_KEY=ZIPCODE_URL")).get("OPTION_VALUE"));
	    	set.setBirthFromYear((String)ddService.getSettingData(CommUtil.getParamsHashMap("OPTION_KEY=BIRTH_FROM_YEAR")).get("OPTION_VALUE"));
	    	set.setBirthToYear((String)ddService.getSettingData(CommUtil.getParamsHashMap("OPTION_KEY=BIRTH_TO_YEAR")).get("OPTION_VALUE"));

	        model.addAttribute("set", set );
    	} catch ( Exception e ) {
    		e.printStackTrace();
    	}
    	
        return "/member/UserMemberU";
    }
    
    /**
     * 회원정보 수정(사용자용)
     * @param vo
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/member/userMemberUpd", method = RequestMethod.POST)
    public String userMemberUpd(@ModelAttribute MemberVO vo, Model model) throws Exception {
    	try {
	    	MemberSet set = new MemberSet();
	    	set.setCondiVO(vo);
	    	
	    	set = svr.userMemberUpd(set);
	    	
	        model.addAttribute("set", set );
	        model.addAttribute("json", CommUtil.getJsonObject(set.getRtnMode(),""));
    	} catch ( Exception e ) {
    		e.printStackTrace();
    	}

        return "/common/json";
    }


    /**
     * 강사 리스트
     * @param vo
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/member/teacherList")
    public String teacherList(@ModelAttribute MemberVO vo, Model model) throws Exception {
    	try {
	    	MemberSet set = new MemberSet();
	    	set.setCondiVO(vo);
	    	
	    	set = svr.teacherList(set);
	    	
	    	model.addAttribute("set", set );
    	} catch ( Exception e ) {
    		e.printStackTrace();
    	}
    	
   		return "/member/TeacherList";
    }

    /**
     * 강사 정보를 조회하는 화면 
     * @param vo
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/member/teacherV")
    public String teacherV(@ModelAttribute MemberVO vo, Model model) throws Exception {
    	try {
	    	MemberSet set = new MemberSet();
	    	set.setCondiVO(vo);
	    	
	    	set = svr.teacherV(set);
	    	
	        model.addAttribute("set", set );
    	} catch ( Exception e ) {
    		e.printStackTrace();
    	}
    	
        return "/member/TeacherV";
    }

    /**
     * 강사 정보를 수정하는 화면
     * @param vo
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/member/teacherU")
    public String teacherU(@ModelAttribute MemberVO vo, Model model) throws Exception {
    	try {
	    	MemberSet set = new MemberSet();
	    	set.setCondiVO(vo);
	    	
	    	set = svr.teacherV(set);
	    	
	        model.addAttribute("set", set );
    	} catch ( Exception e ) {
    		e.printStackTrace();
    	}
    	
        return "/member/TeacherU";
    }
    
    /**
     * 강사 수정
     * @param vo
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/member/teacherUpd", method = RequestMethod.POST)
    public String teacherUpd(@ModelAttribute MemberVO vo, Model model) throws Exception {
    	try {
	    	MemberSet set = new MemberSet();
	    	set.setCondiVO(vo);
	    	
	    	set = svr.teacherUpd(set);
	    	
	        model.addAttribute("set", set );
	        model.addAttribute("json", CommUtil.getJsonObject(set.getRtnMode(),""));
    	} catch ( Exception e ) {
    		e.printStackTrace();
    	}

        return "/common/json";
    }
    
    /**
     * 사진 입력
     * @param request
     * @param vo
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/member/pictureUpload", method = RequestMethod.POST)
    public String pictureUpload(MultipartHttpServletRequest request, @ModelAttribute MemberVO vo, Model model) throws Exception {
    	try {
    		MemberSet set = new MemberSet();
	    	set.setCondiVO(vo);
	    	
	    	// 첨부할 루트 디렉토리
	    	String folder = commSvr.getSetting("PICTURE_FOLDER");
	
	    	File attachDir = new File(folder);
	    	if ( !attachDir.exists() )
	    		attachDir.mkdir();
	    	
	    	// 파일 처리
	    	Map<String, MultipartFile> files = request.getFileMap();
	        CommonsMultipartFile cmf = (CommonsMultipartFile) files.get("newFile");
	
	        String fileName = CommUtil.getFileName(cmf.getFileItem().getName());
	        System.out.println("이미지 =====================> : " + fileName);
	        
	    	//파일 저장
	        File f = new File(attachDir + "//" + fileName);
	        cmf.transferTo(f);
	
	        System.out.println("이미지 =====================> : " + fileName);
	        
	        //파일 정보를 DB에 저장
	        set.getCondiVO().setPicture(fileName);
	    	set = svr.teacherPictureUpd(set);
	
	    	model.addAttribute("set", set );
    	} catch ( Exception e ) {
    		e.printStackTrace();
    	}

        return "/member/TeacherUploadT";
    }

    
    /**
     * 인증메일 재발송
     * @param vo
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/member/reCertificationMail", method = RequestMethod.POST)
    public String reCertificationMail(@ModelAttribute MemberVO vo, Model model) throws Exception {
    	try {
	    	MemberSet set = new MemberSet();
	    	set.setCondiVO(vo);
	    	
	    	try {
	        	//메일 발송
	    		PlainMail mail = new PlainMail();
	    		
		    	mail.setSubject("[회원가입 인증메일] 큐러닝에 가입하신 환영합니다.");
	
		    	StringBuffer contents = new StringBuffer();
		    	contents.append("<div style='font-size: 12px; width: 650px; height:500px; margin:0 auto;' align='center'>");
		    	contents.append("  <div align='left'>");
		    	contents.append("    <a href='http://www.qlearning.co.kr'><img src='http://www.qlearning.co.kr/resources/images/common/toplogo.png' style='border:0;' /></a>");
		    	contents.append("  </div>");
		    	contents.append("  <div style='text-align: left;margin: 30px 10px 30px;'>");
		    	contents.append("    <p style='font-size: 14px; line-height: 1.5;'>안녕하세요.<br />온라인 학습 사이트 <b>큐러닝</b>입니다.<br /><br /></p>");
		    	contents.append("    " + vo.getUserName() + "님의 회원가입을 축하드립니다.<br />");
		    	contents.append("    회원 가입을 정상적으로 처리하기 위해서는 아래 이메일 인증 주소를 클릭 하시거나 <a href='http://www.qlearning.co.kr/guest/certification.do?certificationKey=" + vo.getCertificationKey() + "'>여기</a>를 클릭하여 주십시오.");
		    	contents.append("    <p style='display:block;margin: 30px 10px;'><a href='http://www.qlearning.co.kr/guest/certification.do?certificationKey=" + vo.getCertificationKey() + "'>http://www.qlearning.co.kr/guest/certification.do?certificationKey=" + vo.getCertificationKey() + "</a></p>");
		    	contents.append("    이메일이 정상적으로 인증 되지 않을 경우 고객센터로 연락 주시면 신속하게 처리해 드리겠습니다.  ");
		    	contents.append("  </div>");
		    	contents.append("  <div style='margin: 40px 0 0;'>");
		    	contents.append("    <div style='float: left;'><img src='http://www.qlearning.co.kr/resources/images/admin/common/bottom_logo.png' alt='Qpeople' /></div>");
		    	contents.append("    <div style='float: left;margin-left: 20px;'><p style='font-size: 11px;'>Copyrights 2014 Qpeople Academy. ALL Right Reserved</p></div>");
		    	contents.append("  </div>");
		    	contents.append("</div>");
		    	
		    	mail.setReceiver(vo.getEmail());
    	    	mail.setContent(contents.toString());
	
	        	mail.SendMail();
	    	} catch ( UnsupportedEncodingException e ) {
	    		e.printStackTrace();
	    		throw e;
	    	} catch ( MessagingException e ) {
	    		e.printStackTrace();
	    		throw e;
	    	}
	
			set.setRtnMode(Constant.mode.OK.name());
	    	
	        model.addAttribute("set", set );
	        model.addAttribute("json", CommUtil.getJsonObject(set.getRtnMode(),""));
    	} catch ( Exception e ) {
    		e.printStackTrace();
    	}

        return "/common/json";
    }

}
