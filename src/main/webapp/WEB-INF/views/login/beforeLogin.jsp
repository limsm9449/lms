<%@ page contentType="text/html;charset=utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<html>
<head>
	<title>Login</title>
</head>

<%@ include file="../common/commInclude.jsp" %>

<script type="text/javascript">

$(document).ready(function() {
	alert("로그인 후에 수강신청을 하셔야 합니다.");
<%
	String preUrl = (String)request.getAttribute("preUrl");
	if ( preUrl == null ) {
		preUrl = request.getHeader("referer");
	}
%>
	top.location = "/login.do?preUrl=<%=preUrl%>";
});

</script> 

<body>
</body>
</html>
