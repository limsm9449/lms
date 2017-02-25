package com.qp.lms.point.service;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.qp.lms.common.Constant;
import com.qp.lms.common.service.DdService;
import com.qp.lms.course.model.CourseMasterVO;
import com.qp.lms.point.model.PointSet;
import com.qp.lms.point.model.PointVO;

@Service
public class PointService {
	@Autowired
	private SqlSession sqlSession;
	
	@Autowired
	private DdService ddService;

    public PointSet pointUserList(PointSet set) throws Exception {
    	//쿼리에서 가져올 갯수 지정
    	set.getCondiVO().setLimitUnit(Constant.unitPerPage);

    	List<PointVO> list = sqlSession.selectList("point.pointUserList",set.getCondiVO());
    	set.setList(list);
    	
    	//페이징 처리 변수 세팅
    	set.setTotalCount(((PointVO)sqlSession.selectOne("point.pointUserTotal",set.getCondiVO())).getCnt());
    	set.setPageUnit(Constant.unitPerPage);
    	
    	return set;
    }
    
    public PointSet pointUserV(PointSet set) throws Exception {
    	//잔여 포인트
    	PointVO vo = (PointVO)sqlSession.selectOne("point.pointUserSum",set.getCondiVO());
    	set.setRemainPoint(vo.getRemainPoint());
    	
    	List<PointVO> pointList = sqlSession.selectList("point.pointUserData",set.getCondiVO());
    	set.setPointList(pointList);

    	return set;
    }
    
    
    

}
