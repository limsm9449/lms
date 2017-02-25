package com.qp.lms.company.service;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.qp.lms.common.Constant;
import com.qp.lms.common.SessionUtil;
import com.qp.lms.common.service.DdService;
import com.qp.lms.company.model.CompanyCourseSet;
import com.qp.lms.company.model.CompanyCourseSet;
import com.qp.lms.company.model.CompanyCourseVO;
import com.qp.lms.course.model.CourseMasterVO;
import com.qp.lms.course.model.NormalCourseVO;
import com.qp.lms.course.model.RegisterVO;

@Service
public class CompanyCourseService {
	@Autowired
	private SqlSession sqlSession;

	@Autowired
	private DdService ddService;

    public CompanyCourseSet courseList(CompanyCourseSet set) throws Exception {
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

    	List<CompanyCourseVO> list = sqlSession.selectList("companyCourse.companyCourseList",set.getCondiVO());
    	set.setList(list);
    	
    	//페이징 처리 변수 세팅
    	set.setTotalCount(((CompanyCourseVO)sqlSession.selectOne("companyCourse.companyCourseTotal",set.getCondiVO())).getCnt());
    	set.setPageUnit(Constant.unitPerPage);
    	
    	return set;
    }
    
    public CompanyCourseSet courseN(CompanyCourseSet set) throws Exception {
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
    	
    	// 회사
    	set.setDdCompany(ddService.getDdCompany());

        //차시별 제목 및 비용
    	List<CompanyCourseVO> weekCostList = sqlSession.selectList("courseMaster.weekCostList", set.getCondiVO());
    	set.setWeekCostList(weekCostList);

    	// 과정코드에 대한 과정 Master 데이타
    	CourseMasterVO cmVO = new CourseMasterVO();
    	cmVO.setCourseCode(set.getCondiVO().getCourseCode());
    	set.setCmData((CourseMasterVO) sqlSession.selectOne("courseMaster.courseMasterData",cmVO));

    	return set;
    }
    
    public CompanyCourseSet courseV(CompanyCourseSet set) throws Exception {
    	set.setData((CompanyCourseVO) sqlSession.selectOne("companyCourse.companyCourseData",set.getCondiVO()));

    	List<CompanyCourseVO> list = sqlSession.selectList("companyCourse.titleList",set.getCondiVO());
    	set.setTitleList(list);

    	set.setDdStatus(ddService.getDdCodeKeyDdMain("COURSE_STATUS"));

    	//차시별 제목 및 비용
   		if ( "Y".equals(set.getData().getWeekCostYn()) ) {
	    	List<CompanyCourseVO> titleList = sqlSession.selectList("normalCourse.titleList",set.getCondiVO());
	    	set.setWeekCostList(titleList);
   		}
    	
    	//수강생 리스트
    	List<RegisterVO> registerList = sqlSession.selectList("companyCourse.registerList",set.getCondiVO());
    	set.setRegisterList(registerList);
    	
    	return set;
    }
    
    public CompanyCourseSet courseU(CompanyCourseSet set) throws Exception {
    	set.setData((CompanyCourseVO) sqlSession.selectOne("companyCourse.companyCourseData",set.getCondiVO()));

    	// 회사
    	set.setDdCompany(ddService.getDdCompany());

    	//차시별 제목 및 비용
   		if ( "Y".equals(set.getData().getWeekCostYn()) ) {
	    	List<CompanyCourseVO> titleList = sqlSession.selectList("normalCourse.titleList",set.getCondiVO());
	    	set.setWeekCostList(titleList);
   		}
    	
    	return set;
    }
    
    
    
    
    ///////////////////////////////////////////////// Transaction ////////////////////////////////////////////////////
    
    @Transactional(propagation=Propagation.REQUIRED, rollbackFor={Throwable.class})
    public CompanyCourseSet courseNIns(CompanyCourseSet set) throws Exception {
    	set.getCondiVO().setCreateUser(SessionUtil.getSessionUserId());
    	
   		sqlSession.update("companyCourse.companyCourseIns",set.getCondiVO());
   		
   		String lastId = (String)sqlSession.selectOne("comm.lastInsertId");

   		//차수별 비용 저장
   		if ( "Y".equals(set.getCondiVO().getWeekCostYn()) ) {
	   		NormalCourseVO saveVO = new NormalCourseVO();
			saveVO.setCourseId(lastId);
			for ( int i = 0; i < set.getCondiVO().getWeeks().length; i++ ) {
				saveVO.setWeek(set.getCondiVO().getWeeks()[i]);
				saveVO.setWeekCost(set.getCondiVO().getWeekCosts()[i]);
				
				sqlSession.insert("companyCourse.courseWeekCostIns",saveVO);
			}
   		}

   		set.setRtnMode(Constant.mode.INSERT_OK.name());
   		
    	return set;
    }
    
    @Transactional(propagation=Propagation.REQUIRED, rollbackFor={Throwable.class})
    public CompanyCourseSet courseUUpd(CompanyCourseSet set) throws Exception {
    	set.getCondiVO().setUpdateUser(SessionUtil.getSessionUserId());
    	
   		sqlSession.update("companyCourse.companyCourseUpd",set.getCondiVO());

  		//차수별 비용 저장
   		if ( "Y".equals(set.getCondiVO().getWeekCostYn()) ) {
	   		NormalCourseVO saveVO = new NormalCourseVO();
			saveVO.setCourseId(set.getCondiVO().getCourseId());
			for ( int i = 0; i < set.getCondiVO().getWeeks().length; i++ ) {
				saveVO.setWeek(set.getCondiVO().getWeeks()[i]);
				saveVO.setWeekCost(set.getCondiVO().getWeekCosts()[i]);
				
				sqlSession.insert("companyCourse.courseWeekCostUpd",saveVO);
			}
   		}
   		
   		set.setRtnMode(Constant.mode.UPDATE_OK.name());
   		
    	return set;
    }
    
    @Transactional(propagation=Propagation.REQUIRED, rollbackFor={Throwable.class})
    public CompanyCourseSet courseDel(CompanyCourseSet set) throws Exception {
   		sqlSession.update("companyCourse.comPanyCourseDel",set.getCondiVO());

   		sqlSession.update("companyCourse.courseWeekCostDel",set.getCondiVO());
   		
   		set.setRtnMode(Constant.mode.DELETE_OK.name());
   		
    	return set;
    }

}
