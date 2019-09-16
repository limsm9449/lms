<%@ page contentType="text/html;charset=utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<!-- 
<html>
<head>
</head>

<script type="text/javascript">
function fn_ok() {
	if ( "${error}" == "Y" ) {
		alert("<spring:message code="lms.msg.notExistUser" text="-" />");
		window.location = "/";
	} else {
		document.frm.action = "loginCheck.do";	
		document.frm.target = "tranFrame";	
		document.frm.submit();
		//parent.opener.lfn_naverLoginCallback("${accessToken}");
		//window.close();
	}
}

function lfn_page() {
	window.location = "/";
}
</script> 


<body onload="fn_ok();">
	<form name="frm" action="" method="post" onsubmit="return false;">
		<input type='hidden' name='naverAccessToken' id='naverAccessToken' value="${accessToken}">
	</form>

	<iframe name="tranFrame" style="display: none;"></iframe>
</body>
</html>
 -->
 
<%@ page import="java.net.URLEncoder" %>
<%@ page import="java.net.URL" %>
<%@ page import="java.net.HttpURLConnection" %>
<%@ page import="java.io.BufferedReader" %>
<%@ page import="java.io.InputStreamReader" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
 <html>
  <head>
    <title>네이버로그인</title>
  </head>
  <body>
  <%
    String clientId = "YOUR_CLIENT_ID";//애플리케이션 클라이언트 아이디값";
    String clientSecret = "YOUR_CLIENT_SECRET";//애플리케이션 클라이언트 시크릿값";
    String code = request.getParameter("code");
    String state = request.getParameter("state");
    String redirectURI = URLEncoder.encode("YOUR_CALLBACK_URL", "UTF-8");
    String apiURL;
    apiURL = "https://nid.naver.com/oauth2.0/token?grant_type=authorization_code&";
    apiURL += "client_id=" + clientId;
    apiURL += "&client_secret=" + clientSecret;
    apiURL += "&redirect_uri=" + redirectURI;
    apiURL += "&code=" + code;
    apiURL += "&state=" + state;
    String access_token = "";
    String refresh_token = "";
    System.out.println("apiURL="+apiURL);
    try {
      URL url = new URL(apiURL);
      HttpURLConnection con = (HttpURLConnection)url.openConnection();
      con.setRequestMethod("GET");
      int responseCode = con.getResponseCode();
      BufferedReader br;
      System.out.print("responseCode="+responseCode);
      if(responseCode==200) { // 정상 호출
        br = new BufferedReader(new InputStreamReader(con.getInputStream()));
      } else {  // 에러 발생
        br = new BufferedReader(new InputStreamReader(con.getErrorStream()));
      }
      String inputLine;
      StringBuffer res = new StringBuffer();
      while ((inputLine = br.readLine()) != null) {
        res.append(inputLine);
      }
      br.close();
      if(responseCode==200) {
        out.println(res.toString());
      }
    } catch (Exception e) {
      System.out.println(e);
    }
  %>
  </body>
</html>	