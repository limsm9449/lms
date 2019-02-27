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
	if ( pKind =="save" ) {
		var msg = "";
		if ( pParam.approvalCnt == "1" ) {
			msg = "수강취소를 하시겠습니까?";
		} else {
			msg = "수강취소시 같이 결제한 " + pParam.approvalCnt + "개의 과정이 같이 취소됩니다. 수강취소를 하시겠습니까?";
		}
		if ( confirm(msg) == false )
			return false;
		
		btnUnbind("saveBtn");
		$.ajax({
			type :"POST",
			url : context + "/normalUser/courseRegCancel.do",
			dataType :"json",
			data : "approvalId=" + pParam.approvalId,
			success : function(json){
				if ( json.rtnMode == "UPDATE_OK") {
					alert("정상적으로 취소 되었습니다.");
					window.location.reload();
				}
			},
			error : function(e) {
				alert("<spring:message code="lms.msg.systemError" text="-" />");
			}
		})
	}
}

</script>

<body>
<form name="frm" method="post">

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
                            <p>수강대기과정</p>
                        </div>
                    </div>
                    <h1>
                        나의<span>강의실</span>
                    </h1>
                </div>
                <!-- Top END -->

                <div class='classroom_subtitle'>
                    <p class='subtitle'>수강대기과정</p>
                    <p>현재 수강대기과정입니다. 학습이 시작되면 수강과정으로 이동합니다.</p>
                </div>

                <table class='classroom_lecture lectures'>
                    <tr>
                        <th class='col_1'>과정명</th>
                        <th class='col_2'>학습기간</th>
                        <th class='col_3'>신청일자</th>
                        <th class='col_4'>승인여부</th>
                        <th class='col_5'>교육비</th>
                        <th class='col_6'>수강여부</th>
                    </tr>
<c:if test="${empty set.course}">
					<tr class="last_line"><td colspan="6" class="center last">수강대기과정이 없습니다.</td></tr>
</c:if>	                    
<c:forEach var="row" items="${set.course}" varStatus="idx">
                    <tr>
                        <td class='col_1'>${row.courseName}</td>
	<c:if test="${row.termYn eq 'Y'}">
	          	       <td class='col_2'>${row.studyPeriodFrom} ~ ${row.studyPeriodTo}</td>
	</c:if>	                    
	<c:if test="${row.termYn eq 'N'}">
	            	     <td class='col_2'>${row.cPeriod}</td>
	</c:if>	                          <td class='col_3'>${row.createDate}</td>
                        <td class='col_4'>신청중</td>
                        <td class='col_5'><fmt:formatNumber value="${row.courseCost}" type="number"/>원</td>
                        <td class='col_6'><button id="saveBtn" onclick="lfn_btn('save',{approvalId:'${row.approvalId}', approvalCnt:'${row.approvalCnt}'});">수강취소</button></td>
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