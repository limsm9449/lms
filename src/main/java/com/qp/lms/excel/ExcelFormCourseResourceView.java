package com.qp.lms.excel;

import java.net.URLEncoder;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Calendar;
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
public class ExcelFormCourseResourceView extends AbstractExcelView {

	@Override
	protected void buildExcelDocument(Map<String,Object> ModelMap,HSSFWorkbook workbook, HttpServletRequest request, HttpServletResponse response) throws Exception{
		HSSFSheet worksheet = null;
        HSSFRow row = null;
    	worksheet = workbook.createSheet(URLEncoder.encode("List","UTF-8"));

    	int cIdx = 0;
    	//타이틀
        row = worksheet.createRow(0);
        row.setHeightInPoints(30);
        CommUtil.createTitleCell(workbook, row, cIdx++, "과정코드");
        CommUtil.createTitleCell(workbook, row, cIdx++, "주차");
        CommUtil.createTitleCell(workbook, row, cIdx++, "목차");
        CommUtil.createTitleCell(workbook, row, cIdx++, "경로");
        CommUtil.createTitleCell(workbook, row, cIdx++, "페이지수");

        //컬럼 사이즈 조절
        cIdx = 0;
        worksheet.setColumnWidth(cIdx++, 4000);
        worksheet.setColumnWidth(cIdx++, 4000);
        worksheet.setColumnWidth(cIdx++, 10000);
        worksheet.setColumnWidth(cIdx++, 4000);
        worksheet.setColumnWidth(cIdx++, 4000);

        //내용
        cIdx = 0;
        row = worksheet.createRow(1);
        row.setHeightInPoints(15);
        CommUtil.createContentsCell(workbook, row, cIdx++, "C010101001");
        CommUtil.createContentsCell(workbook, row, cIdx++, "1");
        CommUtil.createContentsCell(workbook, row, cIdx++, "목차");
        CommUtil.createContentsCell(workbook, row, cIdx++, "01");
        CommUtil.createContentsCell(workbook, row, cIdx++, "15");

        response.setContentType("Application/Msexcel");
        response.setHeader("Content-Disposition", "ATTachment; Filename=ExcelFormCourseResource" + "_" + CommUtil.getCurrentDateString("yyyyMMdd_HHmmss") + ".xls");
	}



}