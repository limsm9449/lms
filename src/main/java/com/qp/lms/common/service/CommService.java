package com.qp.lms.common.service;

import java.io.File;
import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.qp.lms.board.model.AttachVO;
import com.qp.lms.category.model.CategorySet;
import com.qp.lms.common.CodeVO;
import com.qp.lms.common.CommUtil;
import com.qp.lms.common.Constant;
import com.qp.lms.common.SessionUtil;
import com.qp.lms.common.model.CommSet;
import com.qp.lms.common.model.CommVO;
import com.qp.lms.common.model.LogVO;
import com.qp.lms.course.model.CourseVO;
import com.qp.lms.login.model.LoginVO;
import com.qp.lms.member.model.MemberVO;

@Service
public class CommService {
	@Autowired
	private SqlSession sqlSession;

	@Autowired
	private DdService ddService;

	public HashMap<String, Object> getDd(HashMap<String, Object> paramMap) throws Exception {
		HashMap<String, Object> hm = new HashMap<String, Object>();
		
		String[] ddKinds = ((String)paramMap.get("DD_KIND")).split(",");
		for ( int i = 0; i < ddKinds.length; i++ ) {
			if ( "CategoryLevel1".equals(ddKinds[i]) ) {
				List<HashMap<String, Object>> list = sqlSession.selectList("axComm.axDdCategoryLevel1", paramMap);
		    	hm.put(ddKinds[i], list);
			} else if ( "CategoryLevel2".equals(ddKinds[i]) ) {
		    	hm.put(ddKinds[i], sqlSession.selectList("axComm.axDdCategoryLevel2", paramMap));
			} else if ( "CategoryLevel3".equals(ddKinds[i]) ) {
		    	hm.put(ddKinds[i], sqlSession.selectList("axComm.axDdCategoryLevel3", paramMap));
			} else if ( "Teacher".equals(ddKinds[i]) ) {
		    	hm.put(ddKinds[i], sqlSession.selectList("axComm.axDdTeacher", paramMap));
			} else if ( "Tutor".equals(ddKinds[i]) ) {
		    	hm.put(ddKinds[i], sqlSession.selectList("axComm.axDdTutor", paramMap));
			} else if ( "QuestGroup".equals(ddKinds[i]) ) {
		    	hm.put(ddKinds[i], sqlSession.selectList("axComm.axDdQuestGroup", paramMap));
			} else if ( "CourseCode".equals(ddKinds[i]) ) {
		    	hm.put(ddKinds[i], sqlSession.selectList("axComm.axDdCourseCode", paramMap));
			} else if ( "ExamCourseCode".equals(ddKinds[i]) ) {
		    	hm.put(ddKinds[i], sqlSession.selectList("axComm.axDdExamCourseCode", paramMap));
			} else if ( "Company".equals(ddKinds[i]) ) {
		    	hm.put(ddKinds[i], sqlSession.selectList("axComm.axDdCompany", paramMap));
			} else if ( "ExamType".equals(ddKinds[i]) ) {
		    	hm.put(ddKinds[i], sqlSession.selectList("axComm.axDdExamType", paramMap));
			} else if ( "ReportCourseCode".equals(ddKinds[i]) ) {
		    	hm.put(ddKinds[i], sqlSession.selectList("axComm.axDdReportCourseCode", paramMap));
			}
		}
		
    	return hm;
    }
		
	public HashMap<String, Object> getMaxCourseCode(HashMap<String, Object> paramMap) throws Exception {
		HashMap<String, Object> hm = new HashMap<String, Object>();
		
		List<HashMap<String, Object>> list = sqlSession.selectList("axComm.axMaxCourseCode", paramMap);
    	hm.put("list", list);
		
    	return hm;
    }
		
    /**
     * 중분류 카테고리를 가져온다.
     * @param courseCode
     * @return
     * @throws Exception
     */
    public List<CodeVO> ddCategory2Depth(CategorySet set) throws Exception {
    	return ddService.getDdCategory2Depth(set.getCondiVO().getC1Code());
    }
    
    /**
     * 소분류 카테고리를 가져온다.
     * @param courseCode
     * @return
     * @throws Exception
     */
    public List<CodeVO> ddCategory3Depth(CategorySet set) throws Exception {
    	return ddService.getDdCategory3Depth(set.getCondiVO().getC2Code());
    }

    /**
     * 과정코드를 가져온다.
     * @param courseCode
     * @return
     * @throws Exception
     */
    public List<CodeVO> ddCourseCode(CategorySet set) throws Exception {
    	return ddService.getDdCourseCode(set.getCondiVO().getC3Code());
    }

    /**
     * 과정코드(사용하는)를 가져온다.
     * @param courseCode
     * @return
     * @throws Exception
     */
    public List<CodeVO> ddCourseCodeForUse(CategorySet set) throws Exception {
    	return ddService.getDdCourseCodeForUse(set.getCondiVO().getC3Code());
    }


    /**
     * 어드민 여부
     * @param userId
     * @return
     * @throws Exception
     */
    public boolean isAdmin(String userId) throws Exception {
    	CommVO comm = sqlSession.selectOne("comm.userAdminCnt", userId);
    	
    	if ( comm.getCnt() > 0 )
    		return true;
    	else
    		return false;
    }

   
    /**
     * 게시판 어드민 여부
     * @param courseId
     * @param userId
     * @return
     * @throws Exception
     */
    public String isBoardAdminYn() throws Exception {
    	String editYn = "N";
    	
    	if ( SessionUtil.isAdmin() || SessionUtil.isTeacher() || SessionUtil.isTutor() ) {
    		editYn = "Y";
    	}

    	return editYn;
    }
    
