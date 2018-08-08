<%@ page contentType="text/html;charset=utf-8"%>
<%@ page import="java.util.Calendar"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="FCK" uri="http://java.fckeditor.net" %>


<head>
<title>
</title>

<%@ include file="../common/commAdminInclude.jsp" %>

</head>

<script type="text/javascript">

<%
	Calendar c = Calendar.getInstance();
	String year = Integer.toString(c.get(Calendar.YEAR));
%>


$(document).ready(function() {
	$("#gFromDate").datepicker({ 
		changeMonth: true,
		changeYear: true,
		yearRange:'<%=year%>:+5',
		showMonthAfterYear: true,
		autoSize: false,
		buttonImage: '<c:url value="/resources/datepicker/images/calendar.gif"/>',
		buttonImageOnly: true,
		showOn: "button"
	});
	$("#gToDate").datepicker({ 
		changeMonth: true,
		changeYear: true,
		yearRange:'<%=year%>:+5',
		showMonthAfterYear: true,
		autoSize: false,
		buttonImage: '<c:url value="/resources/datepicker/images/calendar.gif"/>',
		buttonImageOnly: true,
		showOn: "button"
	});
	$("#cFromDate").datepicker({ 
		changeMonth: true,
		changeYear: true,
		yearRange:'<%=year%>:+5',
		showMonthAfterYear: true,
		autoSize: false,
		buttonImage: '<c:url value="/resources/datepicker/images/calendar.gif"/>',
		buttonImageOnly: true,
		showOn: "button"
	});
	$("#cToDate").datepicker({ 
		changeMonth: true,
		changeYear: true,
		yearRange:'<%=year%>:+5',
		showMonthAfterYear: true,
		autoSize: false,
		buttonImage: '<c:url value="/resources/datepicker/images/calendar.gif"/>',
		buttonImageOnly: true,
		showOn: "button"
	});
});


