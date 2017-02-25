package com.qp.lms.board.service;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.qp.lms.board.model.BoardSet;
import com.qp.lms.board.model.BoardVO;
import com.qp.lms.common.Constant;
import com.qp.lms.common.SessionUtil;
import com.qp.lms.common.service.CommService;

@Service
public class BoardNoticeService {
	@Autowired
	private SqlSession sqlSession;
	
	@Autowired
	private CommService commSvr;

    public BoardSet boardNoticeList(BoardSet set) throws Exception {
    	//쿼리에서 가져올 갯수 지정
    	set.getCondiVO().setLimitUnit(Constant.unitForBoard);

    	List<BoardVO> list = sqlSession.selectList("boardNotice.boardNoticeList",set.getCondiVO());
    	set.setList(list);
    	
    	//페이징 처리 변수 세팅
    	set.setTotalCount(((BoardVO)sqlSession.selectOne("boardNotice.boardNoticeTotal",set.getCondiVO())).getCnt());
    	set.setPageUnit(Constant.unitForBoard);

    	//수정 권한 판단
    	set.getCondiVO().setIsEdit(commSvr.isBoardAdminYn());
    	
    	return set;
    }

    public BoardSet boardNoticeV(BoardSet set) throws Exception {
    	//조회수를 증가 시킨다.
    	sqlSession.update("boardNotice.boardNoticeViewCntUpd",set.getCondiVO());
    	
    	set.setData((BoardVO) sqlSession.selectOne("boardNotice.boardNoticeData",set.getCondiVO()));

    	//수정 권한 판단
    	set.getCondiVO().setIsEdit(commSvr.isBoardAdminYn());
    	
    	return set;
    }

    public BoardSet boardNoticeU(BoardSet set) throws Exception {
    	set.setData((BoardVO) sqlSession.selectOne("boardNotice.boardNoticeData",set.getCondiVO()));
    	
    	return set;
    }

    @Transactional(propagation=Propagation.REQUIRED, rollbackFor={Throwable.class})
    public BoardSet boardNoticeIns(BoardSet set) throws Exception {
    	//게시판 입력
    	set.getCondiVO().setUserId(SessionUtil.getSessionUserId());
    	set.getCondiVO().setUserIp(SessionUtil.getSessionUserIp());
    	
    	sqlSession.insert("boardNotice.boardNoticeIns",set.getCondiVO());
    	
    	set.setRtnMode(Constant.mode.INSERT_OK.name());
    	
    	return set;
    }

    @Transactional(propagation=Propagation.REQUIRED, rollbackFor={Throwable.class})
    public BoardSet boardNoticeUpd(BoardSet set) throws Exception {
    	sqlSession.update("boardNotice.boardNoticeUpd",set.getCondiVO());
    	
    	set.setRtnMode(Constant.mode.UPDATE_OK.name());
    	
    	return set;
    }

    @Transactional(propagation=Propagation.REQUIRED, rollbackFor={Throwable.class})
    public BoardSet boardNoticeDel(BoardSet set) throws Exception {
    	sqlSession.delete("boardNotice.boardNoticeDel",set.getCondiVO());

    	set.setRtnMode(Constant.mode.DELETE_OK.name());
    	
    	return set;
    }
   
	
}
