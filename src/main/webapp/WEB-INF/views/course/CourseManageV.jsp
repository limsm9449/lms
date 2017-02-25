<%@ page contentType="text/html;charset=utf-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="FCK" uri="http://java.fckeditor.net" %>


<head>
<title>
</title>

<%@ include file="../common/commInclude.jsp" %>

</head>

<script type="text/javascript">

function lfn_btn(pKind, pParam) {
	if ( pKind == "update" ) {
		f_submitSelf("/courseManage/courseManageU",$("#courseId").val());
	} else if ( pKind =="delete" ) {
		btnUnbind("delBtn");
		$.ajax({
			type :"POST",
			url : context +"/courseManage/courseManageDel.do",
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
	} else if ( pKind == "list") {
		gfn_goPage("/courseManage/courseManageList",top.gCondition.courseManage.param);
	}
}

</script>

<body>


* <spring:message code="lms.title.courseView" text="-" />
	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;      
	<a href="#" onclick="javascript:Popup.showBoard('NOTICE','${set.data.courseId}'); return false;">공지사항</a>
	&nbsp;
	<a href="#" onclick="javascript:Popup.showBoard('FREE','${set.data.courseId}'); return false;">자유게시판</a>
	&nbsp;
	<a href="#" onclick="javascript:Popup.showBoard('DATA','${set.data.courseId}'); return false;">자료실</a>
	&nbsp;
	<a href="#" onclick="javascript:Popup.showBoard('QNA','${set.data.courseId}'); return false;">Q&A</a>
	&nbsp;
	<a href="#" onclick="javascript:Popup.showBoard('REPORT','${set.data.courseId}'); return false;">레포트</a>
	&nbsp;
	<a href="#" onclick="javascript:Popup.showBoard('DISCUSSION','${set.data.courseId}'); return false;">토론게시판</a>
	&nbsp;

<form id="frm" name="frm" action="" method="post">
	<table>
		<tr>
			<td><spring:message code="lms.label.category" text="-" /></td>
			<td>${set.data.categoryName}</td>
		</tr>
		<tr>
			<td><spring:message code="lms.label.courseName" text="-" /></td>
			<td>
				<input id="courseId" name="courseId" type="hidden" value="${set.data.courseId}"/>
				${set.data.courseName}
			</td>
		</tr>
		<tr>
			<td><spring:message code="lms.label.chasu" text="-" /></td>
			<td>${set.data.chasu}</td>
		</tr>
		<tr>
			<td><spring:message code="lms.label.tutor" text="-" /></td>
			<td>${set.data.tutorName}</td>
		</tr>
		<tr>
			<td><spring:message code="lms.label.courseStatus" text="-" /></td>
			<td>${set.data.statusName}</td>
		</tr>
		<tr>
			<td><spring:message code="lms.label.learingGoal" text="-" /></td>
			<td align="left"><div style="width:400px"><c:out value="${set.data.learingGoal}" escapeXml="" /></div></td>
		</tr>
		<tr>
			<td><spring:message code="lms.label.learingContent" text="-" /></td>
			<td align="left"><div style="width:400px"><c:out value="${set.data.learingContent}" escapeXml="" /></div></td>
		</tr>
		<tr>
			<td><spring:message code="lms.label.evalMethod" text="-" /></td>
			<td align="left"><div style="width:400px"><c:out value="${set.data.evalMethod}" escapeXml="" /></div></td>
		</tr>
		<tr>
			<td><spring:message code="lms.label.learingTarget" text="-" /></td>
			<td align="left"><div style="width:400px"><c:out value="${set.data.learingTarget}" escapeXml="" /></div></td>
		</tr>
		<tr>
			<td><spring:message code="lms.label.learingCost" text="-" /></td>
			<td align="left"><div style="width:400px"><c:out value="${set.data.learingCost}" escapeXml="" /></div></td>
		</tr>
		<tr>
			<td>과정비용</td>
			<td><fmt:formatNumber value="${set.data.courseCost}" type="number"/></td>
		</tr>
		<tr>
			<td><spring:message code="lms.label.gatherDate" text="-" /></td>
			<td>${set.data.gFromDate} ~ ${set.data.gToDate}</td>
		</tr>
		<tr>
			<td><spring:message code="lms.label.courseDate" text="-" /></td>
			<td>${set.data.cFromDate} ~ ${set.data.cToDate}</td>
		</tr>
		<tr>
			<td><spring:message code="lms.label.reportRate" text="-" /></td>
			<td>${set.data.reportRate}</td>
		</tr>
		<tr>
			<td><spring:message code="lms.label.examRate" text="-" /></td>
			<td>${set.data.examRate}</td>
		</tr>
		<tr>
			<td><spring:message code="lms.label.discusstionRate" text="-" /></td>
			<td>${set.data.discussionRate}</td>
		</tr>
		<tr>
			<td><spring:message code="lms.label.progressRate" text="-" /></td>
			<td>${set.data.progressRate}</td>
		</tr>
	</table>


	<br>
	<a href="#" onclick="javascript:lfn_btn('update'); return false;"><img src="<c:url value="/resources/images/btn/btn_update.gif"/>"></a>
	<c:if test="${set.data.aCnt eq 0}">
		<a href="#" id="delBtn" onclick="javascript:lfn_btn('delete'); return false;"><img src="<c:url value="/resources/images/btn/btn_delete.gif"/>"></a>
	</c:if>
	<a href="#" onclick="javascript:lfn_btn('list'); return false;"><img src="<c:url value="/resources/images/btn/btn_cancel.gif"/>"></a>

</form>


</body>
</html>


