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
		showOn: "button",
		beforeShow: function(input) {
		   	var i_offset= $(input).offset();
		   	setTimeout(function(){
		      	$('#ui-datepicker-div').css({'top':i_offset.top + 20 + document.body.scrollTop, 'bottom':'', 'left':i_offset.left});      //datepicker의 div의 포지션을 강제로 input 위치에 그리고 좌측은 모바일이여서 작기때문에 무조건 10px에 놓았다.
		   	})
		} 
	});
	$("#gToDate").datepicker({ 
		changeMonth: true,
		changeYear: true,
		yearRange:'<%=year%>:+5',
		showMonthAfterYear: true,
		autoSize: false,
		buttonImage: '<c:url value="/resources/datepicker/images/calendar.gif"/>',
		buttonImageOnly: true,
		showOn: "button",
		beforeShow: function(input) {
		   	var i_offset= $(input).offset();
		   	setTimeout(function(){
		      	$('#ui-datepicker-div').css({'top':i_offset.top + 20 + document.body.scrollTop, 'bottom':'', 'left':i_offset.left});      //datepicker의 div의 포지션을 강제로 input 위치에 그리고 좌측은 모바일이여서 작기때문에 무조건 10px에 놓았다.
		   	})
		} 
	});
	$("#cFromDate").datepicker({ 
		changeMonth: true,
		changeYear: true,
		yearRange:'<%=year%>:+5',
		showMonthAfterYear: true,
		autoSize: false,
		buttonImage: '<c:url value="/resources/datepicker/images/calendar.gif"/>',
		buttonImageOnly: true,
		showOn: "button",
		beforeShow: function(input) {
		   	var i_offset= $(input).offset();
		   	setTimeout(function(){
		      	$('#ui-datepicker-div').css({'top':i_offset.top + 20 + document.body.scrollTop, 'bottom':'', 'left':i_offset.left});      //datepicker의 div의 포지션을 강제로 input 위치에 그리고 좌측은 모바일이여서 작기때문에 무조건 10px에 놓았다.
		   	})
		} 
	});
	$("#cToDate").datepicker({ 
		changeMonth: true,
		changeYear: true,
		yearRange:'<%=year%>:+5',
		showMonthAfterYear: true,
		autoSize: false,
		buttonImage: '<c:url value="/resources/datepicker/images/calendar.gif"/>',
		buttonImageOnly: true,
		showOn: "button",
		beforeShow: function(input) {
		   	var i_offset= $(input).offset();
		   	setTimeout(function(){
		      	$('#ui-datepicker-div').css({'top':i_offset.top + 20 + document.body.scrollTop, 'bottom':'', 'left':i_offset.left});      //datepicker의 div의 포지션을 강제로 input 위치에 그리고 좌측은 모바일이여서 작기때문에 무조건 10px에 놓았다.
		   	})
		} 
	});
});


