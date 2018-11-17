<%@ page contentType="text/html;charset=utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<!DOCTYPE html>
<html lang='ko'>

<head>
    <meta charset='utf-8'>
    <meta name='viewport' content='width=device-width, initial-scale=1.0'>
    <meta http-equiv='X-UA-Compatible' content='ie=edge'>
    <title>Q learning - Main</title>

	<%@ include file="../common/commMainInclude.jsp" %>
</head>

<body>
    <div class="wrap">
        <!-- HEAD -->
        <div id='width_text'></div>
        <header>
            <div class="head_wrap pc clear_fix" >
                <div class='head_con logo_box'>
                    <img src='/resources/homepage/img/logo.png' alt=' '>
                </div>
                <div class='head_con search_box'>
                    <input type="text">
                    <button>
                        <img src='/resources/homepage/img/search_ic.png' alt=' '>
                    </button>
                </div>
                <div class='head_con util_box'>
<c:if test="${empty set.sessVO}">
       				<a href="/guest/join.do">회원가입</a>
       				<a href="/login.do">로그인</a>
</c:if>      		
<c:if test="${!empty set.sessVO}">      		
                    <a href="javascript:" onclick="gfn_ajax.logout()">로그아웃</a>
                    <a href="javascript:" onclick="page.goPage('/member/userMemberU');" class='pc'>회원정보수정</a>
                    <p class='pc'>${set.sessVO.userName}님 반갑습니다.</p>
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
                    <img src='/resources/homepage/img/logo.png' alt=' '>
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
                            <a href=''>전체과정</a>
                        </li>
                        <li>
                            <a href=''>나의강의실</a>
                        </li>
                        <li>
                            <a href=''>교육안내</a>
                        </li>
                        <li>
                            <a href=''>고객지원</a>
                        </li>
                    </ul>
                    <div class='menu_tutor'>
                        <span>
                            <img src='/resources/homepage/img/channel_ic.png' alt=''>
                        </span>
                        <p>강사채널</p>
                    </div>
                </div>
                <div class='menu_dropdown_wrapper'>
                    <div class='menu_dropdown_wrap'>
                        <div class='menu_dropdown clear_fix'>
                            <ul class='menu_sub'>
<c:forEach var="row" items="${set.categoryList}" varStatus="idx">
                                <li><a href="javascript:" onclick="page.goPage('/main/courseList', 'c1Code=${row.code}');">${row.codeName}</a></li>
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
        <!-- HEAD END -->

        <!-- CONTENTS -->
        <div class='contents_wrap' >
            <div class='slider_wrap'>
                <div class='slide_box slide_1'>
                    <div class='visual_box'>
                        <img src='/resources/homepage/img/main_visual.jpg' alt=''>
                    </div>
                    <div class='slide clear_fix'>
                        <div class='slider_text_box'>
                            <img src='/resources/homepage/img/visual_text.png' class='pc' alt=' '>
                            <img src='/resources/homepage/img/visual_text_mobile.png' class='mobile' alt=' '>
                        </div>
                        <button>상세보기1</button>
                    </div>
                </div>
                <div class='slide_box slide_2'>
                    <div class='visual_box'>
                        <img src='/resources/homepage/img/main_visual.jpg' alt=''>
                    </div>
                    <div class='slide clear_fix'>
                        <div class='slider_text_box'>
                            <img src='/resources/homepage/img/visual_text.png' class='pc' alt=' '>
                            <img src='/resources/homepage/img/visual_text_mobile.png' class='mobile' alt=' '>
                        </div>
                        <button>상세보기2</button>
                    </div>
                </div>
                <div class='slide_box slide_3'>
                    <div class='visual_box'>
                        <img src='/resources/homepage/img/main_visual.jpg' alt=''>
                    </div>
                    <div class='slide clear_fix'>
                        <div class='slider_text_box'>
                            <img src='/resources/homepage/img/visual_text.png' class='pc' alt=' '>
                            <img src='/resources/homepage/img/visual_text_mobile.png' class='mobile' alt=' '>
                        </div>
                        <button>상세보기3</button>
                    </div>
                </div>
            </div>
            <div class='slider_tab_wrap'>
                <div class='slider_tab'>
                    <button onclick='' class='active'>베스트 과정</button>
                    <button onclick=''>9월 신규 이벤트</button>
                    <button onclick=''>주요 공지사항</button>
                </div>
            </div>
            <div class='process_wrap'>
                <p>신규 과정</p>
                <div class='process_box process1'>
                    <div class='process clear_fix'>
                        <p class='process_title'>
                            김정구 교수의
                            <span>
                                새로운 <strong>미래기회 창조 및 선점전략</strong>
                            </span>
                        </p>
                        <p class='process_text'>
                            패러다임이 급변하는 사회, 최고의 위기라고도 할 수 있는 향후 10년. 위기와 역경을 기회로 만들어 당신을 도약시킬 수 있는 미래창조 비결을 제시합니다.
                        </p>
                        <a href=''>바로가기</a>
                    </div>
                </div>
                <div class='process_box process2'>
                    <div class='process'>
                        <p class='process_title'>
                            <span>
                                남다른 <strong>교구활용의 정석</strong>
                            </span>
                        </p>
                        <p class='process_text'>
                            활기찬 교실! 재미있는 수업!<br>다양한 교구를 통한 남다른 교실 만들기!
                        </p>
                        <a href=''>바로가기</a>
                    </div>
                </div>
            </div>
            <div class='recommend_wrap'>
                <p>
                    추천 과정
                    <span>큐매니저가 추천하는 특별한 과정을 만나보세요.</span>
                </p>
                <ul class='clear_fix'>
                    <li class='recommend recommend1 clear_fix'>
                        <a href='' class='recommend_title white'>
                            <p class='lecture_title'>
                                윤코치의
                                <strong>보고서 작성법</strong>
                            </p>
                            <p>한 장의 종이로 상사의<br>마음을 움직인다!</p>
                        </a>
                        <p class='recommend_text'>
                            <strong>[스마트러닝] 윤코치의 보고서 작성법</strong>
                            퇴짜맞는 보고서, 형식적인 보고서는 더 이상 없다!
                        </p>
                        <a class='lecture_more' href=''>상세보기</a>
                    </li>
                    <li class='recommend recommend2 clear_fix'>
                        <a href='' class='recommend_title'>
                            <p class='lecture_title'>
                                토끼와 거북이의
                                <strong>재테크 비법</strong>
                            </p>
                            <p>당신만을 위한 재테크 전략을<br>지금 만나보세요</p>
                        </a>
                        <p class='recommend_text'>
                            <strong>[스마트러닝] 토끼와 거북의의 재테크 비법</strong>
                            퇴짜맞는 보고서, 형식적인 보고서는 더 이상 없다!
                        </p>
                        <a class='lecture_more' href=''>상세보기</a>
                    </li>
                    <li class='recommend recommend3 clear_fix last_right'>
                        <a href='' class='recommend_title'>
                        </a>
                        <p class='recommend_text'>
                            <strong>[스마트러닝] 시원하게 뚫어 주는 비즈니스 스킬</strong>
                            업무에 대한 답답한 마음을 실제적인 비즈니스 스킬을<br>통해 시원하게 해결해 주는 솔루션
                        </p>
                        <a class='lecture_more' href=''>상세보기</a>
                    </li>
                </ul>
            </div>
        </div>
        <!-- CONTENTS END -->
    </div>
    <script src='/resources/homepage/js/main.js'></script>
</body>

</html>