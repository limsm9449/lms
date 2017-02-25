package com.qp.lms.cost.service;

import java.util.HashMap;
import java.util.List;

import net.sf.json.JSONObject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.qp.lms.common.Constant;
import com.qp.lms.common.SessionUtil;
import com.qp.lms.common.service.DdService;
import com.qp.lms.cost.model.CostNotPayVO;
import com.qp.lms.cost.model.CostPaySet;
import com.qp.lms.cost.model.CostPayVO;

@Service
public class CostPayService {
	
	@Autowired
	private SqlSession sqlSession;
	
	@Autowired
	private DdService ddService;
	
	public CostPaySet costPayList(CostPaySet set) throws Exception {
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

    	List<CostPayVO> list = sqlSession.selectList("costPay.costPayList",set.getCondiVO());
    	set.setList(list);
        
    	//페이징 처리 변수 세팅
    	set.setTotalCount(((CostPayVO)sqlSession.selectOne("costPay.costPayListTotal",set.getCondiVO())).getCnt());
    	set.setPageUnit(Constant.unitPerPage);
    	
    	return set;
    }
	
    public CostPaySet costPayV(CostPaySet set) throws Exception {
    	set.setData((CostPayVO) sqlSession.selectOne("costPay.costPayData",set.getCondiVO()));
    	
    	List<CostPayVO> payList = sqlSession.selectList("costPay.costPayDataList",set.getCondiVO());
    	set.setPayList(payList);

    	if ( set.getCondiVO().getCostId() != null && !"".equals(set.getCondiVO().getCostId()) ) {
	    	List<CostPayVO> payRegisterList = sqlSession.selectList("costPay.costPayRegisterDataList",set.getCondiVO());
	    	set.setPayRegisterList(payRegisterList);
    	} else {
    		set.getCondiVO().setCostId(payList.get(0).getCostId());
	    	List<CostPayVO> payRegisterList = sqlSession.selectList("costPay.costPayRegisterDataList",set.getCondiVO());
	    	set.setPayRegisterList(payRegisterList);
    	}
    	
    	return set;
    }
   
    public CostPaySet tutorCostPayList(CostPaySet set) throws Exception {
    	set.getCondiVO().setUserId(SessionUtil.getSessionUserId());
    	
    	//쿼리에서 가져올 갯수 지정
    	set.getCondiVO().setLimitUnit(Constant.unitPerPage);

    	List<CostPayVO> list = sqlSession.selectList("costPay.tutorCostPayList",set.getCondiVO());
    	set.setList(list);
        
    	//페이징 처리 변수 세팅
    	set.setTotalCount(((CostPayVO)sqlSession.selectOne("costPay.tutorCostPayListTotal",set.getCondiVO())).getCnt());
    	set.setPageUnit(Constant.unitPerPage);
    	
    	return set;
    }

    public CostPaySet teacherCostPayList(CostPaySet set) throws Exception {
    	set.getCondiVO().setUserId(SessionUtil.getSessionUserId());
    	
    	//쿼리에서 가져올 갯수 지정
    	set.getCondiVO().setLimitUnit(Constant.unitPerPage);

    	List<CostPayVO> list = sqlSession.selectList("costPay.teacherCostPayList",set.getCondiVO());
    	set.setList(list);
        
    	//페이징 처리 변수 세팅
    	set.setTotalCount(((CostPayVO)sqlSession.selectOne("costPay.teacherCostPayListTotal",set.getCondiVO())).getCnt());
    	set.setPageUnit(Constant.unitPerPage);
    	
    	return set;
    }

    
}
