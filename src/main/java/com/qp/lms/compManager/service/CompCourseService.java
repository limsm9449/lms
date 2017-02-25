package com.qp.lms.compManager.service;

import java.io.FileInputStream;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.ss.usermodel.WorkbookFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.qp.lms.common.Constant;
import com.qp.lms.common.SessionUtil;
import com.qp.lms.common.service.DdService;
import com.qp.lms.compManager.model.CompCourseRegSet;
import com.qp.lms.compManager.model.CompCourseRegVO;
import com.qp.lms.compManager.model.CompCourseSet;
import com.qp.lms.compManager.model.CompCourseVO;
import com.qp.lms.compManager.model.CompUserSet;
import com.qp.lms.compManager.model.CompUserVO;
import com.qp.lms.course.model.CourseVO;
import com.qp.lms.main.model.MainSet;
import com.qp.lms.main.model.MainVO;

@Service
public class CompCourseService {
	@Autowired
	private SqlSession sqlSession;

	@Autowired
	private DdService ddService;

    public CompCourseSet compCourseList(CompCourseSet set) throws Exception {
    	set.getCondiVO().setUserId(SessionUtil.getSessionUserId());

    	//쿼리에서 가져올 갯수 지정
    	set.getCondiVO().setLimitUnit(Constant.unitPerPage);

    	List<CompCourseVO> list = sqlSession.selectList("compCourse.compCourseList",set.getCondiVO());
    	set.setList(list);
    	
    	//페이징 처리 변수 세팅
    	set.setTotalCount(((CompCourseVO)sqlSession.selectOne("compCourse.compCourseTotal",set.getCondiVO())).getCnt());
    	set.setPageUnit(Constant.unitPerPage);
    	
    	return set;
    }

}
