package com.qp.lms.board.controller;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.qp.lms.board.model.BoardDiscussionSet;
import com.qp.lms.board.model.BoardDiscussionVO;
import com.qp.lms.board.service.BoardDiscussionService;
import com.qp.lms.common.CommUtil;
import com.qp.lms.common.SessionUtil;

@Controller
public class BoardDiscussionController {

	private static final Logger logger = LoggerFactory.getLogger(BoardDiscussionController.class);

    @Autowired
    private BoardDiscussionService svr;
    
    /**
     * 토론 리스트
     * @param vo
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/board/boardDiscussionList")
    public String boardDiscussionList(@ModelAttribute BoardDiscussionVO vo, Model model) throws Exception {
    	try {
	    	BoardDiscussionSet set = new BoardDiscussionSet();
	    	set.setCondiVO(vo);
	    	
	    	set = svr.boardDiscussionList(set);
	    	
	    	model.addAttribute("set", set );
    	} catch ( Exception e ) {
    		e.printStackTrace();
    	}

        return "/board/BoardDiscussionList";
    }

    /**
     * 토론 조회 화면 
     * @param vo
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/board/boardDiscussionV")
    public String boardDiscussionV(@ModelAttribute BoardDiscussionVO vo, Model model) throws Exception {
    	try {
	    	BoardDiscussionSet set = new BoardDiscussionSet();
	    	set.setCondiVO(vo);
	    	
	    	set = svr.boardDiscussionV(set);
	    	
	    	set.setUserId(SessionUtil.getSessionUserId());
	    	
	    	model.addAttribute("set", set );
    	} catch ( Exception e ) {
    		e.printStackTrace();
    	}

        return "/board/BoardDiscussionV";
    }

    /**
     * 토론 입력 화면
     * @param vo
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/board/boardDiscussionN")
    public String boardDiscussionN(@ModelAttribute BoardDiscussionVO vo, Model model) throws Exception {
    	try {
	    	BoardDiscussionSet set = new BoardDiscussionSet();
	    	set.setCondiVO(vo);
	    	
	    	model.addAttribute("set", set );
    	} catch ( Exception e ) {
    		e.printStackTrace();
    	}

        return "/board/BoardDiscussionN";
    }
    
    /**
     * 토론 수정 화면
     * @param vo
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/board/boardDiscussionU")
    public String boardDiscussionU(@ModelAttribute BoardDiscussionVO vo, Model model) throws Exception {
    	try {
	    	BoardDiscussionSet set = new BoardDiscussionSet();
	    	set.setCondiVO(vo);
	    	
	    	set = svr.boardDiscussionU(set);
	    	
	    	model.addAttribute("set", set );
    	} catch ( Exception e ) {
    		e.printStackTrace();
    	}

        return "/board/BoardDiscussionU";
    }

    
    /**
     * 토론 리스트
     * @param vo
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/board/userBoardDiscussionList")
    public String userBoardDiscussionList(@ModelAttribute BoardDiscussionVO vo, Model model) throws Exception {
    	try {
	    	BoardDiscussionSet set = new BoardDiscussionSet();
	    	set.setCondiVO(vo);
	    	
	    	set = svr.boardDiscussionList(set);
	    	
	    	model.addAttribute("set", set );
    	} catch ( Exception e ) {
    		e.printStackTrace();
    	}

        return "/board/UserBoardDiscussionList";
    }

    /**
     * 토론 조회 화면 
     * @param vo
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/board/userBoardDiscussionV")
    public String userBoardDiscussionV(@ModelAttribute BoardDiscussionVO vo, Model model) throws Exception {
    	try {
	    	BoardDiscussionSet set = new BoardDiscussionSet();
	    	set.setCondiVO(vo);
	    	
	    	set = svr.boardDiscussionV(set);
	    	
	    	set.setUserId(SessionUtil.getSessionUserId());
	    	
	    	model.addAttribute("set", set );
    	} catch ( Exception e ) {
    		e.printStackTrace();
    	}

        return "/board/UserBoardDiscussionV";
    }

    /**
     * 토론 입력 화면
     * @param vo
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/board/userBoardDiscussionN")
    public String userBoardDiscussionN(@ModelAttribute BoardDiscussionVO vo, Model model) throws Exception {
    	try {
	    	BoardDiscussionSet set = new BoardDiscussionSet();
	    	set.setCondiVO(vo);
	    	
	    	model.addAttribute("set", set );
    	} catch ( Exception e ) {
    		e.printStackTrace();
    	}

        return "/board/UserBoardDiscussionN";
    }
    
    /**
     * 토론 수정 화면
     * @param vo
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/board/userBoardDiscussionU")
    public String userBoardDiscussionU(@ModelAttribute BoardDiscussionVO vo, Model model) throws Exception {
    	try {
	    	BoardDiscussionSet set = new BoardDiscussionSet();
	    	set.setCondiVO(vo);
	    	
	    	set = svr.boardDiscussionU(set);
	    	
	    	model.addAttribute("set", set );
    	} catch ( Exception e ) {
    		e.printStackTrace();
    	}

        return "/board/UserBoardDiscussionU";
    }
    
    
    /**
     * 토론 입력
     * @param vo
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/board/boardDiscussionIns", method = RequestMethod.POST)
    public String boardDiscussionIns(@ModelAttribute BoardDiscussionVO vo, Model model) throws Exception {
    	try {
	    	BoardDiscussionSet set = new BoardDiscussionSet();
	    	set.setCondiVO(vo);
	    	
	    	set = svr.boardDiscussionIns(set);
	    	
	    	model.addAttribute("json", CommUtil.getJsonObject(set.getRtnMode(),""));
    	} catch ( Exception e ) {
    		e.printStackTrace();
    	}

    	return "/common/json";
    }

    /**
     * 토론 수정
     * @param vo
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/board/boardDiscussionUpd", method = RequestMethod.POST)
    public String boardDiscussionUpd(@ModelAttribute BoardDiscussionVO vo, Model model) throws Exception {
    	try {
	    	BoardDiscussionSet set = new BoardDiscussionSet();
	    	set.setCondiVO(vo);
	    	
	    	set = svr.boardDiscussionUpd(set);
	    	
	    	model.addAttribute("json", CommUtil.getJsonObject(set.getRtnMode(),""));
    	} catch ( Exception e ) {
    		e.printStackTrace();
    	}

    	return "/common/json";
    }

    /**
     * 토론 삭제
     * @param vo
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/board/boardDiscussionDel", method = RequestMethod.POST)
    public String boardDiscussionDel(@ModelAttribute BoardDiscussionVO vo, Model model) throws Exception {
    	try {
	    	BoardDiscussionSet set = new BoardDiscussionSet();
	    	set.setCondiVO(vo);
	    	
	    	set = svr.boardDiscussionDel(set);
	    	
	    	model.addAttribute("json", CommUtil.getJsonObject(set.getRtnMode(),""));
    	} catch ( Exception e ) {
    		e.printStackTrace();
    	}

    	return "/common/json";
    }
   

}
