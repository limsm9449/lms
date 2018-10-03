<%@ page contentType="text/html;charset=utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<!DOCTYPE html>
<html lang='ko' data-useragent="Mozilla/5.0 (compatible; MSIE 10.0; Windows NT 6.2; Trident/6.0)">

<head>
    <meta charset='utf-8'>
    <meta name='viewport' content='width=device-width, initial-scale=1, minimum-scale=1, maximum-scale=1'>
    <meta http-equiv='X-UA-Compatible' content='ie=edge'>
    <title>Q learning - Main</title>

	<%@ include file="../common/commMainInclude.jsp" %>

    <script src='/resources/homepage/js/jquery_3.3.1.js'></script>
    <!--[if IE8]>
        <script src="http://code.jquery.com/jquery-1.12.3.js></script>
    <![endif]-->
    <script src='/resources/homepage/js/jquery.bxslider.js'></script>

    <!--[if IE]>
        <link rel='stylesheet' href='/resources/homepage/css/main_ie.css'>
    <![endif]-->

    <link href='https://fonts.googleapis.com/css?family=Nanum+Gothic' rel='stylesheet'>

    <link rel='stylesheet' href='/resources/homepage/css/reset.css'>
    <link rel='stylesheet' href='/resources/homepage/css/main.css'>
</head>

