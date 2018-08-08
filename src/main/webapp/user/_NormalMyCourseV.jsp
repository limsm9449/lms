<%@ page contentType="text/html;charset=utf-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="FCK" uri="http://java.fckeditor.net" %>


<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="ko" xml:lang="ko">
<head>
<title>
</title>

<%@ include file="../common/commInclude.jsp" %>

</head>

<script type="text/javascript">

function f_list() {
	gfn_goPage("/user/myCourseList");
}


</script>

<body>

* 강좌 내용

	<c:if test="${(set.courseInfo.status eq 'CS' || set.courseInfo.status eq 'CP' || set.courseInfo.status eq 'CC' || set.courseInfo.status eq 'CD') && set.courseInfo.isEducationDate eq 'Y'}">
		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;      
		<a href="#" onclick="javascript:Popup.showBoard('NOTICE','${set.condiVO.courseId}'); return false;">공지사항</a>
		&nbsp;
		<a href="#" onclick="javascript:Popup.showBoard('FREE','${set.condiVO.courseId}'); return false;">자유게시판</a>
		&nbsp;
		<a href="#" onclick="javascript:Popup.showBoard('DATA','${set.condiVO.courseId}'); return false;">자료실</a>
		&nbsp;
		<a href="#" onclick="javascript:Popup.showBoard('QNA','${set.condiVO.courseId}'); return false;">Q&A</a>
		&nbsp;
		<c:if test="${set.course.isReport eq 'Y'}">
			<a href="#" onclick="javascript:Popup.showBoard('REPORT','${set.condiVO.courseId}'); return false;">레포트</a>
			&nbsp;
		</c:if>
		<c:if test="${set.course.isDiscussion eq 'Y'}">
			<a href="#" onclick="javascript:Popup.showBoard('DISCUSSION','${set.condiVO.courseId}'); return false;">토론게시판</a>
			&nbsp;
		</c:if>
	</c:if>

<form name="frm" action="" method="post">

	<table>
		<tr>
			<td><spring:message code="lms.label.courseName" text="-" /></td>
			<td>
				<input id="courseId" name="courseId" type="hidden" value="${set.courseInfo.courseId}"/>
				${set.courseInfo.courseName}
			</td>
		</tr>
		<tr>
			<td><spring:message code="lms.label.chasu" text="-" /></td>
			<td>${set.courseInfo.chasu}</td>
		</tr>
		<tr>
			<td><spring:message code="lms.label.tutor" text="-" /></td>
			<td>${set.courseInfo.tutorName}</td>
		</tr>
		<tr>
			<td><spring:message code="lms.label.courseStatus" text="-" /></td>
			<td>${set.courseInfo.statusName}</td>
		</tr>
		<tr>
			<td><spring:message code="lms.label.learingGoal" text="-" /></td>
			<td align="left"><div style="height:100px;width:400px"><c:out value="${set.courseInfo.learingGoal}" escapeXml="" /></div></td>
		</tr>
		<tr>
			<td><spring:message code="lms.label.learingContent" text="-" /></td>
			<td align="left"><div style="height:100px;width:400px"><c:out value="${set.courseInfo.learingContent}" escapeXml="" /></div></td>
		</tr>
		<tr>
			<td><spring:message code="lms.label.evalMethod" text="-" /></td>
			<td align="left"><div style="height:100px;width:400px"><c:out value="${set.courseInfo.evalMethod}" escapeXml="" /></div></td>
		</tr>
		<tr>
			<td><spring:message code="lms.label.learingTarget" text="-" /></td>
			<td align="left"><div style="height:100px;width:400px"><c:out value="${set.courseInfo.learingTarget}" escapeXml="" /></div></td>
		</tr>
		<tr>
			<td>학습비용</td>
			<td align="left"><div style="height:100px;width:400px"><c:out value="${set.courseInfo.learingCost}" escapeXml="" /></div></td>
		</tr>
		<tr>
			<td>학습비용</td>
			<td>${set.courseInfo.courseCost}</td>
		</tr>
		<tr>
			<td><spring:message code="lms.label.courseDate" text="-" /></td>
			<td>${set.courseInfo.cFromDate} ~ ${set.courseInfo.cToDate}</td>
		</tr>
	</table>
	
	<br>
	점수
	<table>
		<thead>
			<tr>
				<td>레포트 점수(${set.evaluation.reportRate})</td>
				<td>시험 점수(${set.evaluation.examRate})</td>
				<td>토론 점수(${set.evaluation.discussionRate})</td>
				<td>강의진도 점수(${set.evaluation.progressRate})</td>
				<td>합계 점수</td>
			</tr>
		</thead>
		<tbody>
			<tr>
				<td>${set.evaluation.reportCalc}</td>
				<td>${set.evaluation.examCalc}</td>
				<td>${set.evaluation.discussionCalc}</td>
				<td>${set.evaluation.progressCalc}</td>
				<td>${set.evaluation.total}</td>
			</tr>
		</tbody>
	</table>
	
	<br>
	진도
	<table>
		<thead>
			<tr>
				<td>주차</td>
				<td>진도율</td>
				<td>학습일자</td>
			</tr>
		</thead>
		<tbody>
			<c:forEach var="row" items="${set.week}" varStatus="idx">
	            <tr <c:if test="${idx.count%2 eq 1}"> class="alt"</c:if>>
					<td>${row.week}</td>
					<td>${row.progressRate}</td>
					<td>${row.studyStart} ~ ${row.studyEnd}</td>
				</tr>
			</c:forEach>
		</tbody>
	</table>
	
	
	<a href="#" onclick="f_list()"><img src="<c:url value="/resources/images/btn/btn_list.gif"/>"></a>
	<br>
</form>

<iframe name="tranFrame" style="display:none;"></iframe>

</body>
</html>


