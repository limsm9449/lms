package com.qp.lms.guest.service;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.qp.lms.board.model.BoardFaqVO;
import com.qp.lms.common.Constant;
import com.qp.lms.common.SessionUtil;
import com.qp.lms.course.model.CourseCodeVO;
import com.qp.lms.course.model.CourseVO;
import com.qp.lms.guest.model.BankVO;
import com.qp.lms.guest.model.GuestSet;
import com.qp.lms.member.model.MemberSet;
import com.qp.lms.user.model.UserSet;

@Service
public class GuestService {
	@Autowired
	private SqlSession sqlSession;

    public GuestSet getCourseCode(GuestSet set) throws Exception {
    	List<CourseCodeVO> list = sqlSession.selectList("user.getCourseCode");
    	set.setCourseCode(list);
    	
        return set ;
    }

    public GuestSet getCourse(GuestSet set) throws Exception {
    	List<CourseVO> list = sqlSession.selectList("user.getCourse",set.getCondiVO());
    	set.setCourse(list);
    	
        return set ;
    }

    public GuestSet getCourseInfo(GuestSet set) throws Exception {
    	set.setCourseInfo((CourseVO) sqlSession.selectOne("course.getCourseKeyCourseId",set.getCondiVO()));
    	
        return set ;
    }
    
    public GuestSet bankInfo(GuestSet set) throws Exception {
    	List<BankVO> bankList = sqlSession.selectList("comm.getBankList",set.getCondiVO());
    	set.setBankList(bankList);
    	
        return set ;
    }
    
    public MemberSet boardFaqList(MemberSet set) throws Exception {
    	List<BoardFaqVO> faqList = sqlSession.selectList("boardFaq.favoriteFaqList",null);
    	set.setFaqList(faqList);
    	
    	return set;
    }

	public GuestSet checkCourse(GuestSet set) throws Exception {
    	set.setCourseInfo((CourseVO) sqlSession.selectOne("user.checkMyCourse",set.getCondiVO()));
    	
        return set ;
    }
}
