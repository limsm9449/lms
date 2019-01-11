package com.qp.lms.common;

import java.io.ByteArrayInputStream;
import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.ObjectInputStream;
import java.io.ObjectOutputStream;
import java.math.BigDecimal;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;

import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFCellStyle;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.hssf.util.HSSFColor;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.CellStyle;
import org.apache.poi.ss.usermodel.Font;
import org.apache.poi.ss.usermodel.Row;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.multipart.commons.CommonsMultipartFile;

import net.sf.json.JSONObject;

public class CommUtil {

	public static boolean isMatchUrl(String[] urls, String findUrl) {
		boolean rtn = false;
		
		for ( int i = 0; i < urls.length; i++ ) {
			if ( urls[i].equals(findUrl) ) {
				rtn = true;
				break;
			}
		}
		return rtn; 
	}
	
	public static String writeObject(Object obj) throws Exception {
		ByteArrayOutputStream baos = new ByteArrayOutputStream();
		ObjectOutputStream oos = new ObjectOutputStream(baos);
		oos.writeObject(obj);
		oos.close();
		String temp = new String(baos.toByteArray(),"ISO-8859-1");
		temp = base64Encode(temp);
		return temp; 
	}

	public static Object readObject(String arg) throws Exception {
		arg = base64Decode(arg);
		ByteArrayInputStream bais = new ByteArrayInputStream(arg.getBytes("ISO-8859-1"));
		ObjectInputStream ois = new ObjectInputStream(bais);
		return ois.readObject();
	}
	
	public static String base64Encode(String str) throws java.io.IOException {
		sun.misc.BASE64Encoder encoder = new sun.misc.BASE64Encoder();
		String result = encoder.encodeBuffer(str.getBytes());
		return result;
	}
	
	public static String base64Decode(String str) throws java.io.IOException {
		sun.misc.BASE64Decoder decoder = new sun.misc.BASE64Decoder();
		byte[] b1 = decoder.decodeBuffer(str);
		String result = new String(b1);
		return result;
	}
	
	/*
	 * 경로 및 파일명의 조합에서 파일명만 가져온다.
	 */
	public static String getFileName(String fullFileName) throws Exception  {
		String fileName = fullFileName.substring(fullFileName.lastIndexOf("\\") + 1,fullFileName.length());
		
		return fileName;
	}

	/*
	 * 문자열에서 공백을 제거한 문자열을 넘겨준다.
	 * 단, NULL이면 빈문자열을 넘겨준다.
	 */
	public static String getString(String str) throws Exception  {
		if ( str == null )
			return "";
		else 
			return str.trim();
	}
	
	/**
	 * 엑셀의 Cell에서 데이타를 가져온다.
	 * @param cell
	 * @return
	 * @throws Exception
	 */
	public static String getCell(HSSFCell cell) throws Exception {
		String cellStr = "";
		
		switch ( cell.getCellType() ) {
			case HSSFCell.CELL_TYPE_FORMULA : 
				cellStr = cell.getCellFormula();
				break;
			case HSSFCell.CELL_TYPE_NUMERIC : 
				cellStr = "" + cell.getNumericCellValue();
				break;
			case HSSFCell.CELL_TYPE_STRING : 
				cellStr = "" + cell.getStringCellValue();
				break;
			case HSSFCell.CELL_TYPE_BLANK : 
				cellStr = "";
				break;
			case HSSFCell.CELL_TYPE_ERROR : 
				cellStr = "" + cell.getErrorCellValue();
				break;
		}
		
		return cellStr;
	}
	
	/**
	 * 엑셀의 Cell에서 데이타를 가져온다.
	 * @param row
	 * @param colIdx
	 * @return
	 */
    public static String getCell(Row row, int colIdx) {
        String value = "";

        Cell cell = row.getCell(colIdx); 
        if ( cell != null ) {
            switch (cell.getCellType()) { 
                case HSSFCell.CELL_TYPE_FORMULA:
                    value = cell.getCellFormula();
                    break;
                case HSSFCell.CELL_TYPE_NUMERIC:
                    value = "" + cell.getNumericCellValue();
                    if ( ".0".equals(value.substring(value.length() - 2)) ) {
                    	value = value.substring(0, value.length() -2);
                    }
                    break;
                case HSSFCell.CELL_TYPE_STRING:
                    value = "" + cell.getStringCellValue();
                    break;
                case HSSFCell.CELL_TYPE_BLANK:
                    value = "";
                    break;
                case HSSFCell.CELL_TYPE_ERROR:
                    value = "" + cell.getErrorCellValue();
                    break;
                default:
            }
        }
        
        return ( value == null ? "" : value );
    }
	
