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

	
    public QuestSet userQuest(QuestSet set) throws Exception {
    	String questName = sqlSession.selectOne("quest.questName", set.getCondiVO());
    	set.setQuestName(questName);
    	
    	List<QuestVO> list =  sqlSession.selectList("quest.userQuestList", set.getCondiVO());
    	set.setList(list);
        
    	return set;
    }
    
    @Transactional(propagation=Propagation.REQUIRED, rollbackFor={Throwable.class})
    public QuestSet userQuestIns(QuestSet set) throws Exception {
    	QuestVO saveVO = new QuestVO();
		saveVO.setCourseId(set.getCondiVO().getCourseId());
		saveVO.setUserId(SessionUtil.getSessionUserId());
		saveVO.setQgId(set.getCondiVO().getQgId());
		for ( int i = 0; i < set.getCondiVO().getSeqs().length; i++ ) {
			saveVO.setSeq(set.getCondiVO().getSeqs()[i]);
			saveVO.setQgId(set.getCondiVO().getQgIds()[i]);
			
			if ( "M".equals(set.getCondiVO().getTypes()[i]) ) {
				String[] m = set.getCondiVO().getAnswers()[i].split(",");
				saveVO.setAnswer1(m[0]);
				saveVO.setAnswer2(m[1]);
				saveVO.setAnswer3(m[2]);
				saveVO.setAnswer4(m[3]);
				
				sqlSession.insert("quest.UserQuestInsert2",saveVO);
			} else {
				saveVO.setAnswer(set.getCondiVO().getAnswers()[i]);
				
				sqlSession.insert("quest.UserQuestInsert1",saveVO);
			}
		}

		sqlSession.update("quest.UserQuestInsertFlagUpd",saveVO);

		set.setRtnMode(Constant.mode.INSERT_OK.name());
		
    	return set;
    }

    public QuestSet userQuestResult(QuestSet set) throws Exception {
    	set.getCondiVO().setUserId(SessionUtil.getSessionUserId());
    	
    	String questName = sqlSession.selectOne("quest.questName", set.getCondiVO());
    	set.setQuestName(questName);
    	
    	List<QuestVO> list = sqlSession.selectList("quest.userQuestResultList", set.getCondiVO());
    	set.setList(list);
        
    	return set;
    }
}
