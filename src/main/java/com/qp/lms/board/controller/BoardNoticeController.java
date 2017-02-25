package com.qp.lms.board.controller;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.qp.lms.board.model.BoardSet;
import com.qp.lms.board.model.BoardVO;
import com.qp.lms.board.service.BoardNoticeService;
import com.qp.lms.common.CommUtil;
import com.qp.lms.common.SessionUtil;

@Controller
public class BoardNoticeController {

	private static final Logger logger = LoggerFactory.getLogger(BoardNoticeController.class);

    @Autowired
    private BoardNoticeService svr;
    
    
    /**
     * 공지사항 리스트
     * @param vo
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/board/boardNoticeList")
    public String boardNoticeList(@ModelAttribute BoardVO vo, Model model) throws Exception {
    	try {
	    	BoardSet set = new BoardSet();
	    	set.setCondiVO(vo);
	    	
	    	set = svr.boardNoticeList(set);
	    	
	    	model.addAttribute("set", set );
    	} catch ( Exception e ) {
    		e.printStackTrace();
    	}
    	
        return "/board/BoardNoticeList";
    }

    @RequestMapping(value = "/board/userBoardNoticeList")
    public String userBoardNoticeList(@ModelAttribute BoardVO vo, Model model) throws Exception {
    	try {
	    	BoardSet set = new BoardSet();
	    	set.setCondiVO(vo);
	    	
	    	set = svr.boardNoticeList(set);
	    	
	    	model.addAttribute("set", set );
    	} catch ( Exception e ) {
    		e.printStackTrace();
    	}
    	
        return "/board/UserBoardNoticeList";
    }

    /**
     * 공지사항 조회 화면
     * @param vo
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/board/boardNoticeV")
    public String boardNoticeV(@ModelAttribute BoardVO vo, Model model) throws Exception {
    	try {
	    	BoardSet set = new BoardSet();
	    	set.setCondiVO(vo);
	    	
	    	set = svr.boardNoticeV(set);
    	    	
	    	model.addAttribute("set", set );
    	} catch ( Exception e ) {
    		e.printStackTrace();
    	}
    	
        return "/board/BoardNoticeV";
    }

    @RequestMapping(value = "/board/userBoardNoticeV")
    public String userBoardNoticeV(@ModelAttribute BoardVO vo, Model model) throws Exception {
    	try {
	    	BoardSet set = new BoardSet();
	    	set.setCondiVO(vo);
	    	
	    	set = svr.boardNoticeV(set);
    	    	
	    	model.addAttribute("set", set );
    	} catch ( Exception e ) {
    		e.printStackTrace();
    	}
    	
        return "/board/UserBoardNoticeV";
    }

    /**
     * 공지사항 입력 화면
     * @param vo
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/board/boardNoticeN")
    public String boardNoticeN(@ModelAttribute BoardVO vo, Model model) throws Exception {
    	try {
	    	BoardSet set = new BoardSet();
	    	set.setCondiVO(vo);
	    	
	    	model.addAttribute("set", set );
    	} catch ( Exception e ) {
    		e.printStackTrace();
    	}

        return "/board/BoardNoticeN";
    }
    
    /**
     * 공지사항 수정 화면
     * @param vo
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/board/boardNoticeU")
    public String boardNoticeU(@ModelAttribute BoardVO vo, Model model) throws Exception {
    	try {
	    	BoardSet set = new BoardSet();
	    	set.setCondiVO(vo);
	    	
	    	set = svr.boardNoticeU(set);
	    	
	    	model.addAttribute("set", set );
    	} catch ( Exception e ) {
    		e.printStackTrace();
    	}

        return "/board/BoardNoticeU";
    }

    
    
    ///////////////////////////////////////////////// Transaction ////////////////////////////////////////////////////
    
    /**
     * 공지사항 입력
     * @param vo
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/board/boardNoticeIns", method = RequestMethod.POST)
    public String boardNoticeIns(@ModelAttribute BoardVO vo, Model model) throws Exception {
    	try {
	    	BoardSet set = new BoardSet();
	    	set.setCondiVO(vo);
	    	
	    	set = svr.boardNoticeIns(set);
	    	model.addAttribute("json", CommUtil.getJsonObject(set.getRtnMode(),""));
    	} catch ( Exception e ) {
    		e.printStackTrace();
    	}

    	return "/common/json";
    }

    /**
     * 공지사항 수정
     * @param vo
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/board/boardNoticeUpd", method = RequestMethod.POST)
    public String boardNoticeUpd(@ModelAttribute BoardVO vo, Model model) throws Exception {
    	try {
	    	BoardSet set = new BoardSet();
	    	set.setCondiVO(vo);
	    	
	    	set = svr.boardNoticeUpd(set);
	    	
	    	model.addAttribute("json", CommUtil.getJsonObject(set.getRtnMode(),""));
    	} catch ( Exception e ) {
    		e.printStackTrace();
    	}

    	return "/common/json";
    }

    /**
     * 공지사항 삭제
     * @param vo
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/board/boardNoticeDel", method = RequestMethod.POST)
    public String boardNoticeDel(@ModelAttribute BoardVO vo, Model model) throws Exception {
    	try {
	    	BoardSet set = new BoardSet();
	    	set.setCondiVO(vo);
	    	
	    	set = svr.boardNoticeDel(set);
	    	
	    	model.addAttribute("json", CommUtil.getJsonObject(set.getRtnMode(),""));
    	} catch ( Exception e ) {
    		e.printStackTrace();
    	}

    	return "/common/json";
    }
   

}
