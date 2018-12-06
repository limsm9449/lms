package com.qp.lms.main.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.qp.lms.board.model.AttachVO;
import com.qp.lms.board.model.BoardFaqVO;
import com.qp.lms.board.model.BoardVO;
import com.qp.lms.common.CodeVO;
import com.qp.lms.common.CommUtil;
import com.qp.lms.common.Constant;
import com.qp.lms.common.SessionUtil;
import com.qp.lms.common.service.DdService;
import com.qp.lms.counsel.model.CounselVO;
import com.qp.lms.course.model.CourseResourceVO;
import com.qp.lms.course.model.CourseVO;
import com.qp.lms.main.model.MainSet;
import com.qp.lms.postscript.model.PostScriptVO;

@Service("mainService")
public class MainService {
	@Autowired
	private SqlSession sqlSession;

	@Autowired
	private DdService ddService;

	public MainSet mainCourseList(MainSet set) throws Exception {
		//공지사항
		set.getCondiVO().setCnt(5);
    	List<BoardVO> noticeList = sqlSession.selectList("main.noticeList", set.getCondiVO());
		set.setNoticeList(noticeList);

		//faq
		set.getCondiVO().setCompType((String)SessionUtil.getAttribute("compType"));
    	List<BoardVO> faqList = sqlSession.selectList("main.faqList", set.getCondiVO());
		set.setFaqList(faqList);

    	return set;
    }
	
	public MainSet mainCourseData(MainSet set) throws Exception {
		set.getCondiVO().setUserId(SessionUtil.getSessionUserId());
		
    	set.setCourseData((CourseVO)sqlSession.selectOne("main.courseData",set.getCondiVO()));
    	
    	List<CourseResourceVO> courseResourceList = sqlSession.selectList("main.courseResourceData",set.getCondiVO());
    	set.setCourseResourceList(courseResourceList);

    	List<PostScriptVO> coursePostscriptList = sqlSession.selectList("postscript.coursePostscriptList",set.getCondiVO());
    	set.setPostScriptList(coursePostscriptList);

    	return set;
    }

	public MainSet cart(MainSet set) throws Exception {
		Map map = new HashMap();
		
		if ( set.getCondiVO().getCourseId() != null ) {
			List al = new ArrayList();
			String[] courseIds = set.getCondiVO().getCourseId().split(",");
			for ( int i = 0; i < courseIds.length; i++ ) {
				al.add(courseIds[i]);
			}
			map.put("list", al);
			
			//결재할 과정 정보
			List<CourseVO> courseList = sqlSession.selectList("main.applicationCourseList",map);
	    	set.setCourseList(courseList);
	    	
	    	HashMap cart = (HashMap)SessionUtil.getAttribute("cart");
	    	if ( cart == null ) {
	    		//바로 신청할 경우....
	    		cart = (HashMap)SessionUtil.getAttribute("tempCart");
	    	}
	    	
	    	//결재금액
	    	int paymentCost = 0;
	    	for ( int i = 0; i < courseList.size(); i++ ) {
	    		if ( CommUtil.isEqual((String)cart.get(courseList.get(i).getCourseId()), "") ) {
	    			//전체 선택인경우... 
	    			paymentCost += Integer.parseInt((String)courseList.get(i).getCourseCost());
	    		} else {
	    			//부분 선택인 경우...
	    			
	    			Map weekMap = new HashMap();
	    			List weekList = new ArrayList();
	    			String[] weeks = ((String)cart.get(courseList.get(i).getCourseId())).split(",");
	    			for ( int k = 0; k < weeks.length; k++ ) {
	    				weekList.add(weeks[k]);
	    			}
	    			weekMap.put("list", weekList);
	    			weekMap.put("courseId", courseList.get(i).getCourseId());
	
	    			List<CourseVO> cartWeekList = sqlSession.selectList("main.applicationCourseWeekList",weekMap);
	    	    	courseList.get(i).setCartWeekList(cartWeekList);
	
	    	    	//차시별 비용 계산
	    	    	int weekCostTotal = 0;
	    			for ( int m = 0; m < cartWeekList.size(); m++ ) {
	        			paymentCost += Integer.parseInt((String)cartWeekList.get(m).getWeekCost());
	        			weekCostTotal += Integer.parseInt((String)cartWeekList.get(m).getWeekCost());
	    			}
	    			courseList.get(i).setCourseCost(Integer.toString(weekCostTotal));
	    		}
	    	}
		}

    	set.setRtnMode(Constant.mode.OK.name());

    	return set;
    }
	
	public MainSet mailQuestion(MainSet set) throws Exception {
		List<CodeVO> ddMailList = sqlSession.selectList("comm.getDdMail",null);
		set.setDdMailList(ddMailList);
    	
    	return set;
    }

