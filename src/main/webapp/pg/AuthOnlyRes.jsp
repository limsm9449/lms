<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page import="lgdacom.XPayClient.XPayClient"%>

<%
    /*
     * [본인확인 처리 페이지]
     *
	 * 매뉴얼 "4. 본인확인 서비스 이용을 위한 개발"의 "V. 본인확인 최종 인증" 참조
	 *
     * LG유플러스으로 부터 내려받은 LGD_AUTHONLYKEY(인증Key)를 가지고 최종 인증요청.(파라미터 전달시 POST를 사용하세요)
     */

    //String configPath = "C:/lgdacom";  //LG유플러스에서 제공한 환경파일("/conf/lgdacom.conf,/conf/mall.conf") 위치 지정.
    String configPath = (String)request.getAttribute("g_configPath");  //LG유플러스에서 제공한 환경파일("/conf/lgdacom.conf,/conf/mall.conf") 위치 지정.
    
    /*
     *************************************************
     * 1.최종인증 요청 - BEGIN
     *************************************************
     */
    
    String CST_PLATFORM                 = request.getParameter("CST_PLATFORM");
    String CST_MID                      = request.getParameter("CST_MID");
    String LGD_MID                      = ("test".equals(CST_PLATFORM.trim())?"t":"")+CST_MID;
    String LGD_AUTHONLYKEY              = request.getParameter("LGD_AUTHONLYKEY");            //LG유플러스으로부터 부여받은 인증키
    String LGD_PAYTYPE    				= request.getParameter("LGD_PAYTYPE");                //인증요청타입 (신용카드:ASC001, 휴대폰 대체인증:ASC007, 계좌:ASC004)

    //해당 API를 사용하기 위해 WEB-INF/lib/XPayClient.jar 를 Classpath 로 등록하셔야 합니다. 
	// (1) XpayClient의 사용을 위한 xpay 객체 생성
    XPayClient xpay = new XPayClient();

	// (2) Init: XPayClient 초기화(환경설정 파일 로드) 
	// configPath: 설정파일
	// CST_PLATFORM: - test, service 값에 따라 lgdacom.conf의 test_url(test) 또는 url(srvice) 사용
	//				- test, service 값에 따라 테스트용 또는 서비스용 아이디 생성
   	boolean isInitOK = xpay.Init(configPath, CST_PLATFORM);   	

	
    if( !isInitOK ) {
    	//API 초기화 실패 화면처리
        out.println( "결제요청을 초기화 하는데 실패하였습니다.<br>");
        out.println( "LG유플러스에서 제공한 환경파일이 정상적으로 설치 되었는지 확인하시기 바랍니다.<br>");        
        out.println( "mall.conf에는 Mert ID = Mert Key 가 반드시 등록되어 있어야 합니다.<br><br>");
        out.println( "문의전화 LG유플러스 1544-7772<br>");
        return;
    }     

	try{
		// (3) Init_TX: 메모리에 mall.conf, lgdacom.conf 할당 및 트랜잭션의 고유한 키 TXID 생성
	    xpay.Init_TX(LGD_MID);
	    xpay.Set("LGD_TXNAME", "AuthOnlyByKey");
	    xpay.Set("LGD_AUTHONLYKEY", LGD_AUTHONLYKEY);
	    xpay.Set("LGD_PAYTYPE", LGD_PAYTYPE);
	    
    }catch(Exception e) {
		// LG U+ API 사용 불가, 설정파일 확인 등 필요(예외처리)
    	out.println("LG유플러스 제공 API를 사용할 수 없습니다. 환경파일 설정을 확인해 주시기 바랍니다. ");
    	out.println(""+e.getMessage());    	
    	return;
    }

	/*
     *************************************************
     * 1.최종인증 요청(수정하지 마세요) - END
     *************************************************
     */


    /*
     * 2. 최종 인증요청 결과처리
     *
     * 최종 인증요청 결과 리턴 파라미터는 연동메뉴얼을 참고하시기 바랍니다.
     */
	 // (4) TX: lgdacom.conf에 설정된 URL로 소켓 통신하여 최종 인증요청, 결과값으로 true, false 리턴
     if ( xpay.TX() ) {
         //1)인증결과 화면처리(성공,실패 결과 처리를 하시기 바랍니다.)
         out.println( "인증요청이 완료되었습니다.  <br>");
         out.println( "TX 인증요청 Response_code = " + xpay.m_szResCode + "<br>");
         out.println( "TX 인증요청 Response_msg = " + xpay.m_szResMsg + "<p>");
         
		 // 인증요청 결과 데이터 출력
         for (int i = 0; i < xpay.ResponseNameCount(); i++)
         {
             out.println(xpay.ResponseName(i) + " = ");
             for (int j = 0; j < xpay.ResponseCount(); j++)
             {
                 out.println("\t" + xpay.Response(xpay.ResponseName(i), j) + "<br>");
             }
         }
         out.println("<p>");
         
		 // (5) DB에 인증요청 결과 처리
         if( "0000".equals( xpay.m_szResCode ) ) {
         	//인증요청 결과 성공 DB처리
         	out.println("인증요청 결과 성공 DB처리하시기 바랍니다.<br>");
         }else{
         	//인증요청 결과 실패 DB처리
         	out.println("인증요청 결과 실패 DB처리하시기 바랍니다.<br>");            	
         }
 	}else {
         //2)API 요청실패 화면처리
         out.println( "인증요청이 실패하였습니다.  <br>");
         out.println( "TX 인증요청 Response_code = " + xpay.m_szResCode + "<br>");
         out.println( "TX 인증요청 Response_msg = " + xpay.m_szResMsg + "<p>");
         
     	//최종인증요청 결과 실패 DB처리
     	out.println("최종인증요청 결과 실패 DB처리하시기 바랍니다.<br>");            	            
     }
%>