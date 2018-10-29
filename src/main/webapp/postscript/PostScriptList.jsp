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
    <title>Q learning - 나의강의실 - 수강후기</title>

    <%@ include file="../common/commMainInclude.jsp" %>

    <link href='https://fonts.googleapis.com/css?family=Nanum+Gothic' rel='stylesheet'>
    <link rel='stylesheet' href='/resources/homepage/css/initialization.css'>
    <link rel='stylesheet' href='/resources/homepage/css/classroom/lecture_detail.css'>
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
		
		f_submitSelf("/postscript/postscriptList");	
	}
}


</script>

<body style='background:#fff'>
<form id="frm" name="frm" method="post">
	<input id="courseId" name="courseId" value="${set.condiVO.courseId}" type="hidden"/>

<frameset rows='*'>
    <div class='wrap'>
        <!-- CONTENTS -->
        <div class='contents_wrap process'>
            <div class='contents_wrap_box popup'>

                <!-- Top -->
                <div class='top_area'>
                    <h1>
                        학습<span>후기</span>
                    </h1>
                    <div class='top_text_box clear_fix'>
                        <span><img src='/resources/homepage/img/support/notice_bg.jpg' alt=' '></span>
                        <p class='top_title'>NEWS & NOTICE!</p>
                        <p>
                            큐러닝의 소식과 공지사항을 알려드립니다. <span></span>항상 유익하고 풍성한 소식 놓치지 말고 확인하세요.
                        </p>
                    </div>
                </div>
                <!-- Top END -->

                <!-- <div class='classroom_subtitle'>
                    <p class='subtitle'>나의 수강후기</p>
                    <p>과정 수료 후 내가 쓴 수강후기입니다.</p>
                </div> -->

                <table class='classroom_lecture review'>
                    <tr>
                        <th class='col_1'>번호</th>
                        <th class='col_2'>내용</th>
                        <th class='col_3'>작성자</th>
                        <th class='col_4'>평점</th>
                        <th class='col_5'>후기 등록일</th>
                    </tr>
<c:if test="${empty set.list}">
					<tr>
						<td colspan="5" class="no_line center"><spring:message code="lms.msg.noSearchData" text="-" /></td>
					</tr>
</c:if>
<c:forEach var="row" items="${set.list}" varStatus="idx">
                    <tr>
                        <td class='col_1'>${row.rownum}</td>
                        <td class='col_2'><c:out value="${row.contents}" escapeXml="" /></td>
                        <td class='col_3'>${row.userName}</td>
                        <td class='col_4'>
                            <span><img src='/resources/homepage/img/course/register_${row.eval1}.png' alt=' '></span>
                            <span><img src='/resources/homepage/img/course/register_${row.eval2}.png' alt=' '></span>
                            <span><img src='/resources/homepage/img/course/register_${row.eval3}.png' alt=' '></span>
                            <span><img src='/resources/homepage/img/course/register_${row.eval4}.png' alt=' '></span>
                            <span><img src='/resources/homepage/img/course/register_${row.eval5}.png' alt=' '></span>
                        </td>
                        <td class='col_5'>${row.createDate}</td>
                    </tr>
</c:forEach>                    
                </table>                
                
                <!-- Pager Area -->
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

                <div class='detail_btn_area'>
                    <a href='#' onclick="javascript:window.close();" class='bg_color'>닫기</a>
                </div>
	             
            </div>
        </div>
        <!-- CONTENTS END -->
    </div>
</frameset>

</form>
<script src='/resources/homepage/js/dev_sub.js?timestamp=<%=timestamp%>'></script>

</body>
</html>