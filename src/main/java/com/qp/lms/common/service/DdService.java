package com.qp.lms.common.service;

import java.io.File;
import java.sql.Connection;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.qp.lms.course.model.CourseSet;
import com.qp.lms.course.model.CourseVO;
import com.qp.lms.course.model.RegisterVO;
import com.qp.lms.board.model.AttachVO;
import com.qp.lms.common.CodeVO;
import com.qp.lms.common.SessionUtil;
import com.qp.lms.common.model.CommSet;

@Service
public class DdService {
	@Autowired
	private SqlSession sqlSession;

	/**
	 * 대분류 DD
	 * @return
	 * @throws Exception
	 */
	public List<CodeVO> getDdCategory1Depth() throws Exception {
        return sqlSession.selectList("category.ddCategory1Depth");
    }
	
	/**
	 * 중분류 DD
	 * @param parentCode
	 * @return
	 * @throws Exception
	 */
	public List<CodeVO> getDdCategory2Depth(String parentCode) throws Exception {
        return sqlSession.selectList("category.ddCategory2Depth", parentCode);
    }
	
	/**
	 * 소분류 DD
	 * @param parentCode
	 * @return
	 * @throws Exception
	 */
	public List<CodeVO> getDdCategory3Depth(String parentCode) throws Exception {
        return sqlSession.selectList("category.ddCategory3Depth", parentCode);
    }
	
	/**
	 * 강사 DD
	 * @param parentCode
	 * @return
	 * @throws Exception
	 */
	public List<CodeVO> getDdTeacher() throws Exception {
        return sqlSession.selectList("comm.ddTeacher");
    }
	
	/**
	 * 튜터 DD
	 * @param parentCode
	 * @return
	 * @throws Exception
	 */
	public List<CodeVO> getDdTutor() throws Exception {
        return sqlSession.selectList("comm.ddTutor");
    }
	
	/**
	 * 과정코드
	 * @param categoryCode
	 * @return
	 * @throws Exception
	 */
	public List<CodeVO> getDdCourseCode(String categoryCode) throws Exception {
        return sqlSession.selectList("comm.getDdCourseCode",categoryCode);
    }
	
	/**
	 * 과정코드(사용이 Y인 과정들)
	 * @param categoryCode
	 * @return
	 * @throws Exception
	 */
	public List<CodeVO> getDdCourseCodeForUse(String categoryCode) throws Exception {
        return sqlSession.selectList("comm.getDdCourseCodeForUse",categoryCode);
    }
	
	/**
	 * DD를 가져온다.
	 * @param ddMain
	 * @return
	 * @throws Exception
	 */
	public List<CodeVO> getDdCode(String ddMain) throws Exception {
        return sqlSession.selectList("comm.getDdCode",ddMain);
    }
	
	/**
	 * 회사 DD
	 * @param parentCode
	 * @return
	 * @throws Exception
	 */
	public List<CodeVO> getDdCompany() throws Exception {
        return sqlSession.selectList("comm.ddCompany");
    }
	
	/**
	 * 설문 DD
	 * @param parentCode
	 * @return
	 * @throws Exception
	 */
	public List<CodeVO> getDdQuestGroup() throws Exception {
        return sqlSession.selectList("comm.ddQuestGroup");
    }
	
	
	
	
	
	
	
	
    public List<CodeVO> getDdCategory(String parentCode) throws Exception {
        return sqlSession.selectList("comm.getDdCategory",parentCode);
    }

    public List<CodeVO> getDdCourseCodeAllKeyCode(String condiCode) throws Exception {
    	CourseVO condiVO = new CourseVO();
    	condiVO.setCondiCode(condiCode);
        return sqlSession.selectList("course.getDdCourseCodeAllKeyCode",condiVO);
    }
 
    public List<CodeVO> getDdCourseCodeKeyCode(String condiCode) throws Exception {
        return sqlSession.selectList("comm.getDdCourseCodeKeyCode",condiCode);
    }

    public List<CodeVO> getDdCourseCodeAll() throws Exception {
        return sqlSession.selectList("comm.getDdCourseCodeAll");
    }


    public List<CodeVO> getDdRate() throws Exception {
        return sqlSession.selectList("comm.getDdCodeKeyDdMain","EVAL_RATE");
    }

    public List<CodeVO> getDdStatusForCourse() throws Exception {
        return sqlSession.selectList("comm.getDdStatusForCourse");
    }

    public List<CodeVO> getDdStatusForCourseManage() throws Exception {
        return sqlSession.selectList("comm.getDdStatusForCourseManage");
    }

    public List<CodeVO> getDdStatusForCompanyCourseManage() throws Exception {
        return sqlSession.selectList("comm.getDdStatusForCompanyCourseManage");
    }

    public List<CodeVO> getDdCourseCodeContainCategory() throws Exception {
        return sqlSession.selectList("course.getDdCourseCodeContainCategory");
    }


    public List<CodeVO> getDdCodeKeyDdMain(String mainCode) throws Exception {
        return sqlSession.selectList("comm.getDdCodeKeyDdMain",mainCode);
    }

    public List<RegisterVO> getRegister(CourseVO condiVO) throws Exception {
        return sqlSession.selectList("courseManage.getRegister",condiVO);
    }

    public List<CodeVO> getDdStatusForProfessor() throws Exception {
        return sqlSession.selectList("comm.getDdStatusForProfessor");
    }

    
}


/*
set.setDdCourseCode((List<CodeVO>) sqlSession.selectList("course.getDdCourseCodeContainCategory"));
set.setDdProfessor((List<CodeVO>) sqlSession.selectList(""));
set.setDdRate((List<CodeVO>) sqlSession.selectList("comm.getDdCodeKeyDdMain","EVAL_RATE"));
set.setDdStatus((List<CodeVO>) sqlSession.selectList("comm.getDdStatusForCourse"));
set.setDdOpenYear((List<CodeVO>) sqlSession.selectList("course.getDdOpenYear"));
*/