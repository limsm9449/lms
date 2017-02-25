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
public class BoardQnaService {
	@Autowired
	private SqlSession sqlSession;
	
	@Autowired
	private CommService commSvr;
	
    public BoardSet boardQnaList(BoardSet set) throws Exception {
    	//쿼리에서 가져올 갯수 지정
    	set.getCondiVO().setLimitUnit(Constant.unitForBoard);

    	List<BoardVO> list = sqlSession.selectList("boardQna.boardQnaList",set.getCondiVO());
    	set.setList(list);
    	
    	//페이징 처리 변수 세팅
    	set.setTotalCount(((BoardVO)sqlSession.selectOne("boardQna.boardQnaTotal",set.getCondiVO())).getCnt());
    	set.setPageUnit(Constant.unitForBoard);

    	//수정 권한 판단
    	set.getCondiVO().setIsEdit(commSvr.isBoardInsYn(set.getCondiVO().getCourseId(),SessionUtil.getSessionUserId()));

    	return set;
    }

    public BoardSet boardQnaV(BoardSet set) throws Exception {
    	//조회수를 증가 시킨다.
    	sqlSession.update("boardQna.boardQnaViewCntUpd",set.getCondiVO());

    	set.setData((BoardVO) sqlSession.selectOne("boardQna.boardQnaData",set.getCondiVO()));

    	//답글 리스트
    	BoardVO answerVO = new BoardVO();
    	answerVO.setpSeq(set.getCondiVO().getSeq());
    	List<BoardVO> list = sqlSession.selectList("boardQna.boardQnaAnswerList",answerVO);
    	set.setAnswerList(list);

    	//수정 권한 판단
    	set.getCondiVO().setIsEdit(commSvr.isBoardUpdYn(set.getCondiVO().getCourseId(),SessionUtil.getSessionUserId()));
    	
    	return set;
    }

    public BoardSet boardQnaU(BoardSet set) throws Exception {
    	set.setData((BoardVO) sqlSession.selectOne("boardQna.boardQnaData",set.getCondiVO()));
    	
    	return set;
    }

    @Transactional(propagation=Propagation.REQUIRED, rollbackFor={Throwable.class})
    public BoardSet boardQnaIns(BoardSet set) throws Exception {
    	//게시판 입력
    	set.getCondiVO().setUserId(SessionUtil.getSessionUserId());
    	set.getCondiVO().setUserIp(SessionUtil.getSessionUserIp());
    	sqlSession.insert("boardQna.boardQnaIns",set.getCondiVO());
    	
    	set.setRtnMode(Constant.mode.INSERT_OK.name());
    	
    	return set;
    }

    @Transactional(propagation=Propagation.REQUIRED, rollbackFor={Throwable.class})
    public BoardSet boardQnaUpd(BoardSet set) throws Exception {
    	sqlSession.update("boardQna.boardQnaUpd",set.getCondiVO());
    	
    	set.setRtnMode(Constant.mode.UPDATE_OK.name());
    	
    	return set;
    }

    @Transactional(propagation=Propagation.REQUIRED, rollbackFor={Throwable.class})
    public BoardSet boardQnaDel(BoardSet set) throws Exception {
    	sqlSession.delete("boardQna.boardQnaDel",set.getCondiVO());

    	//답글 전체 삭제
    	BoardVO answerVO = new BoardVO();
    	answerVO.setpSeq(set.getCondiVO().getSeq());
    	sqlSession.delete("boardQna.boardQnaAnswerDelKeyPSeq",answerVO);

    	set.setRtnMode(Constant.mode.DELETE_OK.name());
    	
    	return set;
    }

    public BoardSet boardQnaAnswer(BoardSet set) throws Exception {
    	List<BoardVO> list = sqlSession.selectList("boardQna.boardQnaAnswerList",set.getCondiVO());
    	set.setList(list);
    	
    	return set;
    }

    public BoardSet boardQnaAnswerU(BoardSet set) throws Exception {
    	set.setData((BoardVO) sqlSession.selectOne("boardQna.boardQnaAnswerData",set.getCondiVO()));
    	
    	return set;
    }

    @Transactional(propagation=Propagation.REQUIRED, rollbackFor={Throwable.class})
    public BoardSet boardQnaAnswerIns(BoardSet set) throws Exception {
    	//게시판 입력
    	set.getCondiVO().setUserId(SessionUtil.getSessionUserId());
    	set.getCondiVO().setUserIp(SessionUtil.getSessionUserIp());
    	sqlSession.insert("boardQna.boardQnaAnswerIns",set.getCondiVO());
    	
    	//답변수 변경
    	sqlSession.update("boardQna.boardQnaReplyCntUpd",set.getCondiVO());

    	set.setRtnMode(Constant.mode.INSERT_OK.name());
    	
    	return set;
    }

    @Transactional(propagation=Propagation.REQUIRED, rollbackFor={Throwable.class})
    public BoardSet boardQnaAnswerUpd(BoardSet set) throws Exception {
    	sqlSession.update("boardQna.boardQnaAnswerUpd",set.getCondiVO());
    	
    	set.setRtnMode(Constant.mode.UPDATE_OK.name());
    	
    	return set;
    }

    @Transactional(propagation=Propagation.REQUIRED, rollbackFor={Throwable.class})
    public BoardSet boardQnaAnswerDel(BoardSet set) throws Exception {
    	sqlSession.delete("boardQna.boardQnaAnswerDel",set.getCondiVO());

    	//답변수 변경
    	sqlSession.update("boardQna.boardQnaReplyCntUpd",set.getCondiVO());

    	set.setRtnMode(Constant.mode.DELETE_OK.name());
    	
    	return set;
    }

	
}
