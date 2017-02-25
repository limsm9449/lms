package com.qp.lms.course.service;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.qp.lms.common.Constant;
import com.qp.lms.common.SessionUtil;
import com.qp.lms.common.service.DdService;
import com.qp.lms.course.model.CourseManageSet;
import com.qp.lms.course.model.CourseManageVO;
import com.qp.lms.course.model.CourseMasterVO;
import com.qp.lms.course.model.RegisterVO;

@Service
public class CourseManageService {
	@Autowired
	private SqlSession sqlSession;

	@Autowired
	private DdService ddService;

    public CourseManageSet courseManageList(CourseManageSet set) throws Exception {
    	// 카테고리 대분류 
    	set.setDdCategory1Depth(ddService.getDdCategory1Depth());
    	
    	// 카테고리 중분류 
    	if ( set.getCondiVO().getC1Code() != null )
    		set.setDdCategory2Depth(ddService.getDdCategory2Depth(set.getCondiVO().getC1Code()));
    	
    	// 카테고리 소분류 
    	if ( set.getCondiVO().getC2Code() != null )
    	set.setDdCategory3Depth(ddService.getDdCategory3Depth(set.getCondiVO().getC2Code()));

    	// 과정코드 
    	if ( set.getCondiVO().getC3Code() != null )
    	set.setDdCourseCode(ddService.getDdCourseCode(set.getCondiVO().getC3Code()));

    	set.setDdStatus(ddService.getDdCode("COURSE_STATUS"));

    	//쿼리에서 가져올 갯수 지정
    	set.getCondiVO().setLimitUnit(Constant.unitPerPage);

    	List<CourseManageVO> list = sqlSession.selectList("courseManage.courseManageList",set.getCondiVO());
    	set.setList(list);
    	
    	//페이징 처리 변수 세팅
    	set.setTotalCount(((CourseManageVO)sqlSession.selectOne("courseManage.courseManageTotal",set.getCondiVO())).getCnt());
    	set.setPageUnit(Constant.unitPerPage);
    	
    	return set;
    }
    
    public CourseManageSet courseManageN(CourseManageSet set) throws Exception {
    	// 카테고리 대분류 
    	set.setDdCategory1Depth(ddService.getDdCategory1Depth());

    	// 카테고리 중분류 
    	if ( set.getCondiVO().getC1Code() != null )
    		set.setDdCategory2Depth(ddService.getDdCategory2Depth(set.getCondiVO().getC1Code()));
    	
    	// 카테고리 소분류 
    	if ( set.getCondiVO().getC2Code() != null )
    	set.setDdCategory3Depth(ddService.getDdCategory3Depth(set.getCondiVO().getC2Code()));

    	// 과정코드 
    	if ( set.getCondiVO().getC3Code() != null )
    	set.setDdCourseCode(ddService.getDdCourseCode(set.getCondiVO().getC3Code()));
    	
    	// 튜터
    	set.setDdTutor(ddService.getDdTutor());

    	// 과정코드에 대한 과정 Master 데이타
    	CourseMasterVO cmVO = new CourseMasterVO();
    	cmVO.setCourseCode(set.getCondiVO().getCourseCode());
    	set.setCmData((CourseMasterVO) sqlSession.selectOne("courseMaster.courseMasterData",cmVO));

    	return set;
    }
    
    public CourseManageSet courseManageV(CourseManageSet set) throws Exception {
    	set.setData((CourseManageVO) sqlSession.selectOne("courseManage.courseData",set.getCondiVO()));

    	set.setDdStatus(ddService.getDdCodeKeyDdMain("COURSE_STATUS"));
    	
    	return set;
    }
    
    public CourseManageSet courseManageU(CourseManageSet set) throws Exception {
    	set.setData((CourseManageVO) sqlSession.selectOne("courseManage.courseData",set.getCondiVO()));

    	// 튜터
    	set.setDdTutor(ddService.getDdTutor());

    	return set;
    }
    
    
    
    
    ///////////////////////////////////////////////// Transaction ////////////////////////////////////////////////////
    
    @Transactional(propagation=Propagation.REQUIRED, rollbackFor={Throwable.class})
    public CourseManageSet courseManageNIns(CourseManageSet set) throws Exception {
    	set.getCondiVO().setCreateUser(SessionUtil.getSessionUserId());
    	
   		sqlSession.update("courseManage.courseManageIns",set.getCondiVO());
    	
   		set.setRtnMode(Constant.mode.INSERT_OK.name());
   		
    	return set;
    }
    
    @Transactional(propagation=Propagation.REQUIRED, rollbackFor={Throwable.class})
    public CourseManageSet courseManageUUpd(CourseManageSet set) throws Exception {
    	set.getCondiVO().setUpdateUser(SessionUtil.getSessionUserId());
    	
   		sqlSession.update("courseManage.courseManageUpd",set.getCondiVO());
    	
   		set.setRtnMode(Constant.mode.UPDATE_OK.name());
   		
    	return set;
    }
    
    @Transactional(propagation=Propagation.REQUIRED, rollbackFor={Throwable.class})
    public CourseManageSet courseManageDel(CourseManageSet set) throws Exception {
   		sqlSession.update("courseManage.courseManageDel",set.getCondiVO());
    	
   		set.setRtnMode(Constant.mode.DELETE_OK.name());
   		
    	return set;
    }

}
