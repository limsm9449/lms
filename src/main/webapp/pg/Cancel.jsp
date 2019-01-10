<%@ page contentType="text/html;charset=utf-8"%>
<%@ page import="lgdacom.XPayClient.XPayClient"%>
<%@ page import="org.springframework.context.ApplicationContext"%>
<%@ page import="org.springframework.web.servlet.support.RequestContextUtils"%>
<%@ page import="com.qp.lms.pg.service.PgService"%>
<%@ page import="com.qp.lms.pg.model.PgSet"%>
<%@ page import="com.qp.lms.pg.model.PgVO"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="ko" xml:lang="ko">
<head>
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1"/>
<title>
</title>

<%@ include file="../common/commAxAdminInclude.jsp" %>

</head>

<body>

<%
	PgSet set = new PgSet();
	set.setCondiVO(new PgVO());
	set.getCondiVO().setApprovalId(request.getParameter("approvalId"));

	ApplicationContext ac = RequestContextUtils.getWebApplicationContext(request);
	PgService pgService = (PgService) ac.getBean("pgService");
	boolean isDBOK = pgService.approvalCancel(set);

	if ( isDBOK ) {
	    /*
	     * [결제취소 요청 페이지]
	     *
	     * LG유플러스으로 부터 내려받은 거래번호(LGD_TID)를 가지고 취소 요청을 합니다.(파라미터 전달시 POST를 사용하세요)
	     * (승인시 LG유플러스으로 부터 내려받은 PAYKEY와 혼동하지 마세요.)
	     */
	    String CST_PLATFORM         = request.getParameter("CST_PLATFORM");                 //LG유플러스 결제서비스 선택(test:테스트, service:서비스)
	    String CST_MID              = request.getParameter("CST_MID");                      //LG유플러스으로 부터 발급받으신 상점아이디를 입력하세요.
	    String LGD_MID              = ("test".equals(CST_PLATFORM.trim())?"t":"")+CST_MID;  //테스트 아이디는 't'를 제외하고 입력하세요.
	                                                                                        //상점아이디(자동생성)
	    String LGD_TID              = request.getParameter("LGD_TID");                      //LG유플러스으로 부터 내려받은 거래번호(LGD_TID)
	
		/* ※ 중요
		* 환경설정 파일의 경우 반드시 외부에서 접근이 가능한 경로에 두시면 안됩니다.
		* 해당 환경파일이 외부에 노출이 되는 경우 해킹의 위험이 존재하므로 반드시 외부에서 접근이 불가능한 경로에 두시기 바랍니다. 
		* 예) [Window 계열] C:\inetpub\wwwroot\lgdacom ==> 절대불가(웹 디렉토리)
		*/
	    String configPath 			= (String)request.getAttribute("g_configPath");  										//LG유플러스에서 제공한 환경파일("/conf/lgdacom.conf") 위치 지정.
	        
	    LGD_TID     				= ( LGD_TID == null )?"":LGD_TID; 
	    
	    XPayClient xpay = new XPayClient();
	    xpay.Init(configPath, CST_PLATFORM);
	    xpay.Init_TX(LGD_MID);
	    xpay.Set("LGD_TXNAME", "Cancel");
	    xpay.Set("LGD_TID", LGD_TID);
	 
	    /*
	     * 1. 결제취소 요청 결과처리
	     *
	     * 취소결과 리턴 파라미터는 연동메뉴얼을 참고하시기 바랍니다.
		 *
		 * [[[중요]]] 고객사에서 정상취소 처리해야할 응답코드
		 * 1. 신용카드 : 0000, AV11  
		 * 2. 계좌이체 : 0000, RF00, RF10, RF09, RF15, RF19, RF23, RF25 (환불진행중 응답건-> 환불결과코드.xls 참고)
		 * 3. 나머지 결제수단의 경우 0000(성공) 만 취소성공 처리
		 *
	     */
	    if (xpay.TX()) {
	        //1)결제취소결과 화면처리(성공,실패 결과 처리를 하시기 바랍니다.)
	        out.println("결제 취소요청이 완료되었습니다.  <br>");
	        out.println( "TX Response_code = " + xpay.m_szResCode + "<br>");
	        out.println( "TX Response_msg = " + xpay.m_szResMsg + "<p>");
	        out.println( "<script type='text/javascript'>");
	        out.println( "alert('결제 취소요청이 완료되었습니다.');");
	        out.println( "opener.fn_search();");
	        out.println( "this.close();");
	        out.println( "</script>");
	    }else {
	        //2)API 요청 실패 화면처리
	        out.println("결제 취소요청이 실패하였습니다.  <br>");
	        out.println( "TX Response_code = " + xpay.m_szResCode + "<br>");
	        out.println( "TX Response_msg = " + xpay.m_szResMsg + "<p>");
	        
	    	pgService.approvalCancelRollback(set);
	        out.println("시스템의 결재 취소를 롤백하였습니다.  <br>");
	    }
	} else {
        out.println("시스템의 결재 취소를 실패하였습니다.  <br>");
	}
%>



</body>
</html>
