package com.qp.lms.quest.service;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.qp.lms.common.Constant;
import com.qp.lms.common.SessionUtil;
import com.qp.lms.quest.model.QuestSet;
import com.qp.lms.quest.model.QuestVO;

@Service
public class QuestGroupService {
	@Autowired
	private SqlSession sqlSession;
	
    public QuestSet questGroupList(QuestSet set) throws Exception {
    	//쿼리에서 가져올 갯수 지정
    	set.getCondiVO().setLimitUnit(Constant.unitPerPage);

    	List<QuestVO> list = sqlSession.selectList("quest.questGroupList",set.getCondiVO());
    	set.setList(list);
    	
    	//페이징 처리 변수 세팅
    	set.setTotalCount(((QuestVO)sqlSession.selectOne("quest.questGroupTotal",set.getCondiVO())).getCnt());
    	set.setPageUnit(Constant.unitPerPage);
    	
        return set ;
    }

    public QuestSet questGroupN(QuestSet set) throws Exception {
        
    	return set;
    }
    
    public QuestSet questGroupV(QuestSet set) throws Exception {
    	set.setData((QuestVO) sqlSession.selectOne("quest.questGroupData",set.getCondiVO()));
        
    	return set;
    }

    public QuestSet questGroupU(QuestSet set) throws Exception {
    	set.setData((QuestVO) sqlSession.selectOne("quest.questGroupData",set.getCondiVO()));
        
    	return set;
    }
        
    
    ///////////////////////////////////////////////// Transaction ////////////////////////////////////////////////////
    @Transactional(propagation=Propagation.REQUIRED, rollbackFor={Throwable.class})
    public QuestSet questGroupIns(QuestSet set) throws Exception {
    	set.getCondiVO().setUserId(SessionUtil.getSessionUserId());
    	
		sqlSession.insert("quest.questGroupIns",set.getCondiVO());
			
		set.setRtnMode(Constant.mode.INSERT_OK.name());
		
    	return set;
    }

    @Transactional(propagation=Propagation.REQUIRED, rollbackFor={Throwable.class})
    public QuestSet questGroupUpd(QuestSet set) throws Exception {
    	set.getCondiVO().setUserId(SessionUtil.getSessionUserId());
    	
       	sqlSession.update("quest.questGroupUpd",set.getCondiVO());
    	
		set.setRtnMode(Constant.mode.UPDATE_OK.name());

    	return set;
    }
	
    @Transactional(propagation=Propagation.REQUIRED, rollbackFor={Throwable.class})
    public QuestSet questGroupDel(QuestSet set) throws Exception {
    	set.getCondiVO().setUserId(SessionUtil.getSessionUserId());
    	
		QuestVO vo = (QuestVO)sqlSession.selectOne("quest.questGroupSubCnt",set.getCondiVO());
		if ( vo.getCnt() > 0 ) {
			set.setRtnMode(Constant.mode.SUB_EXIST.name());
			return set;
		}
		
    	sqlSession.delete("quest.questGroupDel",set.getCondiVO());
    	sqlSession.delete("quest.questAllDel",set.getCondiVO());
    	
		set.setRtnMode(Constant.mode.DELETE_OK.name());

    	return set;
    }
    

}
