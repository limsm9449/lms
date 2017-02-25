package com.qp.lms.quest.service;

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
import com.qp.lms.quest.model.QuestSet;
import com.qp.lms.quest.model.QuestVO;

@Service
public class QuestManageService {
	@Autowired
	private SqlSession sqlSession;

	@Autowired
	private DdService ddService;
	
    public QuestSet questManageList(QuestSet set) throws Exception {
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

    	List<QuestVO> list = sqlSession.selectList("quest.questManageList",set.getCondiVO());
    	set.setList(list);
    	
    	//페이징 처리 변수 세팅
    	set.setTotalCount(((QuestVO)sqlSession.selectOne("quest.questManageTotal",set.getCondiVO())).getCnt());
    	set.setPageUnit(Constant.unitPerPage);
    	
    	return set;
    
    }

    public QuestSet questUserManageList(QuestSet set) throws Exception {
    	//쿼리에서 가져올 갯수 지정
    	set.getCondiVO().setLimitUnit(Constant.unitPerPage);

    	List<QuestVO> list = sqlSession.selectList("quest.questUserManageList",set.getCondiVO());
    	set.setUserList(list);
    	
    	//페이징 처리 변수 세팅
    	set.setTotalCount(((QuestVO)sqlSession.selectOne("quest.questUserManageTotal",set.getCondiVO())).getCnt());
    	set.setPageUnit(Constant.unitPerPage);
    	
    	return set;
    
    }

    public QuestSet questUserManageV(QuestSet set) throws Exception {
    	List<QuestVO> userDetailList = sqlSession.selectList("quest.questUserManageData",set.getCondiVO());
    	set.setUserDetailList(userDetailList);
    	
    	return set;
    
    }
    
}
