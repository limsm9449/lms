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

* 공지사항 조회

<form name="frm" action="" method="post">
	<input id="findString" name="findString" value="${set.condiVO.findString}" type="hidden"/>
	<input id="pageNum" name="pageNum" value="${set.condiVO.pageNum}" type="hidden"/>

	<input id="kind" name="kind" value="${set.condiVO.kind}" type="hidden"/>
	<input id="pSeq" name="pSeq" value="${set.condiVO.pSeq}" type="hidden"/>
	<input id="seq" name="seq" value="${set.condiVO.seq}" type="hidden"/>

	<table style="width:700px">
		<tr>
			<td>제목</td>
			<td><c:out value="${set.data.title}" escapeXml="true" />
			</td>
		</tr>
		<tr>
			<td>내용</td>
			<td>${set.data.contents}</td>
		</tr>
		<tr>
			<td>조회수</td>
			<td>${set.data.viewCnt}
			</td>
		</tr>
		<tr>
			<td>생성일자</td>
			<td>${set.data.updateDate}
			</td>
		</tr>
	</table>

	<br>
	<a href="#" onclick="javascript:f_submitSelf('/guest/boardNotice'); return false;"><img src="<c:url value="/resources/images/btn/btn_list.gif"/>"></a>

</form>

<iframe name="tranFrame" style="display:none;"></iframe>

</body>
</html>


