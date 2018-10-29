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
var pages = [<c:forEach var="row" items="${set.resourceList}" varStatus="idx"><c:if test="${idx.index ne 0}">,</c:if> ${row.previewPage}</c:forEach>];

<%-- 주차별 디렉토리 정보 --%>
var directorys = [<c:forEach var="row" items="${set.resourceList}" varStatus="idx"><c:if test="${idx.index ne 0}">,</c:if> "${row.rootDirectory}/${row.directory}/"</c:forEach>];

<%-- 주차별 목차 --%>
var titles = [<c:forEach var="row" items="${set.resourceList}" varStatus="idx"><c:if test="${idx.index ne 0}">,</c:if> "${row.week}/${row.title}/"</c:forEach>];

var rootDirectory = "${set.data.directory}";
var mobileYn = "${set.data.mobileYn}";
	
$(document).ready(function() {
	<%-- 초기값 세팅 --%>
	QP_API.init(${set.condiVO.courseId}, 1, 1, ${set.data.totalWeek}, false, true);

	QP_API.openWeek(1);
});

</script>

<body>
    <div class='wrap'>
        <div class='lecture_head clear_fix'>
            <p class='lecture_title'>
                ${set.data.courseName}
            </p>
        </div>
		<iframe name="eduContent" id="eduContent" src="about:blank;" style="width: ${set.data.hPx}px; height: ${set.data.vPx}px;">학습 컨텐츠 영역</iframe>
    </div>
	<form name="frm" method="post">
	</form>
</body>


</html>




