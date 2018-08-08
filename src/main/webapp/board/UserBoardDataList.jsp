<%@ page contentType="text/html;charset=utf-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="ko" xml:lang="ko">
<head>
<title>
</title>

<%@ include file="../common/commUserInclude.jsp" %>


</head>

<script type="text/javascript">

var preUrl = "/board/"; 

$(document).ready(function() {
	f_makePageNavigator("paging",${set.condiVO.pageNum},${set.totalCount},${set.pageUnit});
});

function lfn_btn(pKind, pParam) {
	if ( pKind == "search" || pKind == "paging" || pKind == "refresh" ) {
		if ( pKind == "search" )
			$("#pageNum").val(1);
		else if ( pKind == "paging" )
			$("#pageNum").val(pParam.page);
		
		f_submitSelf(preUrl + "userBoardDataList");
	} else if ( pKind == "new" ) {
		lfn_setCondition();
		
		gfn_goPage(preUrl + "userBoardDataN",$("#frm").serialize());
	} else if ( pKind == "view") {
		lfn_setCondition();
		
		$("#seq").val(pParam.seq);
		
		gfn_goPage(preUrl + "userBoardDataV",$("#frm").serialize());
	} else if ( pKind == "close") {
		self.close();
	}
}

function lfn_setCondition() {
	opener.top.gCondition.boardData = {
				param : "findString=" + $("#findString").val() + 
						"&pageNum=" + $("#pageNum").val() + 
						"&courseId=" + $("#courseId").val() + 
						"&isPopup=" + $("#isPopup").val() 
			}	
}

</script>

<body>


<form id="frm" name="frm" method="post">
	<input id="courseId" name="courseId" value="${set.condiVO.courseId}" type="hidden"/>
	<input id="isPopup" name="isPopup" value="${set.condiVO.isPopup}" type="hidden"/>
	<input id="seq" name="seq" value="0" type="hidden"/>

<div id="popup_wrap">
  <div class="pop_header">
    <h3 class="title">자료실</h3>
    <p class="closeBtn" onClick="window.close();">Close</p>
  </div>
  <div class="pop_content">
    <div id="bod_search_r">
        <input type="text" id="findString" name="findString" value="${set.condiVO.findString}">
        <a href="javascript:" onclick="javascript:lfn_btn('search');return false;"><img src="/resources/images/sub/btn_search.png" alt="검색하기" /></a>
    </div>
    <table class="bod_list">
      <caption>목록</caption>
		<thead>
		  <tr class="guide">
				<th width="60"></th>
				<th></th>
				<th width="90"></th>
				<th width="100"></th>
				<th width="60"></th>
			</tr>
			<tr class="t_list">
				<th>No</th>
				<th>제목</th>
				<th>작성자</th>
				<th>등록일자</th>
				<th class="no_line">조회</th>
			</tr>
		</thead>
		<tbody>
			<c:if test="${empty set.list}">
				<tr class="last_line">
					<td colspan="4" class="last center"><spring:message code="lms.msg.noSearchData" text="-" /></td>
				</tr>
			</c:if>
			<c:forEach var="row" items="${set.list}" varStatus="idx">
				<tr <c:if test="${idx.index + 1 eq fn:length(set.list)}"> class="last_line"</c:if>>
	              	<td class="right">${row.rownum}</td>
	              	<td class="title2"><span><a href="#" onClick="javascript:lfn_btn('view',{seq:'${row.seq}'}); return false;" class="click"><c:out value="${row.title}" escapeXml="true" /></a></span></td>
	              	<td class="center">${row.userName}</td>
	              	<td class="center">${row.createDate}</td>
	              	<td class="last right">${row.viewCnt}</td>
				</tr>
			</c:forEach> 
      	</tbody>
    </table>
	<%-- 페이징 --%>
	<div id="paging"></div>
	<div class="right_btn up_btn">
<c:if test="${set.condiVO.isEdit eq 'Y'}">
	  <a href="#" onclick="javascript:lfn_btn('new'); return false;"><img src="/resources/images/sub/btn_write.png" alt="질문하기" /></a>
</c:if>	
	</div>	
  </div>	
</div>


</form>



</body>
</html>



