package com.qp.lms.board.service;

import java.io.File;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.qp.lms.board.model.AttachVO;
import com.qp.lms.board.model.BoardSet;
import com.qp.lms.board.model.BoardVO;
import com.qp.lms.common.CommUtil;
import com.qp.lms.common.Constant;
import com.qp.lms.common.SessionUtil;
import com.qp.lms.common.service.CommService;

@Service
public class BoardDataService {
	@Autowired
	private SqlSession sqlSession;
	
	@Autowired
	private CommService commSvr;
	
    public BoardSet boardDataList(BoardSet set) throws Exception {
    	//쿼리에서 가져올 갯수 지정
    	set.getCondiVO().setLimitUnit(Constant.unitForBoard);

    	List<BoardVO> list = sqlSession.selectList("boardData.boardDataList",set.getCondiVO());
    	set.setList(list);
    	
    	//페이징 처리 변수 세팅
    	set.setTotalCount(((BoardVO)sqlSession.selectOne("boardData.boardDataTotal",set.getCondiVO())).getCnt());
    	set.setPageUnit(Constant.unitForBoard);

    	//수정 권한 판단
    	set.getCondiVO().setIsEdit(commSvr.isBoardInsYn(set.getCondiVO().getCourseId(),SessionUtil.getSessionUserId()));
    	
    	return set;
    }

    public BoardSet boardDataV(BoardSet set) throws Exception {
    	//조회수를 증가 시킨다.
    	sqlSession.update("boardData.boardDataViewCntUpd",set.getCondiVO());
    	
    	set.setData((BoardVO) sqlSession.selectOne("boardData.boardDataData",set.getCondiVO()));

    	//수정 권한 판단
    	set.getCondiVO().setIsEdit(commSvr.isBoardUpdYn(set.getCondiVO().getCourseId(),SessionUtil.getSessionUserId()));
    	
    	return set;
    }

    public BoardSet boardDataN(BoardSet set) throws Exception {
    	//첨부파일에 사용할 임시 SEQ를 구한다.
    	set.getCondiVO().setSeq((String)sqlSession.selectOne("comm.tempSeq"));
    	
    	return set;
    }

    public BoardSet boardDataU(BoardSet set) throws Exception {
    	set.setData((BoardVO) sqlSession.selectOne("boardData.boardDataData",set.getCondiVO()));
    	
    	return set;
    }



    /////////////////////////////////////////////////////////////////////////////////////////////////////
    @Transactional(propagation=Propagation.REQUIRED, rollbackFor={Throwable.class})
    public BoardSet boardDataIns(BoardSet set) throws Exception {
    	//게시판 입력
    	set.getCondiVO().setUserId(SessionUtil.getSessionUserId());
    	set.getCondiVO().setUserIp(SessionUtil.getSessionUserIp());
    	
    	sqlSession.insert("boardData.boardBataIns",set.getCondiVO());
    	
    	//자료실 게시판 추가된 id를 구한다.
    	String lastId = (String)sqlSession.selectOne("comm.lastInsertId");
    	
    	//첨부파일 처리를 위한 VO를 만든다.
    	AttachVO attach = new AttachVO();
    	attach.setKind("BOARD_DATA");
    	attach.setUserId(SessionUtil.getSessionUserId());
    	attach.setpSeq(lastId);

    	//추가한 첨부파일이 있으면 옮겨주고, 임시 테이블에서 삭제한다.
    	sqlSession.insert("attach.attachFromAttachTempIns",attach);
    	sqlSession.delete("attach.attachTempForUserDel",attach);
    	
    	set.setRtnMode(Constant.mode.INSERT_OK.name());
    	
    	return set;
    }

    @Transactional(propagation=Propagation.REQUIRED, rollbackFor={Throwable.class})
    public BoardSet boardDataUpd(BoardSet set) throws Exception {
    	sqlSession.update("boardData.boardDataUpd",set.getCondiVO());
    	
    	set.setRtnMode(Constant.mode.UPDATE_OK.name());
    	
    	return set;
    }

    @Transactional(propagation=Propagation.REQUIRED, rollbackFor={Throwable.class})
    public BoardSet boardDataDel(BoardSet set) throws Exception {
    	sqlSession.delete("boardData.boardDataDel",set.getCondiVO());

    	//첨부파일 처리를 위한 VO를 만든다.
    	AttachVO attach = new AttachVO();
    	attach.setKind(Constant.attach.B_DATA.name());
    	attach.setpSeq(set.getCondiVO().getSeq());

    	//첨부파일 삭제한다.
    	List<AttachVO> list = sqlSession.selectList("attach.attachList",attach);
    	for ( int i = 0; i < list.size(); i++ ) {
    		//파일 삭제
    		String fullFileName = CommUtil.getFileFolder() + ((AttachVO)list.get(i)).getFilePath() + ((AttachVO)list.get(i)).getFileName();
            File f = new File(fullFileName);
            f.delete();
            
            sqlSession.delete("attach.attachDel",((AttachVO)list.get(i)));
    	}
    	
    	set.setRtnMode(Constant.mode.DELETE_OK.name());
    	
    	return set;
    }

	
}
