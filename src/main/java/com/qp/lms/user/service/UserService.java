package com.qp.lms.user.service;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.qp.lms.board.model.AttachVO;
import com.qp.lms.board.model.BoardFaqVO;
import com.qp.lms.board.model.BoardVO;
import com.qp.lms.common.CodeVO;
import com.qp.lms.common.Constant;
import com.qp.lms.common.SessionUtil;
import com.qp.lms.common.service.DdService;
import com.qp.lms.course.model.CourseVO;
import com.qp.lms.evaluation.model.EvaluationVO;
import com.qp.lms.main.model.MainSet;
import com.qp.lms.user.model.UserSet;

@Service
public class UserService {
	@Autowired
	private SqlSession sqlSession;

	@Autowired
	private DdService ddService;

    public UserSet studyroom(UserSet set) throws Exception {
    	set.getCondiVO().setUserId(SessionUtil.getSessionUserId());
    	set.setCourseInfo((CourseVO) sqlSession.selectOne("user.courseData",set.getCondiVO()));
    	
    	List<EvaluationVO> courseWeekList = sqlSession.selectList("evaluation.courseWeekList",set.getCondiVO());
    	set.setWeek(courseWeekList);

    	List<CourseVO> courseExamList = sqlSession.selectList("user.courseExamList",set.getCondiVO());
    	set.setExam(courseExamList);

    	
    	BoardVO board = new BoardVO();
    	board.setCourseId(set.getCondiVO().getCourseId());
    	board.setUserId(set.getCondiVO().getUserId());
    	board.setLimit("4");
    	
    	List<BoardVO> boardNotice4List = sqlSession.selectList("boardNotice.boardNoticeLimitList", board);
    	set.setBoardNoticeList(boardNotice4List);

    	List<BoardVO> boardQna4List = sqlSession.selectList("boardQna.boardQnaLimitList", board);
    	set.setBoardQnaList(boardQna4List);

        return set ;
    }

    public UserSet studyroomDataList(UserSet set) throws Exception {
    	//강좌 상세 조회
    	set.getCondiVO().setUserId(SessionUtil.getSessionUserId());
    	set.setCourseInfo((CourseVO) sqlSession.selectOne("user.courseData",set.getCondiVO()));
    	
    	//자료실 리스트 조회
    	BoardVO board = new BoardVO();
    	board.setFindString(set.getCondiVO().getFindString());
    	board.setUserId(SessionUtil.getSessionUserId());
    	board.setCourseId(set.getCondiVO().getCourseId());
    	
    	//쿼리에서 가져올 갯수 지정
    	set.getCondiVO().setLimitUnit(Constant.unitForBoard);
    	board.setLimitUnit(Constant.unitForBoard);

    	List<BoardVO> list = sqlSession.selectList("boardData.boardDataList",board);
    	set.setBoardDataList(list);
    	
    	//페이징 처리 변수 세팅
    	set.setTotalCount(((BoardVO)sqlSession.selectOne("boardData.boardDataTotal",set.getCondiVO())).getCnt());
    	set.setPageUnit(Constant.unitForBoard);
    	
        return set ;
    }

    public UserSet studyroomDataV(UserSet set) throws Exception {
    	//강좌 상세 조회
    	set.getCondiVO().setUserId(SessionUtil.getSessionUserId());
    	set.setCourseInfo((CourseVO) sqlSession.selectOne("user.courseData",set.getCondiVO()));

    	//자료실 상세조회
    	BoardVO board = new BoardVO();
    	board.setSeq(set.getCondiVO().getSeq());

    	//조회수를 증가 시킨다.
    	sqlSession.update("boardData.boardDataViewCntUpd",board);
    	
    	set.setBoardData((BoardVO) sqlSession.selectOne("boardData.boardDataData",board));
    	
    	//첨부파일
    	AttachVO attach = new AttachVO();
    	attach.setKind("B_DATA");
    	attach.setpSeq(set.getCondiVO().getSeq());
    	List<AttachVO> list = sqlSession.selectList("attach.attachList",attach);
		set.setAttachList(list);
		
        return set ;
    }
    
