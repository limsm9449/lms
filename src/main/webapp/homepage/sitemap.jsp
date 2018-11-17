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
    <link rel='stylesheet' href='/resources/homepage//css/initialization.css'>
    <link rel='stylesheet' href='/resources/homepage//css/support/notice.css'>

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
                                <img src='/resources/homepage//img/course/ic_home.jpg' alt=' '>
                            </span>
                            <p>HOME</p>
                            <span>
                                <img src='/resources/homepage//img/course/arr_right.jpg' alt=' '>
                            </span>
                            <p>사이트맵</p>
                        </div>
                    </div>
                    <h1>
                        사이트<span>맵</span>
                    </h1>
                    <div class='top_text_box clear_fix'>
                        <span><img src='/resources/homepage//img/support/notice_bg.jpg' alt=' '></span>
                        <p class='top_title'>SITE MAP</p>
                        <p>
                            큐러닝 사이트의 전체 메뉴를 확인할 수 있습니다.
                        </p>
                    </div>
                </div>
                <!-- Top END -->

                <div class='menu_dropdown_wrap con clear_fix'>
                    <ul class='menu_sub'>
                    	<li class='menu_title'><a href="javascript:" onclick="page.goPage('/main/courseList', '');">전체과정</a></li>
<c:forEach var="row" items="${courseCategoryList}" varStatus="idx">
                        <li><a href="javascript:" onclick="page.goPage('/main/courseList', 'categorys=${row.code}');">${row.codeName}</a></li>
</c:forEach>
                    </ul>
                    <ul class='menu_sub classroom'>
                    	<li class='menu_title'><a href="javascript:" onclick="page.goPage('/main/myClassroom', '');">나의강의실</a></li>
                        <li><a href="javascript:" onclick="page.goPage('/normalUser/attendCourseList');">수강과정</a></li>
                        <li><a href="javascript:" onclick="page.goPage('/normalUser/waitingCourseList');">수강대기과정</a></li>
                        <li><a href="javascript:" onclick="page.goPage('/normalUser/cancelCourseList');">수강취소과정</a></li>
                        <li><a href="javascript:" onclick="page.goPage('/normalUser/myCourseList');">수강완료과정</a></li>
                        <li><a href="javascript:" onclick="page.goPage('/main/cart');">장바구니</a></li>
                        <li><a href="javascript:" onclick="page.goPage('/member/userMemberU');">회원정보수정</a></li>
                        <li><a href="javascript:" onclick="page.goPage('/member/memberChangePassword');">비밀번호변경</a></li>
                        <li><a href="javascript:" onclick="page.goPage('/counsel/userCounselList');">상담내역</a></li>
                        <li><a href="javascript:" onclick="page.goPage('/member/memberRetired');">회원탈퇴</a></li>
                    </ul> 
                    <ul class='menu_sub'>
                     <li class='menu_title'><a href="javascript:" onclick="page.goPage('/main/tutorial', '');">교육안내</a></li>
                        <li><a href="javascript:" onclick="page.goNsJsp('register_method'); return false;">수강신청방법</a></li>
                        <li><a href='javascript:' onclick="page.goNsJsp('study_method'); return false;">학습방법</a></li>
                        <li><a href='javascript:' onclick="page.goNsJsp('study_manage'); return false;">학습관리</a></li>
                        <li><a href="javascript:" onclick="page.goPage('/main/tutorial', 'shap=quick_to');">학습지원프로그램</a></li>
                    </ul>
                    <ul class='menu_sub'>
                    	<li class='menu_title'><a href="javascript:" onclick="page.goPage('/main/service', '');">고객지원</a></li>
                        <li><a href="javascript:" onclick="page.goPage('/main/noticeList');">공지사항</a></li>
			<li><a href="javascript:" onclick="page.goPage('/main/faqList');">FAQ</a></li>
			<li><a href="javascript:" onclick="page.goPage('/main/eventList');">Event</a></li>
			<li><a href="javascript:" onclick="page.goPage('/main/mailQuestion');">1:1 메일문의</a></li>
			<li><a href="javascript:" onclick="page.goPage('/guest/bankInfo');">입금계좌안내</a></li>
                        <li><a href="javascript:" onclick="page.goPage('/main/service', 'shap=screen_remoteService');">원격지원</a></li>
                        <li><a href="javascript:" onclick="page.goNsJsp('map'); return false;">찾아오시는길</a></li>
                    </ul>
                    <ul class='menu_sub'>
                        <li class='menu_title'><a href=''>기타 서비스</a></li>
                        <li><a href='http://www.qpeople.co.kr/page1_1.html' target='_blank'>회사소개</a></li>
                        <li><a href='/guest/join.do'>서비스이용약관</a></li>
                        <li><a href='/guest/join.do'>개인정보취급방침</a></li>
                        <li><a href="#" onclick="page.goNsJsp('company_learning'); return false;">기업교육문의</a></li>
                        <li><a href="#" onclick="page.goNsJsp('tutor_support'); return false;">튜터지원</a></li>
                    </ul>
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