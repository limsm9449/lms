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
$(document).ready(function() {
		f_makePageNavigator("paging",${set.condiVO.pageNum},${set.totalCount},${set.pageUnit});
	} 
);

function lfn_btn(pKind, pParam) {
	if ( pKind == "search" || pKind == "paging" || pKind == "refresh" ) {
		if ( pKind == "search" )
			$("#pageNum").val(1);
		else if ( pKind == "paging" )
			$("#pageNum").val(pParam.page);
		
		f_submitSelf("/courseManage/courseManageList");	
	} else if ( pKind == "new" ) {
		lfn_setCondition();
		
		gfn_goPage("/courseManage/courseManageN");
	} else if ( pKind == "view") {
		lfn_setCondition();
		
		gfn_goPage("/courseManage/courseManageV","courseId=" + pParam.courseId);
	}
}

function lfn_setCondition() {
	top.gCondition.courseManage = {
		param : "c1Code=" + $("#c1Code").val() + 
				"&c2Code=" + $("#c2Code").val() + 
				"&c3Code=" + $("#c3Code").val() +
				"&courseCode=" + $("#courseCode").val() +
				"&pageNum=" + $("#pageNum").val()
	}	
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

* <spring:message code="lms.title.courseManage" text="-" />
<form id="frm" name="frm" method="post">
	<div>
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
				<td><spring:message code="lms.label.courseName" text="-" /></td>
				<td>
					<select id="courseCode" name="courseCode">
		              	<option value="">전체</option>
						<c:forEach var="row" items="${set.ddCourseCode}">
			              	<option value="${row.ddKey}" <c:if test="${set.condiVO.courseCode eq row.ddKey}">selected</c:if>>${row.ddValue}</option>
						</c:forEach>
					</select>
				</td>
				<td><spring:message code="lms.label.status" text="-" /></td>
				<td>
					<select id="status" name="status">
		             	<option value="" selected>전체</option>
						<c:forEach var="row" items="${set.ddStatus}">
			             	<option value="${row.ddKey}" <c:if test="${row.ddKey eq set.condiVO.status}">selected</c:if>>${row.ddValue}</option>
						</c:forEach>
					</select>
				</td>
			</tr>
		</table>  
		<div align="right"><a href="#" onclick="javascript:lfn_btn('search');return false;"><img src="<c:url value="/resources/images/btn/btn_search.gif"/>"></a></div>
		<table>
			<thead>
				<tr>
					<th><spring:message code="lms.label.category" text="-" /></th>
					<th><spring:message code="lms.label.courseName" text="-" /></th>
					<th><spring:message code="lms.label.tutor" text="-" /></th>
					<th><spring:message code="lms.label.chasu" text="-" /></th>
					<th><spring:message code="lms.label.courseStatus" text="-" /></th>
					<th><spring:message code="lms.label.gatherDate" text="-" /></th>
					<th><spring:message code="lms.label.courseDate" text="-" /></th>
					<th><spring:message code="lms.label.beforeApproval" text="-" /></th>
					<th><spring:message code="lms.label.approval" text="-" /></th>
				</tr>
			</thead>
			<tbody>
				<c:if test="${empty set.list}">
					<tr>
						<td colspan="9" class="no_line center"><spring:message code="lms.msg.noSearchData" text="-" /></td>
					</tr>
				</c:if>
				<c:forEach var="row" items="${set.list}" varStatus="idx">
		            <tr <c:if test="${idx.count%2 eq 1}"> class="alt"</c:if>>
		            	<td>${row.categoryName}</td>
		            	<td><a href="#" onclick="javascript:lfn_btn('view',{courseId:'${row.courseId}'}); return false;" class="click">${row.courseName}</a></td>
		            	<td>${row.tutorName}</td>
		            	<td>${row.chasu}</td>
		            	<td>${row.statusName}</td>
		            	<td>${row.gFromDate} ~ ${row.gToDate}</td>
		            	<td>${row.cFromDate} ~ ${row.cToDate}</td>
		            	<td>${row.yCnt}</td>
		            	<td>${row.aCnt}</td>
		            </tr>
				</c:forEach>
			</tbody>
		</table>
		<div id="paging"></div>
	</div>
	
	<a href="#" onclick="javascript:lfn_btn('new'); return false;"><img src="<c:url value="/resources/images/btn/btn_create.gif"/>"></a>
	
</form>


</body>
</html>