	public MainSet courseList(MainSet set) throws Exception {
    	List<CourseVO> courseList = sqlSession.selectList("main.courseList", set.getCondiVO());
		set.setCourseList(courseList);
		
		int totalCnt = sqlSession.selectOne("main.courseListTotal", set.getCondiVO());
		set.setTotalCount(totalCnt);

    	List<CourseVO> categoryMainCourseList = sqlSession.selectList("main.categoryMainCourseList", set.getCondiVO());
		set.setCategoryMainCourseList(categoryMainCourseList);

    	return set;
    }
	
	public MainSet myClassroom(MainSet set) throws Exception {
		set.getCondiVO().setUserId(SessionUtil.getSessionUserId());
		
		//summary 
		CourseVO courseSummary = sqlSession.selectOne("main.courseSummary", set.getCondiVO());
		set.setCourseSummary(courseSummary);
		
		set.getCondiVO().setCnt(3);
		
		//공지사항
    	List<BoardVO> noticeList = sqlSession.selectList("main.noticeList", set.getCondiVO());
		set.setNoticeList(noticeList);
		
		//상담내역
    	List<CounselVO> counselList = sqlSession.selectList("main.counselList", set.getCondiVO());
		set.setCounselList(counselList);
		
		//학습중인 과정
    	List<CourseVO> attendCourseList = sqlSession.selectList("main.attendCourseList", set.getCondiVO());
		set.setAttendCourseList(attendCourseList);
		
		//수강이력/수료증
    	List<CourseVO> completeCourseList = sqlSession.selectList("main.completeCourseList", set.getCondiVO());
		set.setCompleteCourseList(completeCourseList);
		
		//관심과정 
		
    	return set;
    }

	
	public MainSet service(MainSet set) throws Exception {
		set.getCondiVO().setUserId(SessionUtil.getSessionUserId());

		String compType = (String)SessionUtil.getAttribute("compType");
		List<CodeVO> ddList = sqlSession.selectList("comm.getDdCodeKeyDdMain","FAQ_" + compType);
    	set.setDdCategory(ddList);
    	
		//Faq 카테고리별 5개
    	BoardFaqVO board = new BoardFaqVO();
    	board.setCompType(compType);
    	
    	List<BoardFaqVO> boardFaqlist = sqlSession.selectList("boardFaq.boardFaqCategory5List", board);
    	set.setBoardFaqList(boardFaqlist);

    	set.getCondiVO().setCnt(4);
    	
		//공지사항
    	List<BoardVO> noticeList = sqlSession.selectList("main.noticeList", set.getCondiVO());
		set.setNoticeList(noticeList);
    	
    	//이벤트
    	List<BoardVO> eventList = sqlSession.selectList("main.eventList", set.getCondiVO());
		set.setBoardEventList(eventList);

		return set;
    }

	public MainSet noticeList(MainSet set) throws Exception {
    	// 리스트 조회
    	BoardVO board = new BoardVO();
    	board.setFindString(set.getCondiVO().getFindString());
    	board.setCourseId("0");
    	board.setPageNum(set.getCondiVO().getPageNum());
    	board.setLimitUnit(Constant.unitForBoard);
    	board.setCompCd(set.getCondiVO().getCompCd());
    	
    	List<BoardVO> list = sqlSession.selectList("mainBoardNotice.mainBoardNoticeList",board);
    	set.setBoardNoticeList(list);
    	
    	//페이징 처리 변수 세팅
    	set.setTotalCount(((BoardVO)sqlSession.selectOne("mainBoardNotice.mainBoardNoticeTotal",board)).getCnt());
    	set.setPageUnit(Constant.unitForBoard);
    	
        return set ;
    }

    public MainSet noticeV(MainSet set) throws Exception {
    	// 상세조회
    	BoardVO board = new BoardVO();
    	board.setSeq(set.getCondiVO().getSeq());

    	//조회수를 증가 시킨다.
    	sqlSession.update("mainBoardNotice.mainBoardNoticeViewCntUpd",board);
    	
    	set.setBoardNotice((BoardVO) sqlSession.selectOne("mainBoardNotice.mainBoardNoticeData",board));
    	
        return set ;
    }
    
    public MainSet faqList(MainSet set) throws Exception {
    	//category
    	String compType = (String)SessionUtil.getAttribute("compType");
    	List<CodeVO> ddList = sqlSession.selectList("comm.getDdCodeKeyDdMain","FAQ_" + compType);
    	set.setDdCategory(ddList);

    	// 리스트 조회
    	BoardFaqVO board = new BoardFaqVO();
    	board.setFindString(set.getCondiVO().getFindString());
    	board.setCategory(set.getCondiVO().getCategory());
    	board.setPageNum(set.getCondiVO().getPageNum());
    	board.setLimitUnit(Constant.unitForBoard);
    	board.setCompType(compType);

    	List<BoardFaqVO> list = sqlSession.selectList("boardFaq.boardFaqList",board);
    	set.setBoardFaqList(list);
    	
    	//페이징 처리 변수 세팅
    	set.setTotalCount(((BoardFaqVO)sqlSession.selectOne("boardFaq.boardFaqTotal",board)).getCnt());
    	set.setPageUnit(Constant.unitForBoard);
    	
        return set ;
    }

