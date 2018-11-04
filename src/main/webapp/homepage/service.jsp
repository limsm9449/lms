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
    <title>Q learning - 고객 지원</title>
    
    <%@ include file="../common/commMainInclude.jsp" %>

    <link href='https://fonts.googleapis.com/css?family=Nanum+Gothic' rel='stylesheet'>
    <link rel='stylesheet' href='/resources/homepage/css/initialization.css'>
    <link rel='stylesheet' href='/resources/homepage/css/support/support.css'>
</head>

<script type="text/javascript">

$(document).ready(function() {
	<c:if test="${!empty set.condiVO.shap}">	      	 
		gfn_goScreenPosition("${set.condiVO.shap}");
	</c:if>
});

function lfn_btn(pKind, pParam) {
	if ( pKind == "faqSearch" ) {
		f_submitSelf("/main/faqList");
	} else if ( pKind == "noticeSearch" ) {
		f_submitSelf("/main/noticeList");
	} else if ( pKind == "eventSearch" ) {
		f_submitSelf("/main/eventList");
	} else if ( pKind == "noticeView") {
		$("#seq").val(pParam.seq);
		
		gfn_goPage("/main/noticeV",$("#frm").serialize());
	} else if ( pKind == "eventView") {
		$("#seq").val(pParam.seq);
		
		gfn_goPage("/main/eventV",$("#frm").serialize());
	} else if ( pKind == "faqView") {
		$("#seq").val(pParam.seq);
		
		gfn_goPage("/main/faqV",$("#frm").serialize());
	}
}

</script>

<body>
<form name="frm" id="frm" method="post">
	<input id="seq" name="seq" type="hidden" value="">
	
    <frameset rows='*'>
        <div class='wrap'>
            <!-- PC HEADER -->
            <%@ include file="../common/mainTop.jsp" %>
            <!-- HEAD END -->

            <!-- CONTENTS -->
            <div class='contents_wrap support' onmouseover='sub_hide()'>
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
                                <p>고객지원</p>
                            </div>
                        </div>
                        <h1>
                            고객<span>지원</span>
                        </h1>
                    </div>
                    <!-- Top END -->

                    <!-- Question Search -->
                    <div class='support_search_wrap'>
                        <p class='support_search_text'>찾고 싶은 단어를 검색하거나, 자주묻는 질문을 통해 먼저 답변을 확인하세요.</p>
                        <p>전화나 게시판 상담보다 더 빠르게 해결할 수 있습니다.</p>
                        <div class='support_search_box clear_fix'>
                            <select name='category' id='category'>
                                <option value=''>전체</option>
								<c:forEach var="row" items="${set.ddCategory}">
				              		<option value="${row.ddKey}" <c:if test="${set.condiVO.category eq row.ddKey}">selected</c:if>>${row.ddValue}</option>
								</c:forEach>
                            </select>
                            <input type='text' name='findString' id='findString'>
                            <span>
                                <img src='/resources/homepage/img/course/ic_search.jpg' alt="" onclick="lfn_btn('faqSearch');">
                            </span>
                            <!-- <button>
                                <img src='/resources/homepage/img/course/ic_search.png' alt=' '>
                            </button> -->
                        </div>
                    </div>

                    <!-- Question Tab -->
                    <div class='support_tab_box clear_fix'>
                        <button class='support_btn active' onclick='list_tab(this,"support_qna_1")'>
                            <span>
                                <img src='/resources/homepage/img/support/type_1.png' alt=' '>
                            </span>
<c:forEach var="row" items="${set.ddCategory}" varStatus="idx">
	<c:if test="${row.ddKey eq '01'}">    
                            <p>${row.ddValue}</p>
	</c:if>                            
</c:forEach>                            
                        </button>
                        <button class='support_btn' onclick='list_tab(this,"support_qna_2")'>
                            <span>
                                <img src='/resources/homepage/img/support/type_2.png' alt=' '>
                            </span>
<c:forEach var="row" items="${set.ddCategory}" varStatus="idx">
	<c:if test="${row.ddKey eq '02'}">    
                            <p>${row.ddValue}</p>
	</c:if>                            
</c:forEach>                            
                        </button>
                        <button class='support_btn' onclick='list_tab(this,"support_qna_3")'>
                            <span>
                                <img src='/resources/homepage/img/support/type_3.png' alt=' '>
                            </span>
