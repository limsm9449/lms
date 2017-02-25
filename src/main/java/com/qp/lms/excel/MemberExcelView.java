package com.qp.lms.excel;

import java.net.URLEncoder;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.springframework.web.servlet.view.document.AbstractExcelView;

/*
import com.qp.lms.member.model.MemberSet;
import com.qp.lms.member.model.MemberVO;
*/
/*
 * 파일 다운로드..
 */
public class MemberExcelView extends AbstractExcelView {

	@Override
	protected void buildExcelDocument(Map<String,Object> ModelMap,HSSFWorkbook workbook, HttpServletRequest request, HttpServletResponse response) throws Exception{
		/*
		MemberSet set = (MemberSet)ModelMap.get("set");
        
		HSSFSheet worksheet = null;
        HSSFRow row = null;
        	worksheet = workbook.createSheet(URLEncoder.encode("List","UTF-8"));

        	//타이틀
            row = worksheet.createRow(0);
            row.createCell(0).setCellValue("아이디");
            row.createCell(1).setCellValue("이름");
            row.createCell(2).setCellValue("분류");
            row. createCell(3).setCellValue("이메일");
            row.createCell(4).setCellValue("핸드폰");
            row.createCell(5).setCellValue("가입일");

            //내용
            int col = 0;
            for ( int i = 0; i < set.getList().size(); i++ ) {
            	MemberVO rowVO = (MemberVO)set.getList().get(i);
            	
            	col = 0;
                row = worksheet.createRow(i+1);
                row.createCell(col++).setCellValue(rowVO.getUserId());
                row.createCell(col++).setCellValue(rowVO.getUserName());
                //row.createCell(col++).setCellValue(rowVO.getKindName());
                row.createCell(col++).setCellValue(rowVO.getEmail());
                row.createCell(col++).setCellValue(rowVO.getMobile());
                row.createCell(col++).setCellValue(rowVO.getCreateDate());
            }

        response.setContentType("Application/Msexcel");
        response.setHeader("Content-Disposition", "ATTachment; Filename=MemberList" + "Excel.xls");
*/
	}


}