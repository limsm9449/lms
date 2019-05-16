<%@ page contentType="text/html;charset=utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!DOCTYPE html>
<html lang='ko'>

<head>
    <meta charset='utf-8'>
    <meta name='viewport' content='width=device-width, initial-scale=1, minimum-scale=1, maximum-scale=1'>
    <meta http-equiv='X-UA-Compatible' content='ie=edge'>
    <title>Q learning - 메일인증 확인</title>
    
    <%@ include file="../common/commMainInclude.jsp" %>

    <link href='https://fonts.googleapis.com/css?family=Nanum+Gothic' rel='stylesheet'>
    <link rel='stylesheet' href='/resources/homepageCch/css/initialization.css'>
    <link rel='stylesheet' href='/resources/homepageCch/css/etc/signup.css'>
</head>

<body>
    <frameset rows='*'>
    <div class='wrap'>
        <!-- HEAD -->
        <%@ include file="../common/mainTopCch.jsp" %>
        <!-- HEAD END -->

        <!-- QUICK MENU -->
        <%@ include file="../common/mainQuickMenuCch.jsp" %>

        <!-- CONTENTS -->
        <div class='contents_wrap_box' >
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
                        <p>회원가입</p>
                    </div>
                </div>
            </div>
            <!-- Top END -->

            <div class='util_wrap'>
                <h1>
                    회원가입
                </h1>
                
                <div class='signup_title_box'>
                    <p class='signup_title'>메일인증완료</p>
                    <p>
                        큐러닝 메일인증이 정상적으로 완료되었습니다.<span></span>
                        국내 최고의 온라인 교육 서비스를 제공하도록 최선을 다하겠습니다.
                    </p> 
                </div>
                <div class='signup_completed_box clear_fix'>
                    <p class="signup_top">메일 인증을 완료하여 정상적으로 로그인하실 수 있습니다.</p>
                    <a href='#' onclick='page.goHome();'>
                        큐러닝 <span></span>메인 가기
                    </a>
                    
                </div>
                <div class='signup_completed_bg'>
                    <span><img src='/resources/homepageCch/img/etc/completed_bg.jpg' alt=' '></span>
                </div>
            </div>

        </div>
        <!-- CONTENTS END -->

        <!-- FOOTER -->
        <%@ include file="../common/mainBottomCch.jsp" %>
        <!-- FOOTER END -->
    </div>
    <!-- Local -->
    <script src='/resources/homepageCch/js/sub.js'></script>
</frameset>
</body>

</html>