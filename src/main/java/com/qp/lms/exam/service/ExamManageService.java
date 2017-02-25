package com.qp.lms.exam.service;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.qp.lms.common.CommUtil;
import com.qp.lms.common.Constant;
import com.qp.lms.common.SessionUtil;
import com.qp.lms.common.service.DdService;
import com.qp.lms.course.model.NormalCourseVO;
import com.qp.lms.exam.model.ExamSet;
import com.qp.lms.exam.model.ExamVO;

@Service
public class ExamManageService {
	@Autowired
	private SqlSession sqlSession;

	@Autowired
	private DdService ddService;
	
    public ExamSet examManageList(ExamSet set) throws Exception {
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

    	List<ExamVO> list = sqlSession.selectList("exam.examManageList",set.getCondiVO());
    	set.setList(list);
    	
    	//페이징 처리 변수 세팅
    	set.setTotalCount(((ExamVO)sqlSession.selectOne("exam.examManageTotal",set.getCondiVO())).getCnt());
    	set.setPageUnit(Constant.unitPerPage);
    	
    	return set;
    
    }

    public ExamSet examUserManageList(ExamSet set) throws Exception {
    	//쿼리에서 가져올 갯수 지정
    	set.getCondiVO().setLimitUnit(Constant.unitPerPage);

    	List<ExamVO> list = sqlSession.selectList("exam.examUserManageList",set.getCondiVO());
    	set.setUserList(list);
    	
    	//페이징 처리 변수 세팅
    	set.setTotalCount(((ExamVO)sqlSession.selectOne("exam.examUserManageTotal",set.getCondiVO())).getCnt());
    	set.setPageUnit(Constant.unitPerPage);
    	
    	return set;
    
    }

    public ExamSet examUserManageV(ExamSet set) throws Exception {
    	List<ExamVO> userDetailList = sqlSession.selectList("exam.examUserDetail",set.getCondiVO());
    	set.setUserDetailList(userDetailList);
    	
    	return set;
    
    }
    
}
