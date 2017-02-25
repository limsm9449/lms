<%@ page contentType="text/html;charset=utf-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
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

function lfn_btn(pKind, pParam) {
	if ( pKind =="update" ) {
		gfn_goPage('/courseMaster/courseMasterU',"courseCode=" + $("#courseCode").val()); 
	} else if ( pKind =="list" ) {
		gfn_goPage('/courseMaster/courseMasterList',top.gCondition.courseMaster.param); 
	}
}

</script>

<body>

<form id="frm" name="frm" action="" method="post">

<div id="wrap">
	<div id="container">
    	<div id="contents">
      		<div id="content_head">
        		<h1 class="title">과정 Master 관리</h1>
        		<ul class="gnb">
	          		<li>HOME</li>
	          		<li>강좌 관리</li>
	          		<li class="last">과정 Master 관리</li>
        		</ul>
			</div>

			<div id="article">
		    	<h3 class="title">과정 Master 상세</h3>
		    	
				<table class="view">
					<caption></caption>
					<thead>
					  	<tr class="guide">
	  						<th width="130"></th>
	  						<th></th>
	  					</tr>
					</thead>
					<tbody>
						<tr>
							<th><spring:message code="lms.label.courseName" text="-" /></th>
							<td class="no_line">
								<input id="courseCode" name="courseCode" type="hidden" value="${set.data.courseCode}"/>
								${set.data.courseName}
							</td>
						</tr>
						<tr>
							<th><spring:message code="lms.label.tutor" text="-" /></th>
							<td class="no_line">${set.data.tutorName}</td>
						</tr>
						<tr>
							<th>과정비용유형</th>
							<td class="no_line">${set.data.weekCostYnName}</td>
						</tr>
						<tr>
							<th><spring:message code="lms.label.learingGoal" text="-" /></th>
							<td class="textbox no_line"><div style="width:400px"><c:out value="${set.data.learingGoal}" escapeXml="" /></div></td>
						</tr>
						<tr>
							<th><spring:message code="lms.label.learingContent" text="-" /></th>
							<td class="textbox no_line"><div style="width:400px"><c:out value="${set.data.learingContent}" escapeXml="" /></div></td>
						</tr>
						<tr>
							<th><spring:message code="lms.label.evalMethod" text="-" /></th>
							<td class="textbox no_line"><div style="width:400px"><c:out value="${set.data.evalMethod}" escapeXml="" /></div></td>
						</tr>
						<tr>
							<th><spring:message code="lms.label.learingTarget" text="-" /></th>
							<td class="textbox no_line"><div style="width:400px"><c:out value="${set.data.learingTarget}" escapeXml="" /></div></td>
						</tr>
						<tr>
							<th><spring:message code="lms.label.learingCost" text="-" /></th>
							<td class="textbox no_line"><div style="width:400px"><c:out value="${set.data.learingCost}" escapeXml="" /></div></td>
						</tr>
						<tr>
							<th>홍보영상</th>
							<td class="no_line">${set.data.promotionVideoYn}</td>
						</tr>
						<tr>
							<th>과정비용</th>
							<td class="no_line"><fmt:formatNumber value="${set.data.courseCost}" type="number"/> 원</td>
						</tr>
<c:if test="${set.data.weekCostYn eq 'Y'}">
						<tr>
							<th>차시별 비용</th>
							<td class="no_line">
								<ol id="study_list">
									<c:forEach var="row" items="${set.weekCostList}" varStatus="idx">
								    	<li>${row.title}<span class="price"><fmt:formatNumber value="${row.weekCost}" type="number"/> 원</span></li>
									</c:forEach>
								</ol>
							</td>
						</tr>
</c:if>						
						<tr>
							<th><spring:message code="lms.label.reportRate" text="-" /></th>
							<td class="no_line">${set.data.examRate} %</td>
						</tr>
						<tr>
							<th><spring:message code="lms.label.examRate" text="-" /></th>
							<td class="no_line">${set.data.examRate} %</td>
						</tr>
						<tr>
							<th><spring:message code="lms.label.discusstionRate" text="-" /></th>
							<td class="no_line">${set.data.discussionRate} %</td>
						</tr>
						<tr>
							<th><spring:message code="lms.label.progressRate" text="-" /></th>
							<td class="no_line">${set.data.progressRate} %</td>
						</tr>
					</tbody>
				</table>
				
				<%-- 하단버튼 --%>
		  		<div class="tool_btn">
					<a href="#" onclick="javascript:lfn_btn('update'); return false;" class="blueBtn">수정</a>
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


