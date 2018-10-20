<%@ page contentType="text/html;charset=utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ page import="com.qp.lms.common.SessionVO"%>
<% 
	SessionVO sess = (SessionVO)request.getAttribute("sess"); 
%>

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
                    <a href='#'>
                        <img src='/resources/homepage/img/logo.png' alt=' '>
                    </a>
                </div>
                <div class='head_con util_box'>
                    <a href='#' class='last_right'>로그아웃</a>
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
                        <button>
                            <span></span><span></span><span></span>
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
                    <div class='menu_tutor'>
                        <span>
                            <img src='/resources/homepage/img/channel_ic.png' alt=''>
                        </span>
                        <p>강사소개</p>
                    </div>
                </div>
                <div class='menu_dropdown_wrapper' id='menu_dropdown_pc'>
                    <div class='menu_dropdown_wrap'>
                        <div class='menu_dropdown clear_fix'>
                            <ul class='menu_sub'>
<c:forEach var="row" items="${courseCategoryList}" varStatus="idx">
                                <li><a href="javascript:" onclick="page.goPage('/main/courseList', 'category=${row.code}');">${row.codeName}</a></li>
</c:forEach>
                            </ul>
                            <span class='menu_sub_line'></span>
                            <ul class='menu_sub classroom'>
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
                            <span class='menu_sub_line'></span>
                            <ul class='menu_sub'>
                                <li><a href="javascript:" onclick="page.goNsJsp('how');">수강신청방법</a></li>
                                <li><a href=''>학습방법</a></li>
                                <li><a href=''>학습관리</a></li>
                                <li><a href=''>수강후기</a></li>
                                <li><a href=''>학습지원프로그램</a></li>
                            </ul>
                            <span class='menu_sub_line'></span>
                            <ul class='menu_sub'>
                                <li><a href="javascript:" onclick="page.goPage('/user/noticeList');">공지사항</a></li>
								<li><a href="javascript:" onclick="page.goPage('/user/faqList');">FAQ</a></li>
								<li><a href="javascript:" onclick="page.goPage('/main/mailQuestion');">1:1 메일문의</a></li>
								<li><a href="javascript:" onclick="page.goPage('/guest/bankInfo');">입금계좌안내</a></li>
                                <li><a href=''>원격지원</a></li>
                                <li><a href=''>찾아오시는길</a></li>
                            </ul>
                        </div>
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
                    <a href='#'>
                        <img src='/resources/homepage/img/logo.png' alt=' '>
                    </a>
                </div>
                <div class='head_con util_box'>
<c:if test="${empty session}">
                    <a href='/login.do' class='last_right' onclick='login()'>로그인</a>
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
                        <a href='#'>${session.userName}님 반갑습니다</p>
</c:if>  
                    </div>
                    <div class='mobile_menu process_all'>
                        <button onclick='sub_menu_open(this, "main")'>
                            전체과정
                        </button>
                        <ul>
                            <li class='first_depth'><a href="javascript:" onclick="page.goPage('/main/courseList', '');">전체과정</a></li>
<c:forEach var="row" items="${courseCategoryList}" varStatus="idx">
                         	<li><a href="javascript:" onclick="page.goPage('/main/courseList', 'category=${row.code}');">${row.codeName}</a></li>
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
                            <li class='first_depth'><a href='./html/guidance/tutorial.html'>교육안내</a></li>
                            <li><a href="javascript:" onclick="page.goNsJsp('how');">수강신청방법</a></li>
                            <li><a href=''>학습방법</a></li>
                            <li><a href=''>학습관리</a></li>
                            <li><a href=''>수강후기</a></li>
                            <li><a href=''>학습지원프로그램</a></li>
                        </ul>
                    </div>
                    <div class='mobile_menu service'>
                        <button onclick='sub_menu_open(this, "main")'>
                            고객지원
                        </button>
                        <ul>
                            <li class='first_depth'><a href='./html/support/service.html'>고객지원</a></li>
                            <li><a href="javascript:" onclick="page.goPage('/user/noticeList');">공지사항</a></li>
							<li><a href="javascript:" onclick="page.goPage('/user/faqList');">FAQ</a></li>
							<li><a href="javascript:" onclick="page.goPage('/main/mailQuestion');">1:1 메일문의</a></li>
							<li><a href="javascript:" onclick="page.goPage('/guest/bankInfo');">입금계좌안내</a></li>
                            <li><a href=''>원격지원</a></li>
                            <li><a href=''>찾아오시는길</a></li>
                        </ul>
                    </div>
                    <div class='mobile_menu introduce'>
                        <a href='#'>강사소개</a>
                    </div>
                </div>
            </div>
        </header>
        <!-- MOBILE HEADER END -->
        

        