<%@ page contentType="text/html;charset=utf-8"%>
<%@ page import="java.io.*" %>
<%@ page import="java.text.*" %>
<%@ page import="java.util.*" %>
<%@ page import="java.net.*" %>
<%@ page import="java.security.MessageDigest" %>
<%@ page import="lgdacom.XPayClient.XPayClient"%>

<%
	/*
	 * [본인확인 요청페이지]
	 *
	 * 샘플페이지에서는 기본 파라미터만 예시되어 있으며, 별도로 필요하신 파라미터는 연동메뉴얼을 참고하시어 추가 하시기 바랍니다.
	 */
	
	/*
	 * 1. 기본 인증요청 정보 변경
	 *
	 * 기본정보를 변경하여 주시기 바랍니다.(파라미터 전달시 POST를 사용하세요)
	 */
	String CST_PLATFORM 			= request.getParameter("CST_PLATFORM");                 // LG유플러스 결제서비스 선택(test:테스트, service:서비스)
	String CST_MID              	= request.getParameter("CST_MID");                    	// LG유플러스으로 부터 발급받으신 상점아이디를 입력하세요.
																							// 테스트 아이디는 't'를 반드시 제외하고 입력하세요.(CST_MID: LGD_MID를 설정하기 위한 상점아이디)
	String LGD_MID              	= ("test".equals(CST_PLATFORM.trim())?"t":"")+CST_MID;  // 상점 아이디 LGD_MID는 CST_PLATFORM의 값에 따라 테스트용 또는 서비스용 아이디로 설정됨

	String LGD_MERTKEY          	= (String)request.getAttribute("g_LGD_MERTKEY");		// [반드시 세팅]상점MertKey(mertkey는 상점관리자 -> 계약정보 -> 상점정보관리에서 확인하실수 있습니다')
																							// 상점아이디와 매핑되는 MertKey를 LGD_MERTKEY에 할당

	String LGD_BUYER            	= request.getParameter("LGD_BUYER");              		// 성명(보안을 위해 DB난 세션에서 가져오세요)
	String LGD_BUYERSSN         	= request.getParameter("LGD_BUYERSSN");           		/* 	생년월일 6자리 (YYMMDD) 또는 사업자번호 10자리	
																							 	휴대폰 본인인증을 사용할 경우 생년월일은 '0' 6자리를 넘기세요. 예)000000
																								기타 인증도 사용할 경우 생년월일 (보안을 위해 DB나 세션에 저장처리 권장)
																							*/ 
	String LGD_NAMECHECKYN 			= request.getParameter("LGD_NAMECHECKYN");				// 계좌실명확인여부
	String LGD_HOLDCHECKYN 			= request.getParameter("LGD_HOLDCHECKYN");				// 휴대폰본인확인 SMS발송 여부
	String LGD_MOBILE_SUBAUTH_SITECD = request.getParameter("LGD_MOBILE_SUBAUTH_SITECD");	// 신용평가사에서 부여받은 회원사 고유 코드
																							// (CI값만 필요한 경우 옵션, DI값도 필요한 경우 필수)
	String LGD_CUSTOM_USABLEPAY 	= request.getParameter("LGD_CUSTOM_USABLEPAY");			// [반드시 설정]상점정의 이용가능 인증수단으로 한 개의 값만 설정 (예:"ASC007") 
	String LGD_TIMESTAMP        	= request.getParameter("LGD_TIMESTAMP");            	// 타임스탬프(YYYYMMDDhhmmss)
	String LGD_CUSTOM_SKIN      	= "red";                                            	// 본인확인창 스킨 컬러
	String LGD_WINDOW_TYPE         	= request.getParameter("LGD_WINDOW_TYPE");           	// 본인확인창 호출 방식 (수정불가) 	
	
	//LGD_RETURNURL 을 설정하여 주시기 바랍니다. 반드시 현재 페이지와 동일한 프로트콜 및  호스트이어야 합니다. 아래 부분을 반드시 수정하십시요.
	//String LGD_RETURNURL			= "http://상점 URL/returnurl.jsp";		// FOR MANUAL
	String LGD_RETURNURL			= (String)request.getAttribute("g_LGD_AUTH_RETURNURL");		// FOR MANUAL

	   
	/*
	 *************************************************
	 * 2. MD5 해쉬암호화 (수정하지 마세요) - BEGIN
	 *
	 * MD5 해쉬암호화는 거래 위변조를 막기위한 방법입니다.
	 *************************************************
	 *
	 * 해쉬 암호화 적용( LGD_MID + LGD_BUYERSSN + LGD_TIMESTAMP + LGD_MERTKEY )
	 * LGD_MID          : 상점아이디
	 * LGD_BUYERSSN     : 생년월일 / 사업자번호
	 * LGD_TIMESTAMP    : 타임스탬프
	 * LGD_MERTKEY      : 상점MertKey (mertkey는 상점관리자 -> 계약정보 -> 상점정보관리에서 확인하실수 있습니다)
	 *
	 * MD5 해쉬데이터 암호화 검증을 위해
	 * LG유플러스에서 발급한 상점키(MertKey)를 환경설정 파일(lgdacom/conf/mall.conf)에 반드시 입력하여 주시기 바랍니다.
	 */
	StringBuffer sb = new StringBuffer();
	sb.append(LGD_MID);
	sb.append(LGD_BUYERSSN);
	sb.append(LGD_TIMESTAMP);
	sb.append(LGD_MERTKEY);
	
	byte[] bNoti = sb.toString().getBytes();
	MessageDigest md = MessageDigest.getInstance("MD5");
	byte[] digest = md.digest(bNoti);
	
	StringBuffer strBuf = new StringBuffer();
	for (int i=0 ; i < digest.length ; i++) {
	    int c = digest[i] & 0xff;
	    if (c <= 15){
	        strBuf.append("0");
	    }
	    strBuf.append(Integer.toHexString(c));
	}
	
	String LGD_HASHDATA = strBuf.toString();						//검증을 위한 데이터
	
	
   /*
    *************************************************
    * 2. MD5 해쉬암호화 (수정하지 마세요) - END
    *************************************************
    */
	Map payReqMap = new HashMap();
	    
	payReqMap.put("CST_PLATFORM"                , CST_PLATFORM);                   		// 테스트, 서비스 구분
	payReqMap.put("CST_MID"                     , CST_MID );                        	// 상점아이디
	payReqMap.put("LGD_MID"                     , LGD_MID );                        	// 상점아이디
	payReqMap.put("LGD_HASHDATA"                , LGD_HASHDATA );      	           		// MD5 해쉬암호값
	payReqMap.put("LGD_BUYER"                   , LGD_BUYER );                      	// 구매자
	payReqMap.put("LGD_BUYERSSN"                , LGD_BUYERSSN );                      	// 생년월일 6자리 (YYMMDD) 또는 사업자번호 10자리, 휴대폰 본인인증을 사용할 경우 생년월일은 '0' 6자리를 넘기세요. 예)000000
	payReqMap.put("LGD_NAMECHECKYN"				, LGD_NAMECHECKYN );                  	// 계좌실명확인여부
	payReqMap.put("LGD_HOLDCHECKYN"				, LGD_HOLDCHECKYN );                   	// 휴대폰본인확인 SMS발송 여부
	payReqMap.put("LGD_MOBILE_SUBAUTH_SITECD"   , LGD_MOBILE_SUBAUTH_SITECD );         	// 신용평가사에서 부여받은 회원사 고유 코드
	payReqMap.put("LGD_CUSTOM_SKIN"             , LGD_CUSTOM_SKIN );                	// 본인확인창 SKIN
	payReqMap.put("LGD_TIMESTAMP"               , LGD_TIMESTAMP );                  	// 타임스탬프
	payReqMap.put("LGD_CUSTOM_USABLEPAY"  		, LGD_CUSTOM_USABLEPAY );				// 디폴트 결제수단 (해당 필드를 보내지 않으면 결제수단 선택 UI 가 보이게 됩니다.)
	payReqMap.put("LGD_WINDOW_TYPE"             , LGD_WINDOW_TYPE );                   	// 본인확인창 호출 방식 (수정불가)
	payReqMap.put("LGD_RETURNURL"   			, LGD_RETURNURL );      			   	// 응답수신페이지
	payReqMap.put("LGD_VERSION"  				, "JSP_NON-ActiveX_AuthOnly" );			// 사용타입 정보(수정 및 삭제 금지): 이 정보를 근거로 어떤 서비스를 사용하는지 판단할 수 있습니다.
	 
	
	/*Return URL에서 인증 결과 수신 시 셋팅될 파라미터 입니다.*/
	payReqMap.put("LGD_RESPCODE"		, "" );
	payReqMap.put("LGD_RESPMSG"			, "" );
	payReqMap.put("LGD_AUTHONLYKEY"		, "" );
	payReqMap.put("LGD_PAYTYPE"			, "" );
	
	session.setAttribute("PAYREQ_MAP", payReqMap);
