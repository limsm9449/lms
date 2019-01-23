<%@ page contentType="text/html;charset=utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ page import="com.qp.lms.common.SessionVO"%>
<% 
	SessionVO sess = (SessionVO)request.getAttribute("sess"); 
%>
		<div id='screen_top'></div>

		<input type="hidden" id="courseName" name="courseName">
		
        <!-- PC HEADER -->
        <header class='head_pc'>
            <div class="head_wrap pc clear_fix">
                <div class='head_con logo_box'>
                    <a href='#' onclick="page.goHome();">
                        <img src='/resources/homepageQch/img/main/logo.png' alt=' '>
                    </a>
                </div>
                <div class='head_con search_box'>
                    <input type="text" id="topSearch1" name="topSearch1" value="${set.condiVO.courseName}">
                    <button onclick="$('#courseName').val($('#topSearch1').val());  f_submitSelf('/main/courseList');">
                        <img src='/resources/homepageQch/img/search_ic.png' alt=' '>
                    </button>
                </div>
                <div class='head_con util_box'>
<c:if test="${empty session}">
       				<a href="/guest/join.do" class='last_right'>회원가입</a>
       				<a href="/login.do" onclick='login()'>로그인-Q</a>
</c:if>      		
<c:if test="${!empty session}">      		
                    <a href="javascript:" onclick="gfn_ajax.logout()" class='last_right'>로그아웃-Q</a>
                    <a href="javascript:" onclick="page.goPage('/member/userMemberU');" class='pc'>회원정보수정</a>
</c:if>                  
                </div>
            </div>
            <div class='menu_wrap'>
                <div class='menu_layout pc'>
                </div>
                <div class='menu_dropdown_wrapper' id='menu_dropdown_pc'>
                    <div class='menu_dropdown_wrap clear_fix'>
                        <ul class='menu_sub' id="menu_sub1">
                            <li class='menu_title'><a href="javascript:" onclick="page.goPage('/main/courseList', '');">전체과정보기</a></li>
                        </ul>
                        <ul class='menu_sub classroom' id="menu_sub2">
                            <li class='menu_title'><a href="javascript:" onclick="page.goPage('/normalUser/attendCourseList', '');">나의강의실</a></li>
                            <li><a href="javascript:" onclick="page.goPage('/normalUser/attendCourseList');">수강중 과정</a></li>
                            <li><a href="javascript:" onclick="page.goPage('/normalUser/waitingCourseList');">대기중 과정</a></li>
                            <li><a href="javascript:" onclick="page.goPage('/normalUser/myCourseList');">수강완료과정</a></li>
                        </ul>
                        <ul class='menu_sub' id="menu_sub3">
                            <li class='menu_title'><a href='#'>마이페이지</a></li>
                            <li><a href='javascript:' onclick="page.goPage('/main/myOrder');">주문/신청 조회</a></li>
                            <li><a href='javascript:' onclick="page.goPage('/main/myPoint');">포인트</a></li>
                            <li><a href='javascript:' onclick="page.goPage('/main/myActivity');">나의 활동관리</a></li>
                            <li><a href="javascript:" onclick="page.goPage('/member/userMemberU');">회원정보수정</a></li>
                            <li><a href="javascript:" onclick="page.goPage('/member/memberChangePassword');">비밀번호 변경</a></li>
                        </ul>
                        <ul class='menu_sub' id="menu_sub4">
                            <li class='menu_title'><a href="javascript:" onclick="page.goPage('/main/service', '');">고객지원</a></li>
                            <li><a href="javascript:" onclick="page.goPage('/main/noticeList');">공지사항</a></li>
                            <li><a href="javascript:" onclick="page.goPage('/main/faqList');">자주 묻는 질문</a></li>
                            <li><a href="javascript:" onclick="page.goPage('/main/mailQuestion');">1:1 메일문의</a></li>
                            <li><a href="javascript:" onclick="page.goPage('/main/tutorial');">학습지원</a></li>
                            <li><a href="javascript:" onclick="page.goPage('/guest/bankInfo');">입금계좌안내</a></li>
                        </ul>
                        <ul class='menu_sub' id="menu_sub5">
                            <li class='menu_title'><a href=''>큐러닝</a></li>
                            <li><a href='http://www.qpeople.co.kr/page1_1.html' target='_blank'>회사소개</a></li>
                            <li><a href="#" onclick="page.goNsJsp('company_learningQch'); return false;">기업교육문의</a></li>
                            <li><a href="#" onclick="page.goNsJsp('tutor_supportQch'); return false;">튜터지원</a></li>
                        </ul>
                    </div>
                   
                </div>
            </div>
        </header>
        <!-- PC HEADER END -->

        <!-- MOBILE HEADER -->
        <header class='head_mobile'>
            <div class="head_wrap pc clear_fix">
                <div class='menu_wrap'>
                    <div class='menu_layout pc' onclick='sub_show_hide()'>
                        <div class='mobile_btn'>
                            <button onclick='mobile_menu()'>
                                <span></span><span></span><span></span>
                            </button>
                        </div>
                    </div>
                </div>
                <div class='head_con logo_box'>
                    <a href="javascript:" onclick="page.goHome();">
                        <img src='/resources/homepageQch/img/main/logo.png' alt=' '>
                    </a>
                </div>
                <div class='head_con util_box'>
