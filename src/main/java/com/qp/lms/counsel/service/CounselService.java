package com.qp.lms.counsel.service;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.qp.lms.common.CodeVO;
import com.qp.lms.common.Constant;
import com.qp.lms.common.SessionUtil;
import com.qp.lms.counsel.model.CounselSet;
import com.qp.lms.counsel.model.CounselVO;

@Service
public class CounselService {
	@Autowired
	private SqlSession sqlSession;
	
    public CounselSet userCounselList(CounselSet set) throws Exception {
    	List<CounselVO> list = sqlSession.selectList("counsel.userCounselList",set.getCondiVO());
    	set.setList(list);
    	
    	return set;
    }
    /*
    public CounselSet counselList(CounselSet set) throws Exception {
    	//쿼리에서 가져올 갯수 지정
    	set.getCondiVO().setLimitUnit(Constant.unitPerPage);

    	List<CounselVO> list = sqlSession.selectList("counsel.counselList",set.getCondiVO());
    	set.setList(list);
    	
    	//페이징 처리 변수 세팅
    	set.setTotalCount(((CounselVO)sqlSession.selectOne("counsel.counselTotal",set.getCondiVO())).getCnt());
    	set.setPageUnit(Constant.unitPerPage);
    	
    	return set;
    }*/
    
    public CounselSet userCounselN(CounselSet set) throws Exception {
    	//category
    	List<CodeVO> list = sqlSession.selectList("comm.getDdCodeKeyDdMain","FAQ");
    	set.setDdCategory(list);

    	return set;
    }

    public CounselSet userCounselV(CounselSet set) throws Exception {
    	set.setData((CounselVO) sqlSession.selectOne("counsel.userCounselData",set.getCondiVO()));
    	
    	//category
    	List<CodeVO> list = sqlSession.selectList("comm.getDdCodeKeyDdMain","FAQ");
    	set.setDdCategory(list);

    	return set;
    }

    /*public CounselSet counselAnswer(CounselSet set) throws Exception {
    	set.setData((CounselVO) sqlSession.selectOne("counsel.counselAnswerData",set.getCondiVO()));
    	
    	//category
    	List<CodeVO> list = sqlSession.selectList("comm.getDdCodeKeyDdMain","FAQ");
    	set.setDdCategory(list);

    	return set;
    }*/

    public CounselSet userCounselU(CounselSet set) throws Exception {
    	set.setData((CounselVO) sqlSession.selectOne("counsel.userCounselData",set.getCondiVO()));

    	//category
    	List<CodeVO> list = sqlSession.selectList("comm.getDdCodeKeyDdMain","FAQ");
    	set.setDdCategory(list);
    	
    	return set;
    }

    @Transactional(propagation=Propagation.REQUIRED, rollbackFor={Throwable.class})
    public CounselSet userCounselIns(CounselSet set) throws Exception {
    	set.getCondiVO().setUserId(SessionUtil.getSessionUserId());
    	
    	sqlSession.insert("counsel.userCounselIns",set.getCondiVO());
    	
    	set.setRtnMode(Constant.mode.INSERT_OK.name());
    	
    	return set;
    }

    @Transactional(propagation=Propagation.REQUIRED, rollbackFor={Throwable.class})
    public CounselSet userCounselUpd(CounselSet set) throws Exception {
    	sqlSession.update("counsel.userCounselUpd",set.getCondiVO());
    	
    	set.setRtnMode(Constant.mode.UPDATE_OK.name());
    	
    	return set;
    }

    @Transactional(propagation=Propagation.REQUIRED, rollbackFor={Throwable.class})
    public CounselSet userCounselDel(CounselSet set) throws Exception {
    	sqlSession.delete("counsel.userCounselDel",set.getCondiVO());

    	set.setRtnMode(Constant.mode.DELETE_OK.name());
    	
    	return set;
    }

    /*@Transactional(propagation=Propagation.REQUIRED, rollbackFor={Throwable.class})
    public CounselSet counselAnswerUpd(CounselSet set) throws Exception {
    	sqlSession.insert("counsel.counselAnswerUpd",set.getCondiVO());
    	
    	set.setRtnMode(Constant.mode.UPDATE_OK.name());
    	
    	return set;
    }*/

    

}
