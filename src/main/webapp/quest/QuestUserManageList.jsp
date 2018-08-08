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
	if ( pKind == "search" || pKind == "paging" || pKind == "refresh" ) {
		if ( pKind == "search" )
			$("#pageNum").val(1);
		else if ( pKind == "paging" )
			$("#pageNum").val(pParam.page);
		
		f_submitSelf("/quest/questUserManageList");	
	} else if ( pKind == "view") {
		lfn_setCondition();
		
		gfn_goPage("/quest/questUserManageV","courseId=" + $("#courseId").val() + "&userId=" + pParam.userId);
	} else if ( pKind =="list" ) {
		gfn_goPage('/quest/questManageList',top.gCondition.questManage.param); 
	}
}

function lfn_setCondition() {
	top.gCondition.questUserManage = {
		param : "searchKind=" + $("#searchKind").val() + 
				"&searchStr=" + $("#searchStr").val() + 
				"&courseId=" + $("#courseId").val() + 
				"&pageNum=" + $("#pageNum").val()
	}	
}
</script>

<body>

<form id="frm" name="frm" action="" method="post">
	<input id="courseId" name="courseId" value="${set.condiVO.courseId}" type="hidden"/>

<div id="wrap">
	<div id="container">
    	<div id="contents">
      		<div id="content_head">
        		<h1 class="title">과정별 설문지 관리</h1>
        		<ul class="gnb">
	          		<li>HOME</li>
	          		<li>설문지 관리</li>
	          		<li class="last">과정별 설문지 관리</li>
        		</ul>
			</div>

			<div id="article">
		    	<h3 class="title">수강자 리스트</h3>

		      	
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
		             	<input type="button" class="blueBtn" id="search_btn" onclick="javascript:lfn_btn('search');return false;" value="검색" />
		           	</div>
		   		</div>
		   		
				<%-- 테이블 --%>
		   		<p class="count">${set.totalCount} 건</span></p>
		   		<table summary="">
					<caption></caption>
					<thead>
					  	<tr class="guide">
	  						<th width="100"></th>
	  						<th></th>
	  						<th width="150"></th>
	  						<th width="120"></th>
	  						<th width="50"></th>
	  						<th width="50"></th>
	  						<th width="50"></th>
	  						<th width="50"></th>
  						</tr>
						<tr>
							<th>사용자 ID</th>
							<th>사용자명</th>
							<th>E-mail</th>
							<th>핸드폰</th>
							<th>답1</th>
							<th>답2</th>
							<th>답3</th>
							<th class="no_line">답4</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach var="row" items="${set.userList}" varStatus="idx">
				            <tr <c:if test="${idx.count%2 eq 1}"> class="alt"</c:if>>
				              	<td class="center"><c:out value="${row.userId}" escapeXml="" /></td>
<c:choose>
	<c:when test="${row.questYn eq 'Y'}">
				              	<td class="center"><a href="#" onclick="javascript:lfn_btn('view',{userId:'${row.userId}'}); return false;" class="click"><c:out value="${row.userName}" escapeXml="" /></a></td>
	</c:when>
	<c:otherwise>
				              	<td class="center"><c:out value="${row.userName}" escapeXml="" /></td>
	</c:otherwise>
</c:choose>				              	
				              	<td class="center"><c:out value="${row.email}" escapeXml="" /></td>
				              	<td class="center"><c:out value="${row.mobile}" escapeXml="" /></td>
				              	<td class="center"><c:out value="${row.answer1Cnt}" escapeXml="" /></td>
				              	<td class="center"><c:out value="${row.answer2Cnt}" escapeXml="" /></td>
				              	<td class="center"><c:out value="${row.answer3Cnt}" escapeXml="" /></td>
				              	<td class="no_line center"><c:out value="${row.answer4Cnt}" escapeXml="" /></td>
				            </tr>
						</c:forEach>
					</tbody>
				</table>

				
				<%-- 페이징 --%>
				<div id="paging"></div>
				
				<%-- 하단버튼 --%>
		  		<div class="tool_btn">
					<a href="#" onclick="javascript:lfn_btn('list'); return false;" class="blueBtn">리스트</a>
		  		</div>
			</div>
			<!-- end content body -->
		</div>
	</div>
</div>
	
</form>

</body>
</html>


