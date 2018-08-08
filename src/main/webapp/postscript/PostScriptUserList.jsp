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
		
		f_submitSelf("/postscript/postscriptUserList");	
	} else if ( pKind =="list" ) {
		gfn_goPage('/postscript/postscriptList',top.gCondition.postscript.param); 
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
        		<h1 class="title">수강후기 관리</h1>
        		<ul class="gnb">
	          		<li>HOME</li>
	          		<li>수강후기 관리</li>
	          		<li class="last">수강후기 관리</li>
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
	  						<th width="100"></th>
	  						<th width="150"></th>
	  						<th width="150"></th>
	  						<th width="60"></th>
	  						<th></th>
  						</tr>
						<tr>
							<th>사용자 ID</th>
							<th>사용자명</th>
							<th>E-mail</th>
							<th>핸드폰</th>
							<th>수강평점</th>
							<th class="no_line">수강후기</th>
						</tr>
					</thead>
					<tbody>
						<c:if test="${empty set.userList}">
							<tr>
								<td colspan="6" class="no_line center"><spring:message code="lms.msg.noSearchData" text="-" /></td>
							</tr>
						</c:if>
						<c:forEach var="row" items="${set.userList}" varStatus="idx">
				            <tr <c:if test="${idx.count%2 eq 1}"> class="alt"</c:if>>
				              	<td class="center"><c:out value="${row.userId}" escapeXml="" /></td>
				              	<td class="center"><c:out value="${row.userName}" escapeXml="" /></td>
				              	<td class="subject"><c:out value="${row.email}" escapeXml="" /></td>
				              	<td class="subject"><c:out value="${row.mobile}" escapeXml="" /></td>
				              	<td class="center"><c:out value="${row.eval}" escapeXml="" /></td>
				              	<td class="no_line subject"><pre><c:out value="${row.contents}" escapeXml="" /></pre></td>
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


