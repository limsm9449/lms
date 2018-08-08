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

<%@ include file="../common/commBoardInclude.jsp" %>


</head>

<script type="text/javascript">

var preUrl = "/counsel/"; 

$(document).ready(function() {
	f_makePageNavigator("paging",${set.condiVO.pageNum},${set.totalCount},${set.pageUnit});
});

function lfn_btn(pKind, pParam) {
	if ( pKind == "search" || pKind == "paging" || pKind == "refresh" ) {
		if ( pKind == "search" )
			$("#pageNum").val(1);
		else if ( pKind == "paging" )
			$("#pageNum").val(pParam.page);
		
		f_submitSelf(preUrl + "counselList");
	} else if ( pKind == "view") {
		lfn_setCondition();
		
		$("#seq").val(pParam.seq);
		
		gfn_goPage(preUrl + "counselV",$("#frm").serialize());
	}
}

function lfn_setCondition() {
	top.gCondition.counsel = {
				param : "findString=" + $("#findString").val() + 
						"&pageNum=" + $("#pageNum").val() 
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
        		<h1 class="title">상담내역</h1>
        		<ul class="gnb">
	          		<li>HOME</li>
	          		<li>상담관리</li>
	          		<li class="last">상담내역</li>
        		</ul>
			</div>
			<div id="article">
				<%-- 조건 --%>
		    	<h3 class="title">상담내역</h3>
		       	<div id="search">
		      		<div class="search_1">
		              	<label>검색조건</label>
		              	<input type="text" id="findString" name="findString" value="${set.condiVO.findString}">
		            </div>
		        	<div class="search_2">
		             	<input type="button" class="blueBtn" id="search_btn" onclick="javascript:lfn_btn('search');return false;" value="검색" />
		           	</div>
		   		</div>
		   		
				<%-- 테이블 --%>
		   		<table summary="">
					<thead>
  					  <tr class="guide">
    						<th width="42"></th>
    						<th width="130"></th>
    						<th></th>
    						<th width="110"></th>
    						<th width="70"></th>
    						<th width="80 "></th>
    					</tr>
    					<tr class="t_list">
    						<th>No</th>
    						<th>분류 </th>
    						<th>제목</th>
    						<th>등록일</th>
    						<th>작성자</th>
    						<th class="no_line">답변상태</th>
    					</tr>
					</thead>
					<tbody>
						<c:if test="${fn:length(set.list) eq 0}">
							<tr>
								<td colspan="5" class="no_line center">검색된 데이타가 없습니다.</td>
							</tr>
						</c:if>	
						<c:forEach var="row" items="${set.list}" varStatus="idx">
				            <tr <c:if test="${idx.count%2 eq 1}"> class="alt"</c:if>>
				              	<td class="right">${row.rownum}</td>
				              	<td class="center">${row.categoryName}</td>
				              	<td class="title2"><span><a href="#" onClick="javascript:lfn_btn('view',{seq:'${row.seq}'}); return false;" class="click"><c:out value="${row.title}" escapeXml="true" /></a></span></td>
				              	<td class="center">${row.createDate}</td>
				              	<td class="center">${row.userName}</td>
				              	<td class="no_line center">${row.answerYn}</td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
				
				<%-- 페이징 --%>
				<div id="paging"></div>
				
				<%-- 하단버튼 --%>
				<div class="tool_btn">
					<a href="#" onclick="javascript:lfn_btn('new'); return false;" class="blueBtn">글쓰기</a>
				</div>
		   	</div>
		</div>
	</div>
</div>

</form>



</body>
</html>



