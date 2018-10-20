<%@ page contentType="text/html;charset=utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!DOCTYPE html>
<html lang='ko' data-useragent="Mozilla/5.0 (compatible; MSIE 10.0; Windows NT 6.2; Trident/6.0)">

<head>
    <meta charset='utf-8'>
    <meta name='viewport' content='width=device-width, initial-scale=1, minimum-scale=1, maximum-scale=1'>
    <meta http-equiv='X-UA-Compatible' content='ie=edge'>
    <title>Q learning - 로그인</title>

	<%@ include file="../common/commMainInclude.jsp" %>
	
    <!--[if IE]>
        <link rel='stylesheet' href='/resources/homepage/css/main_compatibility.css'>
    <![endif]-->

    <link href='https://fonts.googleapis.com/css?family=Nanum+Gothic' rel='stylesheet'>

    <link rel='stylesheet' href='/resources/homepage/css/initialization.css'>
    <link rel='stylesheet' href='/resources/homepage/css/util/signin.css'>
</head>

<script type="text/javascript">

$(document).ready(function() {
	$("#userId").focus(); 
});


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
        <%@ include file="../common/mainTop.jsp" %>
        <!-- HEAD END -->

        <!-- CONTENTS -->
        <div class='contents_wrap_box' onmouseover='sub_hide()'>
            <!-- QUICK MENU -->
            <%@ include file="../common/mainQuickMenu.jsp" %>

            <!-- Top -->
            <div class='top_area'>
                <div class='clear_fix'>
                    <div class='process_history_box clear_fix'>
                        <span>
                            <img src='/resources/homepage/img/course/ic_home.jpg' alt=' '>
                        </span>
                        <p>HOME</p>
                        <span>
                            <img src='/resources/homepage/img/course/arr_right.jpg' alt=' '>
                        </span>
                        <p>수강신청</p>
                        <span>
                            <img src='/resources/homepage/img/course/arr_right.jpg' alt=' '>
                        </span>
                        <p>교육과정</p>
                    </div>
                </div>
            </div>
            <!-- Top END -->

            <div class='util_wrap signin'>
                <h1>
                    <span>Welcome</span>
                    큐러닝에 오신 것을 환영합니다.
                </h1>
                <p>로그인을 위하여 아래 아이디와 비밀번호를 입력하여 주십시요.</p>
                <div class='signin_main_control clear_fix'>
                    <input type='text' name='userId' id='userId' placeholder='아이디'>
                    <input type='password' name='password' id='password' placeholder='비밀번호'>
                    <button class='signin_complete_btn' onclick="lfn_login()">로그인</button>
                    <div>
                        <div class='signin_sub_control left clear_fix'>
                            <input type='checkbox' name='' id=''>
                            <p>로그인 상태유지</p>
                        </div>
                        <div class='signin_sub_control right clear_fix'>
                            <a href='#' onclick="page.goPage('/guest/join');">회원가입</a>
                            <a href="#" onclick="window.location='/ns/searchUserIdV.do'">아이디찾기</a>
                            <a href="#" onclick="window.location='/ns/searchPasswordV.do'" class='last_left'>비밀번호찾기</a>
                        </div>
                    </div>
                </div>
                <div class='signin_option_box clear_fix'>
                    <button class='naver'>네이버 아이디로 로그인</button>
                    <button class='facebook'>페이스북 아이디로 로그인</button>
                </div>
                <div class='signin_bg_box'>
                    <img src='/resources/homepage/img/util/login_bg.png' alt=''>
                </div>
            </div>

        </div>
        <!-- CONTENTS END -->

        <!-- FOOTER -->
        <%@ include file="../common/mainBottom.jsp" %>
        <!-- FOOTER END -->
    </div>
</form>
    
    <!-- Local -->
    <script src='/resources/homepage/js/sub.js?timestamp=<%=timestamp%>'></script>
    
</frameset>

<iframe name="tranFrame" style="display:none;"></iframe>

</body>

</html>