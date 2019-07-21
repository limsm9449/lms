<%@ page contentType="text/html;charset=utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<html>
<head>
	<title></title>
</head>

<%@ include file="../common/commMainInclude.jsp"%>

<script type="text/javascript">

$(document).ready(
	function() {
		var params = btoa("${session.userId}:${session.password}");
		window.open("http://" + "${set.condiVO.channel}" + "." + window.location.host.replace("www.","") + "/login.do?p=" + params);
	}
);


</script> 

<body>
</body>

</html>
