package com.qp.lms.category.controller;



import java.util.HashMap;
import java.util.Map;

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
import org.springframework.web.bind.annotation.ResponseBody;

import com.qp.lms.category.model.CategorySet;
import com.qp.lms.category.model.CategoryVO;
import com.qp.lms.category.service.CategoryService;
import com.qp.lms.common.CommUtil;
import com.qp.lms.common.Constant;

@Controller
public class CategoryController {

	 private static final Logger logger = LoggerFactory.getLogger(CategoryController.class);

	    @Autowired
	    private CategoryService svr;

	    
	    
	    /**
	     * 카테고리 조회
	     * @param vo
	     * @param model
	     * @return
	     * @throws Exception
	     */
	    @RequestMapping(value = "/category/categoryList", method = RequestMethod.POST)
	    public String categoryList(@ModelAttribute CategoryVO vo, Model model) throws Exception {
	    	try {
		    	CategorySet set = new CategorySet();
		    	set.setCondiVO(vo);
		    	
		    	set = svr.categoryList(set);
		    	
		        model.addAttribute("set", set );
	    	} catch ( Exception e ) {
	    		e.printStackTrace();
	    	}

	        return "/category/categoryList";
	    }

	    /**
	     * 대분류 추가 화면
	     * @param vo
	     * @param model
	     * @return
	     * @throws Exception
	     */
	    @RequestMapping(value = "/category/category1DepthN")
	    public String category1DepthN(@ModelAttribute CategoryVO vo, Model model) throws Exception {
	        return "/category/category1DepthN";
	    }	    
	    
	    /**
	     * 대분류 추가
	     * @param vo
	     * @param model
	     * @return
	     * @throws Exception
	     */
	    @RequestMapping(value = "/category/category1DepthIns", method = RequestMethod.POST)
	    public String category1DepthIns(@ModelAttribute CategoryVO vo, Model model) throws Exception {
	    	try {
		    	CategorySet set = new CategorySet();
		    	set.setCondiVO(vo);
		    	
		    	set = svr.category1DepthIns(set);
		    	
		    	model.addAttribute("json", CommUtil.getJsonObject(set.getRtnMode(),""));
	    	} catch ( Exception e ) {
	    		e.printStackTrace();
	    	}

	        return "/common/json";
	    }	    
	    
	    /**
	     * 중분류 추가화면
	     * @param vo
	     * @param model
	     * @return
	     * @throws Exception
	     */
	    @RequestMapping(value = "/category/category2DepthN")
	    public String category2DepthN(@ModelAttribute CategoryVO vo, Model model) throws Exception {
	    	try {
		    	CategorySet set = new CategorySet();
		    	set.setCondiVO(vo);
		    	
		    	set = svr.category2DepthN(set);
		    	
		    	model.addAttribute("set", set );
	    	} catch ( Exception e ) {
	    		e.printStackTrace();
	    	}

	        return "/category/category2DepthN";
	    }	
	    
	    /**
	     * 중분류 추가
	     * @param vo
	     * @param model
	     * @return
	     * @throws Exception
	     */
	    @RequestMapping(value = "/category/category2DepthIns", method = RequestMethod.POST)
	    public String category2DepthIns(@ModelAttribute CategoryVO vo, Model model) throws Exception {
	    	try {
		    	CategorySet set = new CategorySet();
		    	set.setCondiVO(vo);
		    	
		    	set = svr.category2DepthIns(set);
		    	
		    	model.addAttribute("json", CommUtil.getJsonObject(set.getRtnMode(),""));
	    	} catch ( Exception e ) {
	    		e.printStackTrace();
	    	}

	        return "/common/json";
	    }	
	    
	    /**
	     * 소분류 추가화면
	     * @param vo
	     * @param model
	     * @return
	     * @throws Exception
	     */
	    @RequestMapping(value = "/category/category3DepthN")
	    public String category3DepthN(@ModelAttribute CategoryVO vo, Model model) throws Exception {
	    	try {
		    	CategorySet set = new CategorySet();
		    	set.setCondiVO(vo);
		    	
		    	set = svr.category3DepthN(set);
		    	
		    	model.addAttribute("set", set );
	    	} catch ( Exception e ) {
	    		e.printStackTrace();
	    	}

	        return "/category/category3DepthN";
	    }	
	    
	    /**
	     * 소분류 추가
	     * @param vo
	     * @param model
	     * @return
	     * @throws Exception
	     */
	    @RequestMapping(value = "/category/category3DepthIns", method = RequestMethod.POST)
	    public String category3DepthIns(@ModelAttribute CategoryVO vo, Model model) throws Exception {
	    	try {
	    		CategorySet set = new CategorySet();
	    	
		    	set.setCondiVO(vo);
		    	
		    	set = svr.category3DepthIns(set);
		    	
		    	model.addAttribute("json", CommUtil.getJsonObject(set.getRtnMode(),""));
	    	} catch ( Exception e ) {
	    		e.printStackTrace();
	    	}

	        return "/common/json";
	    }	
	    
	    /**
	     * 카테고리 수정화면
	     * @param vo
	     * @param model
	     * @return
	     * @throws Exception
	     */
	    @RequestMapping(value = "/category/categoryU")
	    public String categoryU(@ModelAttribute CategoryVO vo, Model model) throws Exception {
	    	try {
		    	CategorySet set = new CategorySet();
		    	set.setCondiVO(vo);
		    	
		    	set = svr.categoryU(set);
		    	
		    	model.addAttribute("set", set );
	    	} catch ( Exception e ) {
	    		e.printStackTrace();
	    	}

	        return "/category/categoryU";
	    }	
	    
	    /**
	     * 카테고리 수정
	     * @param vo
	     * @param model
	     * @return
	     * @throws Exception
	     */
	    @RequestMapping(value = "/category/categoryUUpd", method = RequestMethod.POST)
	    public String categoryUUpd(@ModelAttribute CategoryVO vo, Model model) throws Exception {
	    	try {
		    	CategorySet set = new CategorySet();
		    	set.setCondiVO(vo);
		    	
		    	set = svr.categoryUUpd(set);
		    	
		    	model.addAttribute("json", CommUtil.getJsonObject(set.getRtnMode(),""));
	    	} catch ( Exception e ) {
	    		e.printStackTrace();
	    	}

	        return "/common/json";
	    }	
	    
	    /**
	     * 카테고리를 삭제한다.
	     * @param vo
	     * @param model
	     * @return
	     * @throws Exception
	     */
	    @RequestMapping(value = "/category/categoryUDel", method = RequestMethod.POST)
	    public String categoryUDel(@ModelAttribute CategoryVO vo, Model model) throws Exception {
	    	try {
		    	CategorySet set = new CategorySet();
		    	set.setCondiVO(vo);
		    	
		    	set = svr.categoryUDel(set);
		    	
		    	model.addAttribute("json", CommUtil.getJsonObject(set.getRtnMode(),""));
	    	} catch ( Exception e ) {
	    		e.printStackTrace();
	    	}

	        return "/common/json";
	    }	
	    
	    
	    

}
