<%@ page contentType="text/html;charset=utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<html>
<head>
	<title>LMS System</title>
</head>

<%@ include file="./common/commHomepageInclude.jsp" %>

<script type="text/javascript">
	location = "/login.do?preUrl=<%=request.getParameter("preUrl")%>&loginAuth=<%=request.getParameter("loginAuth")%>";
</script>
    
</html>



