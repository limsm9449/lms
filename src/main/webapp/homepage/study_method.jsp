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
    <link rel='stylesheet' href='/resources/homepage/css/guidance/study_method.css'>
</head>

<body>
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
            </div>
            <div class='study_method_activity'>
                <div>
                    <div class='sub_title white'>
                        <p>회원유형별 학습활동</p>
                    </div>
                    <ul>
                        <li class='activity_list clear_fix'>
                            <p class='activity_type'>학습자</p>
                            <p>회원가입, 로그인, 회원정보 수정<br>과정검색, 수강신청, 교육비 결제, 과정학습,  평가응시, 학습이력관리<br>학습자료검색, 학습질문, 설문참여</p>
                            <div class='arr_bottom'><img src='/resources/homepage/img/guidance/arr_bottom.png' alt=' '></div>
                        </li>
                        <li class='activity_list clear_fix'>
                            <p class='activity_type'>강사</p>
                            <p>학습자료 등록, 학습질문답변, 평가관리, 과제물 채점 및 첨삭<br>학습진행관리, 학습현황 관리 및 학습독려, 성적관리<br>과정 품질관리</p>
                            <div class='arr_bottom mobile'><img src='/resources/homepage/img/guidance/arr_bottom.png' alt=' '></div>
                        </li>
                        <li class='activity_list clear_fix last_top'>
                            <p class='activity_type'>운영자</p>
                            <p>콘텐츠관리, 과정관리, 설문지관리, 과정개설관리<br>수강신청현황관리, 입금/카드승인 확인, 수강신청승인<br>학습진행관리, 학습현황 관리 및 학습독려, 성적관리<br>수입관리, 비용관리, 정산관리, 회원관리, 게시물관리</p>
                        </li>
                    </ul>
                </div>
            </div>
            <div class='study_method_func'>
                <div class='sub_title'>
                    <p>학습창 주요 기능 안내</p>
                </div>
                <span><img src='/resources/homepage/img/guidance/study_img.jpg' alt=' '></span>
                <ol>
                    <li class='function_list'>
                        <p>1) 나의학습현황: 평가항목, 권장학습안내, 점수, 총점 등 표시</p>
                    </li>
                    <li class='function_list'>
                        <p>2) 학습목차: 차시명, 학습시간, 관심표시, 학습시작</p>
                    </li>
                    <li class='function_list'>
                        <p>3) 평가항목 표시, 응시하기, 점수, 제출일, 채점일</p>
                    </li>
                    <li class='function_list'>
                        <p>4) 주요메뉴: 공지사항, 자료실, 자유게시판, 진도상세보기, 학습후기, 질문답변</p>
                    </li>
                </ol>
                
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