	/**
	 * 타이틀 Cell을 생성한다.
	 * @param workbook
	 * @param row
	 * @param idx
	 * @param value
	 * @return
	 * @throws Exception
	 */
	public static HSSFCell createTitleCell(HSSFWorkbook workbook, HSSFRow row,int idx, String value)  throws Exception {
		HSSFCell cell = row.createCell(idx);
		cell.setCellValue(value);
		cell.setCellStyle(createTitleCellStyle(workbook));

		return cell;
	}
	
	/**
	 * 타이틀에 사용할 Cell Style...
	 * @param workbook
	 * @return
	 * @throws Exception
	 */
	public static HSSFCellStyle createTitleCellStyle(HSSFWorkbook workbook)  throws Exception {
		HSSFCellStyle style = workbook.createCellStyle();
		
		style.setAlignment(CellStyle.ALIGN_CENTER);
		style.setVerticalAlignment(CellStyle.VERTICAL_CENTER);
		style.setWrapText(true);
	
		//Border 지정
		style.setBorderLeft(HSSFCellStyle.BORDER_THIN);
		style.setLeftBorderColor(HSSFColor.BLACK.index);
		style.setBorderTop(HSSFCellStyle.BORDER_THIN);
		style.setTopBorderColor(HSSFColor.BLACK.index);
		style.setBorderRight(HSSFCellStyle.BORDER_THIN);
		style.setRightBorderColor(HSSFColor.BLACK.index);
		style.setBorderBottom(HSSFCellStyle.BORDER_THIN);
		style.setBottomBorderColor(HSSFColor.BLACK.index);
	
		//폰트
		Font headFont = workbook.createFont();
		headFont.setFontName("돋움체");
		headFont.setBoldweight(Font.BOLDWEIGHT_BOLD);
		style.setFont(headFont);
		
		return style;
	}	
	
	/**
	 * Contents Cell을 생성한다.
	 * @param workbook
	 * @param row
	 * @param idx
	 * @param value
	 * @return
	 * @throws Exception
	 */
	public static HSSFCell createContentsCell(HSSFWorkbook workbook, HSSFRow row,int idx, String value)  throws Exception {
		HSSFCell cell = row.createCell(idx);
		cell.setCellValue(value);
		cell.setCellStyle(createContentsCellStyle(workbook));

		return cell;
	}
	
	/**
	 * Contents에 사용할 Cell Style...
	 * @param workbook
	 * @return
	 * @throws Exception
	 */
	public static HSSFCellStyle createContentsCellStyle(HSSFWorkbook workbook)  throws Exception {
		HSSFCellStyle style = workbook.createCellStyle();
		
		style.setAlignment(CellStyle.ALIGN_LEFT);
		style.setVerticalAlignment(CellStyle.VERTICAL_CENTER);
		style.setWrapText(true);
	
		//Border 지정
		style.setBorderLeft(HSSFCellStyle.BORDER_THIN);
		style.setLeftBorderColor(HSSFColor.BLACK.index);
		style.setBorderTop(HSSFCellStyle.BORDER_THIN);
		style.setTopBorderColor(HSSFColor.BLACK.index);
		style.setBorderRight(HSSFCellStyle.BORDER_THIN);
		style.setRightBorderColor(HSSFColor.BLACK.index);
		style.setBorderBottom(HSSFCellStyle.BORDER_THIN);
		style.setBottomBorderColor(HSSFColor.BLACK.index);
	
		//폰트
		Font headFont = workbook.createFont();
		headFont.setFontName("돋움체");
		style.setFont(headFont);
		
		return style;
	}	
	
	/*
	 * 첨부 및 다운로드를 위한 디렉토리를 가져온다.
	 */
	public static String getFileFolder() throws Exception {
		String fileFolder = "";
		/*

		fileFolder = SessionUtil.getProperties("serverFileFolder");
		File downloadFile = new File(fileFolder);
		if ( !downloadFile.exists() ) {
			fileFolder = SessionUtil.getProperties("localFileFolder");
		}
		*/
		if ( "DEV".equals(SessionUtil.getSetting("DEV")) ) {
			fileFolder = SessionUtil.getSetting("ATTACH_FOLDER") + "\\";
		} else {
			fileFolder = SessionUtil.getSetting("ATTACH_FOLDER") + "/";
		}
		return fileFolder;
		
	}
	
	public static JSONObject getJsonObject(String rtnMode, String rtnMessage) {
		HashMap hm = new HashMap();
    	hm.put("rtnMode",rtnMode);
    	hm.put("rtnMessage",rtnMessage);
    	
    	return JSONObject.fromObject(hm);
	}
	
