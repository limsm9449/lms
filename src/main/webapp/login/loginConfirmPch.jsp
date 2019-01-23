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

<link rel='stylesheet' href='/resources/homepagePch/css/initialization.css'>
<link rel='stylesheet' href='/resources/homepagePch/css/etc/signin.css'>
</head>

<script type="text/javascript">

$(document).ready(function() {
	if ( opener ) {
		window.close();
	}
	
	if ( $.cookie(cookieName + 'login') == "Y" ) {
		$("input:checkbox[id='cb_continue']").prop("checked", true);

		$("#userId").val($.cookie(cookieName + 'userId'));
		$("#password").val($.cookie(cookieName + 'password'));
	}
	
	$("#userId").focus(); 
});

function lfn_passwordEnter() {
	if ( event.keyCode == 13 ) {
		lfn_login();
	}
}

function lfn_login() {
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

	if ( $("input:checkbox[id='cb_continue']").is(":checked") ) {
		$.cookie(cookieName + 'login', "Y");
		$.cookie(cookieName + 'userId', $("#userId").val(), { expires: 7 });
		$.cookie(cookieName + 'password', $("#password").val(), { expires: 7 });
	} else {
		$.cookie(cookieName + 'login', "N");
		$.removeCookie(cookieName + 'userId');
		$.removeCookie(cookieName + 'password');
	}
	
	document.frm.target = "tranFrame";	
	document.frm.submit();
}

function lfn_page() {
	if ( "<%=request.getParameter("preUrl")%>" == "null")
		page.goHome();
	else {
		if ( "<%=request.getParameter("loginAuth")%>" == "ADMIN_A" || "<%=request.getParameter("loginAuth")%>" == "ADMIN_C" || "<%=request.getParameter("loginAuth")%>" == "ADMIN_M") {
			page.goAdminHome("<%=request.getParameter("preUrl")%>");
		} else if ( "<%=request.getParameter("loginAuth")%>" == "TEACHER") {
			page.goTeacherHome("<%=request.getParameter("preUrl")%>");
		} else if ( "<%=request.getParameter("loginAuth")%>" == "C_TUTOR") {
			page.goCompManagerHome("<%=request.getParameter("preUrl")%>");
		} else if ( "<%=request.getParameter("loginAuth")%>" == "TUTOR") {
			page.goTutorHome("<%=request.getParameter("preUrl")%>");
		} else {
			window.location = "<%=request.getParameter("preUrl")%>";
		}
	}
}

</script>

<body>
<frameset rows='*'>
	<form name="frm" action="loginCheck.do" method="post">

		<div class="wrap">
			<!-- HEAD -->
			<%@ include file="../common/mainTopPch.jsp"%>
			<!-- HEAD END -->

			<!-- QUICK MENU -->
			<%@ include file="../common/mainQuickMenuPch.jsp"%>

			<!-- CONTENTS -->
			<div class='contents_wrap_box'>
				<!-- Top -->
				<div class='top_area'>
					<div class='clear_fix'>
						<div class='process_history_box clear_fix'>
							<span> <img
								src='/resources/homepage/img/course/ic_home.jpg' alt=' '>
							</span>
							<p>HOME</p>
							<span> <img
								src='/resources/homepage/img/course/arr_right.jpg' alt=' '>
							</span>
							<p>수강신청</p>
							<span> <img
								src='/resources/homepage/img/course/arr_right.jpg' alt=' '>
							</span>
							<p>교육과정</p>
						</div>
					</div>
				</div>
				<!-- Top END -->

				<div class='util_wrap signin'>
					<h1>
						<span>Welcome</span> 큐러닝에 오신 것을 환영합니다.
					</h1>
					<p>귀하는 동시접속을 시도하셨습니다.</p>
					<p>최종 로그인 시간 : ${loginTime}</p>
					<p>기존 접속을 끊고 접속하시겠습니까?</p>
					<div class='signin_main_control clear_fix'>
						<input type='hidden' name='userId' id='userId' value="${set.condiVO.userId}">
						<input type='hidden' name='password' id='password' value="${set.condiVO.password}">
						<button class='signin_complete_btn' onclick="lfn_login()">예</button>
						<button class='signin_complete_btn' onclick="page.goHome();">아니요</button>
					</div>
					<div class='signin_bg_box'> 
						<img src='/resources/homepage/img/util/login_bg.png' alt=''>
					</div>
				</div>

			</div>
			<!-- CONTENTS END -->

			<!-- FOOTER -->
			<%@ include file="../common/mainBottomPch.jsp"%>
			<!-- FOOTER END -->
		</div>
	</form>

	<!-- Local -->
	<script
		src='/resources/homepagePch/js/sub.js'></script>

</frameset>

<iframe name="tranFrame" style="display: none;"></iframe>

</body>

</html>