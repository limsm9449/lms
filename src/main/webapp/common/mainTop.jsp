<%@ page contentType="text/html;charset=utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ page import="com.qp.lms.common.SessionVO"%>
<% 
	SessionVO sess = (SessionVO)request.getAttribute("sess"); 
%>
		<div id='screen_top'></div>

        <!-- PC HEADER -->
        <header class='head_pc'>
            <div class="head_wrap pc clear_fix" onmouseover='sub_hide()'>
                <div class='head_con logo_box'>
                    <a href="javascript:" onclick="page.goHome();">
                        <img src='/resources/homepage/img/logo.png' alt=' '>
                    </a>
                </div>
                <div class='head_con search_box'>
                    <input type="text">
                    <button>
                        <img src='/resources/homepage/img/search_ic.png' alt=' '>
                    </button>
                </div>
                <div class='head_con util_box'>
<c:if test="${empty session}">
       				<a href="/guest/join.do">회원가입</a>
       				<a href="/login.do">로그인</a>
</c:if>      		
<c:if test="${!empty session}">      		
                    <a href="javascript:" onclick="gfn_ajax.logout()">로그아웃</a>
                    <a href="javascript:" onclick="page.goPage('/member/userMemberU');" class='pc'>회원정보수정</a>
                    <p class='pc'>${session.userName}님 반갑습니다</p>
</c:if>  
                </div>
            </div>
            <div class="head_wrap mobile clear_fix">
                <div class='mobile_btn'>
                    <button>
                        <span></span><span></span><span></span>
                    </button>
                </div>
                <div class='head_con logo_box'>
                    <a href="javascript:" onclick="page.goHome();">
                        <img src='/resources/homepage/img/logo.png' alt=' '>
                    </a>
                </div>
                <div class='head_con util_box'>
                    <a href="javascript:" onclick="gfn_ajax.logout()" class='last_right'>로그아웃</a>
                </div>
                <div class='head_con search_box'>
                    <input type="text">
                    <button>
                        <img src='/resources/homepage/img/search_ic.png' alt=' '>
                    </button>
                </div>
            </div>
            <div class='menu_wrap'>
                <div class='menu_layout pc' onmouseover='sub_show()'>
                    <div class='mobile_btn'>
                        <button onclick='sub_show_hide_pc(this)'>
                            <span class='first'></span><span class='middle'></span><span class='last'></span>
                        </button>
                    </div>
                    <ul class='menu'>
                        <li>
                            <a href="javascript:" onclick="page.goPage('/main/courseList', '');">전체과정</a>
                        </li>
                        <li>
                            <a href="javascript:" onclick="page.goPage('/main/myClassroom', '');">나의강의실</a>
                        </li>
                        <li>
                            <a href="javascript:" onclick="page.goPage('/main/tutorial', '');">교육안내</a>
                        </li>
                        <li>
                            <a href="javascript:" onclick="page.goPage('/main/service', '');">고객지원</a>
                        </li>
                    </ul>
                    <div class='menu_tutor' onclick='error_msg(event)'>
                    	<a href='#'>
                            <span>
                                <img src='/resources/homepage/img/channel_ic.png' alt=''>
                            </span>
                            <a href='#' onclick="alert('작업중입니다.'); return false;">강사소개</a>
                        </a>
                    </div>
                </div>
                <div class='menu_dropdown_wrapper' id='menu_dropdown_pc'>
                    <div class='menu_dropdown_wrap clear_fix'>
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
                        <img src='/resources/homepage/img/logo.png' alt=' '>
                    </a> 
                </div>
                <div class='head_con util_box'>
<c:if test="${empty session}">
                    <a href='/login.do' class='last_right' onclick='login()'>로그인</a>
</c:if>      		
<c:if test="${!empty session}">      		
                    <a href="javascript:" onclick="gfn_ajax.logout()">로그아웃</a>
