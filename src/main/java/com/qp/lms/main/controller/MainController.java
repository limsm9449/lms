package com.qp.lms.main.controller;



import java.io.File;
import java.net.URLEncoder;
import java.util.Calendar;
import java.util.Collection;
import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;

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
import com.qp.lms.board.service.AttachService;
import com.qp.lms.common.CommUtil;
import com.qp.lms.common.SessionUtil;
import com.qp.lms.common.SessionVO;
import com.qp.lms.common.service.CommService;
import com.qp.lms.company.controller.CompanyController;
import com.qp.lms.main.model.MainSet;
import com.qp.lms.main.model.MainVO;
import com.qp.lms.main.service.MainService;
import com.qp.lms.user.model.UserSet;
import com.qp.lms.user.model.UserVO;

/**
 * Main
 * @author limsm
 *
 */
@Controller
public class MainController {

	private static final Logger logger = LoggerFactory.getLogger(CompanyController.class);

    @Autowired
    private MainService svr;

    @Autowired
    private CommService commSvr;

    @Autowired
    private AttachService attachSvr;

    @RequestMapping(value = "/main/errorNotUseCompany")
    public String errorNotUseCompany(Model model) {

        return "/homepage/errorNotUseCompany";
    }

    @RequestMapping(value = "/main/error")
    public String error(Model model) {

        return "/error";
    }

