package com.qp.lms.board.service;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.qp.lms.board.model.ReplySet;
import com.qp.lms.board.model.ReplyVO;
import com.qp.lms.common.Constant;
import com.qp.lms.common.SessionUtil;

@Service
public class ReplyService {
	@Autowired
	private SqlSession sqlSession;

    public ReplySet replyList(ReplySet set) throws Exception {
    	List<ReplyVO> list = sqlSession.selectList("reply.replyList",set.getCondiVO());
    	set.setList(list);
    	
    	return set;
    }

    public ReplySet replyU(ReplySet set) throws Exception {
    	set.setData((ReplyVO) sqlSession.selectOne("reply.replyData",set.getCondiVO()));
    	
    	return set;
    }

    
    ////////////////////////////////////// @Transaction ////////////////////////////////////////
    @Transactional(propagation=Propagation.REQUIRED, rollbackFor={Throwable.class})
    public ReplySet replyIns(ReplySet set) throws Exception {
    	set.getCondiVO().setUserId(SessionUtil.getSessionUserId());
    	set.getCondiVO().setUserIp(SessionUtil.getSessionUserIp());
    	
    	sqlSession.insert("reply.replyIns",set.getCondiVO());
    	
    	set.setRtnMode(Constant.mode.INSERT_OK.name());
    	
    	return set;
    }

    @Transactional(propagation=Propagation.REQUIRED, rollbackFor={Throwable.class})
    public ReplySet replyUpd(ReplySet set) throws Exception {
    	sqlSession.update("reply.replyUpd",set.getCondiVO());

    	set.setRtnMode(Constant.mode.UPDATE_OK.name());
    	
    	return set;
    }

    @Transactional(propagation=Propagation.REQUIRED, rollbackFor={Throwable.class})
    public ReplySet replyDel(ReplySet set) throws Exception {
    	sqlSession.delete("reply.replyDel",set.getCondiVO());

    	set.setRtnMode(Constant.mode.DELETE_OK.name());
    	
    	return set;
    }

	
}