<body>
    <div class="wrap">
       	
       	<!-- HEAD -->
       	<%@ include file="./mainTop.jsp" %>
       	<!-- HEAD END -->

        <!-- CONTENTS -->
        <div class='contents_wrap' onmouseover='sub_hide()'>
            <!-- QUICK MENU -->
            <%@ include file="./mainQuickMenu.jsp" %>

            <!-- VISUAL -->
            <ul class='slider_wrap tabs' id='tab1'>
                <li class='slide_box slide_1'>
                    <div class='visual_box'>
                        <div class='slide clear_fix'>
                            <div class='slider_text_box'>
                                <img src='/resources/homepage/img/visual_text.png' class='pc' alt=' '>
                            </div>
                            <button>상세보기1</button>
                        </div>
                    </div>
                </li>
                <li class='slide_box slide_2'>
                    <div class='visual_box'>
                        <div class='slide clear_fix'>
                            <div class='slider_text_box left'>
                                <img src='/resources/homepage/img/visual2_text.png' class='pc' alt=' '>
                            </div>
                            <button class='right_bottom'>상세보기2</button>
                        </div>
                    </div>
                </li>
                <li class='slide_box slide_3'>
                    <div class='visual_box'>
                        <div class='slide clear_fix'>
                            <div class='slider_text_box'>
                            </div>
                            <button class='right_bottom_nonText'>상세보기3</button>
                        </div>
                    </div>
                </li>
            </ul>
            <ul class='slider_wrap tabs' id='tab2'>
                <li class='slide_box slide_1'>
                    <div class='visual_box'>
                        <div class='slide clear_fix'>
                            <div class='slider_text_box'>
                                <img src='/resources/homepage/img/visual_text.png' class='pc' alt=' '>
                            </div>
                            <button>이벤트1</button>
                        </div>
                    </div>
                </li>
                <li class='slide_box slide_2'>
                    <div class='visual_box'>
                        <div class='slide clear_fix'>
                            <div class='slider_text_box left'>
                                <img src='/resources/homepage/img/visual2_text.png' class='pc' alt=' '>
                            </div>
                            <button class='right_bottom'>상세보기2</button>
                        </div>
                    </div>
                </li>
                <li class='slide_box slide_3'>
                    <div class='visual_box'>
                        <div class='slide clear_fix'>
                            <div class='slider_text_box'>
                            </div>
                            <button class='right_bottom_nonText'>이벤트3</button>
                        </div>
                    </div>
                </li>
            </ul>
            <ul class='slider_wrap tabs' id='tab3'>
                <li class='slide_box slide_1'>
                    <div class='visual_box'>
                        <div class='slide clear_fix'>
                            <div class='slider_text_box'>
                                <img src='/resources/homepage/img/visual_text.png' class='pc' alt=' '>
                            </div>
                            <button>공지사항1</button>
                        </div>
                    </div>
                </li>
                <li class='slide_box slide_2'>
                    <div class='visual_box'>
                        <div class='slide clear_fix'>
                            <div class='slider_text_box left'>
                                <img src='/resources/homepage/img/visual2_text.png' class='pc' alt=' '>
                            </div>
                            <button class='right_bottom'>상세보기2</button>
                        </div>
                    </div>
                </li>
                <li class='slide_box slide_3'>
                    <div class='visual_box'>
                        <div class='slide clear_fix'>
                            <div class='slider_text_box'>
                            </div>
                            <button class='right_bottom_nonText'>공지사항3</button>
                        </div>
                    </div>
                </li>
            </ul>
            <div class='slider_tab_wrap'>
                <div class='slider_tab'>
                    <button onclick='change_tab(0, this)' class='on'>베스트 과정</button>
                    <button onclick='change_tab(1, this)' id='btn_center'>9월 신규 이벤트</button>
                    <button onclick='change_tab(2, this)'>주요 공지사항</button>
                </div>
            </div>
            <!-- VISUAL END -->

            <!-- NEW PROCESS -->
            <div class='process_wrap'>
                <p>신규 과정</p>
                <div class='slider_wrap process1_slide_wrap'>
                    <div class='slide_box slide_1'>
                        <div class='process_box process1'>
                            <div class='process clear_fix'>
                                <p class='process_title'>
                                    김정구 교수의
                                    <span>
                                        새로운 <strong>미래기회 창조 및 선점전략</strong>
                                    </span>
                                </p>
                                <p class='process_text'>
                                    패러다임이 급변하는 사회, 최고의 위기라고도 할 수 있는 향후 10년. 위기와 역경을 기회로 만들어 당신을 도약시킬 수 있는 미래창조 비결을
                                    제시합니다.
                                </p>
                                <a href=''>바로가기1</a>
                            </div>
                        </div>
                    </div>
                    <div class='slide_box slide_2'>
                        <div class='process_box process1'>
                            <div class='process clear_fix'>
                                <p class='process_title'>
                                    김정구 교수의
                                    <span>
                                        새로운 <strong>미래기회 창조 및 선점전략</strong>
                                    </span>
                                </p>
                                <p class='process_text'>
                                    패러다임이 급변하는 사회, 최고의 위기라고도 할 수 있는 향후 10년. 위기와 역경을 기회로 만들어 당신을 도약시킬 수 있는 미래창조 비결을
                                    제시합니다.
                                </p>
                                <a href=''>바로가기2</a>
                            </div>
                        </div>
                    </div>
                    <div class='slide_box slide_3'>
                        <div class='process_box process1'>
                            <div class='process clear_fix'>
                                <p class='process_title'>
                                    김정구 교수의
                                    <span>
                                        새로운 <strong>미래기회 창조 및 선점전략</strong>
                                    </span>
                                </p>
                                <p class='process_text'>
                                    패러다임이 급변하는 사회, 최고의 위기라고도 할 수 있는 향후 10년. 위기와 역경을 기회로 만들어 당신을 도약시킬 수 있는 미래창조 비결을
                                    제시합니다.
                                </p>
                                <a href=''>바로가기3</a>
                            </div>
                        </div>
                    </div>
                </div>
                <div class='slider_wrap process2_slide_wrap'>
                    <div class='slide_box slide_1'>
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
                                <a href=''>바로가기1</a>
                            </div>
                        </div>
                    </div>
                    <div class='slide_box slide_2'>
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
                                <a href=''>바로가기2</a>
                            </div>
                        </div>
                    </div>
                    <div class='slide_box slide_3'>
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
                                <a href=''>바로가기3</a>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <!-- NEW PROCESS END -->

            <!-- PROCESS RECOMMEND -->
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
            <!-- PROCESS RECOMMEND END -->

            <!-- CUSTOMER SERVICE -->
            <div class="cs clear_fix">
                <div class="notice clear_fix">
                    <p class='cs_title'>공지사항</p>
                    <span class='cs_more'>+</span>
                    <ul>
                        <li class='notice_list'>
                            <a href='#'>
                                <p>[오픈] Grammar Zone Grammar Zone Grammar Zone</p>
                                <span>2017.04.12</span>
                            </a>
                        </li>
                        <li class='notice_list'>
                            <a href='#'>
                                <p>[OPEN] 진로특강 강점편 오픈!!</p>
                                <span>2017.04.12</span>
                            </a>
                        </li>
                        <li class='notice_list'>
                            <a href='#'>
                                <p>[OPEN] 진로특강 강점편 오픈!!</p>
                                <span>2017.04.12</span>
                            </a>
                        </li>
                        <li class='notice_list'>
                            <a href='#'>
                                <p>[OPEN] 진로특강 강점편 오픈!!</p>
                                <span>2017.04.12</span>
                            </a>
                        </li>
                    </ul>
                </div>
                <div class="faq clear_fix">
                    <p class='cs_title'>FAQ</p>
                    <span class='cs_more'>+</span>
                    <ul>
                        <li class='faq_list'>
                            <a href='#'>
                                <p>무통장입금(가상계좌) 결제 방법을 알려주세요</p>
                            </a>
                        </li>
                        <li class='faq_list'>
                            <a href='#'>
                                <p>배송 확인(조회)은 어떻게 하나요?</p>
                            </a>
                        </li>
                        <li class='faq_list'>
                            <a href='#'>
                                <p>회원정보를 수정하고 싶어요</p>
                            </a>
                        </li>
                        <li class='faq_list'>
                            <a href='#'>
                                <p>학습종료 후에도 학습내용을 볼 수 있습니까?</p>
                            </a>
                        </li>
                        <li class='faq_list'>
                            <a href='#'>
                                <p>[학습장애] 학습 중 넥스트 버튼이 안보입니다.</p>
                            </a>
                        </li>
                    </ul>
                </div>
                <div class="guide clear_fix">
                    <p class='cs_title blue'>처음오셨나요?</p>
                    <p class='guide_text'>이용가이드를 확인해 주세요.</p>
                    <a href='#'>바로가기</a>
                </div>
                <div class="center clear_fix">
                    <p class='cs_title'>고객센터</p>
                    <strong>02-888-7805</strong>
                    <div class='center_time_box'>
                        <p>
                            평일 09:00 ~ 12:00<br>
                            03:00 ~ 18:00
                        </p>
                    </div>
                </div>
            </div>
            <!-- CUSTOMER SERVICE END -->
        </div>
        <!-- CONTENTS END -->

		<!-- FOOTER -->
       	<%@ include file="./mainBottom.jsp" %>
        <!-- FOOTER END -->
        
    </div>
    <script src='/resources/homepage/js/main.js'></script>
</body>

</html>