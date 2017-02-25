package com.qp.lms.board.service;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.qp.lms.board.model.BoardFaqSet;
import com.qp.lms.board.model.BoardFaqVO;
import com.qp.lms.common.CodeVO;
import com.qp.lms.common.Constant;
import com.qp.lms.common.SessionUtil;
import com.qp.lms.common.service.CommService;

@Service
public class BoardFaqService {
	@Autowired
	private SqlSession sqlSession;
	
    public BoardFaqSet boardFaqList(BoardFaqSet set) throws Exception {
    	//쿼리에서 가져올 갯수 지정
    	set.getCondiVO().setLimitUnit(Constant.unitForBoard);

    	List<BoardFaqVO> list = sqlSession.selectList("boardFaq.boardFaqList",set.getCondiVO());
    	set.setList(list);
    	
    	//category
    	List<CodeVO> ddList = sqlSession.selectList("comm.getDdCodeKeyDdMain","FAQ");
    	set.setDdCategory(ddList);
    	
    	//페이징 처리 변수 세팅
    	set.setTotalCount(((BoardFaqVO)sqlSession.selectOne("boardFaq.boardFaqTotal",set.getCondiVO())).getCnt());
    	set.setPageUnit(Constant.unitForBoard);

    	if ( SessionUtil.isAdmin() )
    		set.getCondiVO().setIsAdmin("Y");
    	else
    		set.getCondiVO().setIsAdmin("N");

    	return set;
    }

    public BoardFaqSet boardFaqN(BoardFaqSet set) throws Exception {
    	//category
    	List<CodeVO> list = sqlSession.selectList("comm.getDdCodeKeyDdMain","FAQ");
    	set.setDdCategory(list);

    	return set;
    }

    public BoardFaqSet boardFaqV(BoardFaqSet set) throws Exception {
    	//조회수를 증가 시킨다.
    	sqlSession.update("boardFaq.boardFaqViewCntUpd",set.getCondiVO());

    	set.setData((BoardFaqVO) sqlSession.selectOne("boardFaq.boardFaqData",set.getCondiVO()));
    	
    	//category
    	List<CodeVO> list = sqlSession.selectList("comm.getDdCodeKeyDdMain","FAQ");
    	set.setDdCategory(list);

    	if ( SessionUtil.isAdmin() )
    		set.getCondiVO().setIsAdmin("Y");
    	else
    		set.getCondiVO().setIsAdmin("N");

    	return set;
    }

    public BoardFaqSet boardFaqU(BoardFaqSet set) throws Exception {
    	set.setData((BoardFaqVO) sqlSession.selectOne("boardFaq.boardFaqData",set.getCondiVO()));

    	//category
    	List<CodeVO> list = sqlSession.selectList("comm.getDdCodeKeyDdMain","FAQ");
    	set.setDdCategory(list);
    	
    	return set;
    }

    @Transactional(propagation=Propagation.REQUIRED, rollbackFor={Throwable.class})
    public BoardFaqSet boardFaqIns(BoardFaqSet set) throws Exception {
    	sqlSession.insert("boardFaq.boardFaqIns",set.getCondiVO());
    	
    	set.setRtnMode(Constant.mode.INSERT_OK.name());
    	
    	return set;
    }

    @Transactional(propagation=Propagation.REQUIRED, rollbackFor={Throwable.class})
    public BoardFaqSet boardFaqUpd(BoardFaqSet set) throws Exception {
    	sqlSession.update("boardFaq.boardFaqUpd",set.getCondiVO());
    	
    	set.setRtnMode(Constant.mode.UPDATE_OK.name());
    	
    	return set;
    }

    @Transactional(propagation=Propagation.REQUIRED, rollbackFor={Throwable.class})
    public BoardFaqSet boardFaqDel(BoardFaqSet set) throws Exception {
    	sqlSession.delete("boardFaq.boardFaqDel",set.getCondiVO());

    	set.setRtnMode(Constant.mode.DELETE_OK.name());
    	
    	return set;
    }

	
}
