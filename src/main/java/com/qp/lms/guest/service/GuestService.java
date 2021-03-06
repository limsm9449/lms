package com.qp.lms.guest.service;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.qp.lms.board.model.BoardFaqVO;
import com.qp.lms.course.model.CourseCodeVO;
import com.qp.lms.course.model.CourseVO;
import com.qp.lms.guest.model.BankVO;
import com.qp.lms.guest.model.GuestSet;
import com.qp.lms.main.model.MainSet;
import com.qp.lms.main.model.MainVO;
import com.qp.lms.member.model.MemberSet;

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
	
	@Transactional(propagation=Propagation.REQUIRED, rollbackFor={Throwable.class})
    public GuestSet dbInstall(GuestSet set) throws Exception {
    	
		sqlSession.update("dbInstall.createTable",null);
		sqlSession.update("dbInstall.createCodeData",null);
		sqlSession.update("dbInstall.createSettingData",null);
		
    	return set;
    }
	

    public MainSet isExistCompAuth(MainSet set) throws Exception {
    	MainVO vo = (MainVO)sqlSession.selectOne("main.isExistCompAuth",set.getCondiVO());

    	if ( vo.getCnt() == 1 )
    		set.setRtnMode("EXIST");
    	else
    		set.setRtnMode("NOT_EXIST");
    	
    	return set;
    } 
}
