package com.qp.lms.user.service;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.qp.lms.board.model.BoardVO;
import com.qp.lms.common.CommUtil;
import com.qp.lms.common.SessionUtil;
import com.qp.lms.common.service.DdService;
import com.qp.lms.course.model.CourseResourceVO;
import com.qp.lms.course.model.CourseVO;
import com.qp.lms.education.model.EducationVO;
import com.qp.lms.evaluation.model.EvaluationVO;
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

    	sqlSession.insert("user.courseAttendanceLogInsert", set.getCondiVO());
    	
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

    public UserSet studyroomQch(UserSet set) throws Exception {
    	EducationVO eduVO = new EducationVO();
    	eduVO.setUserId(SessionUtil.getSessionUserId());
    	eduVO.setCourseId(set.getCondiVO().getCourseId());
    	eduVO.setCompCd(SessionUtil.getSessionCompCd());
    	
    	set.setCourseInfo((CourseVO) sqlSession.selectOne("education.courseData",eduVO));

    	List<CourseResourceVO> resourceList = sqlSession.selectList("education.courseResourceList",set.getCondiVO());
    	set.setResourceList(resourceList);

    	List<CourseResourceVO> resourcePageList = sqlSession.selectList("education.courseResourcePageList",set.getCondiVO());
    	set.setResourcePageList(resourcePageList);
    	
        return set ;
    }
    
    public UserSet courseAttendanceV(UserSet set) throws Exception {
    	set.getCondiVO().setUserId(SessionUtil.getSessionUserId());
    	
    	List<EvaluationVO> attendanceDays = sqlSession.selectList("user.courseAttendanceDaysList",set.getCondiVO());
    	set.setAttendanceDays(attendanceDays);

        return set ;
    }

    /*public UserSet studyroomDataList(UserSet set) throws Exception {
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
    }*/


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

	public UserSet checkMyCourse(UserSet set) throws Exception {
    	set.getCondiVO().setUserId(SessionUtil.getSessionUserId());
    	set.setCourseInfo((CourseVO) sqlSession.selectOne("user.checkMyCourse",set.getCondiVO()));
    	
        return set ;
    }
}
