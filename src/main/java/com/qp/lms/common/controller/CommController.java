package com.qp.lms.common.controller;



import net.sf.json.JSONArray;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.qp.lms.category.model.CategorySet;
import com.qp.lms.category.model.CategoryVO;
import com.qp.lms.common.model.CommSet;
import com.qp.lms.common.model.CommVO;
import com.qp.lms.common.service.CommService;
import com.qp.lms.ns.model.NsVO;
import com.qp.lms.user.model.UserVO;

@Controller
public class CommController {

	 private static final Logger logger = LoggerFactory.getLogger(CommController.class);

	    @Autowired
	    private CommService svr;
	    
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
