<%@ page contentType="text/html;charset=utf-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="FCK" uri="http://java.fckeditor.net" %>


<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="ko" xml:lang="ko">
<head>
<title>
</title>

<%@ include file="../common/commAdminInclude.jsp" %>

</head>

<script type="text/javascript">
var preUrl = "/evaluation/"; 

function lfn_btn(pKind, pParam) {
	if ( pKind =="list" ) {
		gfn_goPage(preUrl + "courseEvalList",top.gCondition.evaluationUser.param); 
	}
}

</script>

<body>

<form id="frm" name="frm" action="" method="post">
	<input type="hidden" id="screen" name="screen" value="${set.condiVO.screen}">

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
</c:choose>			</div>

			<div id="article">
				<%-- 조건 --%>
		    	<h3 class="title">진도 상세</h3>
		   		
				<%-- 테이블 --%>
		   		<table summary="" class="view">
					<thead>
					  	<tr class="guide">
	  						<th width="150"></th>
	  						<th width="150"></th>
	  						<th width="150"></th>
	  						<th width="150"></th>
	  						<th width="150"></th>
  						</tr>
						<tr>
							<th class="center">레포트 점수(${set.evaluation.reportRate})</th>
							<th class="center">시험 점수(${set.evaluation.examRate})</th>
							<th class="center">토론 점수(${set.evaluation.discussionRate})</th>
							<th class="center">강의진도 점수(${set.evaluation.progressRate})</th>
							<th class="no_line center">합계 점수</th>
						</tr>
					</thead>
					<tbody>
						<tr>
							<td class="right">${set.evaluation.reportCalc}</td>
							<td class="right">${set.evaluation.examCalc}</td>
							<td class="right">${set.evaluation.discussionCalc}</td>
							<td class="right">${set.evaluation.progressCalc}</td>
							<td class="no_line right">${set.evaluation.total}</td>
						</tr>
					</tbody>
				</table>	

				<%-- 테이블 --%>
		   		<table summary="" class="view">
					<thead>
					  	<tr class="guide">
	  						<th width="550"></th>
	  						<th width="70"></th>
	  						<th></th>
  						</tr>
						<tr>
							<th>주차</th>
							<th>진도율</th>
							<th class="no_line">학습일자</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach var="row" items="${set.week}" varStatus="idx">
				            <tr <c:if test="${idx.count%2 eq 1}"> class="alt"</c:if>>
								<td>${row.title}</td>
								<td class="right">${row.progressRate} %</td>
								<td class="no_line center">${row.studyStart} ~ ${row.studyEnd}</td>
							</tr>
						</c:forEach>					
					</tbody>
				</table>	

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