function lfn_btn(pKind, pParam) {
	if ( pKind == "refresh" ) {
		f_submitSelf("/courseManage/courseManageN",$("#frm").serialize());
	} else if ( pKind =="save" ) {
		if ( lfn_validate() == false )
			return false;
		
		btnUnbind("saveBtn");
		$.ajax({
			type :"POST",
			url : context +"/courseManage/courseManageNIns.do",
			dataType :"json",
			data : $("#frm").serialize(),
			success : function(json){
				if ( json.rtnMode == "INSERT_OK") {
					alert("<spring:message code="lms.msg.insertOk" text="-" />");
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
	if ( formValid.check("c1Code",{isNecess:true}) == false )
		return false;
	if ( formValid.check("c2Code",{isNecess:true}) == false )
		return false;
	if ( formValid.check("c3Code",{isNecess:true}) == false )
		return false;
	if ( formValid.check("courseCode",{isNecess:true}) == false )
		return false;
	
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

function lfn_category3Change() {
	$.ajax({
		type : "POST",
		url : context + "/common/ddCourseCode.do",
		dataType : "json",
		data : $("#frm").serialize(),
		success : function(json){
			$("#courseCode").html("");
			
			if ( json.length == 0 )
	 			$("#courseCode").append("<option value=''>" + resource.label.all + "</option>");
			else {
	 			$("#courseCode").append("<option value=''>" + resource.label.all + "</option>");
				for (var i = 0; i < json.length ; i++) {
					var obj = json[i];
					var opt = "";
					opt += "<option value='" + obj.ddKey + "'>";
					opt += obj.ddValue;
					opt += "</option>";
			 		$("#courseCode").append(opt);			
				}
			}
		},
		error : function(e) {
			alert(resource.msg.systemError);
		}
	})
}

</script>

<body>


* <spring:message code="lms.title.courseNew" text="-" />

<form id="frm" name="frm" action="" method="post">

	<table>
		<tr>
			<td><spring:message code="lms.label.category" text="-" /></td>
			<td>
				<select id="c1Code" name="c1Code" onchange="gfn_category1Change()">
	              	<option value="">전체</option>
					<c:forEach var="row" items="${set.ddCategory1Depth}">
		              	<option value="${row.ddKey}" <c:if test="${set.condiVO.c1Code eq row.ddKey}">selected</c:if>>${row.ddValue}</option>
					</c:forEach>
				</select>
				<select id="c2Code" name="c2Code" onchange="gfn_category2Change()">
	              	<option value="">전체</option>
	              	<c:forEach var="row" items="${set.ddCategory2Depth}">
		              	<option value="${row.ddKey}" <c:if test="${set.condiVO.c2Code eq row.ddKey}">selected</c:if>>${row.ddValue}</option>
					</c:forEach>
				</select>
				<select id="c3Code" name="c3Code" onchange="lfn_category3Change()">
	             	<option value="" selected>전체</option>
	             	<c:forEach var="row" items="${set.ddCategory3Depth}">
		              	<option value="${row.ddKey}" <c:if test="${set.condiVO.c3Code eq row.ddKey}">selected</c:if>>${row.ddValue}</option>
					</c:forEach>
				</select>
			</td>
		</tr>
		<tr>
			<td><spring:message code="lms.label.courseName" text="-" /></td>
			<td>
				<select id="courseCode" name="courseCode" onchange="lfn_btn('refresh')">
	              	<option value="">전체</option>
					<c:forEach var="row" items="${set.ddCourseCode}">
		              	<option value="${row.ddKey}" <c:if test="${set.condiVO.courseCode eq row.ddKey}">selected</c:if>>${row.ddValue}</option>
					</c:forEach>
				</select>
			</td>
		</tr>
		<tr>
			<td><spring:message code="lms.label.tutor" text="-" /></td>
			<td>
				<select id="tutorId" name="tutorId">
					<c:forEach var="row" items="${set.ddTutor}">
			             	<option value="${row.ddKey}" <c:if test="${set.cmData.tutorId eq row.ddKey}">selected</c:if>>${row.ddValue}</option>
					</c:forEach>
				</select>
			</td>
		</tr>
		<tr>
			<td><spring:message code="lms.label.learingGoal" text="-" /></td>
			<td align="left"><div style="height:100px;width:400px"><c:out value="${set.cmData.learingGoal}" escapeXml="" /></div></td>
		</tr>
		<tr>
			<td><spring:message code="lms.label.learingContent" text="-" /></td>
			<td align="left"><div style="height:100px;width:400px"><c:out value="${set.cmData.learingContent}" escapeXml="" /></div></td>
		</tr>
		<tr>
			<td><spring:message code="lms.label.evalMethod" text="-" /></td>
			<td align="left"><div style="height:100px;width:400px"><c:out value="${set.cmData.evalMethod}" escapeXml="" /></div></td>
		</tr>
		<tr>
			<td><spring:message code="lms.label.learingTarget" text="-" /></td>
			<td align="left"><div style="height:100px;width:400px"><c:out value="${set.cmData.learingTarget}" escapeXml="" /></div></td>
		</tr>
		<tr>
			<td><spring:message code="lms.label.learingCost" text="-" /></td>
			<td align="left"><div style="height:100px;width:400px"><c:out value="${set.cmData.learingCost}" escapeXml="" /></div></td>
		</tr>
		<tr>
			<td>과정비용</td>
			<td><input id="courseCost" name="courseCost" value="${set.cmData.courseCost}"/></td>
		</tr>
		<tr>
			<td><spring:message code="lms.label.gatherDate" text="-" /></td>
			<td>
				<input id="gFromDate" name="gFromDate" maxlength="10" size="10" class="datePicker" style="ime-mode:disabled;"/> ~ 
				<input id="gToDate" name="gToDate" maxlength="10" size="10" class="datePicker" style="ime-mode:disabled;"/>
			</td>
		</tr>
		<tr>
			<td><spring:message code="lms.label.courseDate" text="-" /></td>
			<td>
				<input id="cFromDate" name="cFromDate" maxlength="10" size="10" class="datePicker" style="ime-mode:disabled;"/> ~ 
				<input id="cToDate" name="cToDate" maxlength="10" size="10" class="datePicker" style="ime-mode:disabled;"/>
			</td>
		</tr>
		<tr>
			<td><spring:message code="lms.label.reportRate" text="-" /></td>
			<td><input id="reportRate" name="reportRate" maxlength="3" size="5" value="${set.cmData.reportRate}"/></td>
		</tr>
		<tr>
			<td><spring:message code="lms.label.examRate" text="-" /></td>
			<td><input id="examRate" name="examRate" maxlength="3" size="5" value="${set.cmData.examRate}" /></td>
		</tr>
		<tr>
			<td><spring:message code="lms.label.discusstionRate" text="-" /></td>
			<td><input id="discussionRate" name="discussionRate" maxlength="3" size="5" value="${set.cmData.discussionRate}" /></td>
		</tr>
		<tr>
			<td><spring:message code="lms.label.progressRate" text="-" /></td>
			<td><input id="progressRate" name="progressRate" maxlength="3" size="5" value="${set.cmData.progressRate}" /></td>
		</tr>
	</table>

		
	<br>
	<a href="#" id="saveBtn" onclick="javascript:lfn_btn('save'); return false;"><img src="<c:url value="/resources/images/btn/btn_save.gif"/>"></a>
	<a href="#" onclick="javascript:lfn_btn('list'); return false;"><img src="<c:url value="/resources/images/btn/btn_cancel.gif"/>"></a>
</form>


</body>
</html>


