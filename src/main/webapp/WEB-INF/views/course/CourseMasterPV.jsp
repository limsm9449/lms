<%@ page contentType="text/html;charset=utf-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="FCK" uri="http://java.fckeditor.net" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>


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


<body>

<form id="frm" name="frm" action="" method="post">

<div id="popup_wrap">
  	<div class="pop_header">
    	<h3 class="title">강좌 Master 상세</h3>
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
					<th><spring:message code="lms.label.courseName" text="-" /></th>
					<td class="no_line">
						<input id="courseCode" name="courseCode" type="hidden" value="${set.data.courseCode}"/>
						${set.data.courseName}
					</td>
				</tr>
				<tr>
					<th><spring:message code="lms.label.tutor" text="-" /></th>
					<td class="no_line">${set.data.tutorName}</td>
				</tr>
				<tr>
					<th><spring:message code="lms.label.learingGoal" text="-" /></th>
					<td class="textbox no_line"><div style="width:400px"><c:out value="${set.data.learingGoal}" escapeXml="" /></div></td>
				</tr>
				<tr>
					<th><spring:message code="lms.label.learingContent" text="-" /></th>
					<td class="textbox no_line"><div style="width:400px"><c:out value="${set.data.learingContent}" escapeXml="" /></div></td>
				</tr>
				<tr>
					<th><spring:message code="lms.label.evalMethod" text="-" /></th>
					<td class="textbox no_line"><div style="width:400px"><c:out value="${set.data.evalMethod}" escapeXml="" /></div></td>
				</tr>
				<tr>
					<th><spring:message code="lms.label.learingTarget" text="-" /></th>
					<td class="textbox no_line"><div style="width:400px"><c:out value="${set.data.learingTarget}" escapeXml="" /></div></td>
				</tr>
				<tr>
					<th><spring:message code="lms.label.learingCost" text="-" /></th>
					<td class="textbox no_line"><div style="width:400px"><c:out value="${set.data.learingCost}" escapeXml="" /></div></td>
				</tr>
				<tr>
					<th>과정비용</th>
					<td class="no_line"><fmt:formatNumber value="${set.data.courseCost}" type="number"/></td>
				</tr>
				<tr>
					<th><spring:message code="lms.label.reportRate" text="-" /></th>
					<td class="no_line">${set.data.examRate} %</td>
				</tr>
				<tr>
					<th><spring:message code="lms.label.examRate" text="-" /></th>
					<td class="no_line">${set.data.examRate} %</td>
				</tr>
				<tr>
					<th><spring:message code="lms.label.discusstionRate" text="-" /></th>
					<td class="no_line">${set.data.discussionRate} %</td>
				</tr>
				<tr>
					<th><spring:message code="lms.label.progressRate" text="-" /></th>
					<td class="no_line">${set.data.progressRate} %</td>
				</tr>
			</tbody>
		</table>
	</div>
</div>

</form>

</body>
</html>


