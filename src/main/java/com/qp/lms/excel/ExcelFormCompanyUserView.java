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

/**
 * 주차관리 일괄등록 양식
 * @author limsm
 *
 */
public class ExcelFormCompanyUserView extends AbstractExcelView {

	@Override
	protected void buildExcelDocument(Map<String,Object> ModelMap,HSSFWorkbook workbook, HttpServletRequest request, HttpServletResponse response) throws Exception{
		HSSFSheet worksheet = null;
        HSSFRow row = null;
    	worksheet = workbook.createSheet(URLEncoder.encode("List","UTF-8"));

    	int cIdx = 0;
    	//타이틀
        row = worksheet.createRow(0);
        row.setHeightInPoints(30);
        CommUtil.createTitleCell(workbook, row, cIdx++, "회원 아이디");
        CommUtil.createTitleCell(workbook, row, cIdx++, "이름");
        CommUtil.createTitleCell(workbook, row, cIdx++, "비밀번호");
        CommUtil.createTitleCell(workbook, row, cIdx++, "이메일주소");
        CommUtil.createTitleCell(workbook, row, cIdx++, "핸드폰번호");
        CommUtil.createTitleCell(workbook, row, cIdx++, "집전화번호");
        CommUtil.createTitleCell(workbook, row, cIdx++, "성별(M/F)");
        CommUtil.createTitleCell(workbook, row, cIdx++, "생년월일");

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

        response.setContentType("Application/Msexcel");
        response.setHeader("Content-Disposition", "ATTachment; Filename=ExcelFormCompanyUser" + "_" + CommUtil.getCurrentDateString("yyyyMMdd_HHmmss") + ".xls");
	}



}