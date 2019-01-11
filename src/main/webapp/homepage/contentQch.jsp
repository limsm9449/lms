<%@ page contentType="text/html;charset=utf-8"%>
<%@ page import="com.qp.lms.common.SessionUtil"%>
<%@ page import="java.util.List"%>
<%@ page import="java.util.HashMap"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>



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

<script type="text/javascript">

var courseInfo = {};
$(document).ready(function(){
	<c:forEach var="row" items="${popularCourseList}" varStatus="idx">
		change_main_img("best", ${idx.index + 1}, "/cImage/main/${row.COMP_CD}/${row.COURSE_ID}_popular1.jpg", "/cImage/main/${row.COMP_CD}/${row.COURSE_ID}_popular2.jpg", "#${row.COLOR}");
		courseInfo["popular${idx.index + 1}"] = ${row.COURSE_ID};
	</c:forEach>	
	<c:forEach var="row" items="${eventList}" varStatus="idx">
		change_main_img("event", ${idx.index + 1}, "/cImage/event/${row.SEQ}_img1.jpg", "/cImage/event/${row.SEQ}_img2.jpg", "#${row.COLOR}");
		courseInfo["event${idx.index + 1}"] = ${row.SEQ};
	</c:forEach>	
	<c:forEach var="row" items="${noticeList}" varStatus="idx">
		change_main_img("notice", ${idx.index + 1}, "/cImage/notice/${row.SEQ}_img1.jpg", "/cImage/notice/${row.SEQ}_img2.jpg", "#${row.COLOR}");
		courseInfo["notice${idx.index + 1}"] = ${row.SEQ};
	</c:forEach>	
	<c:forEach var="row" items="${newCourseList}" varStatus="idx">
		change_img("process", 1, ${idx.index + 1}, "/cImage/main/${row.COMP_CD}/${row.COURSE_ID}_new1.jpg", "/cImage/main/${row.COMP_CD}/${row.COURSE_ID}_new2.jpg", "#${row.COLOR}");
		courseInfo["new${idx.index + 1}"] = ${row.COURSE_ID};
	</c:forEach>	
});

var size = {
    width: window.innerWidth || document.body.clientWidth,
    height: window.innerHeight || document.body.clientHeight
}

function courseClick(kind) {
	gfn_goPage('/main/mainCourseData','courseId=' + courseInfo[kind]);
}

function eventClick(kind) {
	gfn_goPage('/main/eventV','seq=' + courseInfo[kind]);
}

function noticeClick(kind) {
	gfn_goPage('/main/noticeV','seq=' + courseInfo[kind]);
}

// 메인배너 이미지 변경 함수
function change_main_img(category, number, file_name, file_name_m, back_color){
    var change_target, text;
    
    switch(category){
        case 'best' :
            change_target = document.querySelector('#tab1 .slide_' + number);
            break;
        case 'event' :
            change_target = document.querySelector('#tab2 .slide_' + number);
            break;
        default :
            change_target = document.querySelector('#tab3 .slide_' + number);
            break;
    }
    
    if (size){
        if((size.width <= 420) || ((size.height <= 420) && (size.width > size.height))) {
            // mobile
            text = back_color + ' url(' + file_name_m + ') 50% 0 / contain no-repeat';
        }else{
            // pc
            text = back_color + ' url(' + file_name + ') 50% 0 / contain no-repeat';
        }
    }
    change_target.style.background = text;
}

// 이벤트 함수
function change_img(category, order, number, file_name, file_name_m, back_color){
    var change_target = document.querySelector('.' + category + order + '_slide_wrap .slide_box.slide_' + number + '.automation');
    var change_target_m = document.querySelector('.' + category + order + '_slide_wrap .slide_box.slide_' + number + '.automation .' + category + order);
    var text = back_color + ' url(' + file_name + ') 50% 0 / contain no-repeat';
    var text_m = back_color + ' url(' + file_name_m + ') 50% 0 / cover no-repeat';
    change_target.style.background = text;
    change_target_m.style.background = text_m;

    // pc / mobile 스타일 적용
    if (size){
        if((size.width <= 420) || ((size.height <= 420) && (size.width > size.height))) {
            // mobile
            change_target.style.background = 'none';
        }else{
            // pc
            change_target_m.style.background = 'none';
        }
    }
}

</script>

