package com.qp.lms.course.service;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.qp.lms.course.model.CourseCodeSet;
import com.qp.lms.course.model.CourseCodeVO;
import com.qp.lms.common.CodeVO;
import com.qp.lms.common.Constant;
import com.qp.lms.common.SessionUtil;
import com.qp.lms.common.service.DdService;

@Service
public class CourseCodeService {
	
	@Autowired
	private SqlSession sqlSession;
	
	@Autowired
	private DdService ddService;
	
	public CourseCodeSet getCourseCode(CourseCodeSet set) throws Exception {
		// 카테고리 대분류 
    	set.setDdCategory1Depth(ddService.getDdCategory1Depth());
    	
    	// 카테고리 중분류 
    	if ( set.getCondiVO().getC1Code() != null )
    		set.setDdCategory2Depth(ddService.getDdCategory2Depth(set.getCondiVO().getC1Code()));
    	
    	// 카테고리 소분류 
    	if ( set.getCondiVO().getC2Code() != null )
    	set.setDdCategory3Depth(ddService.getDdCategory3Depth(set.getCondiVO().getC2Code()));
    		
    	//쿼리에서 가져올 갯수 지정
    	set.getCondiVO().setLimitUnit(Constant.unitPerPage);

    	List<CourseCodeVO> list = sqlSession.selectList("courseCode.courseCodeList",set.getCondiVO());
    	set.setList(list);
        
    	//페이징 처리 변수 세팅
    	set.setTotalCount(((CourseCodeVO)sqlSession.selectOne("courseCode.courseCodeListTotal",set.getCondiVO())).getCnt());
    	set.setPageUnit(Constant.unitPerPage);
    	
    	return set;
    }
	
    public CourseCodeSet courseCodeN(CourseCodeSet set) throws Exception {
    	// 카테고리 대분류 
    	set.setDdCategory1Depth(ddService.getDdCategory1Depth());
        
    	// 강사 
    	set.setDdTeacher(ddService.getDdTeacher());
    	
    	// 설문 
    	set.setDdQuestGroup(ddService.getDdQuestGroup());
    	
    	return set;
    }
    
    public CourseCodeSet courseCodeV(CourseCodeSet set) throws Exception {
    	set.setData((CourseCodeVO) sqlSession.selectOne("courseCode.courseCodeData",set.getCondiVO()));
        
    	// 강사 
    	set.setDdTeacher(ddService.getDdTeacher());
    	
    	return set;
    }

    public CourseCodeSet courseCodeU(CourseCodeSet set) throws Exception {
    	set.setData((CourseCodeVO) sqlSession.selectOne("courseCode.courseCodeData",set.getCondiVO()));
        
    	// 강사 
    	set.setDdTeacher(ddService.getDdTeacher());
    	
    	// 설문 
    	set.setDdQuestGroup(ddService.getDdQuestGroup());
    	
    	return set;
    }
    
    
    
    
	

    ///////////////////////////////////////////////// Transaction ////////////////////////////////////////////////////
    @Transactional(propagation=Propagation.REQUIRED, rollbackFor={Throwable.class})
    public CourseCodeSet courseCodeNIns(CourseCodeSet set) throws Exception {
    	set.getCondiVO().setCreateUser(SessionUtil.getSessionUserId());
    	
		CourseCodeVO vo = (CourseCodeVO)sqlSession.selectOne("courseCode.isExistCourseCode",set.getCondiVO());
		if ( vo.getCnt() == 1 ) {
			set.setRtnMode(Constant.mode.EXIST.name());
			return set;
		} else {
			sqlSession.insert("courseCode.courseCodeInsert",set.getCondiVO());
			
			set.setRtnMode(Constant.mode.INSERT_OK.name());
		}
		
    	return set;
    }

    @Transactional(propagation=Propagation.REQUIRED, rollbackFor={Throwable.class})
    public CourseCodeSet courseCodeUUpd(CourseCodeSet set) throws Exception {
    	set.getCondiVO().setUpdateUser(SessionUtil.getSessionUserId());
    	
       	sqlSession.update("courseCode.courseCodeUpdate",set.getCondiVO());
    	
		set.setRtnMode(Constant.mode.UPDATE_OK.name());

    	return set;
    }
	
    @Transactional(propagation=Propagation.REQUIRED, rollbackFor={Throwable.class})
    public CourseCodeSet courseCodeUDel(CourseCodeSet set) throws Exception {
    	set.getCondiVO().setCreateUser(SessionUtil.getSessionUserId());
    	
		CourseCodeVO vo = (CourseCodeVO)sqlSession.selectOne("courseCode.courseCnt",set.getCondiVO());
		if ( vo.getCnt() > 0 ) {
			set.setRtnMode(Constant.mode.SUB_EXIST.name());
			return set;
		}
		
    	sqlSession.delete("courseCode.courseCodeDelete",set.getCondiVO());
    	sqlSession.delete("courseCode.courseResourceDelete",set.getCondiVO());
    	sqlSession.delete("courseCode.courseMasterDelete",set.getCondiVO());

		set.setRtnMode(Constant.mode.DELETE_OK.name());

    	return set;
    }

}
