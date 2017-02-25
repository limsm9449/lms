package com.qp.lms.course.service;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.qp.lms.common.CodeVO;
import com.qp.lms.common.Constant;
import com.qp.lms.common.SessionUtil;
import com.qp.lms.common.service.DdService;
import com.qp.lms.course.model.CourseMasterSet;
import com.qp.lms.course.model.CourseMasterVO;
import com.qp.lms.course.model.CourseResourceVO;

@Service
public class CourseMasterService {
	@Autowired
	private SqlSession sqlSession;

	@Autowired
	private DdService ddService;

    public CourseMasterSet courseMasterList(CourseMasterSet set) throws Exception {
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

    	List<CourseMasterVO> list = sqlSession.selectList("courseMaster.courseMasterList",set.getCondiVO());
    	set.setList(list);
    	
    	//페이징 처리 변수 세팅
    	set.setTotalCount(((CourseMasterVO)sqlSession.selectOne("courseMaster.courseMasterTotal",set.getCondiVO())).getCnt());
    	set.setPageUnit(Constant.unitPerPage);
    	
    	return set;
    }
    
    public CourseMasterSet courseMasterN(CourseMasterSet set) throws Exception {
    	//추가할 과정
    	List<CodeVO> courseList = sqlSession.selectList("courseMaster.ddCourseCodeNotInput");
    	set.setDdCourseCode(courseList);

        //차시별 비용
   		if ( "Y".equals(set.getCondiVO().getWeekCostYn()) ) {
	    	List<CourseMasterVO> weekCostList = sqlSession.selectList("courseMaster.weekCostList", set.getCondiVO());
	    	set.setWeekCostList(weekCostList);
   		}
   		
    	//튜터
    	List<CodeVO> tutorList = sqlSession.selectList("comm.ddTutor");
    	set.setDdTutor(tutorList);
    	
    	//과정 비용 유형
    	set.setDdWeekCost(ddService.getDdCodeKeyDdMain("WEEK_COST_YN"));
    	
    	return set;
    }
    
    public CourseMasterSet courseMasterV(CourseMasterSet set) throws Exception {
        set.setData((CourseMasterVO)sqlSession.selectOne("courseMaster.courseMasterData",set.getCondiVO()));

        //차시별 비용
   		if ( "Y".equals(set.getData().getWeekCostYn()) ) {
	    	List<CourseMasterVO> weekCostList = sqlSession.selectList("courseMaster.weekCostList", set.getCondiVO());
	    	set.setWeekCostList(weekCostList);
   		}
   		
    	return set;
    }

    public CourseMasterSet courseMasterU(CourseMasterSet set) throws Exception {
        set.setData((CourseMasterVO)sqlSession.selectOne("courseMaster.courseMasterData",set.getCondiVO()));

        //차시별 비용
   		if ( "Y".equals(set.getData().getWeekCostYn()) ) {
	    	List<CourseMasterVO> weekCostList = sqlSession.selectList("courseMaster.weekCostList", set.getCondiVO());
	    	set.setWeekCostList(weekCostList);
   		}
   		
        //튜터
        List<CodeVO> tutorList = sqlSession.selectList("comm.ddTutor");
    	set.setDdTutor(tutorList);

    	return set;
    }


    
    
    ///////////////////////////////////////////////// Transaction ////////////////////////////////////////////////////
    
    @Transactional(propagation=Propagation.REQUIRED, rollbackFor={Throwable.class})
    public CourseMasterSet courseMasterNIns(CourseMasterSet set) throws Exception {
    	set.getCondiVO().setCreateUser(SessionUtil.getSessionUserId());
    	
   		sqlSession.insert("courseMaster.courseMasterIns",set.getCondiVO());

   		//차수별 비용 저장
   		if ( "Y".equals(set.getCondiVO().getWeekCostYn()) ) {
	   		CourseMasterVO saveVO = new CourseMasterVO();
			saveVO.setCourseCode(set.getCondiVO().getCourseCode());
			for ( int i = 0; i < set.getCondiVO().getWeeks().length; i++ ) {
				saveVO.setWeek(set.getCondiVO().getWeeks()[i]);
				saveVO.setWeekCost(set.getCondiVO().getWeekCosts()[i]);
				
				sqlSession.insert("courseMaster.weekCostUpd",saveVO);
			}
   		}
   			
    	set.setRtnMode(Constant.mode.INSERT_OK.name());
    	
    	return set;
    }

    @Transactional(propagation=Propagation.REQUIRED, rollbackFor={Throwable.class})
    public CourseMasterSet courseMasterUUpd(CourseMasterSet set) throws Exception {
    	set.getCondiVO().setCreateUser(SessionUtil.getSessionUserId());
    	set.getCondiVO().setUpdateUser(set.getCondiVO().getCreateUser());
    	
   		sqlSession.update("courseMaster.courseMasterUpd",set.getCondiVO());
    	
   		//차수별 비용 저장
   		if ( "Y".equals(set.getCondiVO().getWeekCostYn()) ) {
	   		CourseMasterVO saveVO = new CourseMasterVO();
			saveVO.setCourseCode(set.getCondiVO().getCourseCode());
			for ( int i = 0; i < set.getCondiVO().getWeeks().length; i++ ) {
				saveVO.setWeek(set.getCondiVO().getWeeks()[i]);
				saveVO.setWeekCost(set.getCondiVO().getWeekCosts()[i]);
				
				sqlSession.insert("courseMaster.weekCostUpd",saveVO);
			}
   		}
   		
    	set.setRtnMode(Constant.mode.UPDATE_OK.name());
    	
    	return set;
    }

    @Transactional(propagation=Propagation.REQUIRED, rollbackFor={Throwable.class})
    public CourseMasterSet courseMasterDel(CourseMasterSet set) throws Exception {
    	set.getCondiVO().setCreateUser(SessionUtil.getSessionUserId());
    	
       	sqlSession.delete("courseMaster.courseMasterDel",set.getCondiVO());

       	sqlSession.update("courseMaster.weekCostAllUpd",set.getCondiVO());

    	set.setRtnMode(Constant.mode.DELETE_OK.name());
        
    	return set;
    }

}
