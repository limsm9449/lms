package com.qp.lms.board.controller;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.qp.lms.board.model.ReplySet;
import com.qp.lms.board.model.ReplyVO;
import com.qp.lms.board.service.ReplyService;
import com.qp.lms.common.CommUtil;
import com.qp.lms.common.SessionUtil;

@Controller
public class ReplyController {

	private static final Logger logger = LoggerFactory.getLogger(ReplyController.class);

    @Autowired
    private ReplyService svr;
    
    /**
     * Reply 리스트
     * @param vo
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/board/replyList")
    public String replyList(@ModelAttribute ReplyVO vo, Model model) throws Exception {
    	try {
	    	ReplySet set = new ReplySet();
	    	set.setCondiVO(vo);
	    	
	    	set = svr.replyList(set);
	    	
	    	set.setUserId(SessionUtil.getSessionUserId());
	    	
	    	model.addAttribute("set", set );
		} catch ( Exception e ) {
			e.printStackTrace();
		}

        return "/board/ReplyList";
    }

    /**
     * Reply 수정화면...
     * @param vo
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/board/replyU")
    public String replyU(@ModelAttribute ReplyVO vo, Model model) throws Exception {
    	try {
	    	ReplySet set = new ReplySet();
	    	set.setCondiVO(vo);
	    	
	    	set = svr.replyU(set);
	    	
	    	model.addAttribute("set", set );
		} catch ( Exception e ) {
			e.printStackTrace();
		}

        return "/board/ReplyIframe";
    }

    /**
     * Reply 작성화면...
     * @param vo
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/board/userReplyN")
    public String userReplyN(@ModelAttribute ReplyVO vo, Model model) throws Exception {
    	try {
	    	ReplySet set = new ReplySet();
	    	set.setCondiVO(vo);
	    	
	    	model.addAttribute("set", set );
		} catch ( Exception e ) {
			e.printStackTrace();
		}

        return "/board/UserReplyN";
    }

    /**
     * Reply 수정화면...
     * @param vo
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/board/userReplyU")
    public String userReplyU(@ModelAttribute ReplyVO vo, Model model) throws Exception {
    	try {
	    	ReplySet set = new ReplySet();
	    	set.setCondiVO(vo);
	    	
	    	set = svr.replyU(set);
	    	
	    	model.addAttribute("set", set );
		} catch ( Exception e ) {
			e.printStackTrace();
		}

        return "/board/UserReplyU";
    }

    /////////////////////////////////////// Transaction ///////////////////////////////////////
    
    /**
     * Reply 입력
     * @param vo
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/board/replyIns", method = RequestMethod.POST)
    public String replyIns(@ModelAttribute ReplyVO vo, Model model) throws Exception {
    	try {
	    	ReplySet set = new ReplySet();
	    	set.setCondiVO(vo);
	    	
	    	set = svr.replyIns(set);
	    	
    		model.addAttribute("json", CommUtil.getJsonObject(set.getRtnMode(),""));
		} catch ( Exception e ) {
			e.printStackTrace();
		}
	
		return "/common/json";
    }

    /**
     * Reply 수정
     * @param vo
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/board/replyUpd", method = RequestMethod.POST)
    public String replyUpd(@ModelAttribute ReplyVO vo, Model model) throws Exception {
    	try {
	    	ReplySet set = new ReplySet();
	    	set.setCondiVO(vo);
	    	
	    	set = svr.replyUpd(set);
	    	
	    	model.addAttribute("json", CommUtil.getJsonObject(set.getRtnMode(),""));
    	} catch ( Exception e ) {
    		e.printStackTrace();
    	}

    	return "/common/json";
    }

    /**
     * Reply 삭제
     * @param vo
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/board/replyDel", method = RequestMethod.POST)
    public String replyDel(@ModelAttribute ReplyVO vo, Model model) throws Exception {
    	try {
	    	ReplySet set = new ReplySet();
	    	set.setCondiVO(vo);
	    	
	    	set = svr.replyDel(set);
	    	
	    	model.addAttribute("json", CommUtil.getJsonObject(set.getRtnMode(),""));
    	} catch ( Exception e ) {
    		e.printStackTrace();
    	}

    	return "/common/json";
    }
   
   
}
