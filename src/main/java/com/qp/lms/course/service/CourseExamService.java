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
import com.qp.lms.common.service.CommService;
import com.qp.lms.common.service.DdService;
import com.qp.lms.course.model.CourseExamSet;
import com.qp.lms.course.model.CourseExamVO;

@Service
public class CourseExamService {
	@Autowired
	private SqlSession sqlSession;

	@Autowired
	private DdService ddService;

	@Autowired
	private CommService commService;

    public CourseExamSet courseExamList(CourseExamSet set) throws Exception {
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

    	List<CourseExamVO> list = sqlSession.selectList("courseExam.courseExamList",set.getCondiVO());
    	set.setList(list);
    	
    	//페이징 처리 변수 세팅
    	set.setTotalCount(((CourseExamVO)sqlSession.selectOne("courseExam.courseExamTotal",set.getCondiVO())).getCnt());
    	set.setPageUnit(Constant.unitPerPage);
    	
    	return set;
    }
    
    @SuppressWarnings("unchecked") 
    public CourseExamSet courseExamN(CourseExamSet set) throws Exception {
    	List<CodeVO> list =  sqlSession.selectList("courseExam.ddCourseCodeNotInput");
    	set.setDdCourseCode(list);
        
    	return set;
    }
    
    
    public CourseExamSet courseExamV(CourseExamSet set) throws Exception {
    	//주차별 제목을 가져온다.
    	List<CourseExamVO> examList = sqlSession.selectList("courseExam.courseExamDataList",set.getCondiVO());
    	set.setExamList(examList);
    	
    	//카테고리, 과정명을 가져온다.
        set.setData((CourseExamVO)sqlSession.selectOne("courseExam.courseCodeInfo",set.getCondiVO().getCourseCode()));
        
    	return set;
    }
    
    public CourseExamSet courseExamU(CourseExamSet set) throws Exception {
    	//주차별 제목을 가져온다.
    	List<CourseExamVO> examList = sqlSession.selectList("courseExam.courseExamDataList",set.getCondiVO());
    	set.setExamList(examList);
    	
    	//카테고리, 과정명을 가져온다.
        set.setData((CourseExamVO)sqlSession.selectOne("courseExam.courseCodeInfo",set.getCondiVO().getCourseCode()));
        
    	return set;
    }
    

    
    
    ///////////////////////////////////////////////// Transaction ////////////////////////////////////////////////////
    @Transactional(propagation=Propagation.REQUIRED, rollbackFor={Throwable.class})
    public CourseExamSet courseExamNIns(CourseExamSet set) throws Exception {
    	set.getCondiVO().setCreateUser(SessionUtil.getSessionUserId());
    	set.getCondiVO().setUpdateUser(set.getCondiVO().getCreateUser());
    	
		CourseExamVO vo = (CourseExamVO)sqlSession.selectOne("courseExam.isExistCourseExam",set.getCondiVO());
		if ( vo.getCnt() == 1 ) {
			set.setRtnMode(Constant.mode.EXIST.name());
			return set;
		}
		
		CourseExamVO saveVO = new CourseExamVO();
		saveVO.setCourseCode(set.getCondiVO().getCourseCode());
		saveVO.setCreateUser(set.getCondiVO().getCreateUser());
		for ( int i = 0; i < set.getCondiVO().getSeqs().length; i++ ) {
			saveVO.setSeq(set.getCondiVO().getSeqs()[i]);
			saveVO.setType(set.getCondiVO().getTypes()[i]);
			saveVO.setQuestion(set.getCondiVO().getQuestions()[i]);
			saveVO.setQa1(set.getCondiVO().getQa1s()[i]);
			saveVO.setQa2(set.getCondiVO().getQa2s()[i]);
			saveVO.setQa3(set.getCondiVO().getQa3s()[i]);
			saveVO.setQa4(set.getCondiVO().getQa4s()[i]);
			saveVO.setAnswer(set.getCondiVO().getAnswers()[i]);
			saveVO.setGrade(set.getCondiVO().getGrades()[i]);
			
			sqlSession.insert("courseExam.courseExamInsert",saveVO);
		}
    	
		set.setRtnMode(Constant.mode.INSERT_OK.name());
    	
		return set;
    }


    @Transactional(propagation=Propagation.REQUIRED, rollbackFor={Throwable.class})
    public CourseExamSet courseExamUUpd(CourseExamSet set) throws Exception {
    	set.getCondiVO().setCreateUser(SessionUtil.getSessionUserId());
    	
    	//기존거를 삭제한다.
    	sqlSession.delete("courseExam.courseExamDelete",set.getCondiVO());

    	CourseExamVO saveVO = new CourseExamVO();
		saveVO.setCourseCode(set.getCondiVO().getCourseCode());
		saveVO.setUpdateUser(set.getCondiVO().getUpdateUser());
		for ( int i = 0; i < set.getCondiVO().getSeqs().length; i++ ) {
			saveVO.setSeq(set.getCondiVO().getSeqs()[i]);
			saveVO.setType(set.getCondiVO().getTypes()[i]);
			saveVO.setQuestion(set.getCondiVO().getQuestions()[i]);
			saveVO.setQa1(set.getCondiVO().getQa1s()[i]);
			saveVO.setQa2(set.getCondiVO().getQa2s()[i]);
			saveVO.setQa3(set.getCondiVO().getQa3s()[i]);
			saveVO.setQa4(set.getCondiVO().getQa4s()[i]);
			saveVO.setAnswer(set.getCondiVO().getAnswers()[i]);
			saveVO.setGrade(set.getCondiVO().getGrades()[i]);
			
			sqlSession.insert("courseExam.courseExamInsert",saveVO);
		}

		set.setRtnMode(Constant.mode.UPDATE_OK.name());
    	
    	return set;
    }

    
    
}
