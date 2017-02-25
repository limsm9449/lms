package com.qp.lms.category.service;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.qp.lms.category.model.CategorySet;
import com.qp.lms.category.model.CategoryVO;
import com.qp.lms.common.CodeVO;
import com.qp.lms.common.Constant;
import com.qp.lms.common.SessionUtil;
import com.qp.lms.common.service.DdService;
import com.qp.lms.course.model.CourseSet;
import com.qp.lms.course.model.CourseVO;

@Service
public class CategoryService {
	@Autowired
	private SqlSession sqlSession;
	
	@Autowired
	private DdService ddService;

    public CategorySet categoryList(CategorySet set) throws Exception {
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

    	List<CategoryVO> list = sqlSession.selectList("category.categoryList",set.getCondiVO());
    	set.setList(list);

    	//페이징 처리 변수 세팅
    	set.setTotalCount(((CategoryVO)sqlSession.selectOne("category.categoryListTotal",set.getCondiVO())).getCnt());
    	set.setPageUnit(Constant.unitPerPage);
        
    	
    	return set;
    }
	
    public CategorySet category2DepthN(CategorySet set) throws Exception {
    	// 카테고리 대분류 
    	set.setDdCategory1Depth(ddService.getDdCategory1Depth());
      	
    	return set;
    }
    
    public CategorySet category3DepthN(CategorySet set) throws Exception {
    	// 카테고리 대분류 
    	set.setDdCategory1Depth(ddService.getDdCategory1Depth());
      	
    	// 카테고리 중분류 
    	set.setDdCategory2Depth(ddService.getDdCategory2Depth(set.getCondiVO().getC1Code()));
    	
    	return set;
    } 
    
    public CategorySet categoryU(CategorySet set) throws Exception {
    	// 카테고리 정보
    	set.setData((CategoryVO)sqlSession.selectOne("category.categoryInfo",set.getCondiVO().getCode()));
      	
    	//상위 카테고리 정보를 구한다.
    	if ( "3".equals(set.getCondiVO().getDepth()) ) {
    		CategoryVO depth2 = (CategoryVO)sqlSession.selectOne("category.categoryInfo",set.getData().getParentCode());
    		CategoryVO depth1 = (CategoryVO)sqlSession.selectOne("category.categoryInfo",depth2.getParentCode());
    		
    		set.getData().setCodeNames(depth1.getCodeName() + " > " + depth2.getCodeName() + " > ");
    	} else if ( "2".equals(set.getCondiVO().getDepth()) ) {
    		CategoryVO depth1 = (CategoryVO)sqlSession.selectOne("category.categoryInfo",set.getData().getParentCode());
    		
    		set.getData().setCodeNames(depth1.getCodeName() + " > ");
    	}
    	
    	//하위로 데이타가 있는지 확인한다.
    	if ( "1".equals(set.getCondiVO().getDepth()) || "2".equals(set.getCondiVO().getDepth()) ) {
    		CategoryVO vo = (CategoryVO)sqlSession.selectOne("category.subCategoryCount",set.getCondiVO().getCode());
    		set.getData().setSubCnt(vo.getSubCnt());
    	} else if ( "3".equals(set.getCondiVO().getDepth()) ) {
    		CategoryVO vo = (CategoryVO)sqlSession.selectOne("category.subCourseCount",set.getCondiVO().getCode());
    		set.getData().setSubCnt(vo.getSubCnt());
    	}
    	
    	return set;
    } 
    
    
    
    
    
    
    
    ///////////////////////////////////////////////// Transaction ////////////////////////////////////////////////////
    
    @Transactional(propagation=Propagation.REQUIRED, rollbackFor={Throwable.class})
    public CategorySet category1DepthIns(CategorySet set) throws Exception {
    	CategoryVO vo = (CategoryVO)sqlSession.selectOne("category.codeCnt",set.getCondiVO());
		if ( vo.getCnt() == 1 ) {
			set.setRtnMode(Constant.mode.EXIST.name());
			return set;
		}
      	
		sqlSession.insert("category.categoryIns",set.getCondiVO());
		set.setRtnMode(Constant.mode.INSERT_OK.name());
		
    	return set;
    }
    
    @Transactional(propagation=Propagation.REQUIRED, rollbackFor={Throwable.class})
    public CategorySet category2DepthIns(CategorySet set) throws Exception {
    	CategoryVO vo = (CategoryVO)sqlSession.selectOne("category.codeCnt",set.getCondiVO());
		if ( vo.getCnt() == 1 ) {
			set.setRtnMode(Constant.mode.EXIST.name());
			return set;
		}
      	
		sqlSession.insert("category.categoryIns",set.getCondiVO());
		set.setRtnMode(Constant.mode.INSERT_OK.name());
		
    	return set;
    }
    
    @Transactional(propagation=Propagation.REQUIRED, rollbackFor={Throwable.class})
    public CategorySet category3DepthIns(CategorySet set) throws Exception {
    	CategoryVO vo = (CategoryVO)sqlSession.selectOne("category.codeCnt",set.getCondiVO());
		if ( vo.getCnt() == 1 ) {
			set.setRtnMode(Constant.mode.EXIST.name());
			return set;
		}
      	
		sqlSession.insert("category.categoryIns",set.getCondiVO());
		set.setRtnMode(Constant.mode.INSERT_OK.name());
		
    	return set;
    }
    
    @Transactional(propagation=Propagation.REQUIRED, rollbackFor={Throwable.class})
    public CategorySet categoryUUpd(CategorySet set) throws Exception {
		sqlSession.insert("category.categoryUpd",set.getCondiVO());
		set.setRtnMode(Constant.mode.UPDATE_OK.name());
		
    	return set;
    }
    
    @Transactional(propagation=Propagation.REQUIRED, rollbackFor={Throwable.class})
    public CategorySet categoryUDel(CategorySet set) throws Exception {
		sqlSession.insert("category.categoryDel",set.getCondiVO());
		set.setRtnMode(Constant.mode.DELETE_OK.name());
		
    	return set;
    }
    
    
    
    
    
    
}
