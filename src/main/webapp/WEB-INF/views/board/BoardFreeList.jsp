<%@ page contentType="text/html;charset=utf-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions"  prefix="fn"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>


<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="ko" xml:lang="ko">
<head>
<title>
</title>

<%@ include file="../common/commBoardInclude.jsp" %>


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
		
		f_submitSelf(preUrl + "boardFreeList");
	} else if ( pKind == "new" ) {
		lfn_setCondition();
		
		gfn_goPage(preUrl + "boardFreeN",$("#frm").serialize());
	} else if ( pKind == "view") {
		lfn_setCondition();
		
		$("#seq").val(pParam.seq);
		
		gfn_goPage(preUrl + "boardFreeV",$("#frm").serialize());
	} else if ( pKind == "close") {
		self.close();
	}
}

function lfn_setCondition() {
	top.gCondition.boardFree = {
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

<div id="wrap">
	<div id="container">
    	<div id="contents">
<c:if test="${set.condiVO.courseId eq 0}"> 
      		<div id="content_head">
        		<h1 class="title">자유게시판</h1>
        		<ul class="gnb">
	          		<li>HOME</li>
	          		<li>게시물 관리</li>
	          		<li class="last">자유게시판</li>
        		</ul>
			</div>
</c:if>
			<div id="article">
				<%-- 조건 --%>
		    	<h3 class="title">자유게시판</h3>
		       	<div id="search">
		      		<div class="search_1">
		              	<label>검색조건</label>
		              	<input type="text" id="findString" name="findString" value="${set.condiVO.findString}">
		            </div>
		        	<div class="search_2">
		        		<input type="button" class="blueBtn" id="search_btn"  onclick="javascript:lfn_btn('search');return false;" value="검색" />
		           	</div>
		   		</div>
		   		
				<%-- 테이블 --%>
		   		<table summary="">
					<thead>
					  	<tr class="guide">
	  						<th width="60"></th>
	  						<th></th>
	  						<th width="90"></th>
	  						<th width="100"></th>
	  						<th width="60"></th>
  						</tr>
						<tr>
							<th>seq</th>
							<th>제목</th>
							<th>작성자</th>
							<th>등록일자</th>
							<th class="no_line">조회</th>
						</tr>
					</thead>
					<tbody>
						<c:if test="${empty set.list}">
							<tr>
								<td colspan="5" class="no_line center"><spring:message code="lms.msg.noSearchData" text="-" /></td>
							</tr>
						</c:if>
						<c:forEach var="row" items="${set.list}" varStatus="idx">
							<tr <c:if test="${idx.count%2 eq 1}"> class="alt"</c:if>>
				              	<td class="right">${row.rownum}</td>
				              	<td class="subject"><span><a href="#" onClick="javascript:lfn_btn('view',{seq:'${row.seq}'}); return false;" class="click"><c:out value="${row.title}" escapeXml="true" /></a></span></td>
				              	<td class="center">${row.userName}</td>
				              	<td class="center">${row.createDate}</td>
				              	<td class="no_line right">${row.viewCnt}</td>
							</tr>
						</c:forEach> 
					</tbody>
				</table>
				
				<%-- 페이징 --%>
				<div id="paging"></div>
				
				<%-- 하단버튼 --%>
				<div class="tool_btn">
<c:if test="${set.condiVO.isEdit eq 'Y'}">
					<a href="#" onclick="javascript:lfn_btn('new'); return false;" class="blueBtn">글쓰기</a>
</c:if>	
				</div>
		   	</div>
		</div>
	</div>
</div>

</form>

</body>
</html>

