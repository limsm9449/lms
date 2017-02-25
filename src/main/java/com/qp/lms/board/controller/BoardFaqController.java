package com.qp.lms.board.controller;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.qp.lms.board.model.BoardFaqSet;
import com.qp.lms.board.model.BoardFaqVO;
import com.qp.lms.board.service.BoardFaqService;
import com.qp.lms.common.CommUtil;
import com.qp.lms.common.SessionUtil;

@Controller
public class BoardFaqController {

	private static final Logger logger = LoggerFactory.getLogger(BoardFaqController.class);

    @Autowired
    private BoardFaqService svr;

    
    /**
     * FAQ 리스트
     * @param vo
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/board/boardFaqList")
    public String boardFaqList(@ModelAttribute BoardFaqVO vo, Model model) throws Exception {
    	try {
	    	BoardFaqSet set = new BoardFaqSet();
	    	set.setCondiVO(vo);
	    	
	    	set = svr.boardFaqList(set);
	    	
	    	model.addAttribute("set", set );
    	} catch ( Exception e ) {
    		e.printStackTrace();
    	}
    	
        return "/board/BoardFaqList";
    }

    /**
     * FAQ 조회 화면
     * @param vo
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/board/boardFaqV")
    public String boardFaqV(@ModelAttribute BoardFaqVO vo, Model model) throws Exception {
    	try {
	    	BoardFaqSet set = new BoardFaqSet();
	    	set.setCondiVO(vo);
	    	
	    	set = svr.boardFaqV(set);
	    	
	    	model.addAttribute("set", set );
    	} catch ( Exception e ) {
    		e.printStackTrace();
    	}

        return "/board/BoardFaqV";
    }

    /**
     * FAQ 입력 화면
     * @param vo
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/board/boardFaqN")
    public String boardFaqN(@ModelAttribute BoardFaqVO vo, Model model) throws Exception {
    	try {
	    	BoardFaqSet set = new BoardFaqSet();
	    	set.setCondiVO(vo);
	    	
	    	set = svr.boardFaqN(set);
	    	
	    	model.addAttribute("set", set );
    	} catch ( Exception e ) {
    		e.printStackTrace();
    	}

        return "/board/BoardFaqN";
    }
    
    /**
     * FAQ 수정 화면
     * @param vo
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/board/boardFaqU")
    public String boardFaqU(@ModelAttribute BoardFaqVO vo, Model model) throws Exception {
    	try {
	    	BoardFaqSet set = new BoardFaqSet();
	    	set.setCondiVO(vo);
	    	
	    	set = svr.boardFaqU(set);
	    	
	    	model.addAttribute("set", set );
    	} catch ( Exception e ) {
    		e.printStackTrace();
    	}

        return "/board/BoardFaqU";
    }

    /**
     * FAQ 입력
     * @param vo
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/board/boardFaqIns", method = RequestMethod.POST)
    public String boardFaqIns(@ModelAttribute BoardFaqVO vo, Model model) throws Exception {
    	try {
	    	BoardFaqSet set = new BoardFaqSet();
	    	set.setCondiVO(vo);
	    	
	    	set = svr.boardFaqIns(set);
	    	
	    	model.addAttribute("json", CommUtil.getJsonObject(set.getRtnMode(),""));
    	} catch ( Exception e ) {
    		e.printStackTrace();
    	}

    	return "/common/json";
    }

    /**
     * FAQ 수정
     * @param vo
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/board/boardFaqUpd", method = RequestMethod.POST)
    public String boardFaqUpd(@ModelAttribute BoardFaqVO vo, Model model) throws Exception {
    	try {
	    	BoardFaqSet set = new BoardFaqSet();
	    	set.setCondiVO(vo);
	    	
	    	set = svr.boardFaqUpd(set);
	    	
	    	model.addAttribute("json", CommUtil.getJsonObject(set.getRtnMode(),""));
    	} catch ( Exception e ) {
    		e.printStackTrace();
    	}

    	return "/common/json";
    }

    /**
     * FAQ 삭제
     * @param vo
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/board/boardFaqDel", method = RequestMethod.POST)
    public String boardFaqDel(@ModelAttribute BoardFaqVO vo, Model model) throws Exception {
    	try {
	    	BoardFaqSet set = new BoardFaqSet();
	    	set.setCondiVO(vo);
	    	
	    	set = svr.boardFaqDel(set);
	    	
	    	model.addAttribute("json", CommUtil.getJsonObject(set.getRtnMode(),""));
    	} catch ( Exception e ) {
    		e.printStackTrace();
    	}

    	return "/common/json";
    }

}