<body>
<form name="frm" id="frm" method="post">
<frameset rows='*'>
    <div class="wrap">
       	
       	<!-- HEAD -->
       	<%@ include file="../common/mainTop.jsp" %>
       	<!-- HEAD END -->

        <!-- CONTENTS -->
        <div class='contents_wrap' >
            <!-- QUICK MENU -->
            <%@ include file="../common/mainQuickMenu.jsp" %>

            <!-- VISUAL -->
            <ul class='slider_wrap tabs' id='tab1'>
                <li class='slide_box slide_1'>
                    <div class='visual_box'>
                        <div class='slide clear_fix'>
                            <div class='slider_text_box'>
                            </div>
                            <button onclick="courseClick('popular1');">상세보기1111111111111111111</button>
                        </div>
                    </div>
                </li>
                <li class='slide_box slide_2'>
                    <div class='visual_box'>
                        <div class='slide clear_fix'>
                            <div class='slider_text_box left'>
                            </div>
                            <button class='right_bottom' onclick="courseClick('popular2');">상세보기2</button>
                        </div>
                    </div>
                </li>
                <li class='slide_box slide_3'>
                    <div class='visual_box'>
                        <div class='slide clear_fix'>
                            <div class='slider_text_box'>
                            </div>
                            <button class='right_bottom_nonText' onclick="courseClick('popular3');">상세보기3</button>
                        </div>
                    </div>
                </li>
            </ul>
            <ul class='slider_wrap tabs' id='tab2'>
                <li class='slide_box slide_1'>
                    <div class='visual_box'>
                        <div class='slide clear_fix'>
                            <div class='slider_text_box'>
                            </div>
                            <button onclick="eventClick('event1');">이벤트1</button>
                        </div>
                    </div>
                </li>
                <li class='slide_box slide_2'>
                    <div class='visual_box'>
                        <div class='slide clear_fix'>
                            <div class='slider_text_box left'>
                            </div>
                            <button class='right_bottom' onclick="eventClick('event2');">이벤트2</button>
                        </div>
                    </div>
                </li>
                <li class='slide_box slide_3'>
                    <div class='visual_box'>
                        <div class='slide clear_fix'>
                            <div class='slider_text_box'>
                            </div>
                            <button class='right_bottom_nonText' onclick="eventClick('event3');">이벤트3</button>
                        </div>
                    </div>
                </li>
            </ul>
            <ul class='slider_wrap tabs' id='tab3'>
                <li class='slide_box slide_1'>
                    <div class='visual_box'>
                        <div class='slide clear_fix'>
                            <div class='slider_text_box'>
                            </div>
                            <button onclick="noticeClick('notice1');">공지사항1</button>
                        </div>
                    </div>
                </li>
                <li class='slide_box slide_2'>
                    <div class='visual_box'>
                        <div class='slide clear_fix'>
                            <div class='slider_text_box left'>
                            </div>
                            <button class='right_bottom' onclick="noticeClick('notice2');">공지사항2</button>
                        </div>
                    </div>
                </li>
                <li class='slide_box slide_3'>
                    <div class='visual_box'>
                        <div class='slide clear_fix'>
                            <div class='slider_text_box'>
                            </div>
                            <button class='right_bottom_nonText' onclick="noticeClick('notice3');">공지사항3</button>
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
            <div class='process_wrap lectures_wrap automation'>
                <p>
                    <strong>신규</strong> <span>교육</span>과정
                </p>
                <p class='pc'>큐러닝의 신규 교육과정을 만나보세요</p>

                <!-- 신규과정 1 -->
                <div class='slider_wrap process1_slide_wrap'>
                    <div class='slide_box slide_1 automation'>
                        <div class='process_box process1'>
                            <div class='process clear_fix'>
                                <a href='#' onclick="courseClick('new1');">바로가기1</a>
                            </div>
                        </div>
                    </div>
                    <div class='slide_box slide_2 automation'>
                        <div class='process_box process1'>
                            <div class='process clear_fix'>
                                <a href='#' onclick="courseClick('new2');">바로가기2</a>
                            </div>
                        </div>
                    </div>
                    <div class='slide_box slide_3 automation'>
                        <div class='process_box process1'>
                            <div class='process clear_fix'>
                                <a href='#' onclick="courseClick('new3');">바로가기3</a>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- 신규과정 2 -->
                <div class='slider_wrap process2_slide_wrap'>
                    <div class='slide_box slide_1 automation'>
                        <div class='process_box process2'>
                            <div class='process'>
                                <a href='#' onclick="courseClick('new4');">바로가기1</a>
                            </div>
                        </div>
                    </div>
                    <div class='slide_box slide_2 automation'>
                        <div class='process_box process2'>
                            <div class='process'>
                                <a href='#' onclick="courseClick('new5');">바로가기2</a>
                            </div>
                        </div>
                    </div>
                    <div class='slide_box slide_3 automation'>
                        <div class='process_box process2'>
                            <div class='process'>
                                <a href='#' onclick="courseClick('new6');">바로가기3</a>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <!-- NEW PROCESS END -->

            <!-- PROCESS RECOMMEND -->
            <div class='recommend_wrap lectures_wrap'>
                <!-- change_main_img(category, number, file_name, file_name_m, back_color) -->
                <p>
                    <strong>추천</strong> <span>교육</span>과정
                </p>
                <p class='pc'>큐매니저가 추천하는 특별한 교육과정을 만나보세요</p>
                
                <ul class='clear_fix'>
<c:forEach var="row" items="${recommendCourseList}" varStatus="idx">
                    <li class='recommend automation2 clear_fix<c:if test="${idx.index + 1 eq fn:length(recommendCourseList)}"> last_right</c:if>'>  
                        <img src='/cImage/main/${row.COMP_CD}/${row.COURSE_ID}_recommend1.jpg' alt=' '>
                        <img class='mobile' src='/cImage/main/${row.COMP_CD}/${row.COURSE_ID}_recommend2.jpg' alt=' '>
                        <a class='lecture_more' href='#' onclick="gfn_goPage('/main/mainCourseData','courseId=${row.COURSE_ID}');">상세보기</a>
                    </li>
</c:forEach>	
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