	/**
	 * 현재일자를 포맷에 맞춰서 스트링으로 넘겨준다.
	 * dateType : yyyy-MM-dd HH:mm:ss 등...
	 * @param dateType
	 * @return
	 * @throws Exception
	 */
	public static String getCurrentDateString(String dateType) throws Exception {
		String rtn = "";
		
        Calendar currentDate = Calendar.getInstance();
        
        DateFormat df = new SimpleDateFormat(dateType);
        rtn = df.format(currentDate.getTime());
        
        return rtn;
	}

	public static String getAddDay(String dateType, int day) throws Exception {
		String rtn = "";
		
        Calendar currentDate = Calendar.getInstance();
        currentDate.add(Calendar.DAY_OF_MONTH, day);
        
        DateFormat df = new SimpleDateFormat(dateType);
        rtn = df.format(currentDate.getTime());
        
        return rtn;
	}

	public static String saveFile(MultipartHttpServletRequest request) throws Exception {
		String saveFileName = "";
		
    	// 첨부할 루트 디렉토리
    	String attachFolder = getFileFolder();

    	//년별, 월별 디렉토리 존재여부 체크
    	File attachDir = new File(attachFolder + "temp");
    	if ( !attachDir.exists() )
    		attachDir.mkdir();

        saveFileName = attachDir + "//" + UUID.randomUUID().toString();

    	// 파일 처리
    	Map<String, MultipartFile> files = request.getFileMap();
        CommonsMultipartFile cmf = (CommonsMultipartFile) files.get("newFile");
        
    	//파일 저장
        File f = new File(saveFileName);
        cmf.transferTo(f);

        return saveFileName;
	}
	
	/**
	 * 두 변수가 같은지를 비교한다.
	 * @param val1
	 * @param val2
	 * @return
	 * @throws Exception
	 */
	public static boolean isEqual(String val1, String val2) throws Exception {
		String compVal1 = (val1 == null ? "" : val1);
		String compVal2 = (val2 == null ? "" : val2);
		
		if ( compVal1.equals(compVal2) )
			return true;
		else
			return false;
	}
	
	/**
	 * key가 기존 문자열에 없으면 추가를 해준다.
	 * @param pKeys
	 * @param addKey
	 * @param splitStr
	 * @return
	 * @throws Exception
	 */
	public static String uniqueKeyAdd(String pKeys, String addKey) throws Exception {
		return uniqueKeyAdd(pKeys, addKey, ",");
	}
	public static String uniqueKeyAdd(String pKeys, String addKey, String splitStr) throws Exception {
		String keys = pKeys;
		
		if ( addKey == null || "".equals(addKey) ) { 
			return keys;
		} else {
			if ( (keys + splitStr).indexOf(addKey + splitStr) > -1 ) {
				return keys;
			} else {
				return keys + (keys.isEmpty() ? "" : splitStr) + addKey;
			}
		}
	}
	
	/**
	 * 스트링을 분리한다.
	 * @param keys
	 * @param splitStr
	 * @return
	 * @throws Exception
	 */
	public static String[] stringSplit(String str) throws Exception {
		return stringSplit(str, ",");
	}
	public static String[] stringSplit(String str, String splitStr) throws Exception {
		if ( str == null || "".equals(str) ) {
			return new String[]{};
		} else {
			return str.split(splitStr);
		}
	}

	/**
	 * 현재 일자를 구한다.
	 * @param pattern
	 * @return
	 * @throws Exception
	 */
	/*
	public String geCurrenttDate()  throws Exception {
		Calendar c = Calendar.getInstance();
		return geDateStr(c, "YYYY-MM-DD");
	}
	*/

	/**
	 * 일차 추가
	 * @param pattern
	 * @param day
	 * @return
	 * @throws Exception
	 */
	/*
	public String getAddDay(String pattern, int day)  throws Exception {
		Calendar c = Calendar.getInstance();
		c.add(Calendar.DAY_OF_MONTH, day);

		return geDateStr(c, "YYYY-MM-DD");
	}
	*/
	
	/**
	 * 일자를 포맷에 맞춰서 변환한다.
	 * @param c
	 * @param pattern
	 * @return
	 * @throws Exception
	 */
	/*
	public String geDateStr(Calendar c, String pattern)  throws Exception {
		String rtn = "";
		
		String year = Integer.toString(c.get(Calendar.YEAR));
		String month = ( c.get(Calendar.MONTH) < 10 ? "0" : "" ) + Integer.toString(c.get(Calendar.MONTH));
		String day = ( c.get(Calendar.DAY_OF_MONTH) < 10 ? "0" : "" ) + Integer.toString(c.get(Calendar.DAY_OF_MONTH));
		
		if ( "YYYY.MM.DD".equals(pattern) ) {
			rtn = year + "." + month + "." + day;
		} else if ( "YYYY-MM-DD".equals(pattern) ) {
			rtn = year + "-" + month + "-" + day;
		} else if ( "YYYY/MM/DD".equals(pattern) ) {
			rtn = year + "/" + month + "/" + day;
		} else {
			rtn = year + "-" + month + "-" + day;
		}
		
		return rtn;
	}
	*/
	
