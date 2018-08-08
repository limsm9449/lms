<%@ page contentType="text/html;charset=utf-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<head>
<title>
</title>

<%@ include file="../common/commInclude.jsp" %>


</head>

<script type="text/javascript">
function f_courseView(courseCode) {
	$("#courseCode").val(courseCode);
	
	f_submitSelf("/guest/course");
}


$(document).ready(function() {
	} 
);

</script>

<body>

* 과정리스트

<form name="frm" method="post">
	<input id="courseCode" name="courseCode" type="hidden" value=""/>
	<input id="mode" name="mode" value="" type="hidden"/>

	<div>
		<c:forEach var="row" items="${set.courseCode}" varStatus="idx">
           	${row.codeName} - <a href="#" onclick="f_courseView('${row.courseCode}')">${row.courseName} (${row.subCnt})</a><br>
		</c:forEach>
	</div>
	

</form>

<iframe name="tranFrame" style="display:none;"></iframe>

</body>
</html>



</div>
</div>