<c:if test="${empty session}">
                    <a href='/login.do' class='last_right' onclick='login()'>로그인</a>
</c:if>      		
<c:if test="${!empty session}">      		
                    <a href="javascript:" onclick="gfn_ajax.logout()" class='last_right'>로그아웃</a>
</c:if>  
                </div>
                <div class='head_con search_box'>
                    <input type="text" id="topSearch2" name="topSearch2" value="${set.condiVO.courseName}">
                    <button onclick="$('#courseName').val($('#topSearch2').val());  f_submitSelf('/main/courseList');">
                        <img src='/resources/homepageQch/img/search_ic.png' alt=' '>
                    </button>
                </div>
            </div>
            <div class='mobile_dropwdown_wrap'>
                <div class='mobile_bg_box'>
                    <div class='close_btn_area' onclick='mobile_menu_close()'>
                        <img src='/resources/homepageQch/img/main/ic_menu_close.png' alt=' '>
                    </div>
                    <div class='mobile_menu login clear_fix'>
                        <span>
                            <img src='/resources/homepageQch/img/main/ic_login.png' alt=' '>
                        </span>
                        <a href="javascript:" onclick="gfn_ajax.logout()" >로그아웃</a>
                    </div>
                    <div class='mobile_study_box'>
                        <a href="javascript:" onclick="page.goPage('/main/myClassroom', '');">
                            나의강의실
                        </a>
                    </div>
                    <div class='mobile_full_box'>
                        <a href="javascript:" onclick="page.goPage('/main/courseList', '');">
                            전체과정보기
                        </a>
                    </div>
                    <div class='mobile_menu classroom'>
                        <button onclick='sub_menu_open(this, "main")'>
                            나의강의실
                        </button>
                        <ul>
                        	<li class='first_depth'><a href="javascript:" onclick="page.goPage('/main/myClassroom', '');">나의강의실</a></li>
                            <li><a href="javascript:" onclick="page.goPage('/normalUser/attendCourseList');">수강중 과정</a></li>
                            <li><a href="javascript:" onclick="page.goPage('/normalUser/waitingCourseList');">대기중 과정</a></li>
                            <li><a href="javascript:" onclick="page.goPage('/normalUser/myCourseList');">수강완료과정</a></li>
                        </ul>
                    </div>
                    <div class='mobile_menu tutorial'>
                        <button onclick='sub_menu_open(this, "main")'>
                            마이페이지
                        </button>
                        <ul>
                            <li class='first_depth'><a href='javascript:' onclick="page.goPage('/main/myOrder');">주문/신청 조회</a></li>
                            <li><a href='javascript:' onclick="page.goPage('/main/myPoint');">포인트</a></li>
                            <li><a href='javascript:' onclick="page.goPage('/main/myActivity');">나의 활동관리</a></li>
                            <li><a href="javascript:" onclick="page.goPage('/member/userMemberU');">회원정보수정</a></li>
                            <li><a href="javascript:" onclick="page.goPage('/member/memberChangePassword');">비밀번호 변경</a></li>
                        </ul>
                    </div>
                    <div class='mobile_menu service'>
                        <button onclick='sub_menu_open(this, "main")'>
                            고객지원
                        </button>
                        <ul>
                            <li class='first_depth'><a href="javascript:" onclick="page.goPage('/main/noticeList');">공지사항</a></li>
                            <li><a href="javascript:" onclick="page.goPage('/main/faqList');">자주 묻는 질문</a></li>
                            <li><a href="javascript:" onclick="page.goPage('/main/mailQuestion');">1:1 메일문의</a></li>
                            <li><a href="javascript:" onclick="page.goPage('/main/tutorial');">학습지원</a></li>
                            <li><a href="javascript:" onclick="page.goPage('/guest/bankInfo');">입금계좌안내</a></li>
                        </ul>
                    </div>
                    <div class='mobile_menu service'>
                        <button onclick='sub_menu_open(this, "main")'>
                            큐러닝
                        </button>
                        <ul>
                            <li class='first_depth'><a href='/resources/homepageQch/html/support/support.html'>큐러닝</a></li>
                            <li><a href='http://www.qpeople.co.kr/page1_1.html' target='_blank'>회사소개</a></li>
                            <li><a href="#" onclick="page.goNsJsp('company_learning'); return false;">기업교육문의</a></li>
                            <li><a href="#" onclick="page.goNsJsp('tutor_support'); return false;">튜터지원</a></li>
                        </ul>
                    </div>

                </div>
            </div>
        </header>
        <!-- MOBILE HEADER END -->


