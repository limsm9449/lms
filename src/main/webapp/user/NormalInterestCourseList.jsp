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
    <title>Q learning - 나의강의실 - 수강대기과정</title>

    <%@ include file="../common/commMainInclude.jsp" %>

    <link href='https://fonts.googleapis.com/css?family=Nanum+Gothic' rel='stylesheet'>
    <link rel='stylesheet' href='/resources/homepage/css/initialization.css'>
    <link rel='stylesheet' href='/resources/homepage/css/classroom/lecture.css'>
</head>

<script type="text/javascript">

function lfn_btn(pKind, pParam) {
	if ( pKind =="cancel" ) {
		if ( confirm("관신과정을 취소하시겠습니까?") == false )
			return false;
		
		btnUnbind("cancelBtn");
		$.ajax({
			type :"POST",
			url : context + "/main/interestDelete.do",
			dataType :"json",
			data : "courseId=" + pParam.courseId,
			success : function(json){
				if ( json.rtnMode == "OK") {
					alert("관심과정을 취소하였습니다.");
					window.location.reload();
				}
			},
			error : function(e) {
				alert("<spring:message code="lms.msg.systemError" text="-" />");
			}
		})
	} else if ( pKind == "view" ) {
		$("#courseId").val(pParam.courseId);
		
		gfn_goPage("/main/mainCourseData",$("#frm").serialize());
	}
}

</script>

<body>
<form name="frm" id="frm" method="post">
	<input type='hidden' id='courseId' name='courseId'>

<frameset rows='*'>
    <div class='wrap'>
        <!-- PC HEADER -->
        <%@ include file="../common/mainTop.jsp" %>
        <!-- HEAD END -->

        <!-- CONTENTS -->
        <div class='contents_wrap process' >
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
                            <p>관심과정</p>
                        </div>
                    </div>
                    <h1>
                        나의<span>강의실</span>
                    </h1>
                </div>
                <!-- Top END -->

                <div class='classroom_subtitle'>
                    <p class='subtitle'>관심과정</p>
                    <p>관심과정입니다.</p>
                </div>

                <table class='classroom_lecture lectures'>
                    <tr>
                        <th class='col_1'>과정명</th>
                        <th class='col_2'>학습기간</th>
                        <th class='col_3'>교육비</th>
                        <th class='col_4'>취소</th>
                    </tr>
<c:if test="${empty set.course}">
					<tr class="last_line"><td colspan="4" class="center last">관심과정이 없습니다.</td></tr>
</c:if>	                    
<c:forEach var="row" items="${set.course}" varStatus="idx">
                    <tr>
                        <td class='col_1'><a href='javascript:' onclick="javascript:lfn_btn('view',{courseId:'${row.courseId}'}); return false;">${row.courseName}</a></td>
	<c:if test="${row.termYn eq 'Y'}">
	          	       <td class='col_2'>${row.studyPeriodFrom} ~ ${row.studyPeriodTo}</td>
	</c:if>	                    
	<c:if test="${row.termYn eq 'N'}">
	            	     <td class='col_2'>${row.cPeriod}</td>
	</c:if>
                        <td class='col_3'><fmt:formatNumber value="${row.courseCost}" type="number"/>원</td>
                        <td class='col_4'><button id="cancelBtn" onclick="lfn_btn('cancel',{courseId:'${row.courseId}'});">관심과정취소</button></td>
                    </tr>
</c:forEach>                    
                </table>
                
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