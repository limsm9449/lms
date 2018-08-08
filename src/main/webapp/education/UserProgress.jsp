<%@ page contentType="text/html;charset=utf-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="FCK" uri="http://java.fckeditor.net" %>


<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="ko" xml:lang="ko">
<head>
<title>
</title>

<%@ include file="../common/commUserInclude.jsp" %>

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
    <table class="bod_list">
      <thead>
      <tr class="guide">
        <th width="21%"></th>
        <th width="21%"></th>
        <th width="21%"></th>
        <th width="21%"></th>
        <th width="16%"></th>
      </tr>
      <tr class="t_list">
		<th>레포트 점수(${set.evaluation.reportRate})</th>
		<th>시험 점수(${set.evaluation.examRate})</th>
		<th>토론 점수(${set.evaluation.discussionRate})</th>
		<th>강의진도 점수(${set.evaluation.progressRate})</th>
		<th>합계 점수</th>
      </tr>
      </thead>
      <tbody>
      <tr class="last_line">
		<td class="right">${set.evaluation.reportCalc}</td>
		<td class="right">${set.evaluation.examCalc}</td>
		<td class="right">${set.evaluation.discussionCalc}</td>
		<td class="right">${set.evaluation.progressCalc}</td>
		<td class="last right">${set.evaluation.total}</td>        
      </tr>
      </tbody>
    </table>
    <br /><br />
    <table class="bod_list">
      <thead>
      <tr class="guide">
        <th width="60"></th>
        <th width="120"></th>
        <th></th></tr>
      <tr class="t_list">
        <th>주차</th>
        <th>진도율</th>
        <th>학습일자</th>
      </tr>
      </thead>
      <tbody>
<c:forEach var="row" items="${set.week}" varStatus="idx">
           <tr <c:if test="${idx.index + 1 eq fn:length(set.week)}"> class="last_line"</c:if>>
			<td class="center">${row.week}</td>
			<td class="center">${row.progressRate} %</td>
			<td class="last center">${row.studyStart} ~ ${row.studyEnd}</td>
		</tr>
</c:forEach>      
      </tbody>
    </table>
    <br />
  </div><!-- end pop_content -->
</div>



</form>

</body>
</html>


