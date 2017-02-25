package com.qp.lms.system.service;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.qp.lms.common.Constant;
import com.qp.lms.system.model.SystemSet;
import com.qp.lms.system.model.SystemVO;

@Service
public class SystemService {
	@Autowired
	private SqlSession sqlSession;

	public SystemSet logList(SystemSet set) throws Exception {

    	//쿼리에서 가져올 갯수 지정
    	set.getCondiVO().setLimitUnit(Constant.unitPerPage);

    	List<SystemVO> list = sqlSession.selectList("system.logList",set.getCondiVO());
    	set.setLogList(list);
    	
    	//페이징 처리 변수 세팅
    	set.setTotalCount(((SystemVO)sqlSession.selectOne("system.logTotal",set.getCondiVO())).getCnt());
    	set.setPageUnit(Constant.unitPerPage);
    	
    	return set;
    }

    
}
