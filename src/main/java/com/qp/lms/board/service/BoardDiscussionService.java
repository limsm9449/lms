package com.qp.lms.board.service;

import java.sql.Connection;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.qp.lms.board.model.BoardDiscussionSet;
import com.qp.lms.board.model.BoardDiscussionVO;
import com.qp.lms.common.Constant;
import com.qp.lms.common.SessionUtil;
import com.qp.lms.common.service.CommService;

@Service
public class BoardDiscussionService {
	@Autowired
	private SqlSession sqlSession;
	
	@Autowired
	private CommService commSvr;
	
	public BoardDiscussionSet boardDiscussionList(BoardDiscussionSet set) throws Exception {
    	//쿼리에서 가져올 갯수 지정
    	set.getCondiVO().setLimitUnit(Constant.unitForBoard);

    	List<BoardDiscussionVO> list = sqlSession.selectList("boardDiscussion.boardDiscussionList",set.getCondiVO());
    	set.setList(list);
    	
    	//페이징 처리 변수 세팅
    	set.setTotalCount(((BoardDiscussionVO)sqlSession.selectOne("boardDiscussion.boardDiscussionTotal",set.getCondiVO())).getCnt());
    	set.setPageUnit(Constant.unitForBoard);

    	//수정 권한 판단
    	set.getCondiVO().setIsEdit(commSvr.isBoardInsYn(set.getCondiVO().getCourseId(),SessionUtil.getSessionUserId()));
    	
    	return set;
    }

    public BoardDiscussionSet boardDiscussionV(BoardDiscussionSet set) throws Exception {
    	//조회수를 증가 시킨다.
    	sqlSession.update("boardDiscussion.boardDiscussionViewCntUpd",set.getCondiVO());
    	
    	set.setData((BoardDiscussionVO) sqlSession.selectOne("boardDiscussion.boardDiscussionData",set.getCondiVO()));

    	//수정 권한 판단
    	set.getCondiVO().setIsEdit(commSvr.isBoardUpdYn(set.getCondiVO().getCourseId(),SessionUtil.getSessionUserId()));
    	
    	return set;
    }

    public BoardDiscussionSet boardDiscussionU(BoardDiscussionSet set) throws Exception {
    	set.setData((BoardDiscussionVO) sqlSession.selectOne("boardDiscussion.boardDiscussionData",set.getCondiVO()));
    	
    	return set;
    }

    @Transactional(propagation=Propagation.REQUIRED, rollbackFor={Throwable.class})
    public BoardDiscussionSet boardDiscussionIns(BoardDiscussionSet set) throws Exception {

		set.getCondiVO().setUserId(SessionUtil.getSessionUserId());
    	set.getCondiVO().setUserIp(SessionUtil.getSessionUserIp());
    	
    	//1단 등록이면.
    	if ( "".equals(set.getCondiVO().getRef()) ) {
        	//입력한다.
    		set.getCondiVO().setOrd("1");
    		set.getCondiVO().setStep("1");
    		set.getCondiVO().setRef("0");
    		sqlSession.insert("boardDiscussion.boardDiscussionIns",set.getCondiVO());
        	
        	//Ref 세팅
    		BoardDiscussionVO vo = new BoardDiscussionVO();
    		vo.setSeq((String)sqlSession.selectOne("comm.lastInsertId"));
    		vo.setRef(vo.getSeq());
    		sqlSession.insert("boardDiscussion.boardDiscussionRefUpd",vo);
    	} else {
    		//Ord를 구해서 정렬을 증가시킨다.
    		BoardDiscussionVO data =  sqlSession.selectOne("boardDiscussion.boardDiscussionData",set.getCondiVO());
    		set.getCondiVO().setOrd(data.getOrd());
    		
    		sqlSession.update("boardDiscussion.boardDiscussionOrdUpd",set.getCondiVO());
        	
        	//답변을 입력한다.
    		sqlSession.insert("boardDiscussion.boardDiscussionReplyIns",set.getCondiVO());
    		
    	}
    		
    	set.setRtnMode(Constant.mode.INSERT_OK.name());
    	
    	return set;
    }

    @Transactional(propagation=Propagation.REQUIRED, rollbackFor={Throwable.class})
    public BoardDiscussionSet boardDiscussionUpd(BoardDiscussionSet set) throws Exception {
    	sqlSession.update("boardDiscussion.boardDiscussionUpd",set.getCondiVO());
    	
    	set.setRtnMode(Constant.mode.UPDATE_OK.name());
    	
    	return set;
    }

    @Transactional(propagation=Propagation.REQUIRED, rollbackFor={Throwable.class})
    public BoardDiscussionSet boardDiscussionDel(BoardDiscussionSet set) throws Exception {
    	sqlSession.delete("boardDiscussion.boardDiscussionDel",set.getCondiVO());

    	set.setRtnMode(Constant.mode.DELETE_OK.name());
    	
    	return set;
    }

	
}
