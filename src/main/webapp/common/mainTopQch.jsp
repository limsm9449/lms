<%@ page contentType="text/html;charset=utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ page import="com.qp.lms.common.SessionVO"%>
<% 
	SessionVO sess = (SessionVO)request.getAttribute("sess"); 
%>
		<div id='screen_top'></div>

        <header class='head_pc'>
            <div class='head_wrap pc clear_fix'>
                <div class='head_con logo_box'>
                    <a href='../../index.html'>
                        <img src='../../img/main/logo.png' alt=' '>
                    </a>
                </div>
                <div class='head_con search_box'>
                    <input type='text'>
                    <button>
                        <img src='../../img/main/search_ic.png' alt=' '>
                    </button>
                </div>
                <div class='head_con util_box'>
                    <!-- 로그인 상태 -->
                    <!-- <a href='#' class='last_right'>로그아웃</a>
                    <a href='../etc/user_info_change.html' class='pc'>회원정보수정</a>
                    <p class='pc'>OOO님 반갑습니다.</p> -->

                    <!-- 로그오프 상태 -->
                    <a href='../../html/etc/signup_step1.html' class='last_right'>회원가입</a>
                    <a href='../../html/etc/signin.html' onclick='login()'>로그인</a>
                </div>
            </div>
            <div class='head_wrap mobile clear_fix'>
                <div class='mobile_btn'>
                    <button>
                        <span></span><span></span><span></span>
                    </button>
                </div>
                <div class='head_con logo_box'>
                    <img src='../../img/main/logo.png' alt=' '>
                </div>
                <div class='head_con util_box'>
                    <a href='#' class='last_right'>로그아웃</a>
                </div>
                <div class='head_con search_box'>
                    <input type='text'>
                    <button>
                        <img src='../../img/main/search_ic.png' alt=' '>
                    </button>
                </div>
            </div>
            <div class='menu_wrap'>
                <div class='menu_layout pc'>
                    
                    
                    
                </div>
                <div class='menu_dropdown_wrapper' id='menu_dropdown_pc'>
                    <div class='menu_dropdown_wrap clear_fix'>
                        <ul class='menu_sub' id="menu_sub1">
                            <li class='menu_title'><a href='../../html/course/process.html'>전체과정보기</a></li>
                        </ul>
                        <ul class='menu_sub classroom' id="menu_sub2">
                            <li class='menu_title'><a href='../../html/classroom/classroom.html'>나의강의실</a></li>
                            <li><a href='../../html/classroom/lectures.html'>수강중 과정</a></li>
                            <li><a href='../../html/classroom/lecture_standby.html'>대기중 과정</a></li>
                            <li><a href='../../html/classroom/lecture_completed.html'>수강완료과정</a></li>
                        </ul>
                        <ul class='menu_sub' id="menu_sub3">
                            <li class='menu_title'><a href='#'>마이페이지</a></li>
                            <li><a href='#'>주문/신청 조회</a></li>
                            <li><a href='#'>포인트</a></li>
                            <li><a href='#'>나의 활동관리</a></li>
                            <li><a href='../../html/etc/user_info_change.html' class='pc'>회원정보수정</a></li>
                        </ul>
                        <ul class='menu_sub' id="menu_sub4">
                            <li class='menu_title'><a href='../../html/support/support.html'>고객지원</a></li>
                            <li><a href='../../html/support/notice.html'>공지사항</a></li>
                            <li><a href='../../html/support/notice.html'>자주 묻는 질문</a></li>
                            <li><a href='../../html/support/notice.html'>1:1 메일문의</a></li>
                            <li><a href='../../html/support/notice.html'>학습지원</a></li>
                            <li><a href='../../html/support/notice.html'>입금계좌안내</a></li>
                        </ul>
                        <ul class='menu_sub' id="menu_sub5">
                            <li class='menu_title'><a href=''>큐러닝</a></li>
                            <li><a href='http://www.qpeople.co.kr/page1_1.html' target='_blank'>회사소개</a></li>
                            <li><a href='../../html/etc/company_learning.html'>기업교육문의</a></li>
                            <li><a href='../../html/etc/tutor_support.html'>튜터지원</a></li>
                        </ul>
                    </div>
                </div>
            </div>
        </header>
        <!-- PC HEADER END -->

        <!-- MOBILE HEADER -->
        <header class='head_mobile'>
            <div class='head_wrap pc clear_fix'>
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
                    <a href='../../index.html'>
                        <img src='../../img/main/logo.png' alt=' '>
                    </a>
                </div>
                <div class='head_con util_box'>
                    <a href='../etc/signin.html' class='last_right' onclick='login()'>로그인</a>
                    <!--<a href='../../index.html' class='last_right' onclick=''>로그아웃</a>-->
                </div>
                <div class='head_con search_box'>
                    <input type='text'>
                    <button>
                        <img src='../../img/main/search_ic.png' alt=' '>
                    </button>
                </div>
            </div>
            <div class='mobile_dropwdown_wrap'>
                <div class='mobile_bg_box'>
                    <div class='close_btn_area' onclick='mobile_menu_close()'>
                        <img src='../../img/main/ic_menu_close.png' alt=' '>
                    </div>
                    <div class='mobile_menu login clear_fix'>
                        <span>
                            <img src='../../img/main/ic_login.png' alt=' '>
                        </span>
                        <!-- <a href='../../html/etc/signin.html' onclick='login()'>로그인</a> -->
                        <a href='./index.html'>로그아웃</a>
                    </div>
                    <div class='mobile_study_box'>
                        <a href='../../html/classroom/classroom.html'>
                            나의강의실
                        </a>
                    </div>
                    <div class='mobile_full_box'>
                        <a href='../../html/course/process.html'>
                            전체과정보기
                        </a>
                    </div>
                    <div class='mobile_menu classroom'>
                        <button onclick='sub_menu_open(this, "main")'>
                            나의강의실
                        </button>
                        <ul>
                        	<li class='first_depth'><a href='../../html/classroom/classroom.html'>나의강의실</a></li>
                            <li><a href='../../html/classroom/lectures.html'>수강중 과정</a></li>
                            <li><a href='../../html/classroom/lecture_standby.html'>대기중 과정</a></li>
                            <li><a href='../../html/classroom/lecture_completed.html'>수강완료과정</a></li>
                        </ul>
                    </div>
                    <div class='mobile_menu tutorial'>
                        <button onclick='sub_menu_open(this, "main")'>
                            마이페이지
                        </button>
                        <ul>
                            <li class='first_depth'><a href='#'>마이페이지</a></li>
                            <li><a href='#'>주문/신청 조회</a></li>
                            <li><a href='#'>포인트</a></li>
                            <li><a href='#'>나의 활동관리</a></li>
                            <li><a href='../../html/etc/user_info_change.html' class='pc'>회원정보수정</a></li>
                        </ul>
                    </div>
                    <div class='mobile_menu service'>
                        <button onclick='sub_menu_open(this, "main")'>
                            고객지원
                        </button>
                        <ul>
                            <li class='first_depth'><a href='../../html/support/support.html'>고객지원</a></li>
                            <li><a href='../../html/support/notice.html'>공지사항</a></li>
                            <li><a href='../../html/support/notice.html'>자주 묻는 질문</a></li>
                            <li><a href='../../html/support/notice.html'>1:1 메일문의</a></li>
                            <li><a href='../../html/support/notice.html'>학습지원</a></li>
                            <li><a href='../../html/support/notice.html'>입금계좌안내</a></li>
                        </ul>
                    </div>
                    <div class='mobile_menu service'>
                        <button onclick='sub_menu_open(this, "main")'>
                            큐러닝
                        </button>
                        <ul>
                            <li class='first_depth'><a href='../../html/support/support.html'>큐러닝</a></li>
                            <li><a href='http://www.qpeople.co.kr/page1_1.html' target='_blank'>회사소개</a></li>
                            <li><a href='../../html/etc/company_learning.html'>기업교육문의</a></li>
                            <li><a href='../../html/etc/tutor_support.html'>튜터지원</a></li>
                        </ul>
                    </div>
                </div>
            </div>
        </header>
        <!-- MOBILE HEADER END -->

</script>