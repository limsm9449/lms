package com.qp.lms.excel;

import java.net.URLEncoder;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.springframework.web.servlet.view.document.AbstractExcelView;

import com.qp.lms.common.CommUtil;
import com.qp.lms.compManager.model.CompUserSet;
import com.qp.lms.compManager.model.CompUserVO;

/*
import com.qp.lms.member.model.MemberSet;
import com.qp.lms.member.model.MemberVO;
*/
/*
 * 파일 다운로드..
 */
public class UploadInvalidExcelView extends AbstractExcelView {

	@Override
	protected void buildExcelDocument(Map<String,Object> ModelMap,HSSFWorkbook workbook, HttpServletRequest request, HttpServletResponse response) throws Exception{
		CompUserSet set = (CompUserSet)ModelMap.get("set");
        
		HSSFSheet worksheet = null;
        HSSFRow row = null;
    	worksheet = workbook.createSheet(URLEncoder.encode("List","UTF-8"));

    	int cIdx = 0;
    	//타이틀
        row = worksheet.createRow(0);
        row.createCell(cIdx++).setCellValue("회원 아이디");
        row.createCell(cIdx++).setCellValue("이름");
        row.createCell(cIdx++).setCellValue("비밀번호");
        row.createCell(cIdx++).setCellValue("이메일주소");
        row.createCell(cIdx++).setCellValue("핸드폰번호");
        row.createCell(cIdx++).setCellValue("집전화번호");
        row.createCell(cIdx++).setCellValue("성별(M/F)");
        row.createCell(cIdx++).setCellValue("생년월일");
        row.createCell(cIdx++).setCellValue("검증");

        //컬럼 사이즈 조절
        cIdx = 0;
        worksheet.setColumnWidth(cIdx++, 4000);
        worksheet.setColumnWidth(cIdx++, 4000);
        worksheet.setColumnWidth(cIdx++, 4000);
        worksheet.setColumnWidth(cIdx++, 10000);
        worksheet.setColumnWidth(cIdx++, 6000);
        worksheet.setColumnWidth(cIdx++, 6000);
        worksheet.setColumnWidth(cIdx++, 4000);
        worksheet.setColumnWidth(cIdx++, 4000);
        worksheet.setColumnWidth(cIdx++, 20000);
        
        //내용
        for ( int i = 0; i < set.getList().size(); i++ ) {
            row = worksheet.createRow(i + 1);

        	cIdx = 0;
        	
            CompUserVO rowVO = (CompUserVO)set.getList().get(i);
            
            row.createCell(cIdx++).setCellValue(rowVO.getUserId());
            row.createCell(cIdx++).setCellValue(rowVO.getUserName());
            row.createCell(cIdx++).setCellValue(rowVO.getUserPassword());
            row.createCell(cIdx++).setCellValue(rowVO.getEmail());
            row.createCell(cIdx++).setCellValue(rowVO.getMobile());
            row.createCell(cIdx++).setCellValue(rowVO.getHomeTel());
            row.createCell(cIdx++).setCellValue(rowVO.getSex());
            row.createCell(cIdx++).setCellValue(rowVO.getBirthDay());
            row.createCell(cIdx++).setCellValue(rowVO.getError());
        }

        response.setContentType("Application/Msexcel");
        response.setHeader("Content-Disposition", "ATTachment; Filename=UploadValidation" + "Excel.xls");
	}


}