    public UserSet studyroomQnaList(UserSet set) throws Exception {
    	//강좌 상세 조회
    	set.getCondiVO().setUserId(SessionUtil.getSessionUserId());
    	set.setCourseInfo((CourseVO) sqlSession.selectOne("user.courseData",set.getCondiVO()));

    	//QNA 리스트 조회
    	BoardVO board = new BoardVO();
    	board.setFindString(set.getCondiVO().getFindString());
    	board.setUserId(SessionUtil.getSessionUserId());
    	board.setCourseId(set.getCondiVO().getCourseId());
    	
       	//쿼리에서 가져올 갯수 지정
    	set.getCondiVO().setLimitUnit(Constant.unitForBoard);
    	board.setLimitUnit(Constant.unitForBoard);
    	
    	List<BoardVO> list = sqlSession.selectList("boardQna.boardQnaList",board);
    	set.setBoardQnaList(list);
    	
    	//페이징 처리 변수 세팅
    	set.setTotalCount(((BoardVO)sqlSession.selectOne("boardQna.boardQnaTotal",board)).getCnt());
    	set.setPageUnit(Constant.unitForBoard);
    	
        return set ;
    }

    public UserSet studyroomQnaV(UserSet set) throws Exception {
    	//강좌 상세 조회
    	set.getCondiVO().setUserId(SessionUtil.getSessionUserId());
    	set.setCourseInfo((CourseVO) sqlSession.selectOne("user.courseData",set.getCondiVO()));

    	//QNA 상세조회
    	BoardVO board = new BoardVO();
    	board.setSeq(set.getCondiVO().getSeq());

    	//조회수를 증가 시킨다.
    	sqlSession.update("boardQna.boardQnaViewCntUpd",board);

    	set.setBoardQna((BoardVO) sqlSession.selectOne("boardQna.boardQnaData",board));
    	
    	//답글 리스트
    	BoardVO answerVO = new BoardVO();
    	answerVO.setpSeq(set.getCondiVO().getSeq());
    	List<BoardVO> list = sqlSession.selectList("boardQna.boardQnaAnswerList",answerVO);
    	set.setAnswerList(list);
    	
        return set ;
    }

    public UserSet studyroomQnaU(UserSet set) throws Exception {
    	//강좌 상세 조회
    	set.getCondiVO().setUserId(SessionUtil.getSessionUserId());
    	set.setCourseInfo((CourseVO) sqlSession.selectOne("user.courseData",set.getCondiVO()));

    	//QNA 상세조회
    	BoardVO board = new BoardVO();
    	board.setSeq(set.getCondiVO().getSeq());

    	set.setBoardQna((BoardVO) sqlSession.selectOne("boardQna.boardQnaData",board));
    	
        return set ;
    }
    
    public UserSet studyroomQnaN(UserSet set) throws Exception {
    	//강좌 상세 조회
    	set.getCondiVO().setUserId(SessionUtil.getSessionUserId());
    	set.setCourseInfo((CourseVO) sqlSession.selectOne("user.courseData",set.getCondiVO()));
    	
        return set ;
    }

    @Transactional(propagation=Propagation.REQUIRED, rollbackFor={Throwable.class})
    public UserSet studyroomQnaIns(UserSet set) throws Exception {
    	//강좌 상세 조회
    	set.getCondiVO().setUserId(SessionUtil.getSessionUserId());
    	set.setCourseInfo((CourseVO) sqlSession.selectOne("user.courseData",set.getCondiVO()));
    	
    	//게시판 입력
    	BoardVO board = new BoardVO();
    	board.setCourseId(set.getCondiVO().getCourseId());
    	board.setTitle(set.getCondiVO().getTitle());
    	board.setContents(set.getCondiVO().getContents());
    	board.setUserId(SessionUtil.getSessionUserId());
    	board.setUserIp(SessionUtil.getSessionUserIp());
    	
    	sqlSession.insert("boardQna.boardQnaIns",board);
    	
    	set.setRtnMode(Constant.mode.INSERT_OK.name());
    	
        return set ;
    }

    @Transactional(propagation=Propagation.REQUIRED, rollbackFor={Throwable.class})
    public UserSet studyroomQnaUpd(UserSet set) throws Exception {
    	//강좌 상세 조회
    	set.getCondiVO().setUserId(SessionUtil.getSessionUserId());
    	set.setCourseInfo((CourseVO) sqlSession.selectOne("user.courseData",set.getCondiVO()));
    	
    	BoardVO board = new BoardVO();
    	board.setTitle(set.getCondiVO().getTitle());
    	board.setContents(set.getCondiVO().getContents());
    	board.setSeq(set.getCondiVO().getSeq());
    	
    	sqlSession.update("boardQna.boardQnaUpd",board);
    	
    	set.setRtnMode(Constant.mode.UPDATE_OK.name());
    	
        return set ;
    }

