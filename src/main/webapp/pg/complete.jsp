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
    <title>Q learning - 나의강의실 - 장바구니</title>

    <%@ include file="../common/commMainInclude.jsp" %>
    
    <link href='https://fonts.googleapis.com/css?family=Nanum+Gothic' rel='stylesheet'>
    <link rel='stylesheet' href='/resources/homepage/css/initialization.css'>
    <link rel='stylesheet' href='/resources/homepage/css/classroom/basket.css'>
</head>

<body>

<form name="frm" id="frm" method="post">

<frameset rows='*'>
    <div class='wrap'>
        <!-- PC HEADER -->
        <%@ include file="../common/mainTop.jsp" %>
        <!-- HEAD END -->

        <!-- CONTENTS -->
        <div class='contents_wrap process' >
            <div class='contents_wrap_box'>
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
                            <p>나의강의실</p>
                            <span>
                                <img src='/resources/homepage/img/course/arr_right.jpg' alt=' '>
                            </span>
                            <p>장바구니</p>
                        </div>
                    </div>
                    <h1>
                        장바<span>구니</span>
                    </h1>
                </div>
                <!-- Top END -->

                <div class='basket_step_box'>
                    <ul>
                        <li class='basket_step_list clear_fix'>
                            <span><img src='/resources/homepage/img/classroom/basket_step1_inactive.png' alt=' '></span>
                            <p class='basket_title'>장바구니</p>
                        </li>
                        <li class='basket_arr'>
                            <img src='/resources/homepage/img/etc/arr_right.png' alt=' '>
                        </li>
                        <li class='basket_step_list clear_fix'>
                            <span><img src='/resources/homepage/img/classroom/basket_step2_inactive.png' alt=' '></span>
                            <p class='basket_title'>결제정보입력</p>
                        </li>
                        <li class='basket_arr'>
                            <img src='/resources/homepage/img/etc/arr_right.png' alt=' '>
                        </li>
                        <li class='basket_step_list clear_fix on'>
                            <span><img src='/resources/homepage/img/classroom/basket_step3_active.png' alt=' '></span>
                            <p class='basket_title'>결제완료</p>
                            <p>결제가 모두 완료되었습니다.</p>
                        </li>
                    </ul>
                    <p class='basket_note'>
                        <span></span>고객님께서 장바구니에 담으신 과정 및 상품입니다.<br>
                        <span></span>결제시 가격정보를 확인한 후 구매하시기 바랍니다.<br>
                        <span></span>과정은 매월 21일 기준으로 정보 변경됩니다. (참고도서 포함)
                    </p>
                </div>
                <div class='basket_payment_completed'>
                    <div>
                        <p>결제가 모두 완료되었습니다.</p>
                        <p class='guide'><strong>나의 강의실</strong>로 가시면 결제한 과정을 확인할 수 있습니다.</p>
                        <button onclick="page.goPage('/main/myClassroom');">나의 강의실 바로가기</button>
                    </div>
                </div>
            </div>
        </div>
        <!-- CONTENTS END -->

        <!-- FOOTER -->
        <%@ include file="../common/mainBottom.jsp" %>
        <!-- FOOTER END -->
    </div>
</frameset>

</form>

<script src='/resources/homepage/js/dev_sub.js'></script>
</body>
</html>