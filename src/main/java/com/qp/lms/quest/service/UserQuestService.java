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
import com.qp.lms.quest.model.QuestSet;
import com.qp.lms.quest.model.QuestVO;

@Service
public class UserQuestService {
	@Autowired
	private SqlSession sqlSession;

	
    public QuestSet userQuestN(QuestSet set) throws Exception {
    	List<QuestVO> list =  sqlSession.selectList("quest.userQuestNewList", set.getCondiVO());
    	set.setList(list);
        
    	return set;
    }
    
    
    ///////////////////////////////////////////////// Transaction ////////////////////////////////////////////////////
    @Transactional(propagation=Propagation.REQUIRED, rollbackFor={Throwable.class})
    public QuestSet userQuestIns(QuestSet set) throws Exception {
    	QuestVO saveVO = new QuestVO();
		saveVO.setCourseId(set.getCondiVO().getCourseId());
		saveVO.setUserId(SessionUtil.getSessionUserId());
		saveVO.setQgId(set.getCondiVO().getQgId());
		for ( int i = 0; i < set.getCondiVO().getSeqs().length; i++ ) {
			saveVO.setSeq(set.getCondiVO().getSeqs()[i]);
			saveVO.setAnswer(set.getCondiVO().getAnswers()[i]);
			
			sqlSession.insert("quest.UserQuestIns",saveVO);
		}

		sqlSession.update("quest.UserQuestInsertFlagUpd",saveVO);

		set.setRtnMode(Constant.mode.INSERT_OK.name());
		
    	return set;
    }

	
}
