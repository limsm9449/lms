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
    <title>Q learning - 질문답변</title>

    <%@ include file="../common/commMainInclude.jsp" %>

    <link href='https://fonts.googleapis.com/css?family=Nanum+Gothic' rel='stylesheet'>
    <link rel='stylesheet' href='/resources/homepage/css/initialization.css'>
    <link rel='stylesheet' href='/resources/homepage/css/classroom/lecture_detail.css'>
</head>

<script type="text/javascript">

var preUrl = "/board/"; 

$(document).ready(function() {
	f_makePageNavigator("pagingLayer",${set.condiVO.pageNum},${set.totalCount},${set.pageUnit});
});

function lfn_btn(pKind, pParam) {
	if ( pKind == "search" || pKind == "paging" || pKind == "refresh" ) {
		if ( pKind == "search" )
			$("#pageNum").val(1);
		else if ( pKind == "paging" )
			$("#pageNum").val(pParam.page);
		
		f_submitSelf(preUrl + "userBoardQnaList");
	} else if ( pKind == "new" ) {
		gfn_goPage(preUrl + "userBoardQnaN",$("#frm").serialize());
	} else if ( pKind == "view") {
		$("#seq").val(pParam.seq);
		
		$("#prevParams").val(encodeURIComponent($("#frm").serialize()));
		
		gfn_goPage(preUrl + "userBoardQnaV",$("#frm").serialize());
	} else if ( pKind == "close") {
		self.close();
	}
}


</script>

<body style='background:#fff'>
<form id="frm" name="frm" method="post">
	<input id="courseId" name="courseId" value="${set.condiVO.courseId}" type="hidden"/>
	<input id="seq" name="seq" value="0" type="hidden"/>
	<input id="prevParams" name="prevParams" type="hidden" value="">

<frameset rows='*'>
    <div class='wrap'>
        <!-- CONTENTS -->
        <div class='contents_wrap process'>
            <div class='contents_wrap_box popup'>
                <!-- TOP -->
                <div class='top_area'>
                    <h1>
                        질문<span>답변</span>
                    </h1>
                    <div class='top_text_box clear_fix'>
                        <span><img src='/resources/homepage/img/support/notice_bg.jpg' alt=' '></span>
                        <p class='top_title'>NEWS & NOTICE!</p>
                        <p>
                            큐러닝의 소식과 공지사항을 알려드립니다. <span></span>항상 유익하고 풍성한 소식 놓치지 말고 확인하세요.
                        </p>
                    </div>
                </div>
                <!-- TOP END -->

                <div class='notice_search_box'>
                    <input type='text' name='findString' id='findString' placeholder='검색어를 입력해 주세요.' value="${set.condiVO.findString}">
                    <button onclick="lfn_btn('search');return false;">검색</button>
                </div>

                <div class='lecture_detail_table_box qna'>
                    <table>
                        <tr>
                            <th class='col_1'>번호</th>
                            <th class='col_2'>제목</th>
                            <th class='col_3'>작성자</th>
                            <th class='col_4'>등록일자</th>
                            <th class='col_5'>조회</th>
                        </tr>
<c:if test="${empty set.list}">
						<tr class="last_line">
							<td colspan="5"><spring:message code="lms.msg.noSearchData" text="-" /></td>
						</tr>
</c:if>
<c:forEach var="row" items="${set.list}" varStatus="idx"> 
                        <tr>
                            <td class='col_1'>${row.rownum}</td>
                            <td class='col_2'><a href="#" onClick="javascript:lfn_btn('view',{seq:'${row.seq}'}); return false;"><c:out value="${row.title}" escapeXml="true" /><c:if test="${row.answerYn eq 'Y'}">&nbsp;&nbsp;&nbsp;[답변완료]</c:if></a></td>
			              	<td class='col_3'>${row.userName}</td>
                            <td class='col_4'>${row.createDate}</td>
                            <td class='col_5'>${row.viewCnt}</td>
                        </tr>
</c:forEach>                        
                    </table>
                </div>

				<input type='hidden' id='pageNum' name='pageNum' value="${set.condiVO.pageNum}">
		        <div class='pager_box'>
		             <div class='pager clear_fix'>
		                 <div class='pager_prev clear_fix' id="pagingLayerPrev">
		                     <div>&laquo;</div>
		                     <div>&lsaquo;</div>
		                 </div>
		                 <ul class='clear_fix' id="pagingLayer">
		                     <li class='on'>1</li>
		                     <li>2</li>
		                     <li>3</li>
		                     <li>4</li>
		                     <li>5</li>
		                 </ul>
		                 <div class='pager_next clear_fix' id="pagingLayerNext">
		                     <div>&rsaquo;</div>
		                     <div>&raquo;</div>
		                 </div>
		             </div>
		        </div>
		      	<!-- Pager Area END -->
      	
<c:if test="${set.condiVO.isEdit eq 'Y'}">
                <div class='detail_btn_area'>
                    <a href='#' onclick="javascript:lfn_btn('new'); return false;" class='bg_color'>등록하기</a>
                </div>
</c:if>
            </div>
        </div>
        <!-- CONTENTS END -->
    </div>
</frameset>

</form>
<script src='/resources/homepage/js/dev_sub.js?timestamp=<%=timestamp%>'></script>
</body>
</html>