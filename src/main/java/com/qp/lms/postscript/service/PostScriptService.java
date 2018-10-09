package com.qp.lms.postscript.service;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.qp.lms.common.Constant;
import com.qp.lms.common.SessionUtil;
import com.qp.lms.common.service.DdService;
import com.qp.lms.postscript.model.PostScriptSet;
import com.qp.lms.postscript.model.PostScriptVO;
import com.qp.lms.quest.model.QuestSet;
import com.qp.lms.quest.model.QuestVO;

@Service
public class PostScriptService {
	@Autowired
	private SqlSession sqlSession;
	
	@Autowired
	private DdService ddService;
	
    public PostScriptSet postscriptList(PostScriptSet set) throws Exception {
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

    	List<PostScriptVO> list = sqlSession.selectList("postscript.postscriptList",set.getCondiVO());
    	set.setList(list);
    	
    	//페이징 처리 변수 세팅
    	set.setTotalCount(((PostScriptVO)sqlSession.selectOne("postscript.postscriptTotal",set.getCondiVO())).getCnt());
    	set.setPageUnit(Constant.unitPerPage);
    	
        return set ;
    }
	
    public PostScriptSet postscriptUserList(PostScriptSet set) throws Exception {
    	//쿼리에서 가져올 갯수 지정
    	set.getCondiVO().setLimitUnit(Constant.unitPerPage);

    	List<PostScriptVO> userList = sqlSession.selectList("postscript.postscriptUserList",set.getCondiVO());
    	set.setUserList(userList);
    	
    	//페이징 처리 변수 세팅
    	set.setTotalCount(((PostScriptVO)sqlSession.selectOne("postscript.postscriptUserTotal",set.getCondiVO())).getCnt());
    	set.setPageUnit(Constant.unitPerPage);
    	
        return set ;
    }
    
    public PostScriptSet postscriptV(PostScriptSet set) throws Exception {
    	set.getCondiVO().setUserId(SessionUtil.getSessionUserId());
    	set.setData((PostScriptVO) sqlSession.selectOne("postscript.postscriptData",set.getCondiVO()));
        
    	return set;
    }
    
    ///////////////////////////////////////////////// Transaction ////////////////////////////////////////////////////
    @Transactional(propagation=Propagation.REQUIRED, rollbackFor={Throwable.class})
    public PostScriptSet postscriptIns(PostScriptSet set) throws Exception {
    	set.getCondiVO().setUserId(SessionUtil.getSessionUserId());
    	
		sqlSession.insert("postscript.postscriptIns",set.getCondiVO());

		sqlSession.update("postscript.postscriptFlagUpd",set.getCondiVO());

		set.setRtnMode(Constant.mode.INSERT_OK.name());
		
    	return set;
    }
    
	
	
}
