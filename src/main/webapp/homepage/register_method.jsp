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
    <title>Q learning - 교육안내 - 학습방법</title>

    <%@ include file="../common/commMainInclude.jsp" %>

    <link href='https://fonts.googleapis.com/css?family=Nanum+Gothic' rel='stylesheet'>
    <link rel='stylesheet' href='/resources/homepage/css/initialization.css'>
    <link rel='stylesheet' href='/resources/homepage/css/guidance/register_method.css'>
</head>

<body>
<frameset rows='*'>
    <div class='wrap'>
        <!-- PC HEADER -->
        <%@ include file="../common/mainTop.jsp" %>
        <!-- HEAD END -->

        <!-- CONTENTS -->
        <div class='contents_wrap process' onmouseover='sub_hide()'>
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
                            <p>교육안내</p>
                            <span>
                                <img src='/resources/homepage/img/course/arr_right.jpg' alt=' '>
                            </span>
                            <p>학습방법</p>
                        </div>
                    </div>
                    <h1>
                        교육<span>안내</span>
                    </h1>
                </div>
                <!-- Top END -->

                <div class='classroom_subtitle'>
                    <p class='subtitle'>학습방법</p>
                    <p>학습자, 강사, 운영자 모듈로 구성되어 있으며, 고객사에 맞는 교육관리시스템을 제공합니다.</p>
                </div>

                <!-- TAB AREA -->
                <div class='register_method_tab clear_fix'>
                    <button onclick='guide_change("pc", this)' class='on'>PC 러닝 <span></span>학습가이드</button>
                    <button onclick='guide_change("mobile", this)'>모바일 러닝 <span></span>학습가이드</button>
                </div>

                <!-- REGISTER PC VERSION -->
                <div class='register_method_pc'>
                    <!-- <img src='/resources/homepage/img/guidance/pc.jpg' alt=' '> -->
                    <ol>
                        <li class='pc_list_item'>
                            <div class='step_name clear_fix'>
                                <p class='num'>01</p>
                                <p>회원가입</p>
                            </div>
                            <span><img src='/resources/homepage/img/guidance/reg_pc_1.jpg' alt=' '></span>
                            <div class='step_note'>
                                <p class='name'>1) 회원가입</p>
                                <p>- 큐러닝 사이트에 오른쪽 상단의 회원가입을 합니다.</p>
                            </div>
                        </li>
                        <li class='pc_list_item'>
                            <div class='step_name clear_fix'>
                                <p class='num'>02</p>
                                <p>수강신청</p>
                            </div>
                            <span><img src='/resources/homepage/img/guidance/reg_pc_2.jpg' alt=''></span>
                            <div class='step_note'>
                                <p class='name'>1) 과정 수강신청하기</p>
                                <p>- 전체과정을 선택합니다.</p>
                                <p class='name'>
                                    2) 개설 중인 과정을 카테고리 별 조회가 가능합니다.<br>3) 과정정보 확인, 맛보기, 평점/후기 등 확인 할 수 있습니다.<br>4) 과정을 장바구니 담아서 한꺼번에 결제하거나 개별로 수강신청하여 결제할 수 있습니다. <br>5) 그럼, 수강하기 원하는 과정을 수강 신청합니다.
                                </p>
                            </div>
                        </li>
                        <li class='pc_list_item'>
                            <div class='step_name clear_fix'>
                                <p class='num'>03</p>
                                <p>나의강의실</p>
                            </div>
                            <span><img src='/resources/homepage/img/guidance/reg_pc_3.jpg' alt=' '></span>
                            <div class='step_note'>
                                <p class='name'>1) 나의 강의실을 선택합니다.<br>2) 학습중인 과정 중 학습하기 원하는 과정의 학습시작 버튼을 선택합니다.</p>
                            </div>
                            <span><img src='/resources/homepage/img/guidance/reg_pc_4.jpg' alt=' '></span>
                            <div class='step_note'>
                                <p class='name'>3) 선택한 과정의 학습창이 표시됩니다.<br>4) 학습목차 중 학습할 차시명의 시작버튼을 선택하여 학습합니다.
                                </p>
                            </div>
                        </li>
                    </ol>
                </div>

                <!-- REGISTER MOBILE VERSION -->
                <div class='register_method_mobile'>
                    <!-- <img src='/resources/homepage/img/guidance/mobile.jpg' alt=' '> -->
                    <ol>
                        <li class='mobile_list_item clear_fix'>
                            <div class='step_name clear_fix'>
                                <p class='num'>01</p>
                                <p>수강신청</p>
                            </div>
                            <span><img src='/resources/homepage/img/guidance/reg_mobile_1.jpg' alt=' '></span>
                            <span><img src='/resources/homepage/img/guidance/reg_mobile_2.png' alt=' '></span>
                            <div class='step_note'>
                                <p class='name'>1) 로그인하기</p>
                                <p>- 로그인을 선택하여 아이디, 비밀번호를 입력하여 로그인 합니다.</p>
                                <p class='name'>2) 수강신청하기</p>
                                <p>- 좌측 상단의 메뉴를 선택하여 전체과정 메뉴를 선택 합니다.</p>
                            </div>
                            <span><img src='/resources/homepage/img/guidance/reg_mobile_3.png' alt=' '></span>
                            <div class='step_note half'>
                                <p class='name'>3) 과정 선택하여 수강신청하기</p>
                                <p>- 개설 중인 과정을 카테고리 별 조회가 가능합니다.</p>
                                <p>- 과정정보 확인, 맛보기, 평점/후기 등 확인 할 수 있습니다.</p>
                                <p>- 과정을 장바구니 담아서 한꺼번에 결제하거나 개별로 수강신청하여 결제할 수 있습니다. <span></span>그럼, 수강하기 원하는 과정을 수강 신청합니다.</p>
                            </div>
                        </li>
                        <li class='mobile_list_item clear_fix'>
                            <div class='step_name clear_fix'>
                                <p class='num'>02</p>
                                <p>나의 강의실</p>
                            </div>
                            <span><img src='/resources/homepage/img/guidance/reg_mobile_4.jpg' alt=' '></span>
                            <span><img src='/resources/homepage/img/guidance/reg_mobile_5.jpg' alt=' '></span>
                            <div class='step_note'>
                                <p class='name'>1) 나의 강의실을 선택합니다.<br>2) 학습중인 과정 중 학습하기 원하는 과정의 학습시작 버튼을 선택합니다.<br>3) 선택한 과정의 학습창이 표시됩니다.<br>4) 학습시작버튼을 선택하여 학습을 합니다.</p>
                            </div>
                            <span><img src='/resources/homepage/img/guidance/reg_mobile_6.png' alt=' '></span>
                        </li>
                    </ol>
                </div>
            </div>
        </div>
        <!-- CONTENTS END -->

        <!-- FOOTER -->
        <%@ include file="../common/mainBottom.jsp" %>
        <!-- FOOTER END -->
    </div>
</frameset>
<script src='/resources/homepage/js/dev_sub.js'></script>

</body>
</html>