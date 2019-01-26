<%@ page contentType="text/html;charset=utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!DOCTYPE html>
<html lang='ko' data-useragent='Mozilla/5.0 (compatible; MSIE 10.0; Windows NT 6.2; Trident/6.0)'>

<head>
    <meta charset='utf-8'>
    <meta name='viewport' content='width=device-width, initial-scale=1, minimum-scale=1, maximum-scale=1'>
    <meta http-equiv='X-UA-Compatible' content='ie=edge'>
    <title>Q learning - 회원가입 - 가입완료</title>

    <%@ include file="../common/commMainInclude.jsp" %>

    <link href='https://fonts.googleapis.com/css?family=Nanum+Gothic' rel='stylesheet'>

    <link rel='stylesheet' href='/resources/homepagePch/css/initialization.css'>
    <link rel='stylesheet' href='/resources/homepagePch/css/etc/signup.css'>
</head>

<body>
<frameset rows='*'>
    <div class='wrap'>
        <!-- HEAD -->
        <%@ include file="../common/mainTopPch.jsp" %>
        <!-- HEAD END -->

        <!-- CONTENTS -->
        <div class='contents_wrap_box' >
            <!-- QUICK MENU -->
            <%@ include file="../common/mainQuickMenuPch.jsp" %>

            <!-- Top -->
            <div class='top_area'>
                <div class='clear_fix'>
                    <div class='process_history_box clear_fix'>
                        <span>
                            <img src='/resources/homepagePch/img/course/ic_home.jpg' alt=' '>
                        </span>
                        <p>HOME</p>
                        <span>
                            <img src='/resources/homepagePch/img/course/arr_right.jpg' alt=' '>
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
                <div class='util_step_box clear_fix completed'>
                    <div class='pd'>
                        <span><img src='/resources/homepagePch/img/etc/ic_step1.png' alt=''></span>
                        <p>이용약관</p>
                    </div>
                    <div class='arrow'><img src='/resources/homepagePch/img/etc/arr_right.png' alt=''></div>
                    <div>
                        <span><img src='/resources/homepagePch/img/etc/ic_step2.png' alt=''></span>
                        <p>가입여부<span></span>확인</p>
                    </div>
                    <div class='arrow'><img src='/resources/homepagePch/img/etc/arr_right.png' alt=''></div>
                    <div>
                        <span><img src='/resources/homepagePch/img/etc/ic_step3.png' alt=''></span>
                        <p>회원정보<span></span>입력</p>
                    </div>
                    <div class='arrow'><img src='/resources/homepagePch/img/etc/arr_right.png' alt=''></div>
                    <div class='active last_right pd'>
                        <span><img src='/resources/homepagePch/img/etc/ic_step4_active.png' alt=''></span>
                        <p>가입완료</p>
                    </div>
                </div>
                <div class='signup_title_box'>
                    <p class='signup_title'>회원가입완료</p>
                    <p>
                        큐러닝 회원가입이 정상적으로 완료되었습니다.<span></span>
                        국내 최고의 온라인 교육 서비스를 제공하도록 최선을 다하겠습니다.
                    </p>
                </div>
                <div class='signup_completed_box clear_fix'>
                    <p>메인 인증을 완료하셔야 정상적으로 로그인하실 수 있습니다.</p>
                    <a href='#' onclick='page.goHome();'>
                        큐러닝 <span></span>메인 가기
                    </a>
                    <div class='completed_note'>
                        <span>
                            <img src='/resources/homepagePch/img/etc/completed_image.png' alt=' '>
                        </span>
                        <p>입력하신 메일 주소로 인증 메일이 도착하지 않았다면 <span></span>스팸메일로 분류되지 않았는지 확인해보십시오.</p>
                    </div>
                </div>
                <div class='signup_completed_bg'>
                    <span><img src='/resources/homepagePch/img/etc/completed_bg.jpg' alt=' '></span>
                </div>
            </div>

        </div>
        <!-- CONTENTS END -->

        <!-- FOOTER -->
        <%@ include file="../common/mainBottomPch.jsp" %>
        <!-- FOOTER END -->
    </div>
    <!-- Local -->
    <script src='/resources/homepagePch/js/main.js'></script>
</frameset>
</body>

</html>