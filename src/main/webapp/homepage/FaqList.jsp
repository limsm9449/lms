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
    <title>Q learning - 공지사항</title>

	<%@ include file="../common/commMainInclude.jsp" %>
	
    <link href='https://fonts.googleapis.com/css?family=Nanum+Gothic' rel='stylesheet'>
    <link rel='stylesheet' href='/resources/homepage/css/initialization.css'>
    <link rel='stylesheet' href='/resources/homepage/css/support/faq.css'>
    <link rel='stylesheet' href='/resources/homepage/css/support/notice.css'>

</head>

<script type="text/javascript">

$(document).ready(function() {
	f_makePageNavigator("pagingLayer",${set.condiVO.pageNum},${set.totalCount},${set.pageUnit});
});

function lfn_btn(pKind, pParam) {
	if ( pKind == "search" || pKind == "paging" || pKind == "refresh" ) {
		if ( pKind == "search" )
			$("#pageNum").val(1);
		else if ( pKind == "paging" )
			$("#pageNum").val(pParam.page);
		
		f_submitSelf("/main/faqList");
	} else if ( pKind == "view") {
		$("#seq").val(pParam.seq);

		$("#prevParams").val(encodeURIComponent($("#frm").serialize()));
		
		gfn_goPage("/main/faqV",$("#frm").serialize());
	}
}

</script>

<body>
<form name="frm" id="frm" method="post">
	<input id="seq" name="seq" type="hidden" value="">
	<input id="prevParams" name="prevParams" type="hidden" value="">
	
    <frameset rows='*'>
        <div class='wrap'>
            <!-- HEADER -->
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
                                <span>
                                    <img src='/resources/homepage/img/course/arr_right.jpg' alt=' '>
                                </span>
                                <p>Faq</p>
                            </div>
                        </div>
                        <h1>
                            FA<span>Q</span>
                        </h1>
                        <div class='top_text_box clear_fix'>
                            <span><img src='/resources/homepage/img/support/faq_bg.jpg' alt=' '></span>
                            <p class='top_title'>FAQ BEST</p>
                            <p>
                                궁금하신 사항이 있으실 때 먼저 자주하는 질문을 참고하시면 <span></span>고객님의 궁금증을 빠르게 해결하실 수 있습니다.
                            </p>
                        </div>
                    </div>
                    <!-- Top END -->

                    <!-- Contents -->
                    <div class='faq_search_box'>
                        <select name="category">
                            <option value='전체'>전체</option>
			          		<c:forEach var="row" items="${set.ddCategory}">
				              	<option value="${row.ddKey}" <c:if test="${set.condiVO.category eq row.ddKey}">selected</c:if>>${row.ddValue}</option>
							</c:forEach>
                        </select>
                        <input type='text' name='findString' id='findString' value="${set.condiVO.findString}" placeholder='검색어를 입력해 주세요.'>
                        <button onclick="lfn_btn('search');">검색</button>
                    </div>

                    <div class='notice_list_box'>
                        <table>
                            <tr class='notice_table_head'>
                                <th class='notice_col1'>번호</th>
                                <th class='notice_col2'>분류</th>
                                <th class='notice_col3'>제목</th>
                                <th class='notice_col4'>등록일</th>
                                <th class='notice_col5 last_right'>조회</th>
                            </tr>
<c:forEach var="row" items="${set.boardFaqList}" varStatus="idx">
                            <tr>
                                <td class='notice_col1'>${row.rownum}</td>
                                <td class='notice_col2'>${row.categoryName}</td>
                                <td class='notice_col3'><a href="#" onClick="javascript:lfn_btn('view',{seq:'${row.seq}'}); return false;">${row.title}</a></td>
                                <td class='notice_col4'>${row.createDate}</td>
                                <td class='notice_col5 last_right'>${row.viewCnt}</td>
                            </tr>
</c:forEach>                            
                        </table>
                    </div>
                    <!-- Contents END -->

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