package com.qp.lms.common.controller;



import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.qp.lms.category.model.CategorySet;
import com.qp.lms.category.model.CategoryVO;
import com.qp.lms.common.Constant;
import com.qp.lms.common.model.CommSet;
import com.qp.lms.common.model.CommVO;
import com.qp.lms.common.service.CommService;

import net.sf.json.JSONArray;

@Controller
public class CommController {

	 private static final Logger logger = LoggerFactory.getLogger(CommController.class);

	    @Autowired
	    private CommService svr;
	    
	   
	    @RequestMapping(value = "/common/openPage", method = RequestMethod.POST)
	    public String openPage(@RequestParam("page") String page, HttpServletRequest request, HttpServletResponse response) throws Exception {

	        return page;
	    }
	    
	    @RequestMapping(value = "/common/getDd", method = RequestMethod.POST, consumes = "application/json" )
	    public @ResponseBody HashMap<String,Object> getDd(@RequestBody HashMap<String, Object> paramMap, HttpServletRequest request, HttpServletResponse response) throws Exception {
	    	HashMap<String, Object> hm = new HashMap<String, Object>();
	    	
    		try {
	    		hm = svr.getDd(paramMap);
	    	} catch ( Exception e ) {
	    		e.printStackTrace();
	    		hm.put("RtnMode", Constant.mode.ERROR.name());
	    	}

	        return hm;
	    }
	    
	    @RequestMapping(value = "/common/getMaxCourseCode", method = RequestMethod.POST, consumes = "application/json" )
	    public @ResponseBody HashMap<String,Object> getMaxCourseCode(@RequestBody HashMap<String, Object> paramMap, HttpServletRequest request, HttpServletResponse response) throws Exception {
	    	HashMap<String, Object> hm = new HashMap<String, Object>();
	    	
    		try {
	    		hm = svr.getMaxCourseCode(paramMap);
	    	} catch ( Exception e ) {
	    		e.printStackTrace();
	    		hm.put("RtnMode", Constant.mode.ERROR.name());
	    	}

	        return hm;
	    }
	    
	    /**
	     * 카테고리 중분류
	     * @param vo
	     * @param model
	     * @return
	     * @throws Exception
	     */
	    @RequestMapping(value = "/common/ddCategory2Depth", method = RequestMethod.POST)
	    public String ddCategory2Depth(@ModelAttribute CategoryVO vo, Model model) throws Exception {
	    	CategorySet set = new CategorySet();
	    	set.setCondiVO(vo);
	    	
	    	JSONArray json = JSONArray.fromObject(svr.ddCategory2Depth(set));    
	    	
	    	model.addAttribute("json", json);

	        return "/common/json";
	    }
	    
	    /**
	     * 카테고리 소분류
	     * @param vo
	     * @param model
	     * @return
	     * @throws Exception
	     */
	    @RequestMapping(value = "/common/ddCategory3Depth", method = RequestMethod.POST)
	    public String ddCategory3Depth(@ModelAttribute CategoryVO vo, Model model) throws Exception {
	    	CategorySet set = new CategorySet();
	    	set.setCondiVO(vo);
	    	
	    	JSONArray json = JSONArray.fromObject(svr.ddCategory3Depth(set));    
	    	
	    	model.addAttribute("json", json);

	        return "/common/json";
	    }
	    
	    /**
	     * 과정코드
	     * @param vo
	     * @param model
	     * @return
	     * @throws Exception
	     */
	    @RequestMapping(value = "/common/ddCourseCode", method = RequestMethod.POST)
	    public String ddCourseCode(@ModelAttribute CategoryVO vo, Model model) throws Exception {
	    	CategorySet set = new CategorySet();
	    	set.setCondiVO(vo);
	    	
	    	JSONArray json = JSONArray.fromObject(svr.ddCourseCode(set));    
	    	
	    	model.addAttribute("json", json);

	        return "/common/json";
	    }
	    
	    /**
	     * 과정코드(사용가능한)
	     * @param vo
	     * @param model
	     * @return
	     * @throws Exception
	     */
	    @RequestMapping(value = "/common/ddCourseCodeForUse", method = RequestMethod.POST)
	    public String ddCourseCodeForUse(@ModelAttribute CategoryVO vo, Model model) throws Exception {
	    	CategorySet set = new CategorySet();
	    	set.setCondiVO(vo);
	    	
	    	JSONArray json = JSONArray.fromObject(svr.ddCourseCodeForUse(set));    
	    	
	    	model.addAttribute("json", json);

	        return "/common/json";
	    }
	    
	    /**
	     * 사용자 검색
	     * @param vo
	     * @param model
	     * @return
	     * @throws Exception
	     */
	    @RequestMapping(value = "/common/userSearchList")
	    public String userSearchList(@ModelAttribute CommVO vo, Model model) throws Exception {
	    	try {
		    	CommSet set = new CommSet();
		    	set.setCondiVO(vo);
		    	
		    	set = svr.userSearchList(set);
		    	
		        model.addAttribute("set", set );
	    	} catch ( Exception e ) {
	    		e.printStackTrace();
	    	}
	    	
	        return "/common/UserSearchList";
	    }
	    
	    @RequestMapping(value = "/goJsp")
	    public String goPage(@ModelAttribute CommVO vo,Model model) throws Exception {

	        return "/homepage/" + vo.getJspPage();
	    }	    
	    
	    @RequestMapping(value = "/common/ddSubCategory", method = RequestMethod.POST)
	    public String getList(@ModelAttribute CommVO vo,Model model) throws Exception {
	    	CommSet set = new CommSet();
	    	set.setCondiVO(vo);
	    	
	    	set = svr.getSubCategory(set);
	    	
	    	JSONArray json = JSONArray.fromObject(set.getDdCategory());    
	    	
	        model.addAttribute("json", json);

	        return "/common/json";
	    }

	    /**
	     * 게시판 팝업
	     * @param vo
	     * @param model
	     * @return
	     * @throws Exception
	     */
	    @RequestMapping(value = "/common/boardPopup")
	    public String boardPopup(@ModelAttribute CommVO vo, Model model) throws Exception {
	    	try {
		    	CommSet set = new CommSet();
		    	set.setCondiVO(vo);
		    	
		        model.addAttribute("set", set );
	    	} catch ( Exception e ) {
	    		e.printStackTrace();
	    	}
	    	
	        return "/board/BoardPopup";
	    }	    

}
