<%@ page contentType="text/html;charset=utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<!DOCTYPE html>
<html lang='ko'>

<head>
    <meta charset='utf-8'>
    <meta name='viewport' content='width=device-width, initial-scale=1.0'>
    <meta http-equiv='X-UA-Compatible' content='ie=edge'>
    <title>큐러닝 학습창</title>

	<%@ include file="../common/commMainInclude.jsp" %>
	
    <link href='https://fonts.googleapis.com/css?family=Nanum+Gothic' rel='stylesheet'>

    <link rel='stylesheet' href='/resources/homepage/css/initialization.css'>
    <link rel='stylesheet' href='/resources/homepage/css/popup/popup_learning.css'>

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

var rootDirectory = "${set.data.directory}";
var mobileYn = "Y";

$(document).ready(function() {
	<%-- 초기값 세팅 --%>
	<c:choose>
		<c:when test="${set.condiVO.week ne ''}">
			QP_API.init(${set.condiVO.courseId}, ${set.condiVO.week}, 1, ${set.data.totalWeek}, false, false); 
		</c:when>
		<c:otherwise>
			QP_API.init(${set.condiVO.courseId}, ${set.data.lastWeek}, ${set.data.lastPage}, ${set.data.totalWeek}, false, false);
		</c:otherwise>
	</c:choose>		

	QP_API.openLastPage();
});

</script>


<body>
	<iframe name="eduContent" id="eduContent" src="about:blank;" width="100%" height="100%"></iframe>
	<form name="frm" method="post">
	</form>
</body>


</html>
