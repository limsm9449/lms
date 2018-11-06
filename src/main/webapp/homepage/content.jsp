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

    <script src='/resources/homepage/js/jquery.bxslider.js'></script>
    
    <link href='https://fonts.googleapis.com/css?family=Nanum+Gothic' rel='stylesheet'>
    <link href="https://fonts.googleapis.com/css?family=Noto+Sans" rel="stylesheet">
    <link rel='stylesheet' href='/resources/homepage/css/initialization.css'>
    <link rel='stylesheet' href='/resources/homepage/css/main.css'>
    
</head>

<body>
<form name="frm" id="frm" method="post">
<frameset rows='*'>
    <div class="wrap">
       	
       	<!-- HEAD -->
       	<%@ include file="../common/mainTop.jsp" %>
       	<!-- HEAD END -->

        <!-- CONTENTS -->
        <div class='contents_wrap' onmouseover='sub_hide()'>
            <!-- QUICK MENU -->
            <%@ include file="../common/mainQuickMenu.jsp" %>

            <!-- VISUAL -->
            <ul class='slider_wrap tabs' id='tab1'>
                <li class='slide_box slide_1'>
                    <div class='visual_box'>
                        <div class='slide clear_fix'>
                            <div class='slider_text_box'>
                                <img src='/resources/homepage/img/visual_text.png' class='pc' alt=' '>
                            </div>
                            <button onclick="gfn_goPage('/main/mainCourseData','courseId=21');">상세보기1</button>
                        </div>
                    </div>
                </li>
                <li class='slide_box slide_2'>
                    <div class='visual_box'>
                        <div class='slide clear_fix'>
                            <div class='slider_text_box left'>
                                <img src='/resources/homepage/img/visual2_text.png' class='pc' alt=' '>
                            </div>
                            <button class='right_bottom' onclick="gfn_goPage('/main/mainCourseData','courseId=22');">상세보기2</button>
                        </div>
                    </div>
                </li>
                <li class='slide_box slide_3'>
                    <div class='visual_box'>
                        <div class='slide clear_fix'>
                            <div class='slider_text_box'>
                            </div>
                            <button class='right_bottom_nonText' onclick="gfn_goPage('/main/mainCourseData','courseId=23');">상세보기3</button>
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
                            <button class='right_bottom'>이벤트2</button>
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
                            <button class='right_bottom'>공지사항2</button>
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
                    <button onclick='change_tab(1, this)' id='btn_center'>11월 신규 이벤트</button>
                    <button onclick='change_tab(2, this)' class='last_right'>주요 공지사항</button>
                </div>
            </div>
            <!-- VISUAL END -->

            <!-- NEW PROCESS -->
            <div class='process_wrap lectures_wrap'>
                <p>
                    <strong>신규</strong> <span>교육</span>과정
                </p>
                <p class='pc'>큐러닝의 신규 교육과정을 만나보세요</p>
                <div class='slider_wrap process1_slide_wrap'>
                    <div class='slide_box slide_1'>
                        <div class='process_box process1'>
                            <div class='process clear_fix'>
                                <p class='process_title'>
                                    김정구 교수의
                                    <span>
                                        새로운 <strong>미래기회 <span></span>창조 및 선점전략</strong>
                                    </span>
                                </p>
                                <p class='process_text'>
                                    패러다임이 급변하는 사회, 최고의 위기라고도 할 수 있는 향후 10년. 위기와 역경을 기회로 만들어 당신을 도약시킬 수 있는 미래창조 비결을
                                    제시합니다.
                                </p>
                                <a href='#' onclick="gfn_goPage('/main/mainCourseData','courseId=21');">바로가기1</a>
                            </div>
                        </div>
                    </div>
                    <div class='slide_box slide_2'>
                        <div class='process_box process1'>
                            <div class='process clear_fix'>
                                <p class='process_title'>
                                    김정구 교수의
                                    <span>
                                        새로운 <strong>미래기회 <span></span>창조 및 선점전략</strong>
                                    </span>
                                </p>
                                <p class='process_text'>
                                    패러다임이 급변하는 사회, 최고의 위기라고도 할 수 있는 향후 10년. 위기와 역경을 기회로 만들어 당신을 도약시킬 수 있는 미래창조 비결을
                                    제시합니다.
                                </p>
                                <a href='#' onclick="gfn_goPage('/main/mainCourseData','courseId=21');">바로가기2</a>
                            </div>
                        </div>
                    </div>
                    <div class='slide_box slide_3'>
                        <div class='process_box process1'>
                            <div class='process clear_fix'>
                                <p class='process_title'>
                                    김정구 교수의
                                    <span>
                                        새로운 <strong>미래기회 <span></span>창조 및 선점전략</strong>
                                    </span>
                                </p>
                                <p class='process_text'>
                                    패러다임이 급변하는 사회, 최고의 위기라고도 할 수 있는 향후 10년. 위기와 역경을 기회로 만들어 당신을 도약시킬 수 있는 미래창조 비결을
                                    제시합니다.
                                </p>
                                <a href='#' onclick="gfn_goPage('/main/mainCourseData','courseId=21');">바로가기3</a>
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
                                        윤코치의 <strong>보고서 작성법</strong>
                                    </span>
                                </p>
                                <p class='process_text'>
                                    퇴짜맞는 보고서, 형식적인 보고서는 더이상 없다!<br>
                                    상대방의 마음을 한번에 잡을 수 있는 설득력있는 보고서 작성법의 결정판!
                                </p>
                                <a href='#' onclick="gfn_goPage('/main/mainCourseData','courseId=19');">바로가기1</a>
                            </div>
                        </div>
                    </div>
                    <div class='slide_box slide_2'>
                        <div class='process_box process2'>
                            <div class='process'>
                                <p class='process_title'>
                                    <span>
                                        윤코치의 <strong>보고서 작성법</strong>
                                    </span>
                                </p>
                                <p class='process_text'>
                                    퇴짜맞는 보고서, 형식적인 보고서는 더이상 없다!<br>
                                    상대방의 마음을 한번에 잡을 수 있는 설득력있는 보고서 작성법의 결정판!
                                </p>
                                <a href='#' onclick="gfn_goPage('/main/mainCourseData','courseId=19');">바로가기2</a>
                            </div>
                        </div>
                    </div>
                    <div class='slide_box slide_3'>
                        <div class='process_box process2'>
                            <div class='process'>
                                <p class='process_title'>
                                    <span>
                                        윤코치의 <strong>보고서 작성법</strong>
                                    </span>
                                </p>
                                <p class='process_text'>
                                    퇴짜맞는 보고서, 형식적인 보고서는 더이상 없다!<br>
                                    상대방의 마음을 한번에 잡을 수 있는 설득력있는 보고서 작성법의 결정판!
                                </p>
                                <a href='#' onclick="gfn_goPage('/main/mainCourseData','courseId=19');">바로가기3</a>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <!-- NEW PROCESS END -->

            <!-- PROCESS RECOMMEND -->
            <div class='recommend_wrap lectures_wrap'>
                <p>
                    <strong>추천</strong> <span>교육</span>과정
                </p>
                <p class='pc'>큐매니저가 추천하는 특별한 교육과정을 만나보세요</p>
                <ul class='clear_fix'>
                    <li class='recommend recommend1 clear_fix'>
                        <a href='#' onclick="gfn_goPage('/main/mainCourseData','courseId=19');" class='recommend_title white'>
                            <p class='lecture_title'>
                                윤코치의
                                <strong class='bot'>보고서 작성법</strong>
                            </p>
                            <p>한 장의 종이로 상사의<br>마음을 움직인다!</p>
                        </a>
                        <p class='recommend_text' onclick="gfn_goPage('/main/mainCourseData','courseId=19');">
                            <strong>[스마트러닝] <span>윤코치의 보고서 작성법</span></strong>
                            효율적 보고서 작성을 통해 업무 관련 <span></span>커뮤니케이션과 의사결정의 토대를 구축하고 <span></span>업무 성과를 향상시킬 수 있다.
                        </p>
                        <a class='lecture_more' href='#' onclick="gfn_goPage('/main/mainCourseData','courseId=19');">상세보기</a>
                    </li>
                    <li class='recommend recommend2 clear_fix'>
                        <a href='#' onclick="gfn_goPage('/main/mainCourseData','courseId=22');" class='recommend_title white'>
                            <p class='lecture_title'>
                                <strong>토끼와 거북이</strong>의
                                <strong class='bot'>재테크 비법</strong>
                            </p>
                            <p>당신만을 위한 재테크 전략을 <span></span>지금 만나보세요</p>
                        </a>
                        <p class='recommend_text' onclick="gfn_goPage('/main/mainCourseData','courseId=22');">
                            <strong>[스마트러닝] <span>토끼와 거북의의 재테크 비법</span></strong>
                            당신만을 위한 재테크 전략을 <span></span>지금 만나보세요
                        </p>
                        <a class='lecture_more' href='#' onclick="gfn_goPage('/main/mainCourseData','courseId=22');">상세보기</a>
                    </li>
                    <li class='recommend recommend3 clear_fix last_right'>
                        <a href='#' onclick="gfn_goPage('/main/mainCourseData','courseId=23');" class='recommend_title white'>
                            <p class='lecture_title'>
                                <strong>시원하게 뚫어</strong>주는
                                <strong class='bot'>비즈니스 스킬</strong>
                            </p>
                            <p>바쁜 직장인을 위한 실제적이고<br>유익한 비즈니스 스킬</p>
                        </a>
                        <p class='recommend_text' onclick="gfn_goPage('/main/mainCourseData','courseId=23');">
                            <strong>[스마트러닝] <span>시원하게 뚫어 주는 비즈니스 스킬</span></strong>
                            업무에 대한 답답한 마음을 실제적인 <span></span>비즈니스 스킬을 통해 시원하게 <span></span>해결해 주는 솔루션
                        </p>
                        <a class='lecture_more' href='#' onclick="gfn_goPage('/main/mainCourseData','courseId=23');">상세보기</a>
                    </li>
                </ul>
            </div>
            <!-- PROCESS RECOMMEND END -->

            <div class='user_cs clear_fix'>
                <div class='user_cs_notice_box'>
                    <div class='user_cs_title clear_fix'>
                        <p onclick="f_submitSelf('/main/noticeList')">공지사항</p>
                        <p class='user_cs_more' onclick="f_submitSelf('/main/noticeList')">MORE +</p>
                    </div>
                    <ul>