%>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>LG유플러스 전자결제 본인확인서비스  샘플 페이지</title>
	<!-- 고객사 사이트가 https인 경우는 아래 http://을 https:// 으로 변경하시면 됩니다. -->
<script language="javascript" src="http://xpay.uplus.co.kr/xpay/js/xpay_crossplatform.js" type="text/javascript"></script>
<script type="text/javascript">

	/*
	* 수정불가.
	*/
	var LGD_window_type = '<%=LGD_WINDOW_TYPE%>';
	
	/*
	* 수정불가.
	*/
	function launchCrossPlatform(){
		
		lgdwin = openAuthonly( document.getElementById('LGD_PAYINFO'), '<%= CST_PLATFORM %>', LGD_window_type, null );
	}
	
	/*
	* FORM 명만  수정 가능
	*/
	function getFormObject() {
	        return document.getElementById("LGD_PAYINFO");
	}
	
	function  payment_return() {
		
		var fDoc = lgdwin.contentWindow || lgdwin.contentDocument;
	
		if (fDoc.document.getElementById('LGD_RESPCODE').value == "0000") {
			document.getElementById("LGD_AUTHONLYKEY").value = fDoc.document.getElementById('LGD_AUTHONLYKEY').value;
			document.getElementById("LGD_PAYTYPE").value = fDoc.document.getElementById('LGD_PAYTYPE').value;
			
			document.getElementById("LGD_PAYINFO").target = "_self";
			document.getElementById("LGD_PAYINFO").action = "/guest/AuthOnlyRes.do";
			document.getElementById("LGD_PAYINFO").submit();
		} else {
			alert("LGD_RESPCODE (결과코드) : " + fDoc.document.getElementById('LGD_RESPCODE').value + "\n" + "LGD_RESPMSG (결과메시지): " + fDoc.document.getElementById('LGD_RESPMSG').value);
			closeIframe();
		}//end if
	}//end payment_return
