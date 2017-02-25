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

$(document).ready(function() {

});

</script>

<body>

<form name="frm" action="" method="post">

<div id="popup_wrap">
  	<div class="pop_header">
    	<h3 class="title">진도 상세</h3>
    	<p class="closeBtn" onClick="window.close();">Close</p>
  	</div>
  	<div class="pop_content">
		<table class="view">
			<thead>
			  	<tr class="guide">
					<th width="20%"></th>
					<th width="20%"></th>
					<th width="20%"></th>
					<th width="20%"></th>
					<th width="20%"></th>
				</tr>
				<tr>
					<th>레포트 점수(${set.evaluation.reportRate})</th>
					<th>시험 점수(${set.evaluation.examRate})</th>
					<th>토론 점수(${set.evaluation.discussionRate})</th>
					<th>강의진도 점수(${set.evaluation.progressRate})</th>
					<th class="no_line">합계 점수</th>
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

		<table class="view">
			<thead>
			  	<tr class="guide">
					<th width="50"></th>
					<th width="100"></th>
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
						<td class="center">${row.week}</td>
						<td class="center">${row.progressRate} %</td>
						<td class="noline center">${row.studyStart} ~ ${row.studyEnd}</td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
	</div>
</div>	
	
</form>

</body>
</html>


