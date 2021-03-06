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
	var param = gfn_getUrlParams("p");
	if ( param != "" ) {
		loginInfo = atob(param).split(":");
		$("#userId").val(loginInfo[0]);
		$("#password").val(loginInfo[1]);

		document.frm.action = "loginCheck.do";	
		document.frm.target = "tranFrame";	
		document.frm.submit();
	} else {
		if ( opener ) {
			window.close();
		}
		
		<%/* 로그인 페이지로 왔는데 어디민 화면에서 세션이 끊긴 경우 홈으로 간다. */ %>
		if ( parent.document.getElementById("left") ) {
			page.goHome();
		}
		
		if ( $.cookie(cookieName + 'login') == "Y" ) {
			$("input:checkbox[id='cb_continue']").prop("checked", true);
	
			$("#userId").val($.cookie(cookieName + 'userId'));
			$("#password").val($.cookie(cookieName + 'password'));
		}
		
		$("#userId").focus();
	}
});

function lfn_passwordEnter() {
	if ( event.keyCode == 13 ) {
		lfn_login();
		event.preventDefault();
	}
}

function lfn_dupLoginCheck() {
	document.frm.action = "dupLoginCheck.do";	
	
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

	document.frm.target = "tranFrame";	
	document.frm.submit();
}

function lfn_login() {
	document.frm.action = "loginCheck.do";	
	
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
		$.cookie(cookieName + 'login', "Y", { expires: 7 });
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

function lfn_naverLogin() {
	top.location = "/naverLogin.do";
	//window.open("http://localhost:8080/naverLogin.do", "naverLogin", "width=500,height=500,location=no");
	/*
	document.frm.action = "naverLogin.do";	
	document.frm.target = "_self";	
	document.frm.submit();
	*/
}

function lfn_naverLoginCallback(key) {
	$("#naverAccessToken").val(key);
	
	document.frm.action = "loginCheck.do";	
	document.frm.target = "tranFrame";	
	document.frm.submit();
}

function lfn_page(kind) {
	if ( kind == "loginConfirm" ) {
		page.goPage("/loginConfirm", "userId=" + $("#userId").val() + "&password=" + $("#password").val());
	} else {
		if ( "<%=request.getParameter("urlPage")%>" == "null" ) {
			page.goHome();
		} else {
			page.goPage("<%=request.getParameter("urlPage")%>", "<%=request.getParameter("urlParam")%>");
		}
	}
}

</script>

<body>
<frameset rows='*'>
	<form name="frm" action="dupLoginCheck.do" method="post">
		<div style="display:none">
			<!-- 이것은 자동이동을 막기위함이다. -->
			<input type="submit" onclick="return false;" />
			<input type="text"/>
		</div>

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
							<p>로그인</p>
						</div>
					</div>
				</div>
				<!-- Top END -->

				<div class='util_wrap signin'>
					<img src='/cImage/company/${compCd}_login.jpg' alt=' '>
					<div class='signin_main_control clear_fix'>
						<input type='text' name='userId' id='userId' placeholder='아이디' onkeydown="lfn_passwordEnter();">
						<input type='password' name='password' id='password' placeholder='비밀번호' onkeydown="lfn_passwordEnter()">
						<button class='signin_complete_btn' onclick="lfn_login()" style="margin-bottom:10px;">로그인</button>
                        					
<c:if  test = "${NAVER_CLIENT_ID ne null and NAVER_CLIENT_ID ne ''}"> 
					<div class='signin_option_box clear_fix'>
						<input type='hidden' name='naverAccessToken' id='naverAccessToken'>
						<button class='naver' onclick="lfn_naverLogin();" style="display:block;">네이버
							아이디로 로그인</button>
					</div>
 </c:if>	
						<div>
							<div class='signin_sub_control left clear_fix'>
								<input type='checkbox' name='cb_continue' id='cb_continue'>
								<p>로그인 상태유지</p>
							</div>
							<div class='signin_sub_control right clear_fix'>
								<a href='#' onclick="page.goPage('/guest/join');">회원가입</a> 
								<a href="#" onclick="window.location='/ns/searchUserIdV.do'">아이디찾기</a> 
								<a href="#" onclick="window.location='/ns/searchPasswordV.do'" class='last_left'>비밀번호찾기</a>
							</div>
						</div>
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