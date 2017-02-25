package com.qp.lms.compManager.service;

import java.io.FileInputStream;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.ss.usermodel.WorkbookFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.qp.lms.common.Constant;
import com.qp.lms.common.SessionUtil;
import com.qp.lms.common.service.DdService;
import com.qp.lms.compManager.model.CompUserSet;
import com.qp.lms.compManager.model.CompUserVO;
import com.qp.lms.member.model.MemberVO;

@Service
public class CompUserService {
	@Autowired
	private SqlSession sqlSession;

	@Autowired
	private DdService ddService;

    public CompUserSet compUserList(CompUserSet set) throws Exception {
    	set.getCondiVO().setWorkerId(SessionUtil.getSessionUserId());

    	//소속 회사코드
    	set.setCompCd(((CompUserVO)sqlSession.selectOne("compUser.userCompCd",set.getCondiVO())).getCompCd());
    	
    	//쿼리에서 가져올 갯수 지정
    	set.getCondiVO().setLimitUnit(Constant.unitPerPage);

    	List<CompUserVO> list = sqlSession.selectList("compUser.compUserList",set.getCondiVO());
    	set.setList(list);
    	
    	//페이징 처리 변수 세팅
    	set.setTotalCount(((CompUserVO)sqlSession.selectOne("compUser.compUserTotal",set.getCondiVO())).getCnt());
    	set.setPageUnit(Constant.unitPerPage);
    	
    	return set;
    }

    ///////////////////////////////////////////////// Transaction ////////////////////////////////////////////////////
    
    @Transactional(propagation=Propagation.REQUIRED, rollbackFor={Throwable.class})
    public CompUserSet excelUpload(CompUserSet set) throws Exception {
    	set.getCondiVO().setWorkerId(SessionUtil.getSessionUserId());
    	
    	//기존거 삭제
		sqlSession.delete("compUser.compUserDel",set.getCondiVO());

		//데이타 입력
		Workbook wb = WorkbookFactory.create(new FileInputStream(set.getCondiVO().getFileName()));
    	Sheet sheet = wb.getSheetAt(0);
        int rows = sheet.getPhysicalNumberOfRows(); 
        for (int i = 1; i < rows; i++) { 
            Row row = sheet.getRow(i);

            if ( row != null ) {
            	set.getCondiVO().setUserId(getCell(row, 0));
            	set.getCondiVO().setUserName(getCell(row, 1));
            	set.getCondiVO().setUserPassword(getCell(row, 2));
            	set.getCondiVO().setEmail(getCell(row, 3));
            	set.getCondiVO().setMobile(getCell(row, 4));
            	set.getCondiVO().setHomeTel(getCell(row, 5));
            	set.getCondiVO().setSex(getCell(row, 6));
            	set.getCondiVO().setBirthDay(getCell(row, 7));

        		if ( set.getCondiVO().getHomeTel() != null && !"".equals(set.getCondiVO().getHomeTel()) ) {
        			String[] homeTel = set.getCondiVO().getHomeTel().replaceAll("-"," - ").split("-");
        			set.getCondiVO().setHomeTel1(homeTel[0].trim());
        			set.getCondiVO().setHomeTel2(homeTel[1].trim());
    	    		set.getCondiVO().setHomeTel3(homeTel[2].trim());
        		}
        		
        		if ( set.getCondiVO().getMobile() != null && !"".equals(set.getCondiVO().getMobile()) ) {
    	    		String[] mobile = set.getCondiVO().getMobile().replaceAll("-"," - ").split("-");
    	    		set.getCondiVO().setMobile1(mobile[0].trim());
    	    		set.getCondiVO().setMobile2(mobile[1].trim());
    	    		set.getCondiVO().setMobile3(mobile[2].trim());
        		}

    			sqlSession.insert("compUser.compUserIns",set.getCondiVO());
            }
        }
    	
        // 에러 체크
        sqlSession.update("compUser.compUserErrorChk",set.getCondiVO());
        
        CompUserVO tmp = (CompUserVO)sqlSession.selectOne("compUser.uploadInvalidCnt",set.getCondiVO());
        if ( tmp.getCnt() > 0 ) {
        	List<CompUserVO> list = sqlSession.selectList("compUser.uploadExcelList",set.getCondiVO());
        	set.setList(list);
        	
        	set.setRtnMode(Constant.mode.DUPLICATION.name());
        } else {
            sqlSession.insert("compUser.userIns",set.getCondiVO());

            set.setRtnMode(Constant.mode.UPLOAD_OK.name());
        }
        
    	return set;
    }
    
    public String getCell(Row row, int colIdx) {
        String value = "";

        Cell cell = row.getCell(colIdx); 
        if ( cell != null ) {
            switch (cell.getCellType()) { 
                case HSSFCell.CELL_TYPE_FORMULA:
                    value = cell.getCellFormula();
                    break;
                case HSSFCell.CELL_TYPE_NUMERIC:
                    value = "" + cell.getNumericCellValue();
                    break;
                case HSSFCell.CELL_TYPE_STRING:
                    value = "" + cell.getStringCellValue();
                    break;
                case HSSFCell.CELL_TYPE_BLANK:
                    value = "" + cell.getBooleanCellValue();
                    break;
                case HSSFCell.CELL_TYPE_ERROR:
                    value = "" + cell.getErrorCellValue();
                    break;
                default:
            }
        }
        
        return value;
    }
    
}
