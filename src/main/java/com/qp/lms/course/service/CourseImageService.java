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
import com.qp.lms.course.model.CourseImageSet;
import com.qp.lms.course.model.CourseImageVO;
import com.qp.lms.course.model.CourseMasterSet;
import com.qp.lms.course.model.CourseMasterVO;

@Service
public class CourseImageService {
	@Autowired
	private SqlSession sqlSession;

	@Autowired
	private DdService ddService;

    public CourseImageSet courseImageList(CourseImageSet set) throws Exception {
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

    	List<CourseImageVO> list = sqlSession.selectList("courseImage.courseImageList",set.getCondiVO());
    	set.setList(list);
    	
    	//페이징 처리 변수 세팅
    	set.setTotalCount(((CourseImageVO)sqlSession.selectOne("courseImage.courseImageTotal",set.getCondiVO())).getCnt());
    	set.setPageUnit(Constant.unitPerPage);
    	
    	return set;
    }
    
    
    public CourseImageSet courseImageV(CourseImageSet set) throws Exception {
        set.setData((CourseImageVO)sqlSession.selectOne("courseImage.courseImageData",set.getCondiVO()));

    	return set;
    }



    
    ///////////////////////////////////////////////// Transaction ////////////////////////////////////////////////////
    
    @Transactional(propagation=Propagation.REQUIRED, rollbackFor={Throwable.class})
    public CourseImageSet courseImageUpload(CourseImageSet set) throws Exception {
    	set.getCondiVO().setCreateUser(SessionUtil.getSessionUserId());
    	
		sqlSession.update("courseImage.courseImageUpd",set.getCondiVO());
   			
    	set.setRtnMode(Constant.mode.OK.name());
    	
    	return set;
    }


}