    @Transactional(propagation=Propagation.REQUIRED, rollbackFor={Throwable.class})
    public UserSet studyroomQnaDel(UserSet set) throws Exception {
    	//강좌 상세 조회
    	set.getCondiVO().setUserId(SessionUtil.getSessionUserId());
    	set.setCourseInfo((CourseVO) sqlSession.selectOne("user.courseData",set.getCondiVO()));
    	
    	BoardVO board = new BoardVO();
    	board.setSeq(set.getCondiVO().getSeq());
    	
    	sqlSession.delete("boardQna.boardQnaDel",board);

    	//답글 전체 삭제
    	BoardVO answerVO = new BoardVO();
    	answerVO.setpSeq(set.getCondiVO().getSeq());
    	sqlSession.delete("boardQna.boardQnaAnswerDelKeyPSeq",answerVO);

    	set.setRtnMode(Constant.mode.DELETE_OK.name());
    	
        return set ;
    }

    public UserSet studyroomQnaAnswerN(UserSet set) throws Exception {
       	//강좌 상세 조회
    	set.getCondiVO().setUserId(SessionUtil.getSessionUserId());
    	set.setCourseInfo((CourseVO) sqlSession.selectOne("user.courseData",set.getCondiVO()));

    	//QNA 상세조회
    	BoardVO board = new BoardVO();
    	board.setSeq(set.getCondiVO().getSeq());

    	set.setBoardQna((BoardVO) sqlSession.selectOne("boardQna.boardQnaData",board));

    	return set;
    }

    @Transactional(propagation=Propagation.REQUIRED, rollbackFor={Throwable.class})
    public UserSet studyroomQnaAnswerIns(UserSet set) throws Exception {
    	//게시판 입력
    	BoardVO board = new BoardVO();
    	board.setTitle(set.getCondiVO().getTitle());
    	board.setContents(set.getCondiVO().getContents());
    	board.setpSeq(set.getCondiVO().getSeq());
    	board.setUserId(SessionUtil.getSessionUserId());
    	board.setUserIp(SessionUtil.getSessionUserIp());
    	
    	sqlSession.insert("boardQna.boardQnaAnswerIns",board);
    	
    	//답변수 변경
    	sqlSession.update("boardQna.boardQnaReplyCntUpd",board);

    	set.setRtnMode(Constant.mode.INSERT_OK.name());
    	
    	return set;
    }

    public UserSet studyroomQnaAnswerU(UserSet set) throws Exception {
       	//강좌 상세 조회
    	set.getCondiVO().setUserId(SessionUtil.getSessionUserId());
    	set.setCourseInfo((CourseVO) sqlSession.selectOne("user.courseData",set.getCondiVO()));

    	//QNA 상세조회
    	BoardVO board = new BoardVO();
    	board.setSeq(set.getCondiVO().getSeq());

    	set.setBoardQna((BoardVO) sqlSession.selectOne("boardQna.boardQnaData",board));
    	
    	BoardVO answerVO = new BoardVO();
    	answerVO.setSeq(set.getCondiVO().getAnswerSeq());
    	
    	set.setBoardAnswer((BoardVO) sqlSession.selectOne("boardQna.boardQnaAnswerData",answerVO));
    	
    	return set;
    }
    
    @Transactional(propagation=Propagation.REQUIRED, rollbackFor={Throwable.class})
    public UserSet studyroomQnaAnswerUpd(UserSet set) throws Exception {
    	BoardVO board = new BoardVO();
    	board.setContents(set.getCondiVO().getContents());
    	board.setSeq(set.getCondiVO().getAnswerSeq());
    	
    	sqlSession.update("boardQna.boardQnaAnswerUpd",board);
    	
    	set.setRtnMode(Constant.mode.UPDATE_OK.name());
    	
    	return set;
    }

    @Transactional(propagation=Propagation.REQUIRED, rollbackFor={Throwable.class})
    public UserSet studyroomQnaAnswerDel(UserSet set) throws Exception {
    	BoardVO board = new BoardVO();
    	board.setContents(set.getCondiVO().getContents());
    	board.setSeq(set.getCondiVO().getAnswerSeq());
    	
    	sqlSession.delete("boardQna.boardQnaAnswerDel",board);

    	//답변수 변경
    	sqlSession.update("boardQna.boardQnaReplyCntUpd",board);

    	set.setRtnMode(Constant.mode.DELETE_OK.name());
    	
    	return set;
    }

