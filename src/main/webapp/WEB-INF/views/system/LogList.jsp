<%@ page contentType="text/html;charset=utf-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions"  prefix="fn"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="ko" xml:lang="ko">
<head>
<title>
</title>

<%@ include file="../common/commAdminInclude.jsp" %>


</head>

<script type="text/javascript">

$(document).ready(function() {
	f_makePageNavigator("paging",${set.condiVO.pageNum},${set.totalCount},${set.pageUnit});
});

function lfn_btn(pKind, pParam) {
	if ( pKind == "search" || pKind == "paging" || pKind == "refresh" ) {
		if ( pKind == "search" )
			$("#pageNum").val(1);
		else if ( pKind == "paging" )
			$("#pageNum").val(pParam.page);
		
		gfn_goPage("/system/logList",$("#frm").serialize());	
	}
}


</script>

<body>

<form id="frm" name="frm" method="post">

<div id="wrap">
	<div id="container">
    	<div id="contents">
      		<div id="content_head">
        		<h1 class="title">LOG 관리</h1>
        		<ul class="gnb">
	          		<li>HOME</li>
	          		<li>시스템 관리</li>
	          		<li class="last">LOG 관리</li>
        		</ul>
			</div>

			<div id="article">
				<%-- 조건 --%>
		    	<h3 class="title">LOG 관리</h3>
		       	<div id="search">
		      		<div class="search_1">
		              	<label for="c1Code">검색</label>
		              	<select id="searchKind" name="searchKind">
			              	<option value="USER_ID" <c:if test="${set.condiVO.searchKind eq '' || set.condiVO.searchKind eq 'USER_ID'}">selected</c:if>>사용자 ID</option>
			              	<option value="USER_NAME" <c:if test="${set.condiVO.searchKind eq 'USER_NAME'}">selected</c:if>>사용자명</option>
						</select>
						<input type="text" id="searchStr" name="searchStr" value="<c:out value="${set.condiVO.searchStr}"/>">
		            </div>
		        	<div class="search_2">
		              	<label for="c2Code">기타</label>
						<input type="text" id="searchStr2" name="searchStr2" value="<c:out value="${set.condiVO.searchStr2}"/>">
		             	<input type="button" class="blueBtn" id="search_btn" onclick="javascript:lfn_btn('search');return false;" value="검색" />
		           	</div>
		   		</div>
		   		
				<%-- 테이블 --%>
		   		<table summary="">
					<caption></caption>
					<thead>
					  	<tr class="guide">
	  						<th width="70"></th>
	  						<th width="70"></th>
	  						<th width="150"></th>
	  						<th></th>
	  						<th width="100"></th>
  						</tr>
						<tr>
							<th>아이디</th>
							<th>이름</th>
							<th>Url</th>
							<th>Parameter</th>
							<th class="no_line">접속일시</th>							
						</tr>
					</thead>
					<tbody>
						<c:if test="${empty set.logList}">
							<tr><td colspan="5" class="no_line center">검색된 데이타가 없습니다.</td></tr>
						</c:if>
						<c:forEach var="row" items="${set.logList}" varStatus="idx">
							<tr <c:if test="${idx.count%2 eq 1}"> class="alt"</c:if>>
				            	<td class="subject">${row.userId}</td>
				              	<td class="center">${row.userName}</td>
				              	<td class="subject" title="<c:out value="${row.url}" escapeXml="true" />">${row.url}</td>
				              	<td class="subject" title="<c:out value="${row.parameter}" escapeXml="true" />">${row.parameter}</td>
				              	<td class="no_line center">${row.createDate}</td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
				<%-- 페이징 --%>
				<div id="paging"></div>
				<%-- 하단버튼 --%>
				<div class="tool_btn">
				</div>
		   	</div>
		</div>
	</div>
</div>	


</form>


</body>
</html>

