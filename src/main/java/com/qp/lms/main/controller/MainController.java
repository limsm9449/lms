package com.qp.lms.main.controller;



import java.net.URLEncoder;
import java.util.Collection;
import java.util.HashMap;
import java.util.Iterator;

import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;

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
    		MainSet set = new MainSet();
    		set.setCondiVO(vo);
    		
    		//Session 정보를 가져온다.
			set.setSessVO((SessionVO)SessionUtil.getSession());
	    	
			// 메인 페이지에 나올 과정 리스트
			set = svr.mainCourseList(set);
			
	        model.addAttribute("set", set );
    	} catch ( Exception e ) {
    		e.printStackTrace();
    	}

        return "/homepage/content";
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
     * cart에서 수강신청
     * @param vo
     * @param model
     * @return
     * @throws Exception
     */
    /*@RequestMapping(value = "/main/cartApplication")
    public String cartApplication(HttpServletRequest request, @ModelAttribute MainVO vo, Model model) throws Exception {
    	try {
    		MainSet set = new MainSet();
    		set.setCondiVO(vo);

    		set.getCondiVO().setUserId(SessionUtil.getSessionUserId());

   			//과정 ID 생성
			HashMap cart = (HashMap)SessionUtil.getAttribute("cart");
			String courseId = "";
			Collection col = cart.keySet();
			Iterator iter = col.iterator();
			while ( iter.hasNext() ) {
				courseId += ( "".equals(courseId) ? "" : "," ) + iter.next();
			}
			set.getCondiVO().setCourseId(courseId);
			
			set = svr.application(set);
	    	
	        model.addAttribute("set", set );

	        request.setAttribute("serverMode", commSvr.getSetting("SERVER_MODE"));
	    	request.setAttribute("g_conf_home_dir", commSvr.getSetting("g_conf_home_dir"));
	    	request.setAttribute("g_conf_key_dir", commSvr.getSetting("g_conf_key_dir"));
	    	request.setAttribute("g_conf_log_dir", commSvr.getSetting("g_conf_log_dir"));
	    	request.setAttribute("g_conf_gw_url", commSvr.getSetting("g_conf_gw_url"));
	    	request.setAttribute("g_conf_js_url", commSvr.getSetting("g_conf_js_url"));
	    	request.setAttribute("g_conf_server", commSvr.getSetting("g_conf_server"));
	    	request.setAttribute("g_conf_site_cd", commSvr.getSetting("g_conf_site_cd"));
	    	request.setAttribute("g_conf_site_key", commSvr.getSetting("g_conf_site_key"));
	    	request.setAttribute("g_conf_site_name", commSvr.getSetting("g_conf_site_name"));
    	} catch ( Exception e ) {
    		e.printStackTrace();
    	}

    	return "/homepage/application";
    }*/

    /**
     * 결재 요청...
     * @param vo
     * @param model
     * @return
     * @throws Exception
     */
    /*@RequestMapping(value = "/main/ppAxHub")
    public String ppAxHub(HttpServletRequest request, @ModelAttribute MainVO vo, Model model) throws Exception {
		MainSet set = new MainSet();
    	try {
    		set.setCondiVO(vo);
    		
	        model.addAttribute("set", set );
    	} catch ( Exception e ) {
    		e.printStackTrace();
    	}

    	String serverMode = commSvr.getSetting("SERVER_MODE");
    	request.setAttribute("serverMode", serverMode);

    	request.setAttribute("g_conf_home_dir", commSvr.getSetting("g_conf_home_dir"));
    	request.setAttribute("g_conf_key_dir", commSvr.getSetting("g_conf_key_dir"));
    	request.setAttribute("g_conf_log_dir", commSvr.getSetting("g_conf_log_dir"));
    	request.setAttribute("g_conf_gw_url", commSvr.getSetting("g_conf_gw_url"));
    	request.setAttribute("g_conf_js_url", commSvr.getSetting("g_conf_js_url"));
    	request.setAttribute("g_conf_server", commSvr.getSetting("g_conf_server"));
    	request.setAttribute("g_conf_site_cd", commSvr.getSetting("g_conf_site_cd"));
    	request.setAttribute("g_conf_site_key", commSvr.getSetting("g_conf_site_key"));
    	request.setAttribute("g_conf_site_name", commSvr.getSetting("g_conf_site_name"));
    	
    	if ( "REAL".equals(serverMode) ) {
    		return "/homepage/pp_ax_hub_linux";
    	} else {
    		return "/homepage/pp_ax_hub_win";
    	}
    }*/

    /**
     * 카드등 결재 완료후 처리
     * @param vo
     * @param model
     * @return
     * @throws Exception
     */
    /*@RequestMapping(value = "/main/result")
    public String result(MainVO vo) throws Exception {
    	try {
    		MainSet set = new MainSet();
    		set.setCondiVO(vo);

    		//cart 삭제
    		SessionUtil.setAttribute("cart", null);
    		SessionUtil.setAttribute("tempCart", null);
    	} catch ( Exception e ) {
    		e.printStackTrace();
    	}
    	
    	return "/homepage/result";
    }*/

    /**
     * 수강신청
     * @param vo
     * @param model
     * @return
     * @throws Exception
     */
    /*@RequestMapping(value = "/main/application")
    public String application(@ModelAttribute MainVO vo, HttpServletRequest request, Model model) throws Exception {
    	try {
    		MainSet set = new MainSet();
    		set.setCondiVO(vo);

			//Session에 cart 추가
    		HashMap cart = new HashMap();
			if ( !cart.containsKey(vo.getCourseId()) ) {
				cart.put(vo.getCourseId(),vo.getCartWeeks());
				SessionUtil.setAttribute("tempCart", cart);
			}

    		if ( (SessionVO)SessionUtil.getSession() == null ) {
    			return "/login/beforeLogin";
    		} else {
        		set.getCondiVO().setUserId(SessionUtil.getSessionUserId());

				set = svr.application(set);
		    	
		        model.addAttribute("set", set );

		    	request.setAttribute("serverMode", commSvr.getSetting("SERVER_MODE"));
		    	request.setAttribute("g_conf_home_dir", commSvr.getSetting("g_conf_home_dir"));
		    	request.setAttribute("g_conf_key_dir", commSvr.getSetting("g_conf_key_dir"));
		    	request.setAttribute("g_conf_log_dir", commSvr.getSetting("g_conf_log_dir"));
		    	request.setAttribute("g_conf_gw_url", commSvr.getSetting("g_conf_gw_url"));
		    	request.setAttribute("g_conf_js_url", commSvr.getSetting("g_conf_js_url"));
		    	request.setAttribute("g_conf_server", commSvr.getSetting("g_conf_server"));
		    	request.setAttribute("g_conf_site_cd", commSvr.getSetting("g_conf_site_cd"));
		    	request.setAttribute("g_conf_site_key", commSvr.getSetting("g_conf_site_key"));
		    	request.setAttribute("g_conf_site_name", commSvr.getSetting("g_conf_site_name"));
    		}
    	} catch ( Exception e ) {
    		e.printStackTrace();
    	}

    	return "/homepage/application";
    }*/

    /**
     * 결재팝업
     * @param vo
     * @param model
     * @return
     * @throws Exception
     */
    /*@RequestMapping(value = "/main/approvalP")
    public String approvalP(@ModelAttribute MainVO vo, Model model) throws Exception {
    	try {
    		MainSet set = new MainSet();
    		set.setCondiVO(vo);

	        model.addAttribute("set", set );
    	} catch ( Exception e ) {
    		e.printStackTrace();
    	}

    	return "/homepage/approvalP";
    }*/

    /**
     * 결재
     * @param vo
     * @param model
     * @return
     * @throws Exception
     */
    /*@RequestMapping(value = "/main/approval")
    public String approval(@ModelAttribute MainVO vo, Model model) throws Exception {
    	try {
    		MainSet set = new MainSet();
    		set.setCondiVO(vo);

    		set = svr.approval(set);
    		
    		//cart 삭제
    		SessionUtil.setAttribute("cart", null);
    		SessionUtil.setAttribute("tempCart", null);
    		
	    	model.addAttribute("json", CommUtil.getJsonObject(set.getRtnMode(),""));
    	} catch ( Exception e ) {
    		e.printStackTrace();
    	}

        return "/common/json";
    }*/

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

        return "/homepage/mailQuestion";
    }
    
    @RequestMapping(value = "/main/courseList")
    public String courseList(@ModelAttribute MainVO vo, Model model, HttpServletRequest request) throws Exception {
    	try {
    		MainSet set = new MainSet();
    		set.setCondiVO(vo);
    		
    		if ( SessionUtil.getSession() == null)
    			set.getCondiVO().setIsLogin("N");
    		else {
    			set.getCondiVO().setIsLogin("Y");
    			set.getCondiVO().setUserId(SessionUtil.getSessionUserId());
    			set.getCondiVO().setCompCd(SessionUtil.getCompCd());
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

}
