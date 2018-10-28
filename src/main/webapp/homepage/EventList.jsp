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
    <link rel='stylesheet' href='/resources/homepage/css/support/notice.css'>
</head>

<script type="text/javascript">

$(document).ready(function() {
	f_makePageNavigator("pagingLayer",${set.condiVO.pageNum},${set.totalCount},${set.pageUnit});
});

function lfn_btn(pKind, pParam) {
	if ( pKind == "view") {
		$("#seq").val(pParam.seq);
		
		gfn_goPage("/main/eventV",$("#frm").serialize());
	}
}

</script>

<body>
<form name="frm" id="frm" method="post">
	<input id="seq" name="seq" type="hidden" value="">
	
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
                                <p>Event</p>
                            </div>
                        </div>
                        <h1>
                            Event</span>
                        </h1>
                        <div class='top_text_box clear_fix'>
                            <span><img src='/resources/homepage/img/support/notice_bg.jpg' alt=' '></span>
                            <p class='top_title'>Event</p>
                            <p>
                                큐러닝의 Event를 알려드립니다. <span></span>항상 유익하고 풍성한 소식 놓치지 말고 확인하세요.
                            </p>
                        </div>
                    </div>
                    <!-- Top END -->


                    <!-- Contents -->
                    <div class='notice_search_box'>
                    </div>

                    <div class='notice_list_box'>
                        <table>
                            <tr class='notice_table_head'>
                                <th class='notice_col1'>번호</th>
                                <th class='notice_col3'>제목</th>
                                <th class='notice_col4'>등록일</th>
                                <th class='notice_col5 last_right'>조회</th>
                            </tr>
<c:forEach var="row" items="${set.boardNoticeList}" varStatus="idx">
                            <tr>
                                <td class='notice_col1'>${row.rownum}</td>
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
    
    <script src='/resources/homepage/js/sub.js?timestamp=<%=timestamp%>'></script>
</body>

</html>