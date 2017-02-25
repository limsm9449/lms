<%@ page contentType="text/html;charset=utf-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="FCK" uri="http://java.fckeditor.net" %>


<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="ko" xml:lang="ko">
<head>
<title>
</title>

<%@ include file="../common/commAdminInclude.jsp" %>

</head>

<script type="text/javascript">
var gCondition = {
}
</script>

<body onunload="Popup.hideAllPopup();">


	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;      
	<a href="#" onclick="javascript:Popup.showBoard('NOTICE','${set.data.courseId}'); return false;">공지사항</a>
	&nbsp;
	<a href="#" onclick="javascript:Popup.showBoard('FREE','${set.data.courseId}'); return false;">자유게시판</a>
	&nbsp;
	<a href="#" onclick="javascript:Popup.showBoard('DATA','${set.data.courseId}'); return false;">자료실</a>
	&nbsp;
	<a href="#" onclick="javascript:Popup.showBoard('QNA','${set.data.courseId}'); return false;">Q&A</a>
	&nbsp;
	<a href="#" onclick="javascript:Popup.showBoard('REPORT','${set.data.courseId}'); return false;">레포트</a>
	&nbsp;
	<a href="#" onclick="javascript:Popup.showBoard('DISCUSSION','${set.data.courseId}'); return false;">토론게시판</a>

<form id="frm" name="frm" action="" method="post">

<div id="popup_wrap">
  	<div class="pop_header">
    	<h3 class="title">강좌</h3>
    	<p class="closeBtn" onClick="window.close();">Close</p>
  	</div>
  	<div class="pop_content">
		<table class="view">
			<thead>
			  	<tr class="guide">
 						<th width="130"></th>
 						<th></th>
 					</tr>
			</thead>
			<tbody>
				<tr>
					<th><spring:message code="lms.label.category" text="-" /></th>
					<td>${set.data.categoryName}</td>
				</tr>
				<tr>
					<th><spring:message code="lms.label.courseName" text="-" /></th>
					<td>
						<input id="courseId" name="courseId" type="hidden" value="${set.data.courseId}"/>
						${set.data.courseName}
					</td>
				</tr>
				<tr>
					<th><spring:message code="lms.label.chasu" text="-" /></th>
					<td>${set.data.chasu}</td>
				</tr>
				<tr>
					<th><spring:message code="lms.label.tutor" text="-" /></th>
					<td>${set.data.tutorName}</td>
				</tr>
				<tr>
					<th><spring:message code="lms.label.learingGoal" text="-" /></th>
					<td align="left"><div style="width:400px"><c:out value="${set.data.learingGoal}" escapeXml="" /></div></td>
				</tr>
				<tr>
					<th><spring:message code="lms.label.learingContent" text="-" /></th>
					<td align="left"><div style="width:400px"><c:out value="${set.data.learingContent}" escapeXml="" /></div></td>
				</tr>
				<tr>
					<th><spring:message code="lms.label.evalMethod" text="-" /></th>
					<td align="left"><div style="width:400px"><c:out value="${set.data.evalMethod}" escapeXml="" /></div></td>
				</tr>
				<tr>
					<th><spring:message code="lms.label.learingTarget" text="-" /></th>
					<td align="left"><div style="width:400px"><c:out value="${set.data.learingTarget}" escapeXml="" /></div></td>
				</tr>
				<tr>
					<th><spring:message code="lms.label.learingCost" text="-" /></th>
					<td align="left"><div style="width:400px"><c:out value="${set.data.learingCost}" escapeXml="" /></div></td>
				</tr>
				<tr>
					<th>과정비용</th>
					<td><fmt:formatNumber value="${set.data.courseCost}" type="number"/></td>
				</tr>
				<tr>
					<th>오픈여부</th>
					<td>${set.data.openYn}</td>
				</tr>
				<tr>
					<th>교육일수</th>
					<td>${set.data.cPeriod}</td>
				</tr>
				<tr>
					<th><spring:message code="lms.label.reportRate" text="-" /></th>
					<td>${set.data.reportRate}</td>
				</tr>
				<tr>
					<th><spring:message code="lms.label.examRate" text="-" /></th>
					<td>${set.data.examRate}</td>
				</tr>
				<tr>
					<th><spring:message code="lms.label.discusstionRate" text="-" /></th>
					<td>${set.data.discussionRate}</td>
				</tr>
				<tr>
					<th><spring:message code="lms.label.progressRate" text="-" /></th>
					<td>${set.data.progressRate}</td>
				</tr>
			</tbody>
		</table>
	</div>
</div>


</form>


</body>
</html>