</script>
</head>
<body>
<form method="post" name ="LGD_PAYINFO" id="LGD_PAYINFO">
<table>	
    <tr>
    	<td>상점아이디(t를 제외한 아이디) </td>
    	<td><%= CST_MID %></td>
	</tr>
	<tr>
	    <td>상점아이디</td>
	    <td><%= LGD_MID %></td>
	</tr>			
	<tr>
	    <td>서비스,테스트 </td>
	    <td><%= CST_PLATFORM %></td>
	</tr>
	<tr>
	    <td>
			생년월일 <br/>
			또는 사업자번호
		</td>
	    <td><%= LGD_BUYERSSN %></td>
	</tr>
	<tr>
	    <td>성명</td>
	    <td><%= LGD_BUYER %></td>
	</tr>
	<tr>
	    <td>이용가능 인증수단</td>
	    <td><%= LGD_CUSTOM_USABLEPAY %></td>
	</tr>
	<tr>
	    <td>신용평가사 고유 코드</td>
	    <td><%= LGD_MOBILE_SUBAUTH_SITECD %></td>
	</tr>
	<tr>
	    <td>타임스탬프</td>
	    <td><%= LGD_TIMESTAMP %></td>
	</tr>
	<tr>
	    <td>검증데이터</td>
	    <td><%= LGD_HASHDATA %></td>
	</tr>
	
	<tr>
	    <td>실명확인여부</td>
	    <td>
			<%=LGD_NAMECHECKYN %>
		</td>
	</tr>
	<tr>
	    <td>휴대폰본인확인SMS발송여부</td>
	    <td>
			<%=LGD_HOLDCHECKYN %>
		</td>
	</tr>
	<tr>
	    <td>인증창 스킨 color</td>
	    <td>
			<%=LGD_CUSTOM_SKIN %>
		</td>
	</tr>
	<tr>
	    <td>인증창 호출 방식 </td>
	    <td>
			<%=LGD_WINDOW_TYPE %>
		</td>
	</tr>													
	<tr>
		<td>
			<input type="button" value="인증요청" onclick="launchCrossPlatform();"/>
   		</td>
	</tr>
</table>
<%
	for(Iterator i = payReqMap.keySet().iterator(); i.hasNext();){
		Object key = i.next();
		out.println("<input type='hidden' name='" + key + "' id='"+key+"' value='" + payReqMap.get(key) + "'>" );
	}
%>
</form>
</body>
</html>