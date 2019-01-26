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
	alert("로그인 후에 사용하셔야 합니다.");
<%
	String urlPage = (String)request.getParameter("urlPage");
	String urlParam = (String)request.getParameter("urlParam");
	if ( urlPage == null ) {
		urlPage = request.getHeader("referer");
	}
%>
	location = "/login.do?urlPage=<%=urlPage%>&urlParam=<%=urlParam%>";
});

</script> 

<body>
</body>
</html>
