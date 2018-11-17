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
    <title>Q learning - 나의강의실 - 상담내역</title>

    <%@ include file="../common/commMainInclude.jsp" %>

    <link href='https://fonts.googleapis.com/css?family=Nanum+Gothic' rel='stylesheet'>
    <link rel='stylesheet' href='/resources/homepage/css/initialization.css'>
    <link rel='stylesheet' href='/resources/homepage/css/classroom/lecture.css'>
</head>

<script type="text/javascript">
$(document).ready(function() {
});

function lfn_btn(pKind, pParam) {
	if ( pKind == "search" || pKind == "paging" || pKind == "refresh" ) {
		if ( pKind == "search" )
			$("#pageNum").val(1);
		else if ( pKind == "paging" )
			$("#pageNum").val(pParam.page);
		
		f_submitSelf("/counsel/userCounselList");
	} else if ( pKind == "new" ) {
		gfn_goPage("/counsel/userCounselN",$("#frm").serialize());
	} else if ( pKind == "view") {
		$("#seq").val(pParam.seq);
		
		gfn_goPage("/counsel/userCounselV",$("#frm").serialize());
	}
}

</script>

<body>

<form id="frm" name="frm" method="post">
	<input type="hidden" id="seq" name="seq" value=""/>
	
<frameset rows='*'>
    <div class='wrap'>
        <!-- PC HEADER -->
        <%@ include file="../common/mainTop.jsp" %>
        <!-- HEAD END -->

        <!-- CONTENTS -->
        <div class='contents_wrap process'>
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
                            <p>나의강의실</p>
                            <span>
                                <img src='/resources/homepage/img/course/arr_right.jpg' alt=' '>
                            </span>
                            <p>상담내역</p>
                        </div>
                    </div>
                    <h1>
                        나의<span>강의실</span>
                    </h1>
                </div>
                <!-- Top END -->

                <div class='classroom_subtitle'>
                    <p class='subtitle'>상담내역</p>
                    <p>회원님께서 문의하셨던 내용에 대한 답변을 확인하실 수 있습니다.</p>
                </div>

                <table class='classroom_lecture counsel'>
                    <tr>
                        <th class='col_1'>번호</th>
                        <th class='col_2'>분류</th>
                        <th class='col_3'>제목</th>
                        <th class='col_4'>등록일</th>
                        <th class='col_5'>답변상태</th>
                    </tr>
<c:if test="${empty set.list}">
					<tr class="last_line">
						<td colspan="5" class="last center"><spring:message code="lms.msg.noSearchData" text="-" /></td>
					</tr>
</c:if>                  
<c:forEach var="row" items="${set.list}" varStatus="idx">  
                    <tr>
                        <td class='col_1'>${row.rownum}</td>
                        <td class='col_2'>${row.categoryName}</td>
                        <td class='col_3'>
                            <a href="#" onClick="javascript:lfn_btn('view',{seq:'${row.seq}'}); return false;"><c:out value="${row.title}" escapeXml="true" /></a>
                        </td>
                        <td class='col_4'>${row.createDate}</td>
                        <td class='col_5'>${row.answerYn}</td>
                    </tr>
</c:forEach>                    
                </table>
                
                <div class='detail_btn_area'>
                    <a href="#" onclick="javascript:lfn_btn('new');" class='bg_color'>등록하기</a>
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

<script src='/resources/homepage/js/dev_sub.js'></script>

</body>
</html>