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
var a;
function lfn_btn(pKind, pParam) {
	if ( pKind == "search" || pKind == "paging" || pKind == "refresh" ) {
		if ( pKind == "search" )
			$("#pageNum").val(1);
		else if ( pKind == "paging" )
			$("#pageNum").val(pParam.page);
		
		f_submitSelf(preUrl + "waitingApprovalNormalList");	
	} else if ( pKind == "confirm" ) {
		if ( confirm("입금 확인처리를 하시겠습니까?") == false )
			return false;
		
		$.ajax({
			type :"POST",
			url : context + preUrl + "paymentConfrm.do",
			dataType :"json",
			data : "courseId=" + pParam.courseId + '&userId=' + pParam.userId,
			success : function(json){
				if ( json.rtnMode == "UPDATE_OK") {
					alert("입금 확인처리 되었습니다.");
					lfn_btn("search");
				}
			},
			error : function(e) {
				alert("<spring:message code="lms.msg.systemError" text="-" />");
			}
		})
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

* 일반강좌 미입금 관리

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
					<th>입금할 금액</th>
					<th>입금할 은행</th>
					<th>확인</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach var="row" items="${set.list}" varStatus="idx">
		            <tr <c:if test="${idx.count%2 eq 1}"> class="alt"</c:if>>
		            	<td>${row.categoryName}</td>
		            	<td>${row.courseName}</td>
		            	<td>${row.chasu}</td>
		            	<td>${row.userName}</td>
		            	<td><fmt:formatNumber value="${row.paymentCost}" type="number"/></td>
		            	<td>${row.paymentBank}</td>
		            	<td><a href="#" onclick="javascript:lfn_btn('confirm',{courseId:'${row.courseId}',userId:'${row.userId}'}); return false;">확인</a></td>
		            </tr>
				</c:forEach>
			</tbody>
		</table>
		<div id="paging"></div>
	</div>
	
</form>

</body>
</html>


