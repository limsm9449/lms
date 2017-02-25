package com.qp.lms.common;

public class Constant {
	public static enum mode {
		OK,
		EXIST,SUB_EXIST,
		NOT_EXIST,
		INSERT_OK,
		UPDATE_OK,
		DELETE_OK,
		SAVE_OK,
		CREATE_OK,
		ERROR,
		UPLOAD_OK,
		DUPLICATION,
		RETIRED
	};
	
	/** 첨부할 종류 */
	public static enum attach {B_DATA,B_REPORT};
	
	
	// 한페이지에 출력할 갯수...
	public static int unitPerPage = 10;	  
	public static int unitForBoard = 10;

	public static int unitForMain = 5;	  

	//댓글 리스트 갯수
	public static int unitForReply = 20;	  
}
