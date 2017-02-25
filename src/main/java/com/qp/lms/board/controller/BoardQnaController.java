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
import com.qp.lms.board.service.BoardQnaService;
import com.qp.lms.common.CommUtil;
import com.qp.lms.common.SessionUtil;

@Controller
public class BoardQnaController {

	private static final Logger logger = LoggerFactory.getLogger(BoardQnaController.class);

    @Autowired
    private BoardQnaService svr;

    
    /**
     * QNA 리스트
     * @param vo
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/board/boardQnaList")
    public String boardQnaList(@ModelAttribute BoardVO vo, Model model) throws Exception {
    	try {
	    	BoardSet set = new BoardSet();
	    	set.setCondiVO(vo);
	    	
	    	set = svr.boardQnaList(set);
	    	
	    	model.addAttribute("set", set );
    	} catch ( Exception e ) {
    		e.printStackTrace();
    	}
    	
        return "/board/BoardQnaList";
    }

    /**
     * QNA 조회 화면
     * @param vo
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/board/boardQnaV")
    public String boardQnaV(@ModelAttribute BoardVO vo, Model model) throws Exception {
    	try {
	    	BoardSet set = new BoardSet();
	    	set.setCondiVO(vo);
	    	
	    	set = svr.boardQnaV(set);
	 	
	    	set.setUserId(SessionUtil.getSessionUserId());
	    	
	    	model.addAttribute("set", set );
    	} catch ( Exception e ) {
    		e.printStackTrace();
    	}
    	
        return "/board/BoardQnaV";
    }

    /**
     * QNA 입력 화면
     * @param vo
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/board/boardQnaN")
    public String boardQnaN(@ModelAttribute BoardVO vo, Model model) throws Exception {
    	try {
	    	BoardSet set = new BoardSet();
	    	set.setCondiVO(vo);
	    	
	    	model.addAttribute("set", set );
    	} catch ( Exception e ) {
    		e.printStackTrace();
    	}
    	
        return "/board/BoardQnaN";
    }
    
    /**
     * QNA 수정 화면
     * @param vo
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/board/boardQnaU")
    public String boardQnaU(@ModelAttribute BoardVO vo, Model model) throws Exception {
    	try {
	    	BoardSet set = new BoardSet();
	    	set.setCondiVO(vo);
	    	
	    	set = svr.boardQnaU(set);
	    	
	    	model.addAttribute("set", set );
    	} catch ( Exception e ) {
    		e.printStackTrace();
    	}
    	
        return "/board/BoardQnaU";
    }

    
    /**
     * QNA 리스트
     * @param vo
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/board/userBoardQnaList")
    public String userBoardQnaList(@ModelAttribute BoardVO vo, Model model) throws Exception {
    	try {
	    	BoardSet set = new BoardSet();
	    	set.setCondiVO(vo);
	    	
	    	set = svr.boardQnaList(set);
	    	
	    	model.addAttribute("set", set );
    	} catch ( Exception e ) {
    		e.printStackTrace();
    	}
    	
        return "/board/UserBoardQnaList";
    }

    /**
     * QNA 조회 화면
     * @param vo
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/board/userBoardQnaV")
    public String userBoardQnaV(@ModelAttribute BoardVO vo, Model model) throws Exception {
    	try {
	    	BoardSet set = new BoardSet();
	    	set.setCondiVO(vo);
	    	
	    	set = svr.boardQnaV(set);
	 	
	    	set.setUserId(SessionUtil.getSessionUserId());
	    	
	    	model.addAttribute("set", set );
    	} catch ( Exception e ) {
    		e.printStackTrace();
    	}
    	
        return "/board/UserBoardQnaV";
    }

    /**
     * QNA 입력 화면
     * @param vo
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/board/userBoardQnaN")
    public String userBoardQnaN(@ModelAttribute BoardVO vo, Model model) throws Exception {
    	try {
	    	BoardSet set = new BoardSet();
	    	set.setCondiVO(vo);
	    	
	    	model.addAttribute("set", set );
    	} catch ( Exception e ) {
    		e.printStackTrace();
    	}
    	
        return "/board/UserBoardQnaN";
    }
    
    /**
     * QNA 수정 화면
     * @param vo
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/board/userBoardQnaU")
    public String userBoardQnaU(@ModelAttribute BoardVO vo, Model model) throws Exception {
    	try {
	    	BoardSet set = new BoardSet();
	    	set.setCondiVO(vo);
	    	
	    	set = svr.boardQnaU(set);
	    	
	    	model.addAttribute("set", set );
    	} catch ( Exception e ) {
    		e.printStackTrace();
    	}
    	
        return "/board/UserBoardQnaU";
    }

    
    
    /**
     * QNA 입력
     * @param vo
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/board/boardQnaIns", method = RequestMethod.POST)
    public String boardQnaIns(@ModelAttribute BoardVO vo, Model model) throws Exception {
    	try {
	    	BoardSet set = new BoardSet();
	    	set.setCondiVO(vo);
	    	
	    	set = svr.boardQnaIns(set);
	    	
	    	model.addAttribute("json", CommUtil.getJsonObject(set.getRtnMode(),""));
    	} catch ( Exception e ) {
    		e.printStackTrace();
    	}

    	return "/common/json";
    }

    /**
     * QNA 수정
     * @param vo
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/board/boardQnaUpd", method = RequestMethod.POST)
    public String boardQnaUpd(@ModelAttribute BoardVO vo, Model model) throws Exception {
    	try {
	    	BoardSet set = new BoardSet();
	    	set.setCondiVO(vo);
	    	
	    	set = svr.boardQnaUpd(set);
	    	
	    	model.addAttribute("json", CommUtil.getJsonObject(set.getRtnMode(),""));
    	} catch ( Exception e ) {
    		e.printStackTrace();
    	}

    	return "/common/json";
    }

    /**
     * QNA 삭제
     * @param vo
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/board/boardQnaDel", method = RequestMethod.POST)
    public String boardQnaDel(@ModelAttribute BoardVO vo, Model model) throws Exception {
    	try {
	    	BoardSet set = new BoardSet();
	    	set.setCondiVO(vo);
	    	
	    	set = svr.boardQnaDel(set);
	    	
	    	model.addAttribute("json", CommUtil.getJsonObject(set.getRtnMode(),""));
    	} catch ( Exception e ) {
    		e.printStackTrace();
    	}

    	return "/common/json";
    }
    
    /**
     * QNA Answer 입력 화면
     * @param vo
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/board/boardQnaAnswerN")
    public String boardQnaAnswerN(@ModelAttribute BoardVO vo, Model model) throws Exception {
    	try {
	    	BoardSet set = new BoardSet();
	    	set.setCondiVO(vo);
	    	
	    	model.addAttribute("set", set );
    	} catch ( Exception e ) {
    		e.printStackTrace();
    	}

        return "/board/BoardQnaAnswerN";
    }
    
    /**
     * QNA Answer 수정 화면
     * @param vo
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/board/boardQnaAnswerU")
    public String boardQnaAnswerU(@ModelAttribute BoardVO vo, Model model) throws Exception {
    	try {
	    	BoardSet set = new BoardSet();
	    	set.setCondiVO(vo);
	    	
	    	set = svr.boardQnaAnswerU(set);
	    	
	    	model.addAttribute("set", set );
    	} catch ( Exception e ) {
    		e.printStackTrace();
    	}

        return "/board/BoardQnaAnswerU";
    }
    
    /**
     * QNA Answer 입력 화면
     * @param vo
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/board/userBoardQnaAnswerN")
    public String oardQnaAnswerN(@ModelAttribute BoardVO vo, Model model) throws Exception {
    	try {
	    	BoardSet set = new BoardSet();
	    	set.setCondiVO(vo);
	    	
	    	model.addAttribute("set", set );
    	} catch ( Exception e ) {
    		e.printStackTrace();
    	}

        return "/board/UserBoardQnaAnswerN";
    }
    
    /**
     * QNA Answer 수정 화면
     * @param vo
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/board/userBoardQnaAnswerU")
    public String userBoardQnaAnswerU(@ModelAttribute BoardVO vo, Model model) throws Exception {
    	try {
	    	BoardSet set = new BoardSet();
	    	set.setCondiVO(vo);
	    	
	    	set = svr.boardQnaAnswerU(set);
	    	
	    	model.addAttribute("set", set );
    	} catch ( Exception e ) {
    		e.printStackTrace();
    	}

        return "/board/UserBoardQnaAnswerU";
    }


    /**
     * QNA Answer 입력
     * @param vo
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/board/boardQnaAnswerIns", method = RequestMethod.POST)
    public String boardQnaAnswerIns(@ModelAttribute BoardVO vo, Model model) throws Exception {
    	try {
	    	BoardSet set = new BoardSet();
	    	set.setCondiVO(vo);
	    	
	    	set = svr.boardQnaAnswerIns(set);
	    	
	    	model.addAttribute("json", CommUtil.getJsonObject(set.getRtnMode(),""));
    	} catch ( Exception e ) {
    		e.printStackTrace();
    	}

    	return "/common/json";
    }

    /**
     * QNA Answer 수정
     * @param vo
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/board/boardQnaAnswerUpd", method = RequestMethod.POST)
    public String boardQnaAnswerUpd(@ModelAttribute BoardVO vo, Model model) throws Exception {
    	try {
	    	BoardSet set = new BoardSet();
	    	set.setCondiVO(vo);
	    	
	    	set = svr.boardQnaAnswerUpd(set);
	    	
	    	model.addAttribute("json", CommUtil.getJsonObject(set.getRtnMode(),""));
    	} catch ( Exception e ) {
    		e.printStackTrace();
    	}

    	return "/common/json";
    }
    
    /**
     * QNA Answer 삭제
     * @param vo
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/board/boardQnaAnswerDel", method = RequestMethod.POST)
    public String boardQnaAnswerDel(@ModelAttribute BoardVO vo, Model model) throws Exception {
    	try {
	    	BoardSet set = new BoardSet();
	    	set.setCondiVO(vo);
	    	
	    	set = svr.boardQnaAnswerDel(set);
	    	
	    	model.addAttribute("json", CommUtil.getJsonObject(set.getRtnMode(),""));
    	} catch ( Exception e ) {
    		e.printStackTrace();
    	}

    	return "/common/json";
    }
    
    

}
