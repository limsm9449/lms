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
import com.qp.lms.board.service.BoardDataService;
import com.qp.lms.common.CommUtil;
import com.qp.lms.common.SessionUtil;
import com.qp.lms.common.service.CommService;

@Controller
public class BoardDataController {

	private static final Logger logger = LoggerFactory.getLogger(BoardDataController.class);

    @Autowired
    private BoardDataService svr;
    
    @Autowired
    private CommService commSvr;
    
    /**
     * 자료실 리스트
     * @param vo
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/board/boardDataList")
    public String boardDataList(@ModelAttribute BoardVO vo, Model model) throws Exception {
    	try {
	    	BoardSet set = new BoardSet();
	    	set.setCondiVO(vo);
	    	
	    	set = svr.boardDataList(set);
	    	
	    	model.addAttribute("set", set );
    	} catch ( Exception e ) {
    		e.printStackTrace();
    	}

        return "/board/BoardDataList";
    }

    /**
     * 자료실 입력 화면
     * @param vo
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/board/boardDataN")
    public String boardDataN(@ModelAttribute BoardVO vo, Model model) throws Exception {
    	try {
	    	BoardSet set = new BoardSet();
	    	set.setCondiVO(vo);
	
	    	// 임시 파일들을 삭제한다.
	    	commSvr.delAttachTempForUser();
	    	
	    	set = svr.boardDataN(set);
	
	    	model.addAttribute("set", set );
    	
    	} catch ( Exception e ) {
    		e.printStackTrace();
    	}
    	
        return "/board/BoardDataN";
    }

    /**
     * 자료실 조회 화면 
     * @param vo
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/board/boardDataV")
    public String boardDataV(@ModelAttribute BoardVO vo, Model model) throws Exception {
    	try {
	    	BoardSet set = new BoardSet();
	    	set.setCondiVO(vo);
	    	
	    	set = svr.boardDataV(set);
	    	
	    	set.setUserId(SessionUtil.getSessionUserId());
	    	
	    	model.addAttribute("set", set );
    	} catch ( Exception e ) {
    		e.printStackTrace();
    	}

        return "/board/BoardDataV";
    }

    /**
     * 자료실 수정 화면
     * @param vo
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/board/boardDataU")
    public String boardDataU(@ModelAttribute BoardVO vo, Model model) throws Exception {
    	try {
	    	BoardSet set = new BoardSet();
	    	set.setCondiVO(vo);
	    	
	    	// 임시 파일들을 삭제한다.
	    	commSvr.delAttachTempForUser();
	    	
	    	set = svr.boardDataU(set);
	    	
	    	model.addAttribute("set", set );
    	
    	} catch ( Exception e ) {
    		e.printStackTrace();
    	}
    	
    	return "/board/BoardDataU";
    }

    
    /**
     * 자료실 리스트
     * @param vo
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/board/userBoardDataList")
    public String userBoardDataList(@ModelAttribute BoardVO vo, Model model) throws Exception {
    	try {
	    	BoardSet set = new BoardSet();
	    	set.setCondiVO(vo);
	    	
	    	set = svr.boardDataList(set);
	    	
	    	model.addAttribute("set", set );
    	} catch ( Exception e ) {
    		e.printStackTrace();
    	}

        return "/board/UserBoardDataList";
    }

    /**
     * 자료실 입력 화면
     * @param vo
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/board/userBoardDataN")
    public String userBoardDataN(@ModelAttribute BoardVO vo, Model model) throws Exception {
    	try {
	    	BoardSet set = new BoardSet();
	    	set.setCondiVO(vo);
	
	    	// 임시 파일들을 삭제한다.
	    	commSvr.delAttachTempForUser();
	    	
	    	set = svr.boardDataN(set);
	
	    	model.addAttribute("set", set );
    	
    	} catch ( Exception e ) {
    		e.printStackTrace();
    	}
    	
        return "/board/UserBoardDataN";
    }

    /**
     * 자료실 조회 화면 
     * @param vo
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/board/userBoardDataV")
    public String userBoardDataV(@ModelAttribute BoardVO vo, Model model) throws Exception {
    	try {
	    	BoardSet set = new BoardSet();
	    	set.setCondiVO(vo);
	    	
	    	set = svr.boardDataV(set);
	    	
	    	set.setUserId(SessionUtil.getSessionUserId());
	    	
	    	model.addAttribute("set", set );
    	} catch ( Exception e ) {
    		e.printStackTrace();
    	}

        return "/board/UserBoardDataV";
    }

    /**
     * 자료실 수정 화면
     * @param vo
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/board/userBoardDataU")
    public String userBoardDataU(@ModelAttribute BoardVO vo, Model model) throws Exception {
    	try {
	    	BoardSet set = new BoardSet();
	    	set.setCondiVO(vo);
	    	
	    	// 임시 파일들을 삭제한다.
	    	commSvr.delAttachTempForUser();
	    	
	    	set = svr.boardDataU(set);
	    	
	    	model.addAttribute("set", set );
    	
    	} catch ( Exception e ) {
    		e.printStackTrace();
    	}
    	
    	return "/board/UserBoardDataU";
    }

    
    
    ///////////////////////////////////////////////////////////////////////////////////////////////////////
    /**
     * 자료실 입력
     * @param vo
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/board/boardDataIns", method = RequestMethod.POST)
    public String boardDataIns(@ModelAttribute BoardVO vo, Model model) throws Exception {
    	try {
	    	BoardSet set = new BoardSet();
	    	set.setCondiVO(vo);
	    	
	    	set = svr.boardDataIns(set);
	    	
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
    @RequestMapping(value = "/board/boardDataUpd", method = RequestMethod.POST)
    public String boardDataUpd(@ModelAttribute BoardVO vo, Model model) throws Exception {
    	try {
	    	BoardSet set = new BoardSet();
	    	set.setCondiVO(vo);
	    	
	    	set = svr.boardDataUpd(set);
	    	
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
    @RequestMapping(value = "/board/boardDataDel", method = RequestMethod.POST)
    public String boardDataDel(@ModelAttribute BoardVO vo, Model model) throws Exception {
    	try {
    		BoardSet set = new BoardSet();
    	
    		set.setCondiVO(vo);
    	
    		set = svr.boardDataDel(set);
    	
    		model.addAttribute("json", CommUtil.getJsonObject(set.getRtnMode(),""));
    	} catch ( Exception e ) {
    		e.printStackTrace();
    	}

    	return "/common/json";
    }

}
