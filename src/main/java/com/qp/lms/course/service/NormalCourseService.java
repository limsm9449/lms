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
import com.qp.lms.course.model.CourseMasterVO;
import com.qp.lms.course.model.NormalCourseSet;
import com.qp.lms.course.model.NormalCourseVO;

@Service
public class NormalCourseService {
	@Autowired
	private SqlSession sqlSession;

	@Autowired
	private DdService ddService;

    public NormalCourseSet normalCourseList(NormalCourseSet set) throws Exception {
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

    	//쿼리에서 가져올 갯수 지정
    	set.getCondiVO().setLimitUnit(Constant.unitPerPage);

    	List<NormalCourseVO> list = sqlSession.selectList("normalCourse.normalCourseList",set.getCondiVO());
    	set.setList(list);
    	
    	//페이징 처리 변수 세팅
    	set.setTotalCount(((NormalCourseVO)sqlSession.selectOne("normalCourse.normalCourseTotal",set.getCondiVO())).getCnt());
    	set.setPageUnit(Constant.unitPerPage);
    	
    	return set;
    }
    
    public NormalCourseSet normalCourseN(NormalCourseSet set) throws Exception {
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
    	set.setDdCourseCode(ddService.getDdCourseCodeForUse(set.getCondiVO().getC3Code()));
    	
    	// 튜터
    	set.setDdTutor(ddService.getDdTutor());

        //차시별 제목 및 비용
    	List<NormalCourseVO> weekCostList = sqlSession.selectList("normalCourse.weekCostList", set.getCondiVO());
    	set.setWeekCostList(weekCostList);

    	// 과정코드에 대한 과정 Master 데이타
    	CourseMasterVO cmVO = new CourseMasterVO();
    	cmVO.setCourseCode(set.getCondiVO().getCourseCode());
    	set.setCmData((CourseMasterVO) sqlSession.selectOne("courseMaster.courseMasterData",cmVO));

    	return set;
    }
    
    public NormalCourseSet normalCourseV(NormalCourseSet set) throws Exception {
    	set.setData((NormalCourseVO) sqlSession.selectOne("normalCourse.courseData",set.getCondiVO()));

        //차시별 제목 및 비용
   		if ( "Y".equals(set.getData().getWeekCostYn()) ) {
	    	List<NormalCourseVO> list = sqlSession.selectList("normalCourse.titleList",set.getCondiVO());
	    	set.setWeekCostList(list);
   		}
   		
    	return set;
    }
    
    public NormalCourseSet normalCourseU(NormalCourseSet set) throws Exception {
    	set.setData((NormalCourseVO) sqlSession.selectOne("normalCourse.courseData",set.getCondiVO()));

        //차시별 제목 및 비용
   		if ( "Y".equals(set.getData().getWeekCostYn()) ) {
	    	List<NormalCourseVO> list = sqlSession.selectList("normalCourse.titleList",set.getCondiVO());
	    	set.setWeekCostList(list);
   		}
   		
    	// 튜터
    	set.setDdTutor(ddService.getDdTutor());

    	return set;
    }
    
    
    
    
    ///////////////////////////////////////////////// Transaction ////////////////////////////////////////////////////
    
    @Transactional(propagation=Propagation.REQUIRED, rollbackFor={Throwable.class})
    public NormalCourseSet normalCourseNIns(NormalCourseSet set) throws Exception {
    	set.getCondiVO().setCreateUser(SessionUtil.getSessionUserId());
    	
   		sqlSession.insert("normalCourse.normalCourseIns",set.getCondiVO());
    	
    	String lastId = (String)sqlSession.selectOne("comm.lastInsertId");

   		//차수별 비용 저장
   		if ( "Y".equals(set.getCondiVO().getWeekCostYn()) ) {
	   		NormalCourseVO saveVO = new NormalCourseVO();
			saveVO.setCourseId(lastId);
			for ( int i = 0; i < set.getCondiVO().getWeeks().length; i++ ) {
				saveVO.setWeek(set.getCondiVO().getWeeks()[i]);
				saveVO.setWeekCost(set.getCondiVO().getWeekCosts()[i]);
				
				sqlSession.insert("normalCourse.courseWeekCostIns",saveVO);
			}
   		}
		
   		set.setRtnMode(Constant.mode.INSERT_OK.name());
   		
    	return set;
    }
    
    @Transactional(propagation=Propagation.REQUIRED, rollbackFor={Throwable.class})
    public NormalCourseSet normalCourseUUpd(NormalCourseSet set) throws Exception {
    	set.getCondiVO().setUpdateUser(SessionUtil.getSessionUserId());
    	
   		sqlSession.update("normalCourse.normalCourseUpd",set.getCondiVO());

   		//차수별 비용 저장
   		if ( "Y".equals(set.getCondiVO().getWeekCostYn()) ) {
	   		NormalCourseVO saveVO = new NormalCourseVO();
			saveVO.setCourseId(set.getCondiVO().getCourseId());
			for ( int i = 0; i < set.getCondiVO().getWeeks().length; i++ ) {
				saveVO.setWeek(set.getCondiVO().getWeeks()[i]);
				saveVO.setWeekCost(set.getCondiVO().getWeekCosts()[i]);
				
				sqlSession.insert("normalCourse.courseWeekCostUpd",saveVO);
			}
   		}
   		
   		set.setRtnMode(Constant.mode.UPDATE_OK.name());
   		
    	return set;
    }
    
    @Transactional(propagation=Propagation.REQUIRED, rollbackFor={Throwable.class})
    public NormalCourseSet normalCourseDel(NormalCourseSet set) throws Exception {
   		sqlSession.update("normalCourse.normalCourseDel",set.getCondiVO());

   		sqlSession.update("normalCourse.courseWeekCostDel",set.getCondiVO());

   		set.setRtnMode(Constant.mode.DELETE_OK.name());
   		
    	return set;
    }

    public NormalCourseSet popularCourseList(NormalCourseSet set) throws Exception {
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

    	//쿼리에서 가져올 갯수 지정
    	set.getCondiVO().setLimitUnit(Constant.unitPerPage);

    	List<NormalCourseVO> list = sqlSession.selectList("normalCourse.popularCourseList",set.getCondiVO());
    	set.setPopularList(list);
    	
    	//페이징 처리 변수 세팅
    	set.setTotalCount(((NormalCourseVO)sqlSession.selectOne("normalCourse.popularCourseTotal",set.getCondiVO())).getCnt());
    	set.setPageUnit(Constant.unitPerPage);
    	
    	return set;
    }

    @Transactional(propagation=Propagation.REQUIRED, rollbackFor={Throwable.class})
    public NormalCourseSet popularCourseAdd(NormalCourseSet set) throws Exception {
   		sqlSession.update("normalCourse.popularCourseAdd",set.getCondiVO());

   		set.setRtnMode(Constant.mode.OK.name());
   		
    	return set;
    }

    @Transactional(propagation=Propagation.REQUIRED, rollbackFor={Throwable.class})
    public NormalCourseSet popularCourseRemove(NormalCourseSet set) throws Exception {
   		sqlSession.update("normalCourse.popularCourseRemove",set.getCondiVO());

   		set.setRtnMode(Constant.mode.OK.name());
   		
    	return set;
    }

    
}
