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
		gfn_goPage('/quest/questUserManageList',top.gCondition.questUserManage.param); 
	}
}

</script>

<body>

<form id="frm" name="frm" action="" method="post">
	<input id="courseId" name="courseId" value="${set.condiVO.courseId}" type="hidden"/>
	<input id="qgId" name="qgId" value="${set.condiVO.qgId}" type="hidden"/>

<div id="wrap">
	<div id="container">
    	<div id="contents">
      		<div id="content_head">
        		<h1 class="title">과정별 설문지 관리</h1>
        		<ul class="gnb">
	          		<li>HOME</li>
	          		<li>설문지 관리</li>
	          		<li class="last">과정별 설문지 관리</li>
        		</ul>
			</div>

			<div id="article">
		    	<h3 class="title">설문지 상세</h3>

				<%-- 테이블 --%>
		   		<table summary="">
					<caption></caption>
					<thead>
					  	<tr class="guide">
	  						<th width="40"></th>
	  						<th></th>
	  						<th width="350"></th>
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
				              	<td class="subject"><c:out value="${row.question}" escapeXml="" /></td>
				              	<td class="no_line subject"><c:out value="${row.answer}" escapeXml="" /></td>
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


