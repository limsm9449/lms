<%@ page contentType="text/html;charset=utf-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<head>
<title>
</title>


<%@ include file="../common/commInclude.jsp" %>


</head>

<script type="text/javascript">
$(document).ready(function() {
		f_makePageNavigator("paging",${set.condiVO.pageNum},${set.totalCount},${set.pageUnit});
	} 
);

var preUrl = "/approvalNormal/"; 

function lfn_btn(pKind, pParam) {
	if ( pKind == "search" || pKind == "paging" || pKind == "refresh" ) {
		if ( pKind == "search" )
			$("#pageNum").val(1);
		else if ( pKind == "paging" )
			$("#pageNum").val(pParam.page);
		
		f_submitSelf(preUrl + "refundUserList");	
	} else if ( pKind == "refund" ) {
		gfn_popup(preUrl + "approvalNormalRefundP","courseId="+pParam.courseId+"&userId="+pParam.userId,400,300);
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

* 일반강좌 환불 관리

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
			</tr>
		</table>  
		<div align="right"><a href="#" onclick="javascript:lfn_btn('search');return false;"><img src="<c:url value="/resources/images/btn/btn_search.gif"/>"></a></div>
		<table>
			<thead>
				<tr>
					<th>카테고리</th>
					<th>과정명</th>
					<th>차수</th>
					<th>신청자명</th>
					<th>지불 금액</th>
					<th>지불 일자</th>
					<th>환불 금액</th>
					<th>환불 은행</th>
					<th>환불 계좌번호</th>
					<th>환불 일자</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach var="row" items="${set.list}" varStatus="idx">
		            <tr <c:if test="${idx.count%2 eq 1}"> class="alt"</c:if>>
		            	<td>${row.categoryName}</td>
		            	<td><a href="#" onclick="javascript:Popup.showCourseMaster('${row.courseCode}'); return false;">${row.courseName}</a></td>
		            	<td><a href="#" onclick="javascript:Popup.showCourse('${row.courseId}','${row.chasu}'); return false;">${row.chasu}</a></td>
		            	<td>${row.userName}</td>
		            	<td><fmt:formatNumber value="${row.paymentCost}" type="number"/></td>
		            	<td>${row.paymentDate}</td>
		            	<td><fmt:formatNumber value="${row.refundCost}" type="number"/></td>
		            	<td>${row.refundBank}</td>
		            	<td>${row.refundAccNum}</td>
		            	<td>${row.refundDate}</td>
		            </tr>
				</c:forEach>
			</tbody>
		</table>
		<div id="paging"></div>
	</div>
	
</form>

</body>
</html>


