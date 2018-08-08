<%@ page contentType="text/html;charset=utf-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="FCK" uri="http://java.fckeditor.net" %>


<head>
<title>
</title>

<%@ include file="../common/commInclude.jsp" %>

</head>

<script type="text/javascript">

function f_list() {
	f_submitSelf("/guest/courseCode");
}

$(document).ready(function() {

});

</script>
 
<body>

* 과정상세정보

<form name="frm" action="" method="post">
	<input id="mode" name="mode" value="UPDATE" type="hidden"/>

	<table>
		<tr>
			<td width="150px"><spring:message code="lms.label.courseName" text="-" /></td>
			<td align="left">
				<input id="courseId" name="courseId" type="hidden" value="${set.courseInfo.courseId}"/>
				${set.courseInfo.courseName}
			</td>
		</tr>
		<tr>
			<td><spring:message code="lms.label.chasu" text="-" /></td>
			<td>${set.courseInfo.chasu}</td>
		</tr>
		<tr>
			<td><spring:message code="lms.label.tutor" text="-" /></td>
			<td>${set.courseInfo.tutorName}</td>
		</tr>
		<tr>
			<td><spring:message code="lms.label.courseStatus" text="-" /></td>
			<td>${set.courseInfo.statusName}</td>
		</tr>
		<tr>
			<td><spring:message code="lms.label.learingGoal" text="-" /></td>
			<td><pre name="value">${set.courseInfo.learingGoal}</pre></td>
		</tr>
		<tr>
			<td><spring:message code="lms.label.learingContent" text="-" /></td>
			<td><pre name="value">${set.courseInfo.learingContent}</pre></td>
		</tr>
		<tr>
			<td><spring:message code="lms.label.evalMethod" text="-" /></td>
			<td><pre name="value">${set.courseInfo.evalMethod}</pre></td>
		</tr>
		<tr>
			<td><spring:message code="lms.label.learingTarget" text="-" /></td>
			<td><pre name="value">${set.courseInfo.learingTarget}</pre></td>
		</tr>
		<tr>
			<td><spring:message code="lms.label.courseDate" text="-" /></td>
			<td>${set.courseInfo.beginDate} ~ ${set.courseInfo.finishDate}</td>
		</tr>
		<tr>
			<td><spring:message code="lms.label.reportRate" text="-" /></td>
			<td>${set.courseInfo.examRateName}</td>
		</tr>
		<tr>
			<td><spring:message code="lms.label.examRate" text="-" /></td>
			<td>${set.courseInfo.examRateName}</td>
		</tr>
		<tr>
			<td><spring:message code="lms.label.discusstionRate" text="-" /></td>
			<td>${set.courseInfo.discussionRateName}</td>
		</tr>
		<tr>
			<td><spring:message code="lms.label.progressRate" text="-" /></td>
			<td>${set.courseInfo.progressRateName}</td>
		</tr>
	</table>
	
	<a href="#" onclick="f_list()"><img src="<c:url value="/resources/images/btn/btn_list.gif"/>"></a>
	<br>
</form>

<iframe name="tranFrame" style="display:none;"></iframe>

</body>
</html>


