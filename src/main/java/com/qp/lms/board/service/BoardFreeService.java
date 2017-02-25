package com.qp.lms.board.service;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.qp.lms.board.model.BoardSet;
import com.qp.lms.board.model.BoardVO;
import com.qp.lms.board.model.ReplyVO;
import com.qp.lms.common.Constant;
import com.qp.lms.common.SessionUtil;
import com.qp.lms.common.service.CommService;

@Service
public class BoardFreeService {
	@Autowired
	private SqlSession sqlSession;

	@Autowired
	private CommService commSvr;

	public BoardSet boardFreeList(BoardSet set) throws Exception {
    	//쿼리에서 가져올 갯수 지정
    	set.getCondiVO().setLimitUnit(Constant.unitForBoard);

    	List<BoardVO> list = sqlSession.selectList("boardFree.boardFreeList",set.getCondiVO());
    	set.setList(list);
    	
    	//페이징 처리 변수 세팅
    	set.setTotalCount(((BoardVO)sqlSession.selectOne("boardFree.boardFreeTotal",set.getCondiVO())).getCnt());
    	set.setPageUnit(Constant.unitForBoard);

    	//수정 권한 판단
   		set.getCondiVO().setIsEdit(commSvr.isBoardInsYn(set.getCondiVO().getCourseId(),SessionUtil.getSessionUserId()));
    	
    	return set;
    }

    public BoardSet boardFreeV(BoardSet set) throws Exception {
    	//조회수를 증가 시킨다.
    	sqlSession.update("boardFree.boardFreeViewCntUpd",set.getCondiVO());
    	
    	set.setData((BoardVO) sqlSession.selectOne("boardFree.boardFreeData",set.getCondiVO()));

    	//답글
    	ReplyVO vo = new ReplyVO();
    	vo.setpSeq(set.getCondiVO().getSeq());
    	vo.setKind("FREE");
    	List<ReplyVO> replayList = sqlSession.selectList("reply.replyList",vo);
    	set.setReplyList(replayList);
    	
    	//수정 권한 판단
   		set.getCondiVO().setIsEdit(commSvr.isBoardUpdYn(set.getCondiVO().getCourseId(),SessionUtil.getSessionUserId()));
    	
    	return set;
    }

    public BoardSet boardFreeU(BoardSet set) throws Exception {
    	set.setData((BoardVO) sqlSession.selectOne("boardFree.boardFreeData",set.getCondiVO()));
    	
    	return set;
    }

    
    ///////////////////////////////////////////////// Transaction ////////////////////////////////////////////////////
    @Transactional(propagation=Propagation.REQUIRED, rollbackFor={Throwable.class})
    public BoardSet boardFreeIns(BoardSet set) throws Exception {
    	//게시판 입력
    	set.getCondiVO().setUserId(SessionUtil.getSessionUserId());
    	set.getCondiVO().setUserIp(SessionUtil.getSessionUserIp());
    	sqlSession.insert("boardFree.boardFreeIns",set.getCondiVO());
    	
    	set.setRtnMode(Constant.mode.INSERT_OK.name());
    	
    	return set;
    }

    @Transactional(propagation=Propagation.REQUIRED, rollbackFor={Throwable.class})
   public BoardSet boardFreeUpd(BoardSet set) throws Exception {
    	sqlSession.update("boardFree.boardFreeUpd",set.getCondiVO());
    	
    	set.setRtnMode(Constant.mode.UPDATE_OK.name());
    	
    	return set;
    }

    @Transactional(propagation=Propagation.REQUIRED, rollbackFor={Throwable.class})
   public BoardSet boardFreeDel(BoardSet set) throws Exception {
    	sqlSession.delete("boardFree.boardFreeDel",set.getCondiVO());

    	//댓글 삭제
    	ReplyVO replyVO = new ReplyVO();
    	replyVO.setKind("FREE");
    	replyVO.setpSeq(set.getCondiVO().getSeq());
    	sqlSession.delete("reply.replyDelKeyPSeq",replyVO);
    	
    	set.setRtnMode(Constant.mode.DELETE_OK.name());
    	
    	return set;
    }

	
}