<c:forEach var="row" items="${set.ddCategory}" varStatus="idx">
	<c:if test="${row.ddKey eq '03'}">    
                            <p>${row.ddValue}</p>
	</c:if>                            
</c:forEach>                            
                        </button>
                        <button class='support_btn' onclick='list_tab(this,"support_qna_4")'>
                            <span>
                                <img src='/resources/homepage/img/support/type_4.png' alt=' '>
                            </span>
<c:forEach var="row" items="${set.ddCategory}" varStatus="idx">
	<c:if test="${row.ddKey eq '04'}">    
                            <p>${row.ddValue}</p>
	</c:if>                            
</c:forEach>                            
                        </button>
                        <button onclick='list_tab(this,"support_qna_5")' class='support_btn last_right'>
                            <span>
                                <img src='/resources/homepage/img/support/type_5.png' alt=' '>
                            </span>
<c:forEach var="row" items="${set.ddCategory}" varStatus="idx">
	<c:if test="${row.ddKey eq '05'}">    
                            <p>${row.ddValue}</p>
	</c:if>                            
</c:forEach>                            
                        </button>
                    </div>

                    <!-- Posting List -->
                    <div class='support_support_list_box'>
                        <p>자주 묻는 질문 BEST 5</p>
                        <ul class='support_list_wrap' id='support_qna_1'>
<c:set var="count" value="1"/>                        
<c:forEach var="row" items="${set.boardFaqList}" varStatus="idx">
	<c:if test="${row.category eq '01'}">    
                            <li class='support_list_box clear_fix'>
                            	<a href="#" onClick="javascript:lfn_btn('faqView',{seq:'${row.seq}'}); return false;" class='clear_fix'>
	                                <span>Q${count}</span>
	                                <p>${row.title}</p>
	                           	</a>
                            </li>
		<c:set var="count" value="${count + 1}" />                         
	</c:if>   
</c:forEach>                            
                        </ul>
                        <ul class='support_list_wrap' id='support_qna_2'>
<c:set var="count" value="1"/>                        
<c:forEach var="row" items="${set.boardFaqList}" varStatus="idx">
	<c:if test="${row.category eq '02'}">    
                            <li class='support_list_box clear_fix'>
                            	<a href="#" onClick="javascript:lfn_btn('faqView',{seq:'${row.seq}'}); return false;" class='clear_fix'>
	                                <span>Q${count}</span>
	                                <p>${row.title}</p>
	                           	</a>
                            </li>
		<c:set var="count" value="${count + 1}" />                       
	</c:if>       
</c:forEach>                            
                        </ul>
                        <ul class='support_list_wrap' id='support_qna_3'>
<c:set var="count" value="1"/>                        
<c:forEach var="row" items="${set.boardFaqList}" varStatus="idx">
	<c:if test="${row.category eq '03'}">    
                            <li class='support_list_box clear_fix'>
                            	<a href="#" onClick="javascript:lfn_btn('faqView',{seq:'${row.seq}'}); return false;" class='clear_fix'>
	                                <span>Q${count}</span>
	                                <p>${row.title}</p>
	                           	</a>
                            </li>
		<c:set var="count" value="${count + 1}" />                      
	</c:if>        
</c:forEach>                            
                        </ul>
                        <ul class='support_list_wrap' id='support_qna_4'>
<c:set var="count" value="1"/>                        
<c:forEach var="row" items="${set.boardFaqList}" varStatus="idx">
	<c:if test="${row.category eq '04'}">    
                            <li class='support_list_box clear_fix'>
                            	<a href="#" onClick="javascript:lfn_btn('faqView',{seq:'${row.seq}'}); return false;" class='clear_fix'>
	                                <span>Q${count}</span>
	                                <p>${row.title}</p>
	                           	</a>
                            </li>
		<c:set var="count" value="${count + 1}" />                 
	</c:if>             
</c:forEach>                            
                        </ul>
                        <ul class='support_list_wrap' id='support_qna_5'>
<c:set var="count" value="1"/>                        
<c:forEach var="row" items="${set.boardFaqList}" varStatus="idx">
	<c:if test="${row.category eq '05'}">    
                            <li class='support_list_box clear_fix'>
                            	<a href="#" onClick="javascript:lfn_btn('faqView',{seq:'${row.seq}'}); return false;" class='clear_fix'>
	                                <span>Q${count}</span>
	                                <p>${row.title}</p>
	                           	</a>
                            </li>
		<c:set var="count" value="${count + 1}" />                  
	</c:if>            
