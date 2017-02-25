package com.qp.lms.course.service;

import java.io.FileInputStream;
import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.ss.usermodel.WorkbookFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.qp.lms.common.CodeVO;
import com.qp.lms.common.CommUtil;
import com.qp.lms.common.Constant;
import com.qp.lms.common.SessionUtil;
import com.qp.lms.common.service.CommService;
import com.qp.lms.common.service.DdService;
import com.qp.lms.compManager.model.CompUserVO;
import com.qp.lms.course.model.CourseResourceSet;
import com.qp.lms.course.model.CourseResourceVO;

@Service
public class CourseResourceService {
	@Autowired
	private SqlSession sqlSession;

	@Autowired
	private DdService ddService;

	@Autowired
	private CommService commService;

    public CourseResourceSet courseResourceList(CourseResourceSet set) throws Exception {
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

    	List<CourseResourceVO> list = sqlSession.selectList("courseResource.courseResourceList",set.getCondiVO());
    	set.setList(list);
    	
    	//페이징 처리 변수 세팅
    	set.setTotalCount(((CourseResourceVO)sqlSession.selectOne("courseResource.courseResourceTotal",set.getCondiVO())).getCnt());
    	set.setPageUnit(Constant.unitPerPage);
    	
    	return set;
    }
    
    @SuppressWarnings("unchecked") 
    public CourseResourceSet courseResourceN(CourseResourceSet set) throws Exception {
    	List<CodeVO> list =  sqlSession.selectList("courseResource.ddCourseCodeNotInput");
    	set.setDdCourseCode(list);
        
    	return set;
    }
    
    
    public CourseResourceSet courseResourceV(CourseResourceSet set) throws Exception {
    	//주차별 제목을 가져온다.
    	List<CourseResourceVO> list = sqlSession.selectList("courseResource.courseResourceData",set.getCondiVO());
    	set.setList(list);
    	
    	//카테고리, 과정명을 가져온다.
        set.setData((CourseResourceVO)sqlSession.selectOne("courseResource.courseCodeInfo",set.getCondiVO().getCourseCode()));
        
    	return set;
    }
    
    public CourseResourceSet courseResourceU(CourseResourceSet set) throws Exception {
    	//주차별 제목을 가져온다.
    	List<CourseResourceVO> list = sqlSession.selectList("courseResource.courseResourceData",set.getCondiVO());
    	set.setList(list);
    	
    	//카테고리, 과정명을 가져온다.
        set.setData((CourseResourceVO)sqlSession.selectOne("courseResource.courseCodeInfo",set.getCondiVO().getCourseCode()));
        
    	return set;
    }
    
    
    
    ///////////////////////////////////////////////// Transaction ////////////////////////////////////////////////////
    @Transactional(propagation=Propagation.REQUIRED, rollbackFor={Throwable.class})
    public CourseResourceSet courseResourceNIns(CourseResourceSet set) throws Exception {
    	set.getCondiVO().setCreateUser(SessionUtil.getSessionUserId());
    	set.getCondiVO().setUpdateUser(set.getCondiVO().getCreateUser());
    	
		CourseResourceVO vo = (CourseResourceVO)sqlSession.selectOne("courseResource.isExistCourseResource",set.getCondiVO());
		if ( vo.getCnt() == 1 ) {
			set.setRtnMode(Constant.mode.EXIST.name());
			return set;
		}
		
		CourseResourceVO saveVO = new CourseResourceVO();
		saveVO.setCourseCode(set.getCondiVO().getCourseCode());
		saveVO.setCreateUser(set.getCondiVO().getCreateUser());
		for ( int i = 0; i < set.getCondiVO().getWeeks().length; i++ ) {
			saveVO.setWeek(set.getCondiVO().getWeeks()[i]);
			saveVO.setTitle(set.getCondiVO().getTitles()[i]);
			saveVO.setDirectory(set.getCondiVO().getDirectorys()[i]);
			saveVO.setPageCnt(set.getCondiVO().getPageCnts()[i]);
			saveVO.setPreviewPage(set.getCondiVO().getPreviewPages()[i]);
			
			sqlSession.insert("courseResource.courseResourceInsert",saveVO);
		}
    	
		set.setRtnMode(Constant.mode.INSERT_OK.name());
    	
		return set;
    }


