<%@ page contentType="text/html;charset=utf-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="FCK" uri="http://java.fckeditor.net" %>


<head>
<title>
</title>

<%@ include file="../common/commInclude.jsp" %>
<script type="text/javascript" src="jquery.autoheight.js"></script>

</head>

<script type="text/javascript">

$(document).ready(function() {
});

</script>

<body>

* 공지사항

<form name="frm" action="" method="post">

	<table style="width:700px">
		<tr>
			<td>제목</td>
			<td><c:out value="${set.noticeHm.TITLE}" escapeXml="true" />
			</td>
		</tr>
		<tr>
			<td>내용</td>
			<td>${set.noticeHm.CONTENTS}</td>
		</tr>
	</table>

	<br>

</form>

<iframe name="tranFrame" style="display:none;"></iframe>

</body>
</html>


