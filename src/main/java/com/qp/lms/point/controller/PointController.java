package com.qp.lms.point.controller;



import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;

import com.qp.lms.common.SessionUtil;
import com.qp.lms.common.SessionVO;
import com.qp.lms.point.model.PointSet;
import com.qp.lms.point.model.PointVO;
import com.qp.lms.point.service.PointService;

/**
 * 포인트 관리
 * @author limsm
 *
 */
@Controller
public class PointController {

	private static final Logger logger = LoggerFactory.getLogger(PointController.class);

    @Autowired
    private PointService svr;

    /**
     *  사용자별 포인트 리스트
     * @param vo
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/point/pointUserList")
    public String pointUserList(@ModelAttribute PointVO vo, Model model) throws Exception {
    	try {
	    	PointSet set = new PointSet();
	    	set.setCondiVO(vo);
	
	    	set = svr.pointUserList(set);
	    	
	        model.addAttribute("set", set );
    	} catch ( Exception e ) {
    		e.printStackTrace();
    	}

        return "/point/PointUserList";
    }
 
    /**
     * 사용자별 포인트 내역
     * @param vo
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/point/pointUserV")
    public String pointUserV(@ModelAttribute PointVO vo, Model model) throws Exception {
    	try {
	    	PointSet set = new PointSet();
	    	set.setCondiVO(vo);
	    	
	    	set = svr.pointUserV(set);
	    	
	        model.addAttribute("set", set );
    	} catch ( Exception e ) {
    		e.printStackTrace();
    	}

        return "/point/PointUserV";
    }

    /**
     * 마이 포인트 내역
     * @param vo
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/point/myPoint")
    public String myPoint(@ModelAttribute PointVO vo, Model model) throws Exception {
    	try {
	    	PointSet set = new PointSet();
	    	set.setCondiVO(vo);
	    	
	    	set.getCondiVO().setUserId(SessionUtil.getSessionUserId());
	    	
	    	set = svr.pointUserV(set);
	    	
	        model.addAttribute("set", set );
    	} catch ( Exception e ) {
    		e.printStackTrace();
    	}

        return "/point/MyPoint";
    }



}
