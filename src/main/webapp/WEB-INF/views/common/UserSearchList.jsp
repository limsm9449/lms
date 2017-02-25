<%@ page contentType="text/html;charset=utf-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

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
	if ( pKind == "search" || pKind == "paging"  ) {
		if ( pKind == "search" )
			$("#pageNum").val(1);
		else if ( pKind == "paging" )
			$("#pageNum").val(pParam.page);
		
		f_submitSelf("/common/userSearchList");	
	} else if ( pKind == "select") {
		opener.lfn_userInfo(pParam);
		self.close();
	} else if ( pKind == "close") {
		self.close();
	}
}

</script>

<body>

<form id="frm" name="frm" method="post">
	<input id="screen" name="screen" type="hidden" value="${set.condiVO.screen}"/>

<!-- wrap -->
<div id="popup_wrap">
  <div class="pop_header">
    <h3 class="title">사용자 검색</h3>
    <p class="closeBtn" onClick="window.close();">Close</p>
  </div>
  <div class="pop_content">
    <div id="search">
		<div class="search_1">
			<label for="c1Code">검색 조건</label>
			<select id="kind" name="kind">
	          	<option value="USER_ID" <c:if test="${set.condiVO.kind eq '' || set.condiVO.kind eq 'USER_ID'}">selected</c:if>>사용자 ID</option>
	           	<option value="USER_NAME" <c:if test="${set.condiVO.kind eq 'USER_NAME'}">selected</c:if>>사용자명</option>
			</select>
			<input type="text" id="searchStr" name="searchStr" value="<c:out value="${set.condiVO.searchStr}"/>" onkeydown="javascript:if(event.keyCode==13){lfn_btn('search');}">		           
		</div>
       	<div class="search_2">
           	<input type="button" class="blueBtn" id="search_btn" onclick="javascript:lfn_btn('search');return false;" value="검색" />
       	</div>
	</div>
		<table>
			<thead>
				<tr>
					<th width="120">사용자 ID</th>
					<th width="120">사용자 명</th>
					<th width="130">전화번호</th>
					<th>E-mail</th>
				</tr>
			</thead>
			<tbody>
				<c:if test="${empty set.memberList}">
					<tr>
						<td colspan="4"><spring:message code="lms.msg.noSearchData" text="-" /></td>
					</tr>
				</c:if>
				<c:forEach var="row" items="${set.memberList}" varStatus="idx">
		            <tr <c:if test="${idx.count%2 eq 1}"> class="alt"</c:if>>
		            	<td class="center">${row.userId}</td>
		            	<td class="subject"><a href="#" onclick="javascript:lfn_btn('select',{userId:'${row.userId}',userName:'${row.userName}'}); return false;" class="click">${row.userName}</a></td>
		            	<td class="subject">${row.mobile}</td>
		            	<td class="subject">${row.email}</td>
		            </tr>
				</c:forEach>
			</tbody>
		</table>
		<div id="paging"></div>
	
  </div>
</div>
	
</form>


</body>
</html>


