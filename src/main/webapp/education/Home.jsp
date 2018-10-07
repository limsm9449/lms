<%@ page contentType="text/html;charset=utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<!DOCTYPE html>
<html lang='ko'>

<head>
    <meta charset='utf-8'>
    <meta name='viewport' content='width=device-width, initial-scale=1.0'>
    <meta http-equiv='X-UA-Compatible' content='ie=edge'>
    <title>Popup Sample</title>

	<%@ include file="../common/commMainInclude.jsp" %>
	
    <!--[if IE]>
        <link rel='stylesheet' href='/resources/homepagePopup/css/main_ie.css'>
    <![endif]-->

    <link href='https://fonts.googleapis.com/css?family=Nanum+Gothic' rel='stylesheet'>

    <link rel='stylesheet' href='/resources/homepagePopup/css/common/reset.css'>
    <link rel='stylesheet' href='/resources/homepagePopup/css/common/common.css'>
    <link rel='stylesheet' href='/resources/homepagePopup/css/main.css'>

</head>

<script type="text/javascript" src="/resources/js/qpApi.js?timestamp=<%=timestamp%>"></script>

<script type="text/javascript">
var gCondition = {
}

<%-- 주차별 정보 --%>
var weeks = [<c:forEach var="row" items="${set.resourceList}" varStatus="idx"><c:if test="${idx.index ne 0}">,</c:if> ${row.week}</c:forEach>];

<%-- 주차별 페이지 정보 --%>
var pages = [<c:forEach var="row" items="${set.resourceList}" varStatus="idx"><c:if test="${idx.index ne 0}">,</c:if> ${row.pageCnt}</c:forEach>];

<%-- 주차별 디렉토리 정보 --%>
var directorys = [<c:forEach var="row" items="${set.resourceList}" varStatus="idx"><c:if test="${idx.index ne 0}">,</c:if> "${row.rootDirectory}/${row.directory}/"</c:forEach>];

<%-- 주차별 목차 --%>
var titles = [<c:forEach var="row" items="${set.resourceList}" varStatus="idx"><c:if test="${idx.index ne 0}">,</c:if> "${row.week}.${row.title}"</c:forEach>];

$(document).ready(function() {
	<%-- 초기값 세팅 --%>
	<c:choose>
		<c:when test="${set.condiVO.week ne ''}">
			QP_API.init(${set.condiVO.courseId}, ${set.condiVO.week}, 1, ${set.data.totalWeek}, true, false); 
		</c:when>
		<c:otherwise>
			QP_API.init(${set.condiVO.courseId}, ${set.data.lastWeek}, ${set.data.lastPage}, ${set.data.totalWeek}, true, false);
		</c:otherwise>
	</c:choose>		

	QP_API.openLastPage();
});

</script>


<body onunload="Popup.hideAllPopup()">
    <div class='wrap'>
        <div class='lecture_head clear_fix'>
            <p class='lecture_title'>
                ${set.data.courseName}
            </p>
        </div>
		<iframe name="eduContent" id="eduContent" src="about:blank;" style="width: ${set.data.hPx}px; height: ${set.data.vPx}px;">학습 컨텐츠 영역</iframe>
        <div class='btn_area'>
            <button onclick="javascript:Popup.showUserBoard('NOTICE','${set.condiVO.courseId}'); return false;">공지사항</button>
            <button onclick="javascript:Popup.showUserBoard('FREE','${set.condiVO.courseId}'); return false;">자유게시판</button>
            <button onclick="javascript:Popup.showUserBoard('DATA','${set.condiVO.courseId}'); return false;">자료실</button>
            <button onclick="javascript:Popup.showUserBoard('QNA','${set.condiVO.courseId}'); return false;">Q&A</button>

<c:if test="${set.data.isReport eq 'Y'}">
			<button onclick="javascript:Popup.showUserBoard('REPORT','${set.condiVO.courseId}'); return false;">Report</button>
</c:if>	   		
<c:if test="${set.data.isDiscussion eq 'Y'}">
			<button onclick="javascript:Popup.showUserBoard('DISCUSSION','${set.condiVO.courseId}'); return false;">Discussion</button>
</c:if>	   		
			<button onclick="javascript:Popup.showUserProgress('QNA','${set.condiVO.courseId}'); return false;">진도</button>

<c:if test="${set.data.examYn eq 'Y'}">
            <button onclick="javascript:Popup.showExamResult('${set.condiVO.courseId}'); return false;">시험 결과</button>
</c:if>	   		
<c:if test="${set.data.examYn eq 'N'}">
            <button onclick="javascript:Popup.showExam('${set.condiVO.courseId}'); return false;">시험 응시</button>
</c:if>	   		
<c:if test="${set.data.questYn eq 'Y'}">
            <button onclick="javascript:Popup.showQuestResult('${set.condiVO.courseId}'); return false;">설문 결과</button>
</c:if>	   		
<c:if test="${set.data.questYn eq 'N'}">
            <button onclick="javascript:Popup.showQuest('${set.condiVO.courseId}'); return false;">설문</button>
</c:if>	   		
<c:if test="${set.data.isReport eq 'Y' && set.data.reportYn eq 'Y'}">
            <button onclick="javascript:Popup.showReport('${set.condiVO.courseId}'); return false;">과정리포트 제출</button>
            <button onclick="javascript:Popup.showReportResult('${set.condiVO.courseId}'); return false;">과정리포트 채점결과</button>
</c:if>	   		
<c:if test="${set.data.isReport eq 'Y' && set.data.reportYn eq 'N'}">
            <button onclick="javascript:Popup.showReport('${set.condiVO.courseId}'); return false;">과정리포트 제출</button>
</c:if>	   		
        </div>
    </div>
	<form name="frm" method="post">
	</form>
</body>


</html>
