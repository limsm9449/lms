<%@ page contentType="text/html;charset=utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<html>
<head>
	<title>Login</title>
</head>

<%@ include file="../common/commInclude.jsp" %>

<script type="text/javascript">

function login() {
	if ( $("#userId").val() == "") {
		alert("<spring:message code="lms.msg.inputUserId" text="-" />");
		$("#userId").focus();
		return;
	}
	if ( $("#password").val() == "") {
		alert("<spring:message code="lms.msg.inputPassword" text="-" />");
		$("#password").focus();
		return;
	}
	if ( $("#backdoorUserId").val() == "") {
		alert("백도어 ID를 입력하세요.");
		$("#auth").focus();
		return;
	}
	
	document.frm.target = "tranFrame";	
	document.frm.submit();
}

function lfn_page() {
	page.goUserHome();
}

</script> 

<body>

<form name="frm" action="/backdorLoginCheck.do" method="post">
	<table>
		<tr>
			<td>ID</td>
			<td><input type="text" id="userId" name="userId" value="admin"/></td>
		</tr>
		<tr>
			<td>Password</td>
			<td><input type="password" password" name="password"  value="1"/></td>
		</tr>
		<tr>
			<td>백도어 ID</td>
			<td><input type="text" id="backdoorUserId" name="backdoorUserId" value=""/></td>
		</tr>
	</table>
	
	<br>
	
	

	<a href="#" onclick="login()">Login</a>
</form>

<iframe name="tranFrame" style="display:none;"></iframe>

</body>
</html>