    /**
     * 게시판 생성 가능 여부
     * @param courseId
     * @param userId
     * @return
     * @throws Exception
     */
    public String isBoardInsYn(String courseId,String userId) throws Exception {
    	String editYn = "N";
    	
    	if ( SessionUtil.isAdmin() || SessionUtil.isTeacher() || SessionUtil.isTutor() ) {
    		editYn = "Y";
    	} else {
	    	if ( "0".equals(courseId) ) {
	    		editYn = "Y";
	    	} else { 
	    		CommVO condiVO =  new CommVO();
	    		condiVO.setCourseId(courseId);
	    		condiVO.setUserId(userId);
		    	CommVO comm = sqlSession.selectOne("comm.courseEditInfo", condiVO);
		    	
		    	if ( "N".equals(comm.getCompleteYn()) && "Y".equals(comm.getIsPeriod()) ) {
		    		editYn = "Y";
		    	}
		    		
	    	}
    	}

    	return editYn;
    }

    /**
     * 게시판 수정 가능 여부
     * @param courseId
     * @param userId
     * @return
     * @throws Exception
     */
    public String isBoardUpdYn(String courseId,String userId) throws Exception {
    	String editYn = "N";
    	
    	if ( SessionUtil.isAdmin() ) {
    		editYn = "Y";
    	} else {
	    	if ( "0".equals(courseId) ) {
	    		editYn = "Y";
	    	} else { 
	    		CommVO condiVO =  new CommVO();
	    		condiVO.setCourseId(courseId);
	    		condiVO.setUserId(userId);
		    	CommVO comm = sqlSession.selectOne("comm.courseEditInfo", condiVO);
		    	
		    	if ( "N".equals(comm.getCompleteYn()) && "Y".equals(comm.getIsPeriod()) ) {
		    		editYn = "Y";
		    	}
	    	}
    	}
    	
    	return editYn;
    }

    public CommSet getSubCategory(CommSet set) throws Exception {
    	List<CodeVO> list = sqlSession.selectList("comm.getDdCategory",set.getCondiVO().getParentCode());
    	set.setDdCategory(list);
        
    	return set;
    }

    /*
     * 임시로 추가된 파일들을 삭제 처리 한다.
     */
    @Transactional(propagation=Propagation.REQUIRED, rollbackFor={Throwable.class})
    public void delAttachTemp() throws Exception {
    	List<AttachVO> list = sqlSession.selectList("attach.attachTempForDeleteList");
    	
    	for ( int i = 0; i < list.size(); i++ ) {
    		//파일 삭제
    		String fullFileName = CommUtil.getFileFolder() + ((AttachVO)list.get(i)).getFilePath() + ((AttachVO)list.get(i)).getFileName();
            File f = new File(fullFileName);
            f.delete();
            
            sqlSession.delete("attach.attachTempDel",((AttachVO)list.get(i)));
    	}
    }

    /**
     * 내가 자료실 입력시 첨부만 해놓고 저장은 안한 파일들을 삭제한다.
     * @throws Exception
     */
    @Transactional(propagation=Propagation.REQUIRED, rollbackFor={Throwable.class})
    public void delAttachTempForUser() throws Exception {
		AttachVO vo = new AttachVO();
		vo.setUserId(SessionUtil.getSessionUserId());
    	List<AttachVO> list = sqlSession.selectList("attach.attachTempForUser",vo);
    	
    	for ( int i = 0; i < list.size(); i++ ) {
    		//파일 삭제
    		String fullFileName = CommUtil.getFileFolder() + ((AttachVO)list.get(i)).getFilePath() + ((AttachVO)list.get(i)).getFileName();
            File f = new File(fullFileName);
            f.delete();
    	}
        
        sqlSession.delete("attach.attachTempForUserDel",vo);
    }
    
    /**
     * 사용자 검색
     * @param set
     * @return
     * @throws Exception
     */
    public CommSet userSearchList(CommSet set) throws Exception {
    	//쿼리에서 가져올 갯수 지정
    	set.getCondiVO().setLimitUnit(Constant.unitPerPage);

    	List<MemberVO> list = sqlSession.selectList("comm.userSearchList",set.getCondiVO());
     	set.setMemberList(list);
    	
    	//페이징 처리 변수 세팅
    	set.setTotalCount(((MemberVO)sqlSession.selectOne("comm.userSearchTotal",set.getCondiVO())).getCnt());
    	set.setPageUnit(Constant.unitPerPage);

    	return set;
    }
    

    @Transactional(propagation=Propagation.REQUIRED, rollbackFor={Throwable.class})
    public void requestLog(String userId, String url, String params, String ip) throws Exception {
    	LogVO vo = new LogVO();
    	vo.setParameter(params);
    	vo.setUrl(url);
    	vo.setIp(ip);
    	vo.setUserId(userId);
    	
       	sqlSession.update("comm.requestLogIns",vo);
    }
    
    /**
     * 환경 설정 값
     * @return
     * @throws Exception
     */
    public String getSetting(String key) throws Exception {
    	return (String)sqlSession.selectOne("comm.getSetting",key);
    }
    
    /**
     * 상단 메뉴에 나올 인기과정
     * @param set
     * @return
     * @throws Exception
     */
    public List<CourseVO> getFavorityCourseList() throws Exception {
    	//인기과정
    	return  sqlSession.selectList("comm.getFavoriteCourse"); 
    } 

    public List<CourseVO> getCourseCategoryList() throws Exception {
    	return  sqlSession.selectList("main.categoryList"); 
    }
    
    @Transactional(propagation=Propagation.REQUIRED, rollbackFor={Throwable.class})
    public void lastLog(String userId) throws Exception {
    	LoginVO vo = new LoginVO();
    	vo.setUserId(userId);
    	
       	sqlSession.update("login.lastLogUpdate",vo);
    }

}
