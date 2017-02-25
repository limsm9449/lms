package com.qp.lms.compManager.service;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.qp.lms.common.Constant;
import com.qp.lms.common.SessionUtil;
import com.qp.lms.compManager.model.CompCostApprovalSet;
import com.qp.lms.compManager.model.CompCostApprovalVO;

@Service
public class CompCostApprovalService {
	
	@Autowired
	private SqlSession sqlSession;
	
	
	public CompCostApprovalSet compCostApprovalList(CompCostApprovalSet set) throws Exception {
		set.getCondiVO().setUserId(SessionUtil.getSessionUserId());
		
    	//쿼리에서 가져올 갯수 지정
    	set.getCondiVO().setLimitUnit(Constant.unitPerPage);

    	List<CompCostApprovalVO> list = sqlSession.selectList("compCostApproval.compCostApprovalList",set.getCondiVO());
    	set.setList(list);
        
    	//페이징 처리 변수 세팅
    	set.setTotalCount(((CompCostApprovalVO)sqlSession.selectOne("compCostApproval.compCostApprovalTotal",set.getCondiVO())).getCnt());
    	set.setPageUnit(Constant.unitPerPage);
    	
    	return set;
    }

}
