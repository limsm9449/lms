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
    <title>Q learning - 교육안내 - 학습관리</title>

    <%@ include file="../common/commMainInclude.jsp" %>
    
    <link href='https://fonts.googleapis.com/css?family=Nanum+Gothic' rel='stylesheet'>
    <link rel='stylesheet' href='/resources/homepage//css/initialization.css'>
    <link rel='stylesheet' href='/resources/homepage//css/guidance/register_method.css'>
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
                            <p>수료안내</p>
                        </div>
                    </div>
                    <h1>
                        교육<span>안내</span>
                    </h1>
                </div>
                <!-- Top END -->

                <div class='classroom_subtitle'>
                    <p class='subtitle'>수료안내</p>
                    <p>수료기준, 공통 적용사항, 수료증 발급에 대한 안내를 제공합니다.</p>
                </div>

                <!-- REGISTER PC VERSION -->
                <div class='register_method_pc finish'>
                    <ol>
                        <li class='pc_list_item'>
                            <div class='step_name clear_fix'>
                                <p class='num'>01</p>
                                <p>인터넷원격훈련(이러닝교육)의 수료 기준</p>
                            </div>
                            <div class='step_note'>
                                <!-- <p class='name'>1) 회원가입</p> -->
                                <p>- 진도율이 80% 이상 진행합니다. (1일 최대 학습시간은 8차시로 제한)</p>
                                <p>- 교육기간 종료일까지 시험/과제 제출 합니다. (시험유무는 과정별로 상이함)</p>
                                <p>- 평가성적이 총점 60점 이상 입니다. (100점 만점 기준)</p>
                            </div>
                        </li>
                        <li class='pc_list_item'>
                            <div class='step_name clear_fix'>
                                <p class='num'>02</p>
                                <p>인터넷원격훈련(이러닝교육)의 공통 적용사항</p>
                            </div>
                            <div class='step_note'>
                                <!-- <p class='name'>1) 과정 수강신청하기</p> -->
                                <p>- 부정행위 방지를 위하여, 공인인증기관을 통한 본인인증절차를 수강과정별로 진행합니다.</p>
                                <p>- 주차별진도학습(이러닝은 매 8차시 단위), 시험 및 과제 진행시 캡챠(화면인증) 적용합니다.</p>
                                <p>- 교육기간 중 한국산업인력공단에서 ACS(자동전화/문자)를 통한 본인 진행여부 확인합니다.</p>
                            </div>
                        </li>
                        <li class='pc_list_item'>
                            <div class='step_name clear_fix'>
                                <p class='num'>03</p>
                                <p>수료증 발급</p>
                            </div>
                            <div class='step_note'>
                                <p>- 수료증 발급은 [ 나의강의실 > 수강완료과정 ]에서 가능합니다.</p>
                                <p>- 수료증은 학습자님께서 교육기간 종료전에 수료를 하여도, 과정의 교육기간이 종료된 후 발급이 가능 합니다.</p>
                                <p>- 발급된 수료증은 법적 효력이 없는 점 인지 하시기 바랍니다.</p>
                                <p>- 수료증은 프린터 인쇄를 통해 발급 됩니다.</p>
                            </div>
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