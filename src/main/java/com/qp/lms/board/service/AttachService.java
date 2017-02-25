package com.qp.lms.board.service;

import java.io.File;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.qp.lms.board.model.AttachSet;
import com.qp.lms.board.model.AttachVO;
import com.qp.lms.board.model.BoardVO;
import com.qp.lms.common.CommUtil;
import com.qp.lms.common.Constant;
import com.qp.lms.common.SessionUtil;

@Service
public class AttachService {
	@Autowired
	private SqlSession sqlSession;

    public AttachSet attachI(AttachSet set) throws Exception {
		set.setIsMy("N");

		set.getCondiVO().setUserId(SessionUtil.getSessionUserId());
		
		List<AttachVO> list = sqlSession.selectList("attach.attachTempList",set.getCondiVO());
		set.setList(list);
    	
    	return set;
    }
    
	/*
	 * 첨부파일 목록을 가져온다.
	 */
    public AttachSet attachV(AttachSet set) throws Exception {
		List<AttachVO> list = sqlSession.selectList("attach.attachList",set.getCondiVO());
		set.setList(list);

		//내가 등록한 데이타인지 체크
		BoardVO vo = new BoardVO();
		vo.setSeq(set.getCondiVO().getpSeq());
		BoardVO boardVO = (BoardVO)sqlSession.selectOne("boardData.boardDataData",vo);
		if ( boardVO != null ) {
			if ( SessionUtil.getSessionUserId().equals(boardVO.getUserId()) ) 
				set.setIsMy("Y");
			else
				set.setIsMy("N");
		}
		
		if (SessionUtil.isAdmin() == true || SessionUtil.isTeacher() == true || SessionUtil.isTutor() == true)
			set.getCondiVO().setIsAdmin("Y");
		else
			set.getCondiVO().setIsAdmin("N");
    	
    	return set;
    }

	/*
	 * 다운로드할 파일 정보를 가져온다.
	 */
    public AttachSet attachDownload(AttachSet set) throws Exception {
    	// 리스트를 가져온다.
    	set.setData((AttachVO) sqlSession.selectOne("attach.attachData",set.getCondiVO()));
    	
    	return set;
    }

    /*
	 * 첨부파일 추가
	 */
    @Transactional(propagation=Propagation.REQUIRED, rollbackFor={Throwable.class})
    public AttachSet attachIns(AttachSet set) throws Exception {
    	// 추가한다.
    	if ( "TEMP".equals(CommUtil.getString(set.getCondiVO().getMode())) ) {
    		set.getCondiVO().setUserId(SessionUtil.getSessionUserId());

    		sqlSession.update("attach.attachTempIns",set.getCondiVO());
    	} else
    		sqlSession.update("attach.attachIns",set.getCondiVO());
    	
    	set.setRtnMode(Constant.mode.INSERT_OK.name());

    	return set;
    }

	/*
	 * 첨부파일 삭제
	 */
    @Transactional(propagation=Propagation.REQUIRED, rollbackFor={Throwable.class})
    public AttachSet attachDel(AttachSet set) throws Exception {
    	// 파일 삭제를 위한 정보를 가지고 온다.
    	if ( "TEMP".equals(CommUtil.getString(set.getCondiVO().getMode())) ) {
    		set.getCondiVO().setUserId(SessionUtil.getSessionUserId());

    		set.setData((AttachVO) sqlSession.selectOne("attach.attachDataTemp",set.getCondiVO()));
    	} else
    		set.setData((AttachVO) sqlSession.selectOne("attach.attachData",set.getCondiVO()));
    	
    	// 삭제한다.
    	if ( "TEMP".equals(CommUtil.getString(set.getCondiVO().getMode())) )
    		sqlSession.update("attach.attachTempDel",set.getCondiVO());
    	else
    		sqlSession.update("attach.attachDel",set.getCondiVO());
    	
    	set.setRtnMode(Constant.mode.DELETE_OK.name());
    	
    	return set;
    }


}
