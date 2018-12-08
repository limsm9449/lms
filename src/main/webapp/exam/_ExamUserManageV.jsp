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
function lfn_btn(pKind, pParam) {
	if ( pKind =="list" ) {
		gfn_goPage('/exam/examUserManageList',top.gCondition.examUserManage.param); 
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
        		<h1 class="title">시험 관리</h1>
        		<ul class="gnb">
	          		<li>HOME</li>
	          		<li>성적 관리</li>
	          		<li class="last">시험 관리</li>
        		</ul>
			</div>

			<div id="article">
		    	<h3 class="title">시험 상세</h3>

				<%-- 테이블 --%>
		   		<table summary="">
					<caption></caption>
					<thead>
					  	<tr class="guide">
	  						<th width="40"></th>
	  						<th></th>
	  						<th width="100"></th>
  						</tr>
						<tr>
							<th>순번</th>
							<th>질문</th>
							<th class="no_line">답</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach var="row" items="${set.userDetailList}" varStatus="idx">
				            <tr <c:if test="${idx.count%2 eq 1}"> class="alt"</c:if>>
				              	<td class="center"><c:out value="${row.seq}" escapeXml="" /></td>
				              	<td class="subject">
				              		<p class="quest"><c:out value="${row.question}" escapeXml="" /></p>
				              		<c:if test="${row.type eq 'G'}">
					              		<ul class="exam">
					              			<li><input type="radio" <c:if test="${row.userAnswer eq '1'}">checked</c:if> disabled/><c:out value="${row.qa1}" escapeXml="" /></li>
					              			<li><input type="radio" <c:if test="${row.userAnswer eq '2'}">checked</c:if> disabled/><c:out value="${row.qa2}" escapeXml="" /></li>
					              			<li><input type="radio" <c:if test="${row.userAnswer eq '3'}">checked</c:if> disabled/><c:out value="${row.qa3}" escapeXml="" /></li>
					              			<li><input type="radio" <c:if test="${row.userAnswer eq '4'}">checked</c:if> disabled/><c:out value="${row.qa4}" escapeXml="" /></li>
						              	</ul>
				              		</c:if>
				              		<c:if test="${row.type eq 'J'}">
				              			<textarea class="polltext" disabled><c:out value="${row.userAnswer}" escapeXml="" /></textarea>
				              		</c:if>
				              	</td>
				              	<td class="no_line center"><c:out value="${row.answer}" escapeXml="" /><c:if test="${row.userAnswer ne row.answer}"> (틀림)</c:if></td>
				            </tr>
						</c:forEach>						
					</tbody>
				</table>
				
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


