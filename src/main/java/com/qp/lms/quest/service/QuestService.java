package com.qp.lms.quest.service;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.qp.lms.common.CodeVO;
import com.qp.lms.common.Constant;
import com.qp.lms.common.SessionUtil;
import com.qp.lms.course.model.CourseExamVO;
import com.qp.lms.course.model.CourseResourceVO;
import com.qp.lms.quest.model.QuestSet;
import com.qp.lms.quest.model.QuestVO;

@Service
public class QuestService {
	@Autowired
	private SqlSession sqlSession;

    public QuestSet questList(QuestSet set) throws Exception {
    	//쿼리에서 가져올 갯수 지정
    	set.getCondiVO().setLimitUnit(Constant.unitPerPage);

    	List<QuestVO> list = sqlSession.selectList("quest.questList",set.getCondiVO());
    	set.setList(list);
    	
    	//페이징 처리 변수 세팅
    	set.setTotalCount(((QuestVO)sqlSession.selectOne("quest.questTotal",set.getCondiVO())).getCnt());
    	set.setPageUnit(Constant.unitPerPage);
    	
        return set ;
    }
	
    public QuestSet questN(QuestSet set) throws Exception {
    	List<CodeVO> ddQuestGroup =  sqlSession.selectList("quest.ddQuestGroupNotInput");
    	set.setDdQuestGroup(ddQuestGroup);
        
    	return set;
    }
    
    public QuestSet questV(QuestSet set) throws Exception {
    	List<QuestVO> questDetailList = sqlSession.selectList("quest.questDetailList",set.getCondiVO());
    	set.setQuestDetailList(questDetailList);
        
    	return set;
    }

    public QuestSet questU(QuestSet set) throws Exception {
    	List<QuestVO> questDetailList = sqlSession.selectList("quest.questDetailList",set.getCondiVO());
    	set.setQuestDetailList(questDetailList);
        
        set.setData((QuestVO)sqlSession.selectOne("quest.questGroupData",set.getCondiVO()));
        
    	return set;
    }
        
    
    ///////////////////////////////////////////////// Transaction ////////////////////////////////////////////////////
    @Transactional(propagation=Propagation.REQUIRED, rollbackFor={Throwable.class})
    public QuestSet questIns(QuestSet set) throws Exception {
    	QuestVO saveVO = new QuestVO();
		saveVO.setQgId(set.getCondiVO().getQgId());
		saveVO.setUserId(SessionUtil.getSessionUserId());
		for ( int i = 0; i < set.getCondiVO().getSeqs().length; i++ ) {
			saveVO.setSeq(set.getCondiVO().getSeqs()[i]);
			saveVO.setType(set.getCondiVO().getTypes()[i]);
			saveVO.setQuestion(set.getCondiVO().getQuestions()[i]);
			saveVO.setQa1(set.getCondiVO().getQa1s()[i]);
			saveVO.setQa2(set.getCondiVO().getQa2s()[i]);
			saveVO.setQa3(set.getCondiVO().getQa3s()[i]);
			saveVO.setQa4(set.getCondiVO().getQa4s()[i]);
			
			sqlSession.insert("quest.questIns",saveVO);
		}
			
		set.setRtnMode(Constant.mode.INSERT_OK.name());
		
    	return set;
    }

    @Transactional(propagation=Propagation.REQUIRED, rollbackFor={Throwable.class})
    public QuestSet questUpd(QuestSet set) throws Exception {
   	set.getCondiVO().setCreateUser(SessionUtil.getSessionUserId());
    	
    	//기존거를 삭제한다.
    	sqlSession.delete("quest.questAllDel",set.getCondiVO());

    	QuestVO saveVO = new QuestVO();
		saveVO.setQgId(set.getCondiVO().getQgId());
		saveVO.setUserId(SessionUtil.getSessionUserId());
		for ( int i = 0; i < set.getCondiVO().getSeqs().length; i++ ) {
			saveVO.setSeq(set.getCondiVO().getSeqs()[i]);
			saveVO.setType(set.getCondiVO().getTypes()[i]);
			saveVO.setQuestion(set.getCondiVO().getQuestions()[i]);
			saveVO.setQa1(set.getCondiVO().getQa1s()[i]);
			saveVO.setQa2(set.getCondiVO().getQa2s()[i]);
			saveVO.setQa3(set.getCondiVO().getQa3s()[i]);
			saveVO.setQa4(set.getCondiVO().getQa4s()[i]);
			
			sqlSession.insert("quest.questIns",saveVO);
		}
    	
		set.setRtnMode(Constant.mode.UPDATE_OK.name());

    	return set;
    }
	
}