</c:forEach>                            
                        </ul>
                    </div>

                    <!-- User CS -->
                    <div class='user_cs clear_fix'>
                        <div class='user_cs_notice_box'>
                            <div class='user_cs_title clear_fix'>
                                <p>공지사항</p>
                                <p class='user_cs_more' onclick="lfn_btn('noticeSearch');">MORE +</p>
                            </div>
                            <ul>
<c:forEach var="row" items="${set.noticeList}" varStatus="idx">
                                <li class='user_cs_list'>
                                    <a href="#" onClick="javascript:lfn_btn('noticeView',{seq:'${row.seq}'}); return false;" class='clear_fix'>
                                        <p>${row.title}</p>
                                        <p class='user_cs_list_date'>${row.createDate}</p>
                                    </a>
                                </li>
</c:forEach>                                
                            </ul>
                        </div>
                        <div class='user_cs_counsel'>
                            <div class='user_cs_title clear_fix'>
                                <p>
                                    이벤트
                                </p>
                                <p class='user_cs_more' onclick="lfn_btn('eventSearch');">MORE +</p>
                            </div>
                            <ul>
<c:forEach var="row" items="${set.boardEventList}" varStatus="idx">
                                <li class='user_cs_list'>
                                    <a href="#" onClick="javascript:lfn_btn('eventView',{seq:'${row.seq}'}); return false;" class='clear_fix'>
                                        <p>${row.title}</p>
                                        <p class='user_cs_list_date'>${row.createDate}</p>
                                    </a>
                                </li>
</c:forEach>                                
                            </ul>
                        </div>
                    </div>
                    <!-- User CS END -->

                    <!-- Remote Service -->
                    <div class="support_remote_service clear_fix" id='screen_remoteService'>
                        <div class="support_remote_text">
                            <p class='support_remote_title'>
                                PC <span></span>원격지원 서비스
                            </p>
                            <p>
                                전화상담만으로 해결이 <span></span>어려운 경우, 전문 상담원이 <span></span>직접 PC 화면을 컨트롤해 <span></span>문제를
                                해결해 드립니다.
                            </p>
                            <div class='support_text_btn_box clear_fix'>
                                <button>신청하기</button>
                                <button class='last_right'>연결하기</button>
                            </div>
                        </div>
                        <div class="support_remote_step">
                            <ol class='support_step_list clear_fix'>
                                <li>
                                    <p class='support_step_list_title'>
                                        Step 1.
                                        <strong>신청하기</strong>
                                    </p>
                                    <p>
                                        버튼을 통해 <span></span>신청서 작성
                                    </p>
                                </li>
                                <li class='mobile_last_right'>
                                    <p class='support_step_list_title'>
                                        Step 2.
                                        <strong>전화연결</strong>
                                    </p>
                                    <p>
                                        신청 접수 후 큐러닝 <span></span>콜센터에서 전화연결
                                    </p>
                                </li>
                                <li>
                                    <p class='support_step_list_title'>
                                        Step 3.
                                        <strong>PC 연결</strong>
                                    </p>
                                    <p>
                                        상담원과 시간 협의 후 <span></span>지정시간에 연결
                                    </p>
                                </li>
                                <li class='last_right'>
                                    <p class='support_step_list_title'>
                                        Step 4.
                                        <strong>진단 및 해결</strong>
                                    </p>
                                    <p>
                                        상담원과 통화 후 <span></span>문제 진단 및 해결
                                    </p>
                                </li>
                            </ol>
                            <ul class='support_step_text_list'>
                                <li>
                                    <p>* PC에 설치되어 있는 방화벽, 보안 프로그램 등에 의해 원격지원 서비스가 불가한 경우도 있습니다.</p>
                                </li>
                                <li>
                                    <p>* 공공장소의 PC는 원격제어에 제한이 있을 수 있습니다.</p>
                                </li>
                                <li>
                                    <p>* PC 원격지원 운영시간: 평일 09:00 ~ 20:30(화, 목 운영 / 주말 및 공휴일은 휴무)</p>
                                </li>
                            </ul>
                        </div>
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
    <script src='/resources/homepage/js/dev_sub.js?timestamp=<%=timestamp%>'></script>
</body>

</html>