<%@ page contentType="text/html;charset=utf-8"%>
<%@ page import="java.net.URLEncoder" %>
<%@ page import="java.security.SecureRandom" %>
<%@ page import="java.math.BigInteger" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>


<%--
  String clientId = (String)request.getAttribute("naverClientId");
  String redirectURI = URLEncoder.encode((String)request.getAttribute("naverCallback"), "UTF-8");
  System.out.println("clientId : " + clientId);
  System.out.println("redirectURI : " + redirectURI);
  SecureRandom random = new SecureRandom();
  String state = new BigInteger(130, random).toString();
  String apiURL = "https://nid.naver.com/oauth2.0/authorize?response_type=code&svctype=0";
  apiURL += "&client_id=" + clientId;
  apiURL += "&redirect_uri=" + redirectURI;
  apiURL += "&state=" + state;
  session.setAttribute("state", state);
  System.out.println("apiURL : " + apiURL);
--%>

<!--
<html>
  <meta http-equiv="refresh" content="0;url=<%=apiURL%>">	
</html>
<body>
</body>
-->
<!-- 네아로 예제 코드가 되는 지 테스트  -->
<html>
  <head>
    <title>네이버로그인</title>
  </head>
  <body>
  <%
    String clientId = "6jlIlsVQtLVPSn6H05Ow";//애플리케이션 클라이언트 아이디값";
    String redirectURI = URLEncoder.encode("http://testqlearn.cafe24.com//naverCallback.do", "UTF-8");
    SecureRandom random = new SecureRandom();
    String state = new BigInteger(130, random).toString();
    String apiURL = "https://nid.naver.com/oauth2.0/authorize?response_type=code";
    apiURL += "&client_id=" + clientId;
    apiURL += "&redirect_uri=" + redirectURI;
    apiURL += "&state=" + state;
    session.setAttribute("state", state);
 %>
  <a href="<%=apiURL%>"><img height="50" src="http://static.nid.naver.com/oauth/small_g_in.PNG"/></a>
  </body>
</html>