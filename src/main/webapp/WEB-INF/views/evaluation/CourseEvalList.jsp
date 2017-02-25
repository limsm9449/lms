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
var preUrl = "/evaluation/"; 

$(document).ready(function() {
	f_makePageNavigator("paging",${set.condiVO.pageNum},${set.totalCount},${set.pageUnit});
});

function lfn_btn(pKind, pParam) {
	if ( pKind == "search" || pKind == "paging" || pKind == "refresh" ) {
		if ( pKind == "search" )
			$("#pageNum").val(1);
		else if ( pKind == "paging" )
			$("#pageNum").val(pParam.page);
		
		f_submitSelf(preUrl + "courseEvalList");	
	} else if ( pKind == "view") {
		lfn_setCondition();
		
		gfn_goPage(preUrl + "courseEvalV","screen=${set.condiVO.screen}&courseId=" + pParam.courseId + "&userId=" + pParam.userId);
	} else if ( pKind =="list" ) {
		if ( "${set.condiVO.screen}" == "compCourse" ) 
			gfn_goPage("/compCourse/compCourseList",top.gCondition.compCourse.param); 
		else
			gfn_goPage(preUrl + "courseList",top.gCondition.evaluationCourse.param); 
	}
}

function lfn_setCondition() {
	top.gCondition.evaluationUser = {
		param : "searchKind=" + $("#searchKind").val() + 
				"&searchStr=" + $("#searchStr").val() + 
				"&courseId=${set.condiVO.courseId}" +
				"&screen=${set.condiVO.screen}" +
		      	"&pageNum=" + $("#pageNum").val()
	}	
}


</script>

<body>

<form id="frm" name="frm" method="post">
	<input type="hidden" id="screen" name="screen" value="${set.condiVO.screen}">
	<input type="hidden" id="courseId" name="courseId" value="${set.condiVO.courseId}">

<div id="wrap">
	<div id="container">
    	<div id="contents">
      		<div id="content_head">
<c:choose>
	<c:when test="${set.condiVO.screen eq 'compCourse'}">
        		<h1 class="title">강좌 관리</h1>
        		<ul class="gnb">
	          		<li>HOME</li>
	          		<li>강좌 관리</li>
	          		<li class="last">강좌 관리</li>
        		</ul>	          		
	</c:when>
	<c:otherwise>
        		<h1 class="title">진도 관리</h1>
        		<ul class="gnb">
	          		<li>HOME</li>
	          		<li>성적 관리</li>
	          		<li class="last">진도 관리</li>
        		</ul>
	</c:otherwise>
</c:choose>
			</div>

			<div id="article">
				<%-- 조건 --%>
		    	<h3 class="title">수강생 리스트</h3>

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
					<thead>
					  	<tr class="guide">
	  						<th></th>
	  						<th width="80"></th>
	  						<th width="80"></th>
	  						<th width="80"></th>
	  						<th width="80"></th>
	  						<th width="80"></th>
  						</tr>
						<tr>
							<th>이름</th>
							<th>레포트</th>
							<th>시험</th>
							<th>토론</th>
							<th>강의진도</th>
							<th class="no_line">총점</th>
						</tr>
					</thead>
					<tbody>
						<c:if test="${empty set.list}">
							<tr>
								<td colspan="6" class="no_line center"><spring:message code="lms.msg.noSearchData" text="-" /></td>
							</tr>
						</c:if>
						<c:forEach var="row" items="${set.list}" varStatus="idx">
				            <tr <c:if test="${idx.count%2 eq 1}"> class="alt"</c:if>>
				            	<td class="subject"><a href="#" onclick="javascript:lfn_btn('view',{courseId:'${row.courseId}',userId:'${row.userId}'}); return false;" class="click">${row.userName}</a></td>
				            	<td class="right">${row.report}</td>
				            	<td class="right">${row.exam}</td>
				            	<td class="right">${row.discussion}</td>
				            	<td class="right">${row.progress}</td>
				            	<td class="no_line right">${row.total}</td>
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
		</div>
	</div>
</div>
						
</form>

</body>
</html>

