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
    <title>Q learning - 입금계좌</title>
    
    <%@ include file="../common/commMainInclude.jsp" %>

    <link href='https://fonts.googleapis.com/css?family=Nanum+Gothic' rel='stylesheet'>
    <link rel='stylesheet' href='/resources/homepage/css/initialization.css'>
    <link rel='stylesheet' href='/resources/homepage/css/support/account.css'>
</head>

<body>
    <frameset rows='*'>
    <div class='wrap'>
        <!-- HEAD -->
        <%@ include file="../common/mainTop.jsp" %>
        <!-- HEAD END -->

        <!-- CONTENTS -->
        <div class='contents_wrap_box' >
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
                        <p>회원가입</p>
                    </div>
                </div>
            </div>
            <!-- Top END -->

            <div class='util_wrap'>
                <h1>
                    회원가입
                </h1>
                <div class='signup_all_agree_box clear_fix'>
                    <c:choose>
	<c:when test="${set.rtnMode eq 'OK'}">
		        <div class="joinflow_box">
		          <p class="big_2"><span class="blue">메일인증 완료</span></p>
		          <p>큐러닝 회원가입이 정상적으로 완료되었습니다. <br />국내 최고의 온라인 교육 서비스를 제공하도록 최선을 다하겠습니다.</p>
		        </div>
	</c:when>
	<c:otherwise>
		        <div class="joinflow_box">
		          <p class="big_2"><span class="blue">메일인증 오류</span></p>
		          <p>정상적인 인증 절차에 의한 확인이 아닙니다.</p>
		        </div>
	</c:otherwise>
</c:choose> 
                </div>
            </div>

        </div>
        <!-- CONTENTS END -->

        <!-- FOOTER -->
        <%@ include file="../common/mainBottom.jsp" %>
        <!-- FOOTER END -->
    </div>
    <!-- Local -->
    <script src='/resources/homepage/js/dev_sub.js?timestamp=<%=timestamp%>'></script>
</frameset>
</body>

</html>