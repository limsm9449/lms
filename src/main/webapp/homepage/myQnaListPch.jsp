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
    <title>Q learning - 마이페이지 - 학습 Q&A 내역</title>

    <%@ include file="../common/commMainInclude.jsp" %>


    <link href='https://fonts.googleapis.com/css?family=Nanum+Gothic' rel='stylesheet'>
    <link rel='stylesheet' href='/resources/homepageQch/css/initialization.css'>
    <link rel='stylesheet' href='/resources/homepageQch/css/mypage/mypage_main.css'>
    <link rel='stylesheet' href='/resources/homepageQch/css/mypage/mypage_table.css'>
    <link rel='stylesheet' href='/resources/homepageQch/css/mypage/mypage.css'>    
</head>

<script type="text/javascript">
$(document).ready(function() {
	f_makePageNavigator("pagingLayer",${set.condiVO.pageNum},${set.totalCount},${set.pageUnit},${set.pageCnt});
});

function lfn_btn(pKind, pParam) {
	if ( pKind == "search" || pKind == "paging" || pKind == "refresh" ) {
		if ( pKind == "search" )
			$("#pageNum").val(1);
		else if ( pKind == "paging" )
			$("#pageNum").val(pParam.page);
		
		f_submitSelf("/main/myQnaList");
	}
}

</script>

<body>

<form id="frm" name="frm" method="post">
	<input type="hidden" id="seq" name="seq" value=""/>
	
<frameset rows='*'>
    <div class='wrap'>
        <!-- HEAD -->
        <%@ include file="../common/mainTopQch.jsp" %>
        <!-- HEAD END -->

        <!-- CONTENTS -->
        <div class='contents_wrap process'>
            <!-- QUICK MENU -->
            <%@ include file="../common/mainQuickMenuQch.jsp" %>
            
            <div class='contents_wrap_box'>

                <!-- Top -->
                <div class='top_area'>
                    <div class='clear_fix'>
                        <div class='process_history_box clear_fix'>
                            <span>
                                <img src='/resources/homepageQch/img/course/ic_home.jpg' alt=' '>
                            </span>
                            <p>HOME</p>
                            <span>
                                <img src='/resources/homepageQch/img/course/arr_right.jpg' alt=' '>
                            </span>
                            <p>마이페이지</p>
                        </div>
                    </div>
                    <h1>
                        <span>마이</span>페이지
                    </h1>
                </div>
                <!-- Top END -->

                <div class='classroom_subtitle' id="detail_2">
                </div>


                <!-- REGISTER PC VERSION -->
                <div class='register_method_pc1' id="detail_3">
                    <!-- <img src='../../img/notice/pc.jpg' alt=' '> -->
                    <ol>
                        
                        <!-- Contents -->
                    
                    
                    
					<!-- Search Result Area -->
                    <div class="pra2_point">
                        <div class="t1_point">
                            학습 Q&A 내역
                        </div>
                        <div class="t1_point_txt" id="detail_4">
                            강의에 관련된 질문내역을 확인할 수 있습니다. 
                        </div>
                    </div>
                    <table class="QA_table">
                    	<tr class="QA_table_top">
                        	<td class="QA_table_top_1">과정명</td>
                            <td class="QA_table_top_2">제목</td>
                            <td class="QA_table_top_3">답변여부</td>
                            <td class="QA_table_top_4">등록일</td>
                        </tr>
<c:if test="${empty set.myQnaList}">
						<tr class="last_line">
							<td colspan="4" class="last center" style="border-right:none"><spring:message code="lms.msg.noSearchData" text="-" /></td>
						</tr>
</c:if>                  
<c:forEach var="row" items="${set.myQnaList}" varStatus="idx">  
                        <tr>
                        	<td class="QA_table_mid_1">
                                <div class='process_result_text'>
                                    <div class='process_result_text_top clear_fix'>
                                        <p>일반</p>
	<c:if test="${row.mobileYn eq 'Y'}">	                                        
                                        <p class='process_result_mobile'>모바일</p>
	</c:if>  
                                    </div>
                                    <p>${row.courseName}</p>
                                    <div class='process_result_text_bottom clear_fix'>
                                        <p>교육기간</p>
                                        <p class='process_result_payment'>${row.cFromDate} ~ ${row.cToDate} (${row.cPeriod}일)</p>
                                    </div>
                                </div>
                            </td>
                            <td class="QA_table_mid_2"><a href="#" onClick="javascript:page.goPage('/main/myQnaV','seq=${row.seq}');  return false;">${row.title}</a></td>
                            <td class="QA_table_mid_3">${row.answerYn}</td>
                            <td class="QA_table_mid_4">${row.createDateStr}</td>
                        </tr>                    
</c:forEach>                           
                    </table>
                    
                    <input type='hidden' id='pageNum' name='pageNum' value="${set.condiVO.pageNum}">
                    <div class='pager_box'>
	                    <div class='pager clear_fix'>
	                        <div class='pager_prev clear_fix' id="pagingLayerPrev">
	                        </div>
	                        <ul class='clear_fix' id="pagingLayer">
	                        </ul>
	                        <div class='pager_next clear_fix' id="pagingLayerNext">
	                        </div>
	                    </div>
	                </div>
                    <!-- Search Result Area END -->
            </div>
        </div>
        <!-- CONTENTS END -->

        <!-- FOOTER -->
        <%@ include file="../common/mainBottomQch.jsp" %>
        <!-- FOOTER END -->
    </div>
</frameset>
</form>

<script src='/resources/homepageQch/js/main.js'></script>
</body>
</html>