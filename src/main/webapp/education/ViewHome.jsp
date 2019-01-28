<%@ page contentType="text/html;charset=utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<!DOCTYPE html>
<html lang='ko'>

<head>
    <meta charset='utf-8'>
    <meta name='viewport' content='width=device-width, initial-scale=1.0'>
    <meta http-equiv='X-UA-Compatible' content='ie=edge'>
    <title>강의 콘텐츠 미리보기</title>

	<%@ include file="../common/commMainInclude.jsp" %>

    <link href='https://fonts.googleapis.com/css?family=Nanum+Gothic' rel='stylesheet'>

    <link rel='stylesheet' href='/resources/homepage/css/initialization.css'>
    <link rel='stylesheet' href='/resources/homepage/css/popup/popup_learning.css'>

</head>

<script type="text/javascript" src="/resources/js/qpApi.js?timestamp=<%=timestamp%>"></script>

<script type="text/javascript">
var gCondition = {
}

<%-- 차시별 정보 --%>
var weeks = [<c:forEach var="row" items="${set.resourceList}" varStatus="idx"><c:if test="${idx.index ne 0}">,</c:if> ${row.week}</c:forEach>];

<%-- 차시별 페이지 정보 --%>
var pages = [<c:forEach var="row" items="${set.resourceList}" varStatus="idx"><c:if test="${idx.index ne 0}">,</c:if> ${row.pageCnt}</c:forEach>];

<%-- 차시별 디렉토리 정보 --%>
var directorys = [<c:forEach var="row" items="${set.resourceList}" varStatus="idx"><c:if test="${idx.index ne 0}">,</c:if> "${row.rootDirectory}/${row.directory}/"</c:forEach>];

<%-- 차시별 목차 --%>
var titles = [<c:forEach var="row" items="${set.resourceList}" varStatus="idx"><c:if test="${idx.index ne 0}">,</c:if> "${row.week}/${row.title}/"</c:forEach>];

var rootDirectory = "${set.data.directory}";
var mobileYn = "${set.condiVO.mobileYn}";

$(document).ready(function() {
	<%-- 초기값 세팅 --%>
	QP_API.init(${set.condiVO.courseId}, ${set.condiVO.week}, 1, ${set.data.totalWeek}, false, false);

	QP_API.openWeek(${set.condiVO.week});
});

</script>

<body onunload="Popup.hideAllPopup()">

<form name="frm" method="post">
</form>

<div id="study_popup_wrap">
  	<div class="study_header">
    	<h3 class="title">${set.data.courseName}</h3>
  	</div>
  	<div class="study_content" style="width: ${set.data.hPx}px; height: ${set.data.vPx}px;">
		<iframe name="eduContent" id="eduContent" src="about:blank;">학습 콘텐츠 영역</iframe>
	</div>
	<div class="study_tools">
	   	<ul class="lms">
	   		<li><span onClick="" class="lmsbtn">공지사항</span></li>
	   		<li><span onClick="" class="lmsbtn">자유게시판</span></li>
	   		<li><span onClick="" class="lmsbtn">자료실</span></li>
	   		<li><span onClick="" class="lmsbtn">Q&A</span></li>
<c:if test="${set.data.isReport eq 'Y'}">
	   		<li><span onClick="" class="lmsbtn">Report</span></li>
</c:if>	   		
<c:if test="${set.data.isExam eq 'Y'}">
	   		<li><span onClick="" class="lmsbtn">Exam</span></li>
</c:if>	   		
<c:if test="${set.data.isDiscussion eq 'Y'}">
	   		<li><span onClick="" class="lmsbtn">Discussion</span></li>
</c:if>	   		
	   		<li class="noline"><span onClick="" class="lmsbtn">북마크</span></li>
	   	</ul>
	</div>
</div>


</body>


</html>