    @Transactional(propagation=Propagation.REQUIRED, rollbackFor={Throwable.class})
    public CourseResourceSet courseResourceUUpd(CourseResourceSet set) throws Exception {
    	set.getCondiVO().setCreateUser(SessionUtil.getSessionUserId());
    	
    	//기존거를 삭제한다.
    	sqlSession.delete("courseResource.courseResourceDelete",set.getCondiVO());

    	CourseResourceVO saveVO = new CourseResourceVO();
		saveVO.setCourseCode(set.getCondiVO().getCourseCode());
		saveVO.setUpdateUser(set.getCondiVO().getUpdateUser());
		for ( int i = 0; i < set.getCondiVO().getWeeks().length; i++ ) {
			saveVO.setWeek(set.getCondiVO().getWeeks()[i]);
			saveVO.setTitle(set.getCondiVO().getTitles()[i]);
			saveVO.setDirectory(set.getCondiVO().getDirectorys()[i]);
			saveVO.setPageCnt(set.getCondiVO().getPageCnts()[i]);
			saveVO.setPreviewPage(set.getCondiVO().getPreviewPages()[i]);
			
			sqlSession.insert("courseResource.courseResourceInsert",saveVO);
		}

		set.setRtnMode(Constant.mode.UPDATE_OK.name());
    	
    	return set;
    }

    @Transactional(propagation=Propagation.REQUIRED, rollbackFor={Throwable.class})
    public CourseResourceSet excelUpload(CourseResourceSet set) throws Exception {
    	set.getCondiVO().setCreateUser(SessionUtil.getSessionUserId());

    	String courseCodes = "";
    	
		//과정코드 입력 여부 확인
		Workbook wb = WorkbookFactory.create(new FileInputStream(set.getCondiVO().getFileName()));
    	Sheet sheet = wb.getSheetAt(0);
        int rows = sheet.getPhysicalNumberOfRows(); 
        for (int i = 1; i < rows; i++) { 
            Row row = sheet.getRow(i);

            if ( row != null ) {
            	String data = CommUtil.getCell(row, 0);
            	
            	if ( !data.isEmpty() ) {
            		courseCodes = CommUtil.uniqueKeyAdd(courseCodes, data);
            		System.out.println(i + " : " + courseCodes);
            	}
            }
        }
        String[] arrCourseCodes = CommUtil.stringSplit(courseCodes);
        
		boolean isDup = false;
		String dupCourseCodes = "";
        for ( int i = 0; i < arrCourseCodes.length; i++ ) {
        	set.getCondiVO().setCourseCode(arrCourseCodes[i]);
        	CourseResourceVO tmp = (CourseResourceVO)sqlSession.selectOne("courseResource.isExistCourseResource",set.getCondiVO());
        	if ( tmp.getCnt() > 0 ) {
        		isDup = true;
        		dupCourseCodes += (dupCourseCodes.isEmpty() ? "" : ",") + arrCourseCodes[i];
        	}
        }

        //과정별 주차 입력
        if ( isDup == false ) {
        	CourseResourceVO saveVO = new CourseResourceVO();
        	saveVO.setCreateUser(SessionUtil.getSessionUserId());
        	
            for (int i = 1; i < rows; i++) { 
                Row row = sheet.getRow(i);

        		row.getCell(1).setCellType(HSSFCell.CELL_TYPE_STRING);
        		row.getCell(3).setCellType(HSSFCell.CELL_TYPE_STRING);

        		if ( row != null ) {
                	String data = CommUtil.getCell(row, 0);
            
                	if ( !CommUtil.isEqual(data, "") ) {
                		saveVO.setCourseCode(CommUtil.getCell(row, 0));
                		saveVO.setWeek(CommUtil.getCell(row, 1));
                		saveVO.setTitle(CommUtil.getCell(row, 2));
                		saveVO.setDirectory(CommUtil.getCell(row, 3));
                		saveVO.setPageCnt(CommUtil.getCell(row, 4));

                		sqlSession.insert("courseResource.courseResourceInsert",saveVO);
                	}
                	
                }
            }

            set.setRtnMode(Constant.mode.INSERT_OK.name());
        	
        } else {
        	set.setRtnMode(Constant.mode.DUPLICATION.name());
        	set.setRtnData(dupCourseCodes);
        }
        
    	return set;
    }
    
}
