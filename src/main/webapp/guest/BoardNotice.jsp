<%@ page contentType="text/html;charset=utf-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions"  prefix="fn"%>

<head>
<title>
</title>

<%@ include file="../common/commInclude.jsp" %>


</head>

<script type="text/javascript">

$(document).ready(function() {
		f_makePageNavigator("paging",${set.condiVO.pageNum},${set.totalCount},${set.pageUnit});
	} 
);

function f_search() {
	f_submitSelf('/guest/boardNotice');
}

function paging(page) {
	$("#pageNum").val(page);
	f_search();
}

function f_find() {
	$("#pageNum").val("1");
	f_search();
}


function f_preSubmit(pDoUrl,pParam) {
	if ( pDoUrl == "/guest/boardNoticeV" )
		$("#seq").val(pParam.seq);
	else
		$("#seq").val("-1");
	
	return true;
}

</script>

<body>

* 공지사항

<form name="frm" method="post">
	<input id="kind" name="kind" value="${set.condiVO.kind}" type="hidden"/>
	<input id="pSeq" name="pSeq" value="${set.condiVO.pSeq}" type="hidden"/>
	<input id="seq" name="seq" value="-1" type="hidden"/>
	
	<div>
		<input type="text" id="findString" name="findString" value="${set.condiVO.findString}"><a href="#" onClick="javascript:f_find(); return false;"><img src="<c:url value="/resources/images/btn/btn_search1.gif"/>" alt="찾기"></a>
		<br><br>

		<table>
			<thead>
				<tr>
					<th>seq</th>
					<th>제목</th>
					<th>조회</th>
					<th>생성일자</th>
				</tr>
			</thead>
			<tbody>	
				<c:if test="${fn:length(set.list) eq 0}">
					<tr>
						<td colspan="5">검색된 데이타가 없습니다.</td>
					</tr>
				</c:if>	
				<c:forEach var="row" items="${set.list}" varStatus="idx">
		            <tr <c:if test="${idx.count%2 eq 1}"> class="alt"</c:if>>
		              	<td>${row.seq}</td>
		              	<td align="left"><span><a name="answerView0" href="#" onClick="javascript:f_submitSelf('/guest/boardNoticeV',{seq:'${row.seq}'}); return false;"><c:out value="${row.title}" escapeXml="true" /></a></span></td>
		              	<td>${row.viewCnt}</td>
		              	<td>${row.updateDate}</td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
	
		<div id="paging"></div>
	</div>
</form>



<iframe name="tranFrame" style="display:none;"></iframe>

</body>
</html>



</div>
</div>