    public MainSet faqV(MainSet set) throws Exception {
    	// 상세조회
    	BoardFaqVO board = new BoardFaqVO();
    	board.setSeq(set.getCondiVO().getSeq());
    	board.setCompType((String)SessionUtil.getAttribute("compType"));
    	
    	//조회수를 증가 시킨다.
    	sqlSession.update("boardFaq.boardFaqViewCntUpd",board);
    	
    	set.setBoardFaq((BoardFaqVO) sqlSession.selectOne("boardFaq.boardFaqData",board));
    	
        return set ;
    }
    
	public MainSet eventList(MainSet set) throws Exception {
    	// 리스트 조회
    	BoardVO board = new BoardVO();
    	board.setFindString(set.getCondiVO().getFindString());
    	board.setPageNum(set.getCondiVO().getPageNum());
    	board.setLimitUnit(Constant.unitForBoard);
    	board.setCompCd(set.getCondiVO().getCompCd());
    	
    	List<BoardVO> list = sqlSession.selectList("mainBoardEvent.mainBoardEventList",board);
    	set.setBoardNoticeList(list);
    	
    	//페이징 처리 변수 세팅
    	set.setTotalCount(((BoardVO)sqlSession.selectOne("mainBoardEvent.mainBoardEventTotal",board)).getCnt());
    	set.setPageUnit(Constant.unitForBoard);
    	
        return set ;
    }

    public MainSet eventV(MainSet set) throws Exception {
    	// 상세조회
    	BoardVO board = new BoardVO();
    	board.setSeq(set.getCondiVO().getSeq());

    	//조회수를 증가 시킨다.
    	sqlSession.update("mainBoardEvent.mainBoardEventViewCntUpd",board);
    	
    	set.setBoardNotice((BoardVO) sqlSession.selectOne("mainBoardEvent.mainBoardEventData",board));
    	
        return set ;
    }

    @Transactional(propagation=Propagation.REQUIRED, rollbackFor={Throwable.class})
    public MainSet companyInquiry(MainSet set) throws Exception {
		sqlSession.insert("main.companyInquiryInsert", set.getCondiVO());
    	
    	//자료실 게시판 추가된 id를 구한다.
    	String lastId = (String)sqlSession.selectOne("comm.lastInsertId");
    	
    	//첨부파일 처리를 위한 VO를 만든다.
    	AttachVO attach = new AttachVO();
    	attach.setKind(Constant.attach.COMP_LEARN.name());
    	attach.setUserId(set.getCondiVO().getAttachUserId());
    	attach.setpSeq(lastId);

    	//추가한 첨부파일이 있으면 옮겨주고, 임시 테이블에서 삭제한다.
    	sqlSession.insert("attach.attachFromAttachTempIns",attach);
    	sqlSession.delete("attach.attachTempForUserDel",attach);
    	
    	set.setRtnMode(Constant.mode.OK.name());

    	return set;
    }

    @Transactional(propagation=Propagation.REQUIRED, rollbackFor={Throwable.class})
    public MainSet tutorInquiry(MainSet set) throws Exception {
		sqlSession.insert("main.tutorInquiryInsert", set.getCondiVO());
		
    	//자료실 게시판 추가된 id를 구한다.
    	String lastId = (String)sqlSession.selectOne("comm.lastInsertId");
    	
    	//첨부파일 처리를 위한 VO를 만든다.
    	AttachVO attach = new AttachVO();
    	attach.setKind(Constant.attach.TUTOR_SUPP.name());
    	attach.setUserId(set.getCondiVO().getAttachUserId());
    	attach.setpSeq(lastId);

    	//추가한 첨부파일이 있으면 옮겨주고, 임시 테이블에서 삭제한다.
    	sqlSession.insert("attach.attachFromAttachTempIns",attach);
    	sqlSession.delete("attach.attachTempForUserDel",attach);

    	set.setRtnMode(Constant.mode.OK.name());

    	return set;
    }
    
    @Transactional(propagation=Propagation.REQUIRED, rollbackFor={Throwable.class})
    public MainSet interestAdd(MainSet set) throws Exception {
    	set.getCondiVO().setUserId(SessionUtil.getSessionUserId());
    	
    	sqlSession.insert("main.interestCourseInsert", set.getCondiVO());
    	
    	set.setRtnMode(Constant.mode.OK.name());

    	return set;
    }
    
    @Transactional(propagation=Propagation.REQUIRED, rollbackFor={Throwable.class})
    public MainSet interestDelete(MainSet set) throws Exception {
    	set.getCondiVO().setUserId(SessionUtil.getSessionUserId());
    	
    	sqlSession.delete("main.interestCourseDelete", set.getCondiVO());
    	
    	set.setRtnMode(Constant.mode.OK.name());

    	return set;
    }
}
