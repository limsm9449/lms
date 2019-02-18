package com.qp.lms.user.service;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.qp.lms.common.Constant;
import com.qp.lms.common.SessionUtil;
import com.qp.lms.course.model.CourseVO;
import com.qp.lms.evaluation.model.EvaluationVO;
import com.qp.lms.member.model.MemberSet;
import com.qp.lms.member.model.MemberVO;
import com.qp.lms.user.model.UserSet;
import com.qp.lms.user.model.UserVO;

@Service
public class NormalUserService {
	@Autowired
	private SqlSession sqlSession;

    public UserSet attendCourseList(UserSet set) throws Exception {
    	set.getCondiVO().setUserId(SessionUtil.getSessionUserId());
    	set.getCondiVO().setCompType(SessionUtil.getSessionCompType());
    	set.getCondiVO().setCompCd(SessionUtil.getSessionCompCd());
    	List<CourseVO> list = sqlSession.selectList("normalUser.attendCourseList",set.getCondiVO());
    	set.setCourse(list);
    	
    	set.setData((UserVO)sqlSession.selectOne("normalUser.userInfo",set.getCondiVO()));
    	
        return set ;
    }

    public UserSet waitingCourseList(UserSet set) throws Exception {
    	set.getCondiVO().setUserId(SessionUtil.getSessionUserId());
    	set.getCondiVO().setCompType(SessionUtil.getSessionCompType());
    	set.getCondiVO().setCompCd(SessionUtil.getSessionCompCd());
    	List<CourseVO> list = sqlSession.selectList("normalUser.waitingCourseList",set.getCondiVO());
    	set.setCourse(list);
    	
        return set ;
    }

    public UserSet cancelCourseList(UserSet set) throws Exception {
    	set.getCondiVO().setUserId(SessionUtil.getSessionUserId());
    	set.getCondiVO().setCompType(SessionUtil.getSessionCompType());
    	set.getCondiVO().setCompCd(SessionUtil.getSessionCompCd());
    	List<CourseVO> list = sqlSession.selectList("normalUser.cancelCourseList",set.getCondiVO());
    	set.setCourse(list);
    	
        return set ;
    }

    public UserSet myCourseList(UserSet set) throws Exception {
    	set.getCondiVO().setUserId(SessionUtil.getSessionUserId());
    	set.getCondiVO().setCompType(SessionUtil.getSessionCompType());
    	set.getCondiVO().setCompCd(SessionUtil.getSessionCompCd());
    	List<CourseVO> list = sqlSession.selectList("normalUser.myCourseList",set.getCondiVO());
    	set.setCourse(list);
    	
        return set ;
    }

    public UserSet interestCourseList(UserSet set) throws Exception {
    	set.getCondiVO().setUserId(SessionUtil.getSessionUserId());
    	set.getCondiVO().setCompCd(SessionUtil.getSessionCompCd());
    	List<CourseVO> list = sqlSession.selectList("normalUser.interestCourseList",set.getCondiVO());
    	set.setCourse(list);
    	
        return set ;
    }
    
    @Transactional(propagation=Propagation.REQUIRED, rollbackFor={Throwable.class})
    public UserSet courseRegCancel(UserSet set) throws Exception {
   		sqlSession.update("normalUser.courseRegCancel",set.getCondiVO());
   		sqlSession.update("normalUser.courseApprovalRegCancel",set.getCondiVO());
    	
		set.setRtnMode(Constant.mode.UPDATE_OK.name());
		
    	return set;
    }
    
}
