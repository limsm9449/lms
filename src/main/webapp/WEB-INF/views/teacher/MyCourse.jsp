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
		
		f_submitSelf("/teacher/myCourse");	
	} else if ( pKind == "courseEval" ) {
		lfn_setCondition();
		
		gfn_goPage("/teacher/courseEval","courseId=" + pParam.courseId);
	}
}

function lfn_setCondition() {
	top.gCondition.myCourse = {
		param : "courseName=" + $("#courseName").val() +
				"&pageNum=" + $("#pageNum").val()
	}	
}

</script>

<body>

<form id="frm" name="frm" method="post">
	<input id="courseId" name="courseId" type="hidden" value=""/>
 
<div id="wrap">
	<div id="container">
    	<div id="contents">
      		<div id="content_head">
        		<h1 class="title">담당 강좌 리스트</h1>
        		<ul class="gnb">
	          		<li>HOME</li>
	          		<li>강좌관리</li>
	          		<li class="last">담당 강좌 리스트</li>
        		</ul>
			</div>

			<div id="article">
				<%-- 조건 --%>
		    	<h3 class="title">담당 강좌 리스트</h3>

				<%-- 조건 --%>
		       	<div id="search">
		      		<div class="search_1">
		            	<label for="f_subject">과정명</label>
		             	<input type="text" class="search_input" id="courseName" name="courseName" value="${set.condiVO.courseName}" />
		            </div>
		        	<div class="search_2">
		             	<input type="button" class="blueBtn" id="search_btn" onclick="javascript:lfn_btn('search');return false;" value="검색" />
		           	</div>
		   		</div>
		   				   		
				<%-- 테이블 --%>
		   		<table summary="" >
					<caption></caption>
					<thead>
					  	<tr class="guide">
	  						<th></th>
	  						<th width="50"></th>
	  						<th width="80"></th>
	  						<th width="60"></th>
	  						<th width="70"></th>
	  						<th width="70"></th>
	  						<th width="70"></th>
	  						<th width="60"></th>
	  						<th width="60"></th>
	  						<th width="60"></th>
  						</tr>
						<tr>
							<th>과저명</th>
							<th>차수</th>
							<th>과정종류</th>
							<th>전체</th>
							<th>레포트</th>
							<th>시험</th>
							<th>토론</th>
							<th>진도</th>
							<th>완료</th>
							<th class="no_line">미완료</th>
						</tr>
					</thead>
					<tbody>
						<c:if test="${empty set.courses}">
							<tr><td colspan="10" class="no_line center">검색된 데이타가 없습니다.</td></tr>
						</c:if>	
						<c:forEach var="row" items="${set.courses}" varStatus="idx">
				            <tr <c:if test="${idx.count%2 eq 1}"> class="alt"</c:if>>
				            	<td class="subject"><a href="#" onclick="javascript:lfn_btn('courseEval',{courseId:'${row.courseId}'}); return false;" class="click">${row.courseName}</a></td>
				            	<td class="center">${row.chasu}</td>
				            	<td class="center">${row.courseKindName}</td>
				            	<td class="right">${row.allCnt}</td>
				            	<td class="right">
				            		<c:if test="${row.isReport eq 'Y'}">${row.reportCnt}</c:if>
				            		<c:if test="${row.isReport eq 'N'}">-</c:if>
				            	</td>
				            	<td class="right">
				            		<c:if test="${row.isExam eq 'Y'}">${row.examCnt}</c:if>
				            		<c:if test="${row.isExam eq 'N'}">-</c:if>
				            	</td>
				            	<td class="right">
				            		<c:if test="${row.isDiscussion eq 'Y'}">${row.discussionCnt}</c:if>
				            		<c:if test="${row.isDiscussion eq 'N'}">-</c:if>
				            	</td>
				            	<td class="right">
				            		<c:if test="${row.isProgress eq 'Y'}">${row.progressCnt}</c:if>
				            		<c:if test="${row.isProgress eq 'N'}">-</c:if>
				            	</td>
				            	<td class="right">${row.completeCnt}</td>
				            	<td class="no_line right">${row.notCompleteCnt}</td>
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

