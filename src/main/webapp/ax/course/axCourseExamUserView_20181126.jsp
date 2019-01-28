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

<%@ include file="../../common/commAxAdminInclude.jsp" %>
<link rel="stylesheet" type="text/css" media="all" href="/resources/css/admin/admin.css" /> 

</head>

<script type="text/javascript">


</script>


<body>

<form id="frm" name="frm" action="" method="post">
	
<div id="popup_wrap">
  	<div class="pop_header">
    	<h3 class="title">평가</h3>
    	<p class="closeBtn" onClick="window.close();">Close</p>
  	</div>
  	<div class="pop_content">
		<%-- 테이블 --%>
   		<table summary="">
			<caption></caption>
			<thead>
			  	<tr class="guide">
 						<th width="50"></th>
 						<th></th>
						</tr>
				<tr>
					<th>순번</th>
					<th class="no_line">질문</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach var="row" items="${list}" varStatus="idx">
		            <tr <c:if test="${idx.count%2 eq 1}"> class="alt"</c:if>>
		              	<td class="center"><c:out value="${row.ORD}" escapeXml="" /></td>
		              	<td class="no_line subject">
		              		<p class="quest"><c:out value="${row.QUESTION}" escapeXml="" /></p>
		              		<c:if test="${row.TYPE eq 'G'}">
			              		<ul class="exam">
			              			<li><input type="radio" id="answers${idx.index}" name="answers${idx.index}" value="1"/><c:out value="${row.QA1}" escapeXml="" /></li>
			              			<li><input type="radio" id="answers${idx.index}" name="answers${idx.index}" value="2"/><c:out value="${row.QA2}" escapeXml="" /></li>
			              			<li><input type="radio" id="answers${idx.index}" name="answers${idx.index}" value="3"/><c:out value="${row.QA3}" escapeXml="" /></li>
			              			<li><input type="radio" id="answers${idx.index}" name="answers${idx.index}" value="4"/><c:out value="${row.QA4}" escapeXml="" /></li>
				              	</ul>
		              			<textarea id="memos${idx.index}" name="memos${idx.index}" class="polltext" style="display:none"></textarea>
		              		</c:if>
		              		<c:if test="${row.TYPE eq 'M'}">
			              		<ul class="exam">
			              			<li><input type="checkbox" id="answers${idx.index}" name="answers${idx.index}" value="1"/><c:out value="${row.QA1}" escapeXml="" /></li>
			              			<li><input type="checkbox" id="answers${idx.index}" name="answers${idx.index}" value="2"/><c:out value="${row.QA2}" escapeXml="" /></li>
			              			<li><input type="checkbox" id="answers${idx.index}" name="answers${idx.index}" value="3"/><c:out value="${row.QA3}" escapeXml="" /></li>
			              			<li><input type="checkbox" id="answers${idx.index}" name="answers${idx.index}" value="4"/><c:out value="${row.QA4}" escapeXml="" /></li>
				              	</ul>
		              			<textarea id="memos${idx.index}" name="memos${idx.index}" class="polltext" style="display:none"></textarea>
		              		</c:if>
		              		<c:if test="${row.TYPE eq 'J'}">
		              			<textarea id="memos${idx.index}" name="memos${idx.index}" class="polltext"></textarea>
		              			<input type="radio" id="answers${idx.index}" name="answers${idx.index}" value="1" style="display:none"/>
		              			<input type="radio" id="answers${idx.index}" name="answers${idx.index}" value="2" style="display:none"/>
		              			<input type="radio" id="answers${idx.index}" name="answers${idx.index}" value="3" style="display:none"/>
		              			<input type="radio" id="answers${idx.index}" name="answers${idx.index}" value="4" style="display:none"/>
		              		</c:if>
		              	</td>
		            </tr>
				</c:forEach>
			</tbody>
		</table>
	</div>
	
</div>

</form>

</body>
</html>


