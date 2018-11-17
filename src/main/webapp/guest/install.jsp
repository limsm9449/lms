<%@ page contentType="text/html;charset=utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<!DOCTYPE html>
<html lang='ko'
	data-useragent="Mozilla/5.0 (compatible; MSIE 10.0; Windows NT 6.2; Trident/6.0)">

<head>
<meta charset='utf-8'>
<meta name='viewport'
	content='width=device-width, initial-scale=1, minimum-scale=1, maximum-scale=1'>
<meta http-equiv='X-UA-Compatible' content='ie=edge'>
<title>Q learning - 로그인</title>

<%@ include file="../common/commMainInclude.jsp"%>

<!--[if IE]>
        <link rel='stylesheet' href='/resources/homepage/css/main_compatibility.css'>
    <![endif]-->

<link href='https://fonts.googleapis.com/css?family=Nanum+Gothic'
	rel='stylesheet'>

<link rel='stylesheet' href='/resources/homepage/css/initialization.css'>
<link rel='stylesheet' href='/resources/homepage/css/util/signin.css'>
</head>

<script type="text/javascript">

$(document).ready(function() {
	$("#userId").focus();
	$("#userId").val(""); 
	$("#password").val("");
});

function lfn_passwordEnter() {
	if ( event.keyCode == 13 ) {
		lfn_login();
	}
}

function lfn_install() {
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
	
	$.ajax({
		url : context + "/guest/dbInstall.do",
		type : "POST",
		async : false,
		dataType :"json",
		data : $("#frm").serialize(),
		success : function(data){
			if ( data.rtnMode == "INSTALL_OK" ) {
				alert("DB가 설치되었습니다.");
				page.goHome();
			} else if ( data.rtnMode == "NO_AUTH" ) {
				alert("권한이 없습니다.");
			} else {
				alert("DB가 설치시 오류가 발생했습니다.");
			}
		},
		error : function(e) {
			alert(resource.msg.systemError);
		}
	});
}

</script>

<body>
<frameset rows='*'>
	<form name="frm" id="frm" action="" method="post">

		<div class="wrap">
			<!-- HEAD -->
			<%@ include file="../common/mainTop.jsp"%>
			<!-- HEAD END -->

			<!-- CONTENTS -->
			<div class='contents_wrap_box' >
				<div class='util_wrap signin'>
					<h1>
						<span>Welcome</span> 큐러닝에 오신 것을 환영합니다.
					</h1>
					<p></p>
					<div class='signin_main_control clear_fix'>
						<input type='text' name='userId' id='userId' value="" placeholder='아이디'>
						<input type='password' name='password' id='password' placeholder='비밀번호' value="" onkeydown="lfn_passwordEnter()">
						<button class='signin_complete_btn' onclick="lfn_install()">DB Install</button>
					</div>
				</div>

			</div>
			<!-- CONTENTS END -->

			<!-- FOOTER -->
			<%@ include file="../common/mainBottom.jsp"%>
			<!-- FOOTER END -->
		</div>
	</form>

	<!-- Local -->
	<script
		src='/resources/homepage/js/dev_sub.js?timestamp=<%=timestamp%>'></script>

</frameset>


</body>

</html>