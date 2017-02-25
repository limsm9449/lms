<%@ page contentType="text/html;charset=utf-8"%>
<%@ page import="java.util.Calendar"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
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

<%
	Calendar c = Calendar.getInstance();
	String year = Integer.toString(c.get(Calendar.YEAR));
%>


$(document).ready(function() {
});


function lfn_btn(pKind, pParam) {
	if ( pKind == "refresh" ) {
		f_submitSelf("/normalCourse/normalCourseN",$("#frm").serialize());
	} else if ( pKind =="save" ) {
		if ( lfn_validate() == false )
			return false;
		
		if ( confirm("생성하시겠습니까?") == true ) {
			btnUnbind("saveBtn");
			$.ajax({
				type :"POST",
				url : context +"/normalCourse/normalCourseNIns.do",
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
		}
	} else if ( pKind == "list") {
		gfn_goPage("/normalCourse/normalCourseList",top.gCondition.normalCourse.param);
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
	if ( formValid.check("courseCost",{isNecess:true,isNum:true}) == false )
		return false;
	if ( formValid.check("cPeriod",{isNecess:true,isNum:true}) == false )
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
	
<c:if test="${set.cmData.weekCostYn eq 'Y'}">
	var weekCosts = $("[id=weekCosts]");
	for ( i = 0; i < weekCosts.length; i++ ) {
		if ( formValid.check("weekCosts",{isNecess:true,isNum:true},i) == false )
			return false;
	}
</c:if>

	return true;
}

function lfn_category3Change() {
	$.ajax({
		type : "POST",
		url : context + "/common/ddCourseCodeForUse.do",
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
		    	<h3 class="title">강좌 생성</h3>

				<table class="input">
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
							<td class="no_line">
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
							<th><spring:message code="lms.label.courseName" text="-" /></th>
							<td class="no_line">
								<select id="courseCode" name="courseCode" onchange="lfn_btn('refresh')">
					              	<option value="">전체</option>
									<c:forEach var="row" items="${set.ddCourseCode}">
						              	<option value="${row.ddKey}" <c:if test="${set.condiVO.courseCode eq row.ddKey}">selected</c:if>>${row.ddValue}</option>
									</c:forEach>
								</select>
							</td>
						</tr>
						<tr>
							<th><spring:message code="lms.label.tutor" text="-" /></th>
							<td class="no_line">
								<select id="tutorId" name="tutorId">
									<c:forEach var="row" items="${set.ddTutor}">
							             	<option value="${row.ddKey}" <c:if test="${set.cmData.tutorId eq row.ddKey}">selected</c:if>>${row.ddValue}</option>
									</c:forEach>
								</select>
							</td>
						</tr>
						<tr>
							<th>과정비용유형</th>
							<td class="no_line"><input id="weekCostYn" name="weekCostYn" type="hidden" value="${set.cmData.weekCostYn}"/>${set.cmData.weekCostYnName}</td>
						</tr>
						<tr>
							<th><spring:message code="lms.label.learingGoal" text="-" /></th>
							<td class="no_line"><div style="width:400px"><c:out value="${set.cmData.learingGoal}" escapeXml="" /></div></td>
						</tr>
						<tr>
							<th><spring:message code="lms.label.learingContent" text="-" /></th>
							<td class="no_line"><div style="width:400px"><c:out value="${set.cmData.learingContent}" escapeXml="" /></div></td>
						</tr>
						<tr>
							<th><spring:message code="lms.label.evalMethod" text="-" /></th>
							<td class="no_line"><div style="width:400px"><c:out value="${set.cmData.evalMethod}" escapeXml="" /></div></td>
						</tr>
						<tr>
							<th><spring:message code="lms.label.learingTarget" text="-" /></th>
							<td class="no_line"><div style="width:400px"><c:out value="${set.cmData.learingTarget}" escapeXml="" /></div></td>
						</tr>
						<tr>
							<th><spring:message code="lms.label.learingCost" text="-" /></th>
							<td class="no_line"><div style="width:400px"><c:out value="${set.cmData.learingCost}" escapeXml="" /></div></td>
						</tr>
						<tr>
							<th>과정비용</th>
							<td class="no_line"><input id="courseCost" name="courseCost" value="${set.cmData.courseCost}"/></td>
						</tr>
<c:if test="${set.cmData.weekCostYn eq 'Y'}">
						<tr>
							<th>차시별 비용</th>
							<td class="textbox no_line">
								<table>
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
											<td>${row.week}. ${row.title}</td>
											<td class="no_line"><input type="hidden" id="weeks" name="weeks" value="${row.week}"/><input id="weekCosts" name="weekCosts" value="${row.weekCost}" style="width:70px"/></td>
										</tr>
										</c:forEach>
								</table>
							</td>
						</tr>
</c:if>							
						<tr>
							<th>오픈여부</th>
							<td class="no_line">
								<select id="openYn" name="openYn">
									<option value="Y">Y</option>
									<option value="N" selected>N</option>
								</select>
							</td>
						</tr>
						<tr>
							<th>교육일수</th>
							<td class="no_line"><input id="cPeriod" name="cPeriod" maxlength="3" size="5" value="30"/></td>
						</tr>
						<tr>
							<th><spring:message code="lms.label.reportRate" text="-" /></th>
							<td class="no_line"><input id="reportRate" name="reportRate" maxlength="3" size="5" value="${set.cmData.reportRate}"/></td>
						</tr>
						<tr>
							<th><spring:message code="lms.label.examRate" text="-" /></th>
							<td class="no_line"><input id="examRate" name="examRate" maxlength="3" size="5" value="${set.cmData.examRate}" /></td>
						</tr>
						<tr>
							<th><spring:message code="lms.label.discusstionRate" text="-" /></th>
							<td class="no_line"><input id="discussionRate" name="discussionRate" maxlength="3" size="5" value="${set.cmData.discussionRate}" /></td>
						</tr>
						<tr>
							<th><spring:message code="lms.label.progressRate" text="-" /></th>
							<td class="no_line"><input id="progressRate" name="progressRate" maxlength="3" size="5" value="${set.cmData.progressRate}" /></td>
						</tr>
					</tbody>
				</table>
				
				<%-- 하단버튼 --%>
		  		<div class="tool_btn">
					<a href="#" id="saveBtn" onclick="javascript:lfn_btn('save'); return false;" class="blueBtn">저장</a>
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


