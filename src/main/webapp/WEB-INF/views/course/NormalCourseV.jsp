<%@ page contentType="text/html;charset=utf-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="FCK" uri="http://java.fckeditor.net" %>


<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="ko" xml:lang="ko">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>
</title>

<%@ include file="../common/commAdminInclude.jsp" %>

</head>

<script type="text/javascript">

function lfn_btn(pKind, pParam) {
	if ( pKind == "update" ) {
		f_submitSelf("/normalCourse/normalCourseU",$("#courseId").val());
	} else if ( pKind =="delete" ) {
		if ( confirm("삭제하시겠습니까?") == true ) {
			btnUnbind("delBtn");
			$.ajax({
				type :"POST",
				url : context +"/normalCourse/normalCourseDel.do",
				dataType :"json",
				data : $("#frm").serialize(),
				success : function(json){
					if ( json.rtnMode == "DELETE_OK") {
						alert("<spring:message code="lms.msg.deleteOk" text="-" />");
						lfn_btn("list");
					}
				},
				error : function(e) {
					alert("<spring:message code="lms.msg.systemError" text="-" />");
				}
			})
		}
	} else if ( pKind == "list") {
		gfn_goPage("/normalCourse/normalCourseList",top.gCondition.normalCourse.param);
	}
}

</script>

<body>


<form id="frm" name="frm" action="" method="post">

<div id="wrap">
	<div id="container">
    	<div id="contents">
      		<div id="content_head">
        		<h1 class="title">강좌 관리</h1>
        		<ul class="gnb">
	          		<li>HOME</li>
	          		<li>일반 강좌 관리</li>
	          		<li class="last">강좌 관리</li>
        		</ul>
			</div>

			<div id="article">
				<%-- 조건 --%>
		    	<h3 class="title insertool">강좌 상세</h3>

				<div class="course_tool">
					<a href="#" onclick="javascript:Popup.showViewCourse('${set.data.courseId}','1','${set.data.hPx + 100}','${set.data.vPx + 100}'); return false;" class="click">과정보기</a>
					<a href="#" onclick="javascript:Popup.showBoard('NOTICE','${set.data.courseId}'); return false;" class="click">공지사항</a>
					<a href="#" onclick="javascript:Popup.showBoard('FREE','${set.data.courseId}'); return false;" class="click">자유게시판</a>
					<a href="#" onclick="javascript:Popup.showBoard('DATA','${set.data.courseId}'); return false;" class="click">자료실</a>
					<a href="#" onclick="javascript:Popup.showBoard('QNA','${set.data.courseId}'); return false;" class="click">Q&A</a>
					<a href="#" onclick="javascript:Popup.showBoard('REPORT','${set.data.courseId}'); return false;" class="click">레포트</a>
					<a href="#" onclick="javascript:Popup.showBoard('DISCUSSION','${set.data.courseId}'); return false;" class="click">토론게시판</a>
				</div>

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
							<th><spring:message code="lms.label.category" text="-" /></th>
							<td class="no_line">${set.data.categoryName}</td>
						</tr>
						<tr>
							<th><spring:message code="lms.label.courseName" text="-" /></th>
							<td class="no_line">
								<input id="courseId" name="courseId" type="hidden" value="${set.data.courseId}"/>
								${set.data.courseName}
							</td>
						</tr>
						<tr>
							<th><spring:message code="lms.label.chasu" text="-" /></th>
							<td class="no_line">${set.data.chasu}</td>
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
							<th>과정비용</th>
							<td class="no_line"><fmt:formatNumber value="${set.data.courseCost}" type="number"/></td>
						</tr>
<c:if test="${set.data.weekCostYn eq 'Y'}">
						<tr>
							<th>차시별 목차 및 비용</th>
							<td class="no_line">
								<table class="view">
									<thead>
									  	<tr class="guide">
					  						<th></th>
					  						<th width="100"></th>
				  						</tr>
										<tr>
											<th>제목</th>
											<th class="no_line">비용</th>
										</tr>
									</thead>
									<c:forEach var="row" items="${set.weekCostList}" varStatus="idx">
										<tr>
											<td onclick="javascript:Popup.showViewCourse('${set.data.courseId}','${row.week}','${set.data.hPx + 100}','${set.data.vPx + 100}'); return false;" class="click">${row.week}. ${row.title}</td>
											<td class="no_line right"><fmt:formatNumber value="${row.weekCost}" type="number"/></td>
										</tr>
										</c:forEach>
								</table>
							</td>
						</tr>
</c:if>						
						<tr>
							<th>오픈여부</th>
							<td class="no_line">${set.data.openYn}</td>
						</tr>
						<tr>
							<th>교육일수</th>
							<td class="no_line">${set.data.cPeriod}</td>
						</tr>
						<tr>
							<th><spring:message code="lms.label.reportRate" text="-" /></th>
							<td class="no_line">${set.data.reportRate} %</td>
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
<c:if test="${set.data.aCnt eq 0}">
					<a href="#" id="delBtn" onclick="javascript:lfn_btn('delete'); return false;" class="blueBtn">삭제</a>
</c:if>
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