<c:forEach var="row" items="${set.noticeList}" varStatus="idx">
                        <li class='user_cs_list'>
                            <a href="#" onClick="javascript:gfn_goPage('/main/noticeV','seq=${row.seq}'); return false;" class='clear_fix'>
                                <p>${row.title}</p>
                                <p class='user_cs_list_date'>${row.createDate}</p>
                            </a>
                        </li>
</c:forEach>                        
                    </ul>
                </div>
                <div class='user_cs_counsel'>
                    <div class='user_cs_title clear_fix'>
                        <p onclick="f_submitSelf('/main/faqList')">
                            BEST FAQ
                        </p>
                        <p class='user_cs_more' onclick="f_submitSelf('/main/faqList')">MORE +</p>
                    </div>
                    <ul>
<c:forEach var="row" items="${set.faqList}" varStatus="idx">
                        <li class='user_cs_list'>
                            <a href="#" onClick="javascript:gfn_goPage('/main/faqV','seq=${row.seq}'); return false;" class='clear_fix'>
                                <p>${row.title}</p>
                                <p class='user_cs_list_date'>${row.createDate}</p>
                            </a>
                        </li>
</c:forEach>                        
                    </ul>
                </div>
                <div class="guide clear_fix">
                    <p class='cs_title blue'><span>처음</span>오셨나요?</p>
                    <p class='guide_text'>이용가이드를 확인해 주세요.</p>
                    <a href="javascript:" onclick="page.goPage('/main/tutorial', '');">바로가기</a>
                </div>
                <div class="center clear_fix">
                    <p class='cs_title'>1:1문의</p>
                    <p class='info_text'>사이트/교육과정에 필요한 모든 것을 알려드립니다</p>
                    <a href="javascript:" onclick="page.goPage('/main/mailQuestion');">문의하기</a>
                </div>
                <div class="center call clear_fix">
                    <p class='cs_title'>고객센터</p>
                    <span onclick='location.href = "mailto:sy.choi@qpeople.co.kr"'>
                        <img src='/resources/homepage/img/center_ic.png' alt=' '>
                    </span>
                    <a href='mailto:sy.choi@qpeople.co.kr' class='note'>궁금한 질문을 이메일로 문의하세요.</a>
                </div>
            </div>

        </div>
        <!-- CONTENTS END -->

		<!-- FOOTER -->
       	<%@ include file="../common/mainBottom.jsp" %>
        <!-- FOOTER END -->
        
    </div>
</frameset>
</form>    
    <script src='/resources/homepage/js/dev.js?timestamp=<%=timestamp%>'></script>
</body>

</html>