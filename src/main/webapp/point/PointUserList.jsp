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
	} 
);

function lfn_btn(pKind, pParam) {
	if ( pKind == "search" || pKind == "paging" || pKind == "refresh" ) {
		if ( pKind == "search" )
			$("#pageNum").val(1);
		else if ( pKind == "paging" )
			$("#pageNum").val(pParam.page);
		
		f_submitSelf("/point/pointUserList");	
	} else if ( pKind == "view") {
		lfn_setCondition();
		
		gfn_goPage("/point/pointUserV","userId=" + pParam.userId);
	}
}

function lfn_setCondition() {
	top.gCondition.point = {
		param : "searchKind=" + $("#searchKind").val() +
				"&searchStr=" + $("#searchStr").val() +
				"&pageNum=" + $("#pageNum").val()
	}	
}


</script>

<body>

<form id="frm" name="frm" method="post">

<div id="wrap">
	<div id="container">
    	<div id="contents">
      		<div id="content_head">
        		<h1 class="title">Point 관리</h1>
        		<ul class="gnb">
	          		<li>HOME</li>
	          		<li>사용자</li>
	          		<li class="last">Point 관리</li>
        		</ul>
			</div>

			<div id="article">
				<%-- 조건 --%>
		    	<h3 class="title">Point 관리</h3>
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
		   		<table summary="">
					<caption></caption>
					<thead>
					  	<tr class="guide">
	  						<th width="90"></th>
	  						<th width="100"></th>
	  						<th width="100"></th>
	  						<th width="100"></th>
	  						<th></th>
	  						<th width="70"></th>
	  						<th width="70"></th>
	  						<th width="70"></th>
  						</tr>
						<tr>
							<th>사용자 ID</th>
							<th>사용자명</th>
							<th>사용자 구분</th>
							<th>핸드폰</th>
							<th>E-Mail</th>
							<th>적립 Point</th>
							<th>사용 Point</th>
							<th class="no_line">잔여 Point</th>
						</tr>
					</thead>
					<tbody>
						<c:if test="${empty set.list}">
							<tr><td colspan="9" class="no_line center">검색된 데이타가 없습니다.</td></tr>
						</c:if>
						<c:forEach var="row" items="${set.list}" varStatus="idx">
							<tr <c:if test="${idx.count%2 eq 1}"> class="alt"</c:if>>
				            	<td class="subject">${row.userId}</td>
				            	<td class="center"><a href="#" onclick="javascript:lfn_btn('view',{userId:'${row.userId}'}); return false;" class="click">${row.userName}</a></td>
				            	<td class="center">${row.userKind}</td>
				            	<td class="subject">${row.mobile}</td>
				            	<td class="subject">${row.email}</td>
				            	<td class="right">${row.inPoint}</td>
				            	<td class="right">${row.outPoint}</td>
				            	<td class="no_line right">${row.remainPoint}</td>
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


