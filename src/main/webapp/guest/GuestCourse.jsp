<%@ page contentType="text/html;charset=utf-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<head>
<title>
</title>

<%@ include file="../common/commInclude.jsp" %>


</head>

<script type="text/javascript">
function f_courseInfo(courseId) {
	$("#courseId").val(courseId);
	
	f_submitSelf("/guest/courseInfo");	
}


$(document).ready(function() {
	} 
);

function f_list() {
	f_submitSelf("/guest/courseCode");
}

</script>

<body>

* 과정

<form name="frm" method="post">
	<input id="courseId" name="courseId" type="hidden" value=""/>

	<div>
		<table>
			<thead>
				<tr>
					<th><spring:message code="lms.label.courseName" text="-" /></th>
					<th><spring:message code="lms.label.tutor" text="-" /></th>
					<th><spring:message code="lms.label.chasu" text="-" /></th>
					<th><spring:message code="lms.label.courseStatus" text="-" /></th>
					<th><spring:message code="lms.label.courseDate" text="-" /></th>
				</tr>
			</thead>
			<tbody>
				<c:forEach var="row" items="${set.course}" varStatus="idx">
		            <tr <c:if test="${idx.count%2 eq 1}"> class="alt"</c:if>>
		            	<td><a href="#" onclick="f_courseInfo('${row.courseId}')">${row.courseName}</a></td>
		            	<td>${row.tutorName}</td>
		            	<td>${row.chasu}</td>
		            	<td>${row.statusName}</td>
		            	<td>${row.beginDate} ~ ${row.finishDate}</td>
		            </tr>
				</c:forEach>
			</tbody>
		</table>
	</div>
	
	<a href="#" onclick="f_list()"><img src="<c:url value="/resources/images/btn/btn_list.gif"/>"></a>
	<br>
	
</form>

<iframe name="tranFrame" style="display:none;"></iframe>

</body>
</html>



</div>
</div>