</c:if>  

                </div>
                <div class='head_con search_box'>
                    <input type="text">
                    <button>
                        <img src='/resources/homepage/img/search_ic.png' alt=' '>
                    </button>
                </div>
            </div>
            <div class='mobile_dropwdown_wrap'>
                <div class='mobile_bg_box'>
                    <div class='close_btn_area' onclick='mobile_menu_close()'>
                        <img src='/resources/homepage/img/ic_menu_close.png' alt=' '>
                    </div>
                    <div class='mobile_menu login clear_fix'>
                        <span>
                            <img src='/resources/homepage/img/ic_login.png' alt=' '>
                        </span>
<c:if test="${empty session}">
                        <a href='/login.do'>로그인</a>
</c:if>      		
<c:if test="${!empty session}">
                        <a href='#'>${session.userName}님 반갑습니다</a>
</c:if>  
                    </div>
                    <div class='mobile_study_box'>
                        <a href="javascript:" onclick="page.goPage('/main/myClassroom', '');">
                            나의강의실
                        </a>
                    </div>
                    <div class='mobile_menu process_all'>
                        <button onclick='sub_menu_open(this, "others")'>
                            전체과정
                        </button>
                        <ul>
                            <li class='first_depth'><a href="javascript:" onclick="page.goPage('/main/courseList', '');">전체과정</a></li>
<c:forEach var="row" items="${courseCategoryList}" varStatus="idx">
                         	<li><a href="javascript:" onclick="page.goPage('/main/courseList', 'categorys=${row.code}');">${row.codeName}</a></li>
</c:forEach>
                        </ul>
                    </div>
                    <div class='mobile_menu classroom'>
                        <button onclick='sub_menu_open(this, "main")'>
                            나의강의실
                        </button>
                        <ul>
                            <li class='first_depth'><a href="javascript:" onclick="page.goPage('/main/myClassroom', '');">나의강의실</a></li>
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
                    </div>
                    <div class='mobile_menu tutorial'>
                        <button onclick='sub_menu_open(this, "main")'>
                            교육안내
                        </button>
                        <ul>
                            <li class='first_depth'><a href="javascript:" onclick="page.goPage('/main/tutorial', '');">교육안내</a></li>
                            <li><a href="javascript:" onclick="page.goNsJsp('register_method'); return false;">수강신청방법</a></li>
                            <li><a href='javascript:' onclick="page.goNsJsp('study_method'); return false;">학습방법</a></li>
                            <li><a href='javascript:' onclick="page.goNsJsp('study_manage'); return false;">학습관리</a></li>
                            <li><a href="javascript:" onclick="page.goPage('/main/tutorial', 'shap=quick_to');">학습지원프로그램</a></li>
                        </ul>
                    </div>
                    <div class='mobile_menu service'>
                        <button onclick='sub_menu_open(this, "main")'>
                            고객지원
                        </button>
                        <ul>
                            <li class='first_depth'><a href="javascript:" onclick="page.goPage('/main/service', '');">고객지원</a></li>
                            <li><a href="javascript:" onclick="page.goPage('/main/noticeList');">공지사항</a></li>
							<li><a href="javascript:" onclick="page.goPage('/main/faqList');">FAQ</a></li>
							<li><a href="javascript:" onclick="page.goPage('/main/eventList');">Event</a></li>
							<li><a href="javascript:" onclick="page.goPage('/main/mailQuestion');">1:1 메일문의</a></li>
							<li><a href="javascript:" onclick="page.goPage('/guest/bankInfo');">입금계좌안내</a></li>
                            <li><a href="javascript:" onclick="page.goPage('/main/service', 'shap=screen_remoteService');">원격지원</a></li> 
                            <li><a href="javascript:" onclick="page.goNsJsp('map'); return false;">찾아오시는길</a></li>
                        </ul>
                    </div>
                    <div class='mobile_menu introduce'>
                        <a href='#' onclick="alert('작업중입니다.'); return false;">강사소개</a> 
                    </div>
                </div>
            </div>
        </header>
        <!-- MOBILE HEADER END -->

</script>