    public UserSet noticeList(UserSet set) throws Exception {
    	// 리스트 조회
    	BoardVO board = new BoardVO();
    	board.setFindString(set.getCondiVO().getFindString());
    	board.setCourseId("0");
    	
    	//쿼리에서 가져올 갯수 지정
    	set.getCondiVO().setLimitUnit(Constant.unitForBoard);
    	board.setLimitUnit(Constant.unitForBoard);

    	List<BoardVO> list = sqlSession.selectList("boardNotice.boardNoticeList",board);
    	set.setBoardNoticeList(list);
    	
    	//페이징 처리 변수 세팅
    	set.setTotalCount(((BoardVO)sqlSession.selectOne("boardNotice.boardNoticeTotal",set.getCondiVO())).getCnt());
    	set.setPageUnit(Constant.unitForBoard);
    	
        return set ;
    }

    public UserSet noticeV(UserSet set) throws Exception {
    	// 상세조회
    	BoardVO board = new BoardVO();
    	board.setSeq(set.getCondiVO().getSeq());
    	board.setCourseId("0");

    	//조회수를 증가 시킨다.
    	sqlSession.update("boardNotice.boardNoticeViewCntUpd",board);
    	
    	set.setBoardNotice((BoardVO) sqlSession.selectOne("boardNotice.boardNoticeData",board));
    	
    	// 다음
    	BoardVO nextVO = (BoardVO)sqlSession.selectOne("boardNotice.nextNoticeSeq",board);
    	if ( nextVO != null && !"".equals(nextVO.getSeq()) ) {
    		set.getBoardNotice().setNextSeq(nextVO.getSeq());
    	} else {
    		set.getBoardNotice().setNextSeq("");
    	}
    	// 이전
    	BoardVO prevVO = (BoardVO)sqlSession.selectOne("boardNotice.prevNoticeSeq",board);
    	if ( prevVO != null && !"".equals(prevVO.getSeq()) ) {
    		set.getBoardNotice().setPrevSeq(prevVO.getSeq());;
    	} else {
    		set.getBoardNotice().setPrevSeq("");
    	}
    	
        return set ;
    }
    
    public UserSet faqList(UserSet set) throws Exception {
    	//category
    	List<CodeVO> ddList = sqlSession.selectList("comm.getDdCodeKeyDdMain","FAQ");
    	set.setDdCategory(ddList);

    	// 리스트 조회
    	BoardFaqVO board = new BoardFaqVO();
    	board.setFindString(set.getCondiVO().getFindString());
    	board.setCategory(set.getCondiVO().getCategory());
    	
    	//쿼리에서 가져올 갯수 지정
    	set.getCondiVO().setLimitUnit(Constant.unitForBoard);
    	board.setLimitUnit(Constant.unitForBoard);

    	List<BoardFaqVO> list = sqlSession.selectList("boardFaq.boardFaqList",board);
    	set.setBoardFaqList(list);
    	
    	//페이징 처리 변수 세팅
    	set.setTotalCount(((BoardFaqVO)sqlSession.selectOne("boardFaq.boardFaqTotal",set.getCondiVO())).getCnt());
    	set.setPageUnit(Constant.unitForBoard);
    	
        return set ;
    }

    public UserSet faqV(UserSet set) throws Exception {
    	// 상세조회
    	BoardFaqVO board = new BoardFaqVO();
    	board.setSeq(set.getCondiVO().getSeq());

    	//조회수를 증가 시킨다.
    	sqlSession.update("boardFaq.boardFaqViewCntUpd",board);
    	
    	set.setBoardFaq((BoardFaqVO) sqlSession.selectOne("boardFaq.boardFaqData",board));
    	
        return set ;
    }

    /*
	public UserSet courseList(UserSet set) throws Exception {
    	// 카테고리 대분류 
    	set.setDdCategory1Depth(ddService.getDdCategory1Depth());
    	
    	// 카테고리 중분류 
    	if ( set.getCondiVO().getC1Code() != null )
    		set.setDdCategory2Depth(ddService.getDdCategory2Depth(set.getCondiVO().getC1Code()));
    	
    	// 카테고리 소분류 
    	if ( set.getCondiVO().getC2Code() != null )
    	set.setDdCategory3Depth(ddService.getDdCategory3Depth(set.getCondiVO().getC2Code()));

    	//쿼리에서 가져올 갯수 지정
    	set.getCondiVO().setLimitUnit(Constant.unitForMain);

    	List<CourseVO> courseList = sqlSession.selectList("user.courseList",set.getCondiVO());
    	set.setCourseList(courseList);
        
    	//페이징 처리 변수 세팅
    	set.setTotalCount(((CourseVO)sqlSession.selectOne("user.courseTotal",set.getCondiVO())).getCnt());
    	set.setPageUnit(Constant.unitForMain);
    	
    	return set;
    }
    */


}