    /**
     * Main Top
     * @param vo
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/main/top")
    public String top(@ModelAttribute MainVO vo, Model model) throws Exception {
    	try {
    		MainSet set = new MainSet();
	
			SessionVO sessVO = (SessionVO)SessionUtil.getSession();
			
    		//Session 정보를 가져온다.
			set.setSessVO((SessionVO)SessionUtil.getSession());
	    	
	        model.addAttribute("set", set );
    	} catch ( Exception e ) {
    		e.printStackTrace();
    	}

        return "/homepage/top";
    }

    /**
     * 메인 페이지에 나올 과정 리스트
     * @param vo
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/main/content")
    public String content(@ModelAttribute MainVO vo, Model model) throws Exception {
    	try {
    		vo.setCompCd((String)SessionUtil.getAttribute("compCd"));
    		
    		MainSet set = new MainSet();
    		set.setCondiVO(vo);
    		
    		//Session 정보를 가져온다.
			set.setSessVO((SessionVO)SessionUtil.getSession());
	    	
			// 메인 페이지에 나올 과정 리스트
			set = svr.content(set);
			
	        model.addAttribute("set", set );
    	} catch ( Exception e ) {
    		e.printStackTrace();
    	}

        return CommUtil.getCompTypePage("/homepage/content");
    }
    
    /**
     * 과정 상세 내용을 조회한다.
     * @param vo
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/main/mainCourseData")
    public String mainCourseData(@ModelAttribute MainVO vo, Model model) throws Exception {
    	try {
    		MainSet set = new MainSet();
    		set.setCondiVO(vo);
    		
    		if ( SessionUtil.getSession() == null)
    			set.getCondiVO().setIsLogin("N");
    		else {
    			set.getCondiVO().setIsLogin("Y");
    			set.getCondiVO().setUserId(SessionUtil.getSessionUserId());
    			set.getCondiVO().setCompType((String)SessionUtil.getAttribute("compType"));
    		}
    		
			set = svr.mainCourseData(set);
	    	
	        model.addAttribute("set", set );
    	} catch ( Exception e ) {
    		e.printStackTrace();
    	}

        return "/homepage/courseInfo";
    }

    /**
     * cart 
     * @param vo
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/main/cart")
    public String cart(@ModelAttribute MainVO vo, HttpServletRequest request, Model model) throws Exception {
    	try {
    		MainSet set = new MainSet();
    		set.setCondiVO(vo);

    		if ( (SessionVO)SessionUtil.getSession() == null ) {
    			return "/login/beforeLogin";
    		} else {
    			set.getCondiVO().setUserId(SessionUtil.getSessionUserId());
    			set.getCondiVO().setCompType((String)SessionUtil.getAttribute("compType"));

				//과정 ID 생성
				String courseId = "";
				HashMap cart = (HashMap)SessionUtil.getAttribute("cart");
				if ( cart != null ) {
					Collection col = cart.keySet();
	    			Iterator iter = col.iterator();
	    			while ( iter.hasNext() ) {
	    				courseId += ( "".equals(courseId) ? "" : "," ) + iter.next();
	    			}
	    			set.getCondiVO().setCourseId(courseId);
				}
				
				set = svr.cart(set);
	    		
		        model.addAttribute("set", set );
    		}
    	} catch ( Exception e ) {
    		e.printStackTrace();
    	}

    	return "/homepage/cart";
    }

    
    /**
     * cart 추가
     * @param vo
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/main/cartAdd")
    public String cartAdd(@ModelAttribute MainVO vo, Model model) throws Exception {
    	try {
    		MainSet set = new MainSet();
    		set.setCondiVO(vo);

    		if ( (SessionVO)SessionUtil.getSession() == null ) {
    			model.addAttribute("json", CommUtil.getJsonObject("NO_SESSION",""));
    		} else {
        		set.getCondiVO().setUserId(SessionUtil.getSessionUserId());

    			//Session에 cart 추가
        		HashMap cart = (HashMap)SessionUtil.getAttribute("cart");
    			if ( cart == null )
    				cart = new HashMap();
    			if ( !cart.containsKey(vo.getCartCourseId()) ) {
    				cart.put(vo.getCartCourseId(),vo.getCartWeeks());
    				SessionUtil.setAttribute("cart", cart);
    			}
    			
    			//과정 ID 생성
    			String courseId = "";
    			Collection col = cart.keySet();
    			Iterator iter = col.iterator();
    			while ( iter.hasNext() ) {
    				courseId += ( "".equals(courseId) ? "" : "," ) + iter.next();
    			}
    			set.getCondiVO().setCourseId(courseId);

				set = svr.cart(set);
		    	
		        //model.addAttribute("set", set );
		        model.addAttribute("json", CommUtil.getJsonObject(set.getRtnMode(),""));
    		}
    	} catch ( Exception e ) {
    		e.printStackTrace();
    	}

    	return "/common/json";
    }

    /**
     * cart 삭제
     * @param vo
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/main/cartDel")
    public String cartDel(@ModelAttribute MainVO vo, Model model) throws Exception {
    	try {
    		MainSet set = new MainSet();
    		set.setCondiVO(vo);

    		if ( (SessionVO)SessionUtil.getSession() == null ) {
    			return "/login/beforeLogin";
    		} else {
        		set.getCondiVO().setUserId(SessionUtil.getSessionUserId());

    			//Session에 cart 추가
        		HashMap cart = (HashMap)SessionUtil.getAttribute("cart");
    			if ( cart == null )
    				cart = new HashMap();
    			if ( cart.containsKey(vo.getCartCourseId()) ) {
    				cart.remove(vo.getCartCourseId());
    				SessionUtil.setAttribute("cart", cart);
    			}
    				
    			//과정 ID 생성
    			String courseId = "";
    			Collection col = cart.keySet();
    			Iterator iter = col.iterator();
    			while ( iter.hasNext() ) {
    				courseId += ( "".equals(courseId) ? "" : "," ) + iter.next();
    			}
    			set.getCondiVO().setCourseId(courseId);
    			
				set = svr.cart(set);
		    	
		        model.addAttribute("set", set );

    		}
    	} catch ( Exception e ) {
    		e.printStackTrace();
    	}

    	return "/homepage/cart";
    }

    /**
     * cart 전체 삭제
     * @param vo
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/main/cartSelectDel")
    public String cartSelectDel(@ModelAttribute MainVO vo, Model model) throws Exception {
    	try {
    		MainSet set = new MainSet();
    		set.setCondiVO(vo);

    		if ( (SessionVO)SessionUtil.getSession() == null ) {
    			return "/login/beforeLogin";
    		} else {
        		set.getCondiVO().setUserId(SessionUtil.getSessionUserId());

    			//Session에 cart 추가
        		HashMap cart = (HashMap)SessionUtil.getAttribute("cart");
    			if ( cart == null )
    				cart = new HashMap();
    			
    			String[] ids = vo.getCartCourseId().split(",");
    			for ( int i = 0; i < ids.length; i++ ) {
	    			if ( cart.containsKey(ids[i]) ) {
	    				cart.remove(ids[i]);
	    			}
    			}
				SessionUtil.setAttribute("cart", cart);
    				
    			//과정 ID 생성
    			String courseId = "";
    			Collection col = cart.keySet();
    			Iterator iter = col.iterator();
    			while ( iter.hasNext() ) {
    				courseId += ( "".equals(courseId) ? "" : "," ) + iter.next();
    			}
    			set.getCondiVO().setCourseId(courseId);
    			
				set = svr.cart(set);
		    	
		        model.addAttribute("set", set );

    		}
    	} catch ( Exception e ) {
    		e.printStackTrace();
    	}

    	return "/homepage/cart";
    }

    /**
     * 1:1 메일문의
     * @param vo
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/main/mailQuestion")
    public String mailQuestion(@ModelAttribute MainVO vo, Model model) throws Exception {
    	try {
    		MainSet set = new MainSet();
    		set.setCondiVO(vo);

			// 메인 페이지에 나올 과정 리스트
			set = svr.mailQuestion(set);
			
	        model.addAttribute("set", set );
    	} catch ( Exception e ) {
    		e.printStackTrace();
    	}

        return CommUtil.getCompTypePage("/homepage/mailQuestion");
    }
    
    @RequestMapping(value = "/main/courseList")
    public String courseList(@ModelAttribute MainVO vo, Model model, HttpServletRequest request) throws Exception {
    	try {
    		vo.setCompCd((String)SessionUtil.getAttribute("compCd"));
    		
    		if ( !CommUtil.isEqual(vo.getTopSearch(), "") ) {
    			vo.setCourseName(vo.getTopSearch());
    		}
    		
    		MainSet set = new MainSet();
    		set.setCondiVO(vo);
    		
    		if ( SessionUtil.getSession() == null)
    			set.getCondiVO().setIsLogin("N");
    		else {
    			set.getCondiVO().setIsLogin("Y");
    			set.getCondiVO().setUserId(SessionUtil.getSessionUserId());
    		}

			// 메인 페이지에 나올 과정 리스트
			set = svr.courseList(set);
			
	        model.addAttribute("set", set );
    	} catch ( Exception e ) {
    		e.printStackTrace();
    	}

        return "/homepage/CourseList";
    }
    
    @RequestMapping(value = "/main/myClassroom")
    public String myClassroom(@ModelAttribute MainVO vo, Model model) throws Exception {
    	try {
    		MainSet set = new MainSet();
    		set.setCondiVO(vo);

    		if ( (SessionVO)SessionUtil.getSession() == null ) {
    			return "/login/beforeLogin";
    		} else {
				set = svr.myClassroom(set);
		    	
		        model.addAttribute("set", set );
    		}
    	} catch ( Exception e ) {
    		e.printStackTrace();
    	}

    	return "/homepage/myClassroom";
    }

    @RequestMapping(value = "/main/tutorial")
    public String tutorial(@ModelAttribute MainVO vo, Model model) throws Exception {
    	try {
    		MainSet set = new MainSet();
    		set.setCondiVO(vo);

	        model.addAttribute("set", set );
    	} catch ( Exception e ) {
    		e.printStackTrace();
    	}

    	return CommUtil.getCompTypePage("/homepage/tutorial");
    }

    @RequestMapping(value = "/main/service")
    public String service(@ModelAttribute MainVO vo, Model model) throws Exception {
    	try {
    		vo.setCompCd((String)SessionUtil.getAttribute("compCd"));
    		
    		MainSet set = new MainSet();
    		set.setCondiVO(vo);

			set = svr.service(set);
		    	
	        model.addAttribute("set", set );
    	} catch ( Exception e ) {
    		e.printStackTrace();
    	}

    	return "/homepage/service";
    }
    
    @RequestMapping(value = "/main/noticeList")
    public String noticeList(@ModelAttribute MainVO vo,Model model) throws Exception {
    	try {
    		vo.setCompCd((String)SessionUtil.getAttribute("compCd"));
    		
    		MainSet set = new MainSet();
	    	set.setCondiVO(vo);
	    	
	    	set = svr.noticeList(set);
	    	
	        model.addAttribute("set", set ); 
    	} catch ( Exception e ) {
    		e.printStackTrace();
    	}

        return CommUtil.getCompTypePage("/homepage/NoticeList");
    }


    @RequestMapping(value = "/main/noticeV")
    public String noticeV(@ModelAttribute MainVO vo,Model model) throws Exception {
    	try {
    		MainSet set = new MainSet();
	    	set.setCondiVO(vo);
	    	
	    	set = svr.noticeV(set);
	    	
	        model.addAttribute("set", set ); 
    	} catch ( Exception e ) {
    		e.printStackTrace();
    	}

        return CommUtil.getCompTypePage("/homepage/NoticeV");
    }

    @RequestMapping(value = "/main/faqList")
    public String faqList(@ModelAttribute MainVO vo,Model model) throws Exception {
    	try {
    		vo.setCompCd((String)SessionUtil.getAttribute("compCd"));
    		
    		MainSet set = new MainSet();
	    	set.setCondiVO(vo);
	    	
	    	set = svr.faqList(set);
	    	
	        model.addAttribute("set", set ); 
    	} catch ( Exception e ) {
    		e.printStackTrace();
    	}

        return CommUtil.getCompTypePage("/homepage/FaqList");
    }

    @RequestMapping(value = "/main/faqV")
    public String faqV(@ModelAttribute MainVO vo,Model model) throws Exception {
    	try {
    		MainSet set = new MainSet();
	    	set.setCondiVO(vo);
	    	
	    	set = svr.faqV(set);
	    	
	        model.addAttribute("set", set ); 
    	} catch ( Exception e ) {
    		e.printStackTrace();
    	}

        return CommUtil.getCompTypePage("/homepage/FaqV");
    }

    @RequestMapping(value = "/main/eventList")
    public String eventList(@ModelAttribute MainVO vo,Model model) throws Exception {
    	try {
    		vo.setCompCd((String)SessionUtil.getAttribute("compCd"));
    		
    		MainSet set = new MainSet();
	    	set.setCondiVO(vo);
	    	
	    	set = svr.eventList(set);
	    	
	        model.addAttribute("set", set ); 
    	} catch ( Exception e ) {
    		e.printStackTrace();
    	}

        return "/homepage/EventList";
    }

    @RequestMapping(value = "/main/eventV")
    public String eventV(@ModelAttribute MainVO vo,Model model) throws Exception {
    	try {
    		MainSet set = new MainSet();
	    	set.setCondiVO(vo);
	    	
	    	set = svr.eventV(set);
	    	
	        model.addAttribute("set", set ); 
    	} catch ( Exception e ) {
    		e.printStackTrace();
    	}

        return "/homepage/EventV";
    }

    @RequestMapping(value = "/main/companyInquiry")
    public String companyInquiry(@ModelAttribute MainVO vo, Model model) throws Exception {
    	try {
    		MainSet set = new MainSet();
    		set.setCondiVO(vo);

    		if ( (SessionVO)SessionUtil.getSession() == null ) {
        		set.getCondiVO().setUserId("GUEST");
    		} else { 
        		set.getCondiVO().setUserId(SessionUtil.getSessionUserId());
    		}

			set = svr.companyInquiry(set);
		    	
	        model.addAttribute("json", CommUtil.getJsonObject(set.getRtnMode(),""));
    	} catch ( Exception e ) {
    		e.printStackTrace();
    	}

    	return "/common/json";
    }
    
    @RequestMapping(value = "/main/tutorInquiry")
    public String tutorInquiry(@ModelAttribute MainVO vo, Model model) throws Exception {
    	try {
    		MainSet set = new MainSet();
    		set.setCondiVO(vo);

    		if ( (SessionVO)SessionUtil.getSession() == null ) {
        		set.getCondiVO().setUserId("GUEST");
    		} else { 
        		set.getCondiVO().setUserId(SessionUtil.getSessionUserId());
    		}

			set = svr.tutorInquiry(set);
		    	
	        model.addAttribute("json", CommUtil.getJsonObject(set.getRtnMode(),""));
    	} catch ( Exception e ) {
    		e.printStackTrace();
    	}

    	return "/common/json";
    }
    
    @RequestMapping(value = "/main/attachI")
    public String attachI( @ModelAttribute AttachVO vo, Model model) throws Exception {
    	try {
	    	AttachSet set = new AttachSet();
	    	set.setCondiVO(vo);
	    	
	    	set = attachSvr.attachI(set);
	
	    	model.addAttribute("set", set );
    	} catch ( Exception e ) {
    		e.printStackTrace();
    	}

        return "/homepage/AttachI";
    }
    
    @RequestMapping(value = "/main/attachIns", method = RequestMethod.POST)
    public String attachIns(MultipartHttpServletRequest request, @ModelAttribute AttachVO vo, Model model) throws Exception {
    	try {
	    	AttachSet set = new AttachSet();
	    	set.setCondiVO(vo);
	    	
	    	Calendar cal = Calendar.getInstance();
	    	String year = Integer.toString(cal.get(Calendar.YEAR));
	    	String month = Integer.toString(cal.get(Calendar.MONTH) + 1);
	    	
	    	if ( month.length() == 1 )
	    		month = "0" + month;
	    	
	    	// 첨부할 루트 디렉토리
	    	String attachFolder = CommUtil.getFileFolder();
	
	    	//년별, 월별 디렉토리 존재여부 체크
	    	File attachDir = new File(attachFolder + year);
	    	if ( !attachDir.exists() )
	    		attachDir.mkdir();
	    	attachDir = new File(attachFolder + year + "//" + month);
	    	if ( !attachDir.exists() )
	    		attachDir.mkdir();
	    	
	    	// 파일 처리
	    	Map<String, MultipartFile> files = request.getFileMap();
	        CommonsMultipartFile cmf = (CommonsMultipartFile) files.get("newFile");
	        
	    	vo.setFileSize(cmf.getFileItem().getSize());
	    	vo.setFileName(UUID.randomUUID().toString());
	    	vo.setFilePath(year + "//" + month + "//");
	    	vo.setOrgFileName(CommUtil.getFileName(cmf.getFileItem().getName()));
	    
	    	//파일 저장
	        File f = new File(attachDir + "//" + vo.getFileName());
	        cmf.transferTo(f);
	
	        //파일 정보를 DB에 저장
	    	set = attachSvr.attachIns(set);
	
	    	model.addAttribute("set", set );
    	} catch ( Exception e ) {
    		e.printStackTrace();
    	}

        return "/board/AttachT";
    }

    @RequestMapping(value = "/main/attachDel", method = RequestMethod.POST)
    public String attachDel(MultipartHttpServletRequest request, @ModelAttribute AttachVO vo, Model model) throws Exception {
    	try {
	    	AttachSet set = new AttachSet();
	    	set.setCondiVO(vo);
	    	
	    	set = attachSvr.attachDel(set);
	    	
	    	// 파일을 삭제한다.
	    	if ( set.getData() != null ) {
	            String fullFileName = CommUtil.getFileFolder() + set.getData().getFilePath() + set.getData().getFileName();
	
	            File f = new File(fullFileName);
	            f.delete();
	    	}
	     
	    	model.addAttribute("set", set );
    	} catch ( Exception e ) {
    		e.printStackTrace();
    	}

    	return "/board/AttachT";
    }
    
    @RequestMapping(value = "/main/interestAdd")
    public String interestAdd(@ModelAttribute MainVO vo, Model model) throws Exception {
    	try {
    		MainSet set = new MainSet();
    		set.setCondiVO(vo);

			set = svr.interestAdd(set);
	    	
	        model.addAttribute("json", CommUtil.getJsonObject(set.getRtnMode(),""));
    	} catch ( Exception e ) {
    		e.printStackTrace();
    	}

    	return "/common/json";
    }
    
    @RequestMapping(value = "/main/interestDelete")
    public String interestDelete(@ModelAttribute MainVO vo, Model model) throws Exception {
    	try {
    		MainSet set = new MainSet();
    		set.setCondiVO(vo);

			set = svr.interestDelete(set);
	    	
	        model.addAttribute("json", CommUtil.getJsonObject(set.getRtnMode(),""));
    	} catch ( Exception e ) {
    		e.printStackTrace();
    	}

    	return "/common/json";
    }
    
}