	/**
	 * 파라미터를 가져온다.
	 * @param request
	 * @return
	 * @throws Exception
	 */
	public static String getParameters(HttpServletRequest request)  throws Exception {
    	String params = "";
    	
    	Map resultMap = null;  
        String paramKey = "";  
        String[] paramValues = null;  
        
        Map map = request.getParameterMap();  
        Iterator iterator = map.keySet().iterator();  
        while (iterator.hasNext())  {  
        	paramKey = (String)iterator.next();  
        	paramValues = (String[])map.get(paramKey);
            
            for ( int i = 0; i < paramValues.length; i++ ) {
            	params += ("".equals(params) ? "" : "&") + paramKey + "=" + paramValues[i];
            }
        }  
        
        return params;
	}
	
	public static void setSesstionInfo(HashMap<String, Object> hm) throws Exception {
		hm.put("SESSION_USER_ID", SessionUtil.getSessionUserId());
		
		hm.put("SESSION_AUTH", SessionUtil.getAuth());
		hm.put("SESSION_COMP_CD", SessionUtil.getCompCd());
		
		hm.put("SESSION_ADMIN_YN", ( SessionUtil.isAdmin() ? "YES" : "NO" ) );
		hm.put("SESSION_SITE_MANAGER_YN", ( SessionUtil.isSiteManager() ? "YES" : "NO" ) );
		hm.put("SESSION_CONTENTS_MANAGER_YN", ( SessionUtil.isContentsManager() ? "YES" : "NO" ) );
		hm.put("SESSION_TUTOR_YN", ( SessionUtil.isTutor() ? "YES" : "NO" ) );
		hm.put("SESSION_TEACHER_YN", ( SessionUtil.isTeacher() ? "YES" : "NO" ) );
	}

	public static int getIntValue(Object obj) throws Exception {
		int rtn = 0;
		
		if ( obj.getClass() == Integer.class ) {
			rtn = ((Integer)obj).intValue();
		} else if ( obj.getClass() == BigDecimal.class ) {
			rtn = ((BigDecimal)obj).intValue();
		} else if ( obj.getClass() == Float.class ) {
			rtn = ((Float)obj).intValue();
		} else if ( obj.getClass() == Long.class ) {
			rtn = ((Long)obj).intValue();
		}
		return rtn;
	}
	
	public static HashMap<String, Object> getParamsHashMap(String params) throws Exception {
		HashMap<String, Object> hm = new HashMap<String, Object>();
		
		String[] paramsArr1 = params.split(",");
		for ( int i = 0 ; i < paramsArr1.length; i++ ) {
			String[] paramsArr2 = paramsArr1[i].split("=");
			hm.put(paramsArr2[0], paramsArr2[1]);
		}
		
		return hm;
	}
	
	private static String capitalize(final String line) throws Exception {
	   return Character.toUpperCase(line.charAt(0)) + line.substring(1);
	}

	public static String getCompTypePage(String page) throws Exception {
		String compType = (String)SessionUtil.getAttribute("compType");
		
		/*
		String b2cPage = "";
		String c2cPage = "";
		String b2bPage = "";
		
		String[] pagePath = page.split("/");
		if ( pagePath.length == 1 ) {
			b2cPage = "/qCh" + capitalize(pagePath[0]);
			c2cPage = "/pCh" + capitalize(pagePath[0]);
			b2bPage = pagePath[0];
		} else if ( pagePath.length == 2 ) {
			b2cPage = "/" + pagePath[0] + "/qCh" + capitalize(pagePath[1]);
			c2cPage = "/" + pagePath[0] + "/pCh" + capitalize(pagePath[1]);
			b2bPage = "/" + pagePath[0] + "/" + pagePath[1];
		}
		*/
		
		if ( compType.equals("B2C") ) {
			//Q 채널
			return page + "Qch";
		} else if ( compType.equals("C2C") ) {
			//P 채널
			return page + "Pch";
		} else if ( compType.equals("B2B") ) {
			//연수원
			return page;
		} else {
			return "error";
		}
	}

	public static String getCompTypePage(String b2cPage, String c2cPage, String b2bPage) throws Exception {
		String compType = (String)SessionUtil.getAttribute("compType");
		
		if ( compType.equals("B2C") ) {
			//Q 채널
			return b2cPage;
		} else if ( compType.equals("C2C") ) {
			//P 채널
			return c2cPage;
		} else if ( compType.equals("B2B") ) {
			//연수원
			return b2bPage;
		} else {
			return "error";
		}
	}

}
