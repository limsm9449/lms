package com.qp.lms.cost.service;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.qp.lms.common.Constant;
import com.qp.lms.common.SessionUtil;
import com.qp.lms.common.service.DdService;
import com.qp.lms.cost.model.CostRateSet;
import com.qp.lms.cost.model.CostRateVO;

@Service
public class CostRateService {
	
	@Autowired
	private SqlSession sqlSession;
	
	@Autowired
	private DdService ddService;
	
	public CostRateSet costRateList(CostRateSet set) throws Exception {
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

    	List<CostRateVO> list = sqlSession.selectList("costRate.costRateList",set.getCondiVO());
    	set.setList(list);
        
    	//페이징 처리 변수 세팅
    	set.setTotalCount(((CostRateVO)sqlSession.selectOne("costRate.costRateListTotal",set.getCondiVO())).getCnt());
    	set.setPageUnit(Constant.unitPerPage);
    	
    	return set;
    }
	
    public CostRateSet costRateU(CostRateSet set) throws Exception {
    	set.setData((CostRateVO) sqlSession.selectOne("costRate.costRateData",set.getCondiVO()));
        
    	return set;
    }
    
    
    
    
	

    ///////////////////////////////////////////////// Transaction ////////////////////////////////////////////////////
    @Transactional(propagation=Propagation.REQUIRED, rollbackFor={Throwable.class})
    public CostRateSet costRateUUpd(CostRateSet set) throws Exception {
    	set.getCondiVO().setUpdateUser(SessionUtil.getSessionUserId());
    	
       	sqlSession.update("costRate.costRateUpdate",set.getCondiVO());
    	
		set.setRtnMode(Constant.mode.UPDATE_OK.name());

    	return set;
    }
	

}
