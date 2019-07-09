<%@ page contentType="text/html;charset=utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<html>
<head>
	<title></title>
</head>

<script type="text/javascript" src="/resources/js/jquery-3.3.1.min.js"></script>

<script type="text/javascript">

$(document).ready(
	function() {
		if ( "${set.isNotExistUserId}" == "Y" ) {
			alert("<spring:message code="lms.msg.notExistUser" text="-" />");
			parent.$("#userId").focus();
		} else if ( "${set.isNotExistBackdoorUserId}" == "Y" ) {
			alert("<spring:message code="lms.msg.notExistUser" text="-" />");
			parent.$("#backdoorUserId").focus();
		} else if ( "${set.isWrongPassword}" == "Y" ) {
			alert("<spring:message code="lms.msg.wrongPassword" text="-" />");
			parent.$("#password").focus();
		} else if ( "${set.isNotAuth}" == "Y" ) {
			alert("권한이 없습니다.");
			parent.$("#auth").focus();
		} else if ( "${set.isNotAdmin}" == "Y" ) {
			alert("관리자가 아닙니다.");
			parent.$("#userId").focus();
		} else if ( "${set.data.retiredYn}" == "Y" ) {
			alert("탈퇴한 회원입니다.\n재가입시 관리자에게 문의하시기 바랍니다.");
			parent.$("#userId").focus();
		} else if ( "${set.isNotCertification}" == "Y" ) {
			alert("메일로 발송된 인증키로 인증확인을 하셔야 합니다.");
		} else if ( "${set.isLogin}" == "Y" ) {
			parent.lfn_page('loginConfirm');
		} else if ( "${set.isLogin}" == "N" ) {
			parent.lfn_login();
		} else {
			parent.lfn_page();
		}
	}
);



</script> 

<body>
</body>

</html>
