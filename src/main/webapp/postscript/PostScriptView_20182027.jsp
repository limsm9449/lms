<%@ page contentType="text/html;charset=utf-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="FCK" uri="http://java.fckeditor.net" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>


<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="ko" xml:lang="ko">
<head>
<title>
</title>

<%@ include file="../common/commAdminInclude.jsp" %>

</head>

<script type="text/javascript">
var gCondition = {
}

</script>


<body>

<form id="frm" name="frm" action="" method="post">
	<input type="hidden" id="courseId" name="courseId" value="${set.condiVO.courseId}"/> 
	
<div id="popup_wrap">
  	<div class="pop_header">
    	<h3 class="title">수강후기</h3>
    	<p class="closeBtn" onClick="window.close();">Close</p>
  	</div>
  	<div class="pop_content">
		<%-- 테이블 --%>
   		<table summary="" class="view">
			<caption></caption>
			<thead>
			  	<tr class="guide">
					<th width="100"></th>
					<th></th>
				</tr>
			</thead>
			<tbody>
				<tr>
					<th>강좌 평점</th> 
					<td class="no_line">
						<ul class="exam">
	              			<li><input type="radio" id="eval" name="eval" value="2" disabled <c:if test="${set.data.eval eq '2'}">checked</c:if>/>2 점</li>
	              			<li><input type="radio" id="eval" name="eval" value="4" disabled <c:if test="${set.data.eval eq '4'}">checked</c:if>/>4 점</li>
	              			<li><input type="radio" id="eval" name="eval" value="6" disabled <c:if test="${set.data.eval eq '6'}">checked</c:if>/>6 점</li>
	              			<li><input type="radio" id="eval" name="eval" value="8" disabled <c:if test="${set.data.eval eq '8'}">checked</c:if>/>8 점</li>
	              			<li><input type="radio" id="eval" name="eval" value="10" disabled <c:if test="${set.data.eval eq '10'}">checked</c:if>/>10 점</li>
		              	</ul>
					</td>
				</tr>
				<tr>
					<th>수강후기</th>
					<td class="textbox no_line">
						<textarea id="contents" name="contents" class="polltext" style="height:100px" disabled><c:out value="${set.data.contents}" escapeXml="" /></textarea>
					</td>
				</tr>
			</tbody>
		</table>
	</div>
	
</div>

</form>

</body>
</html>


