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
import com.qp.lms.board.service.BoardReportService;
import com.qp.lms.common.CommUtil;
import com.qp.lms.common.SessionUtil;
import com.qp.lms.common.service.CommService;

@Controller
public class BoardReportController {

	private static final Logger logger = LoggerFactory.getLogger(BoardReportController.class);

    @Autowired
    private BoardReportService svr;
    
    @Autowired
    private CommService commSvr;
    
    /**
     * 자료실 리스트
     * @param vo
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/board/boardReportList")
    public String boardReportList(@ModelAttribute BoardVO vo, Model model) throws Exception {
    	try {
	    	BoardSet set = new BoardSet();
	    	set.setCondiVO(vo);
	    	
	    	set = svr.boardReportList(set);
	    	
	    	model.addAttribute("set", set );
    	} catch ( Exception e ) {
    		e.printStackTrace();
    	}

        return "/board/BoardReportList";
    }

    /**
     * 자료실 입력 화면
     * @param vo
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/board/boardReportN")
    public String boardReportN(@ModelAttribute BoardVO vo, Model model) throws Exception {
    	try {
	    	BoardSet set = new BoardSet();
	    	set.setCondiVO(vo);
	
	    	// 임시 파일들을 삭제한다.
	    	commSvr.delAttachTempForUser();
	    	
	    	set = svr.boardReportN(set);
	
	    	model.addAttribute("set", set );
    	
    	} catch ( Exception e ) {
    		e.printStackTrace();
    	}
    	
        return "/board/BoardReportN";
    }

    /**
     * 자료실 조회 화면 
     * @param vo
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/board/boardReportV")
    public String boardReportV(@ModelAttribute BoardVO vo, Model model) throws Exception {
    	try {
	    	BoardSet set = new BoardSet();
	    	set.setCondiVO(vo);
	    	
	    	set = svr.boardReportV(set);
	    	
	    	set.setUserId(SessionUtil.getSessionUserId());
	    	
	    	model.addAttribute("set", set );
    	} catch ( Exception e ) {
    		e.printStackTrace();
    	}

        return "/board/BoardReportV";
    }

    /**
     * 자료실 수정 화면
     * @param vo
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/board/boardReportU")
    public String boardReportU(@ModelAttribute BoardVO vo, Model model) throws Exception {
    	try {
	    	BoardSet set = new BoardSet();
	    	set.setCondiVO(vo);
	    	
	    	// 임시 파일들을 삭제한다.
	    	commSvr.delAttachTempForUser();
	    	
	    	set = svr.boardReportU(set);
	    	
	    	model.addAttribute("set", set );
    	
    	} catch ( Exception e ) {
    		e.printStackTrace();
    	}
    	
    	return "/board/BoardReportU";
    }

    
    /**
     * 자료실 리스트
     * @param vo
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/board/userBoardReportList")
    public String userBoardReportList(@ModelAttribute BoardVO vo, Model model) throws Exception {
    	try {
	    	BoardSet set = new BoardSet();
	    	set.setCondiVO(vo);
	    	
	    	set = svr.boardReportList(set);
	    	
	    	model.addAttribute("set", set );
    	} catch ( Exception e ) {
    		e.printStackTrace();
    	}

        return "/board/UserBoardReportList";
    }

    /**
     * 자료실 입력 화면
     * @param vo
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/board/userBoardReportN")
    public String userBoardReportN(@ModelAttribute BoardVO vo, Model model) throws Exception {
    	try {
	    	BoardSet set = new BoardSet();
	    	set.setCondiVO(vo);
	
	    	// 임시 파일들을 삭제한다.
	    	commSvr.delAttachTempForUser();
	    	
	    	set = svr.boardReportN(set);
	
	    	model.addAttribute("set", set );
    	
    	} catch ( Exception e ) {
    		e.printStackTrace();
    	}
    	
        return "/board/UserBoardReportN";
    }

    /**
     * 자료실 조회 화면 
     * @param vo
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/board/userBoardReportV")
    public String userBoardReportV(@ModelAttribute BoardVO vo, Model model) throws Exception {
    	try {
	    	BoardSet set = new BoardSet();
	    	set.setCondiVO(vo);
	    	
	    	set = svr.boardReportV(set);
	    	
	    	set.setUserId(SessionUtil.getSessionUserId());
	    	
	    	model.addAttribute("set", set );
    	} catch ( Exception e ) {
    		e.printStackTrace();
    	}

        return "/board/UserBoardReportV";
    }

    /**
     * 자료실 수정 화면
     * @param vo
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/board/userBoardReportU")
    public String userBoardReportU(@ModelAttribute BoardVO vo, Model model) throws Exception {
    	try {
	    	BoardSet set = new BoardSet();
	    	set.setCondiVO(vo);
	    	
	    	// 임시 파일들을 삭제한다.
	    	commSvr.delAttachTempForUser();
	    	
	    	set = svr.boardReportU(set);
	    	
	    	model.addAttribute("set", set );
    	
    	} catch ( Exception e ) {
    		e.printStackTrace();
    	}
    	
    	return "/board/UserBoardReportU";
    }

    
    ///////////////////////////////////////////////////////////////////////////////////////////////////////
    /**
     * 자료실 입력
     * @param vo
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/board/boardReportIns", method = RequestMethod.POST)
    public String boardReportIns(@ModelAttribute BoardVO vo, Model model) throws Exception {
    	try {
	    	BoardSet set = new BoardSet();
	    	set.setCondiVO(vo);
	    	
	    	set = svr.boardReportIns(set);
	    	
	    	// 임시 파일들을 삭제한다.
	    	commSvr.delAttachTemp();
    	
	    	model.addAttribute("json", CommUtil.getJsonObject(set.getRtnMode(),""));
    	} catch ( Exception e ) {
    		e.printStackTrace();
    	}

    	return "/common/json";
    }

    /**
     * 자료실 수정
     * @param vo
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/board/boardReportUpd", method = RequestMethod.POST)
    public String boardReportUpd(@ModelAttribute BoardVO vo, Model model) throws Exception {
    	try {
	    	BoardSet set = new BoardSet();
	    	set.setCondiVO(vo);
	    	
	    	set = svr.boardReportUpd(set);
	    	
	    	model.addAttribute("json", CommUtil.getJsonObject(set.getRtnMode(),""));
    	} catch ( Exception e ) {
    		e.printStackTrace();
    	}

    	return "/common/json";
    }

    /**
     * 자료실 삭제
     * @param vo
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/board/boardReportDel", method = RequestMethod.POST)
    public String boardReportDel(@ModelAttribute BoardVO vo, Model model) throws Exception {
    	try {
    		BoardSet set = new BoardSet();
    	
    		set.setCondiVO(vo);
    	
    		set = svr.boardReportDel(set);
    	
    		model.addAttribute("json", CommUtil.getJsonObject(set.getRtnMode(),""));
    	} catch ( Exception e ) {
    		e.printStackTrace();
    	}

    	return "/common/json";
    }

}
