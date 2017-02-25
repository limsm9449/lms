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
import com.qp.lms.board.service.BoardFreeService;
import com.qp.lms.common.CommUtil;
import com.qp.lms.common.SessionUtil;

@Controller
public class BoardFreeController {

	private static final Logger logger = LoggerFactory.getLogger(BoardFreeController.class);

    @Autowired
    private BoardFreeService svr;
    
    /**
     * 자유게시판 리스트
     * @param vo
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/board/boardFreeList")
    public String boardFreeList(@ModelAttribute BoardVO vo, Model model) throws Exception {
    	try {
    		BoardSet set = new BoardSet();
	    	set.setCondiVO(vo);
	    	
	    	set = svr.boardFreeList(set);
	    	
	    	model.addAttribute("set", set );
    	} catch ( Exception e ) {
    		e.printStackTrace();
    	}
    	
        return "/board/BoardFreeList";
    }

    /**
     * 자유게시판 조회 화면 
     * @param vo
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/board/boardFreeV")
    public String boardFreeV(@ModelAttribute BoardVO vo, Model model) throws Exception {
    	try {
	    	BoardSet set = new BoardSet();
	    	set.setCondiVO(vo);
	    	
	    	set = svr.boardFreeV(set);
	    	
	    	set.setUserId(SessionUtil.getSessionUserId());
	    	
	    	model.addAttribute("set", set );
    	} catch ( Exception e ) {
    		e.printStackTrace();
    	}
    	
        return "/board/BoardFreeV";
    }

    /**
     * 자유게시판 입력 화면
     * @param vo
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/board/boardFreeN")
    public String boardFreeN(@ModelAttribute BoardVO vo, Model model) throws Exception {
    	try {
	    	BoardSet set = new BoardSet();
	    	set.setCondiVO(vo);
	    	
	    	model.addAttribute("set", set );
    	} catch ( Exception e ) {
    		e.printStackTrace();
    	}
    	
        return "/board/BoardFreeN";
    }
    
    /**
     * 자유게시판 수정 화면
     * @param vo
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/board/boardFreeU")
    public String boardFreeU(@ModelAttribute BoardVO vo, Model model) throws Exception {
    	try {
	    	BoardSet set = new BoardSet();
	    	set.setCondiVO(vo);
	    	
	    	set = svr.boardFreeU(set);
	    	
	    	model.addAttribute("set", set );
    	} catch ( Exception e ) {
    		e.printStackTrace();
    	}
	
        return "/board/BoardFreeU";
    }


    @RequestMapping(value = "/board/userBoardFreeList")
    public String userBoardFreeList(@ModelAttribute BoardVO vo, Model model) throws Exception {
    	try {
    		BoardSet set = new BoardSet();
	    	set.setCondiVO(vo);
	    	
	    	set = svr.boardFreeList(set);
	    	
	    	model.addAttribute("set", set );
    	} catch ( Exception e ) {
    		e.printStackTrace();
    	}
    	
        return "/board/UserBoardFreeList";
    }

    /**
     * 자유게시판 조회 화면 
     * @param vo
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/board/userBoardFreeV")
    public String userBoardFreeV(@ModelAttribute BoardVO vo, Model model) throws Exception {
    	try {
	    	BoardSet set = new BoardSet();
	    	set.setCondiVO(vo);
	    	
	    	set = svr.boardFreeV(set);
	    	
	    	set.setUserId(SessionUtil.getSessionUserId());
	    	
	    	model.addAttribute("set", set );
    	} catch ( Exception e ) {
    		e.printStackTrace();
    	}
    	
        return "/board/UserBoardFreeV";
    }

    /**
     * 자유게시판 입력 화면
     * @param vo
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/board/userBoardFreeN")
    public String userBoardFreeN(@ModelAttribute BoardVO vo, Model model) throws Exception {
    	try {
	    	BoardSet set = new BoardSet();
	    	set.setCondiVO(vo);
	    	
	    	model.addAttribute("set", set );
    	} catch ( Exception e ) {
    		e.printStackTrace();
    	}
    	
        return "/board/UserBoardFreeN";
    }
    
    /**
     * 자유게시판 수정 화면
     * @param vo
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/board/userBoardFreeU")
    public String userBoardFreeU(@ModelAttribute BoardVO vo, Model model) throws Exception {
    	try {
	    	BoardSet set = new BoardSet();
	    	set.setCondiVO(vo);
	    	
	    	set = svr.boardFreeU(set);
	    	
	    	model.addAttribute("set", set );
    	} catch ( Exception e ) {
    		e.printStackTrace();
    	}
	
        return "/board/UserBoardFreeU";
    }
    
    ///////////////////////////////////////////////// Transaction ////////////////////////////////////////////////////
    
    /**
     * 자유게시판 입력
     * @param vo
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/board/boardFreeIns", method = RequestMethod.POST)
    public String boardFreeIns(@ModelAttribute BoardVO vo, Model model) throws Exception {
    	try {
    		BoardSet set = new BoardSet();
	    	set.setCondiVO(vo);
	    	
	    	set = svr.boardFreeIns(set);
	    	
	    	model.addAttribute("json", CommUtil.getJsonObject(set.getRtnMode(),""));
    	} catch ( Exception e ) {
    		e.printStackTrace();
    	}

    	return "/common/json";
    }

    /**
     * 자유게시판 수정
     * @param vo
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/board/boardFreeUpd", method = RequestMethod.POST)
    public String boardFreeUpd(@ModelAttribute BoardVO vo, Model model) throws Exception {
    	try {
	    	BoardSet set = new BoardSet();
	    	set.setCondiVO(vo);
	    	
	    	set = svr.boardFreeUpd(set);
	    	
	    	model.addAttribute("json", CommUtil.getJsonObject(set.getRtnMode(),""));
    	} catch ( Exception e ) {
    		e.printStackTrace();
    	}

    	return "/common/json";
    }

    /**
     * 자유게시판 삭제
     * @param vo
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/board/boardFreeDel", method = RequestMethod.POST)
    public String boardFreeDel(@ModelAttribute BoardVO vo, Model model) throws Exception {
    	try {
	    	BoardSet set = new BoardSet();
	    	set.setCondiVO(vo);
	    	
	    	set = svr.boardFreeDel(set);
	    	
	    	model.addAttribute("json", CommUtil.getJsonObject(set.getRtnMode(),""));
    	} catch ( Exception e ) {
    		e.printStackTrace();
    	}

    	return "/common/json";
    }
   

}
