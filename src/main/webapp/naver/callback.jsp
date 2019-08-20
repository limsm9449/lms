<%@ page contentType="text/html;charset=utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

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
	