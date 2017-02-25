<%@ page contentType="text/html;charset=utf-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions"  prefix="fn"%>

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
		
		f_submitSelf(preUrl + "boardFaqList");
	} else if ( pKind == "new" ) {
		lfn_setCondition();
		
		gfn_goPage(preUrl + "boardFaqN",$("#frm").serialize());
	} else if ( pKind == "view") {
		lfn_setCondition();
		
		$("#seq").val(pParam.seq);
		
		gfn_goPage(preUrl + "boardFaqV",$("#frm").serialize());
	} else if ( pKind == "close") {
		self.close();
	}
}

function lfn_setCondition() {
	top.gCondition.boardFaq = {
		param : "findString=" + $("#findString").val() + 
				"&pageNum=" + $("#pageNum").val() + 
				"&category=" + $("#category").val() + 
				"&isPopup=" + $("#isPopup").val() 
	}	
}

</script>

<body>

<form id="frm" name="frm" method="post">
	<input id="seq" name="seq" value="0" type="hidden"/>

<div id="wrap">
	<div id="container">
    	<div id="contents">
      		<div id="content_head">
        		<h1 class="title">FAQ</h1>
        		<ul class="gnb">
	          		<li>HOME</li>
	          		<li>게시물 관리</li>
	          		<li class="last">FAQ</li>
        		</ul>
			</div>

			<div id="article">
				<%-- 조건 --%>
		    	<h3 class="title">FAQ</h3>
		       	<div id="search">
		      		<div class="search_1">
		              	<label>검색조건</label>
		              	<input type="text" id="findString" name="findString" value="${set.condiVO.findString}">
		            </div>
		        	<div class="search_2">
			        	<label>Category</label>
						<select id="category" name="category">
				            <option value="">전체</option>
							<c:forEach var="row" items="${set.ddCategory}">
				              	<option value="${row.ddKey}" <c:if test="${set.condiVO.category eq row.ddKey}">selected</c:if>>${row.ddValue}</option>
							</c:forEach>
						</select>
		             	<input type="button" class="blueBtn" id="search_btn" onclick="javascript:lfn_btn('search');return false;" value="검색" />
		           	</div>
		   		</div>
		   		
				<%-- 테이블 --%>
		   		<table summary="">
					<thead>
					  	<tr class="guide">
	  						<th width="60"></th>
	  						<th width="120"></th>
	  						<th></th>
	  						<th width="100"></th>
	  						<th width="60"></th>
  						</tr>
						<tr>
							<th>seq</th>
							<th>Category</th>
							<th>제목</th>
							<th>생성일자</th>
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
				              	<td class="subject">${row.categoryName}</td>
				              	<td class="subject"><span><a href="#" onClick="javascript:lfn_btn('view',{seq:'${row.seq}'}); return false;" class="click"><c:out value="${row.title}" escapeXml="true" /></a></span></td>
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
<c:if test="${set.condiVO.isAdmin eq 'Y'}">
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