function lfn_btn(pKind, pParam) {
	if ( pKind =="save" ) {
		if ( lfn_validate() == false )
			return false;
		
		btnUnbind("saveBtn");
		$.ajax({
			type :"POST",
			url : context +"/courseManage/courseManageUUpd.do",
			dataType :"json",
			data : $("#frm").serialize(),
			success : function(json){
				if ( json.rtnMode == "UPDATE_OK") {
					alert("<spring:message code="lms.msg.updateOk" text="-" />");
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

function lfn_validate() {
	if ($("#gFromDate").val() == "") {
	    alert('일자를 입력해주세요.');
	    $("#gFromDate").select();
	    return false;
	}  
	if ($("#gToDate").val() == "") {
	    alert('일자를 입력해주세요.');
	    $("#gToDate").select();
	    return false;
	}  
	if ($("#cFromDate").val() == "") {
	    alert('일자를 입력해주세요.');
	    $("#cFromDate").select();
	    return false;
	}  
	if ($("#cToDate").val() == "") {
	    alert('일자를 입력해주세요.');
	    $("#cToDate").select();
	    return false;
	}  

	if ( formValid.check("courseCost",{isNecess:true,isNum:true}) == false )
		return false;
	if ( formValid.check("reportRate",{isNecess:true,isNum:true}) == false )
		return false;
	if ( formValid.check("examRate",{isNecess:true,isNum:true}) == false )
		return false;
	if ( formValid.check("discussionRate",{isNecess:true,isNum:true}) == false )
		return false;
	if ( formValid.check("progressRate",{isNecess:true,isNum:true}) == false )
		return false;
	if ( parseInt($("#reportRate").val(),10) + parseInt($("#examRate").val(),10) +
			 parseInt($("#discussionRate").val(),10) + parseInt($("#progressRate").val(),10) != 100 ) {
		alert("점수 비율은 100 이여야 합니다.")
		return false;
	}
	
	return true;
}


</script>

<body>


* <spring:message code="lms.title.courseUpdate" text="-" />

<form id="frm" name="frm" action="" method="post">

	<table>
		<tr>
			<td><spring:message code="lms.label.category" text="-" /></td>
			<td>${set.data.categoryName}</td>
		</tr>
		<tr>
			<td><spring:message code="lms.label.courseName" text="-" /></td>
			<td>
				<input id="courseId" name="courseId" type="hidden" value="${set.data.courseId}"/>${set.data.courseName}
			</td>
		</tr>
		<tr>
			<td><spring:message code="lms.label.tutor" text="-" /></td>
			<td>
				<select id="tutorId" name="tutorId">
					<c:forEach var="row" items="${set.ddTutor}">
			             	<option value="${row.ddKey}" <c:if test="${set.data.tutorId eq row.ddKey}">selected</c:if>>${row.ddValue}</option>
					</c:forEach>
				</select>
			</td>
		</tr>
		<tr>
			<td><spring:message code="lms.label.learingGoal" text="-" /></td>
			<td align="left"><div style="height:100px;width:400px"><c:out value="${set.data.learingGoal}" escapeXml="" /></div></td>
		</tr>
		<tr>
			<td><spring:message code="lms.label.learingContent" text="-" /></td>
			<td align="left"><div style="height:100px;width:400px"><c:out value="${set.data.learingContent}" escapeXml="" /></div></td>
		</tr>
		<tr>
			<td><spring:message code="lms.label.evalMethod" text="-" /></td>
			<td align="left"><div style="height:100px;width:400px"><c:out value="${set.data.evalMethod}" escapeXml="" /></div></td>
		</tr>
		<tr>
			<td><spring:message code="lms.label.learingTarget" text="-" /></td>
			<td align="left"><div style="height:100px;width:400px"><c:out value="${set.data.learingTarget}" escapeXml="" /></div></td>
		</tr>
		<tr>
			<td><spring:message code="lms.label.learingCost" text="-" /></td>
			<td align="left"><div style="height:100px;width:400px"><c:out value="${set.data.learingCost}" escapeXml="" /></div></td>
		</tr>
		<tr>
			<td>과정비용</td>
			<td><input id="progressRate" name="progressRate" value="${set.data.courseCost}"/></td>
		</tr>
		<tr>
			<td><spring:message code="lms.label.gatherDate" text="-" /></td>
			<td>
				<input id="gFromDate" name="gFromDate" maxlength="10" size="10" class="datePicker" style="ime-mode:disabled;" value="<c:out value="${set.data.gFromDate}" escapeXml="" />"/> ~ 
				<input id="gToDate" name="gToDate" maxlength="10" size="10" class="datePicker" style="ime-mode:disabled;" value="<c:out value="${set.data.gToDate}" escapeXml="" />"/>
			</td>
		</tr>
		<tr>
			<td><spring:message code="lms.label.courseDate" text="-" /></td>
			<td>
				<input id="cFromDate" name="cFromDate" maxlength="10" size="10" class="datePicker" style="ime-mode:disabled;" value="<c:out value="${set.data.cFromDate}" escapeXml="" />"/> ~ 
				<input id="cToDate" name="cToDate" maxlength="10" size="10" class="datePicker" style="ime-mode:disabled;" value="<c:out value="${set.data.cToDate}" escapeXml="" />"/>
			</td>
		</tr>
		<tr>
			<td><spring:message code="lms.label.reportRate" text="-" /></td>
			<td><input id="reportRate" name="reportRate" maxlength="3" size="5" value="<c:out value="${set.data.reportRate}" escapeXml="" />"/></td>
		</tr>
		<tr>
			<td><spring:message code="lms.label.examRate" text="-" /></td>
			<td><input id="examRate" name="examRate" maxlength="3" size="5" value="<c:out value="${set.data.examRate}" escapeXml="" />" /></td>
		</tr>
		<tr>
			<td><spring:message code="lms.label.discusstionRate" text="-" /></td>
			<td><input id="discussionRate" name="discussionRate" maxlength="3" size="5" value="<c:out value="${set.data.discussionRate}" escapeXml="" />" /></td>
		</tr>
		<tr>
			<td><spring:message code="lms.label.progressRate" text="-" /></td>
			<td><input id="progressRate" name="progressRate" maxlength="3" size="5" value="<c:out value="${set.data.progressRate}" escapeXml="" />" /></td>
		</tr>
	</table>

		
	<br>
	<a href="#" id="saveBtn" onclick="javascript:lfn_btn('save'); return false;"><img src="<c:url value="/resources/images/btn/btn_save.gif"/>"></a>
	<a href="#" onclick="javascript:lfn_btn('list'); return false;"><img src="<c:url value="/resources/images/btn/btn_cancel.gif"/>"></a>
</form>


</body>
</html>


