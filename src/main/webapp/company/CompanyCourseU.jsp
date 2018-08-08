<%@ page contentType="text/html;charset=utf-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
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

$(document).ready(function() {
});


function lfn_btn(pKind, pParam) {
	if ( pKind =="save" ) {
		if ( lfn_validate() == false )
			return false;
		
		if ( confirm("수정하시겠습니까?") == true ) {
			btnUnbind("saveBtn");
			$.ajax({
				type :"POST",
				url : context +"/companyCourse/companyCourseUUpd.do",
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
		}
	} else if ( pKind == "list") {
		gfn_goPage("/companyCourse/companyCourseList",top.gCondition.companyCourse.param);
	}
}

function lfn_validate() {
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
	
<c:if test="${set.data.weekCostYn eq 'Y'}">
	var weekCosts = $("[id=weekCosts]");
	for ( i = 0; i < weekCosts.length; i++ ) {
		if ( formValid.check("weekCosts",{isNecess:true,isNum:true},i) == false )
			return false;
	}
</c:if>
	
	return true;
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
	          		<li>기업 강좌 관리</li>
	          		<li class="last">강좌 관리</li>
        		</ul>
			</div>

			<div id="article">
				<%-- 조건 --%>
		    	<h3 class="title">강좌 수정</h3>

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
							<td class="no_line">${set.data.categoryName}</td>
						</tr>
						<tr>
							<th><spring:message code="lms.label.courseName" text="-" /></th>
							<td class="no_line">
								<input id="courseId" name="courseId" type="hidden" value="${set.data.courseId}"/>${set.data.courseName}
							</td>
						</tr>
						<tr>
							<th><spring:message code="lms.label.companyName" text="-" /></th>
							<td class="no_line">${set.data.compName}</td>
						</tr>
						<tr>
							<th>과정비용유형</th>
							<td class="no_line"><input id="weekCostYn" name="weekCostYn" type="hidden" value="${set.data.weekCostYn}"/>${set.data.weekCostYnName}</td>
						</tr>
						<tr>
							<th><spring:message code="lms.label.learingGoal" text="-" /></th>
							<td class="no_line"><div style="width:400px"><c:out value="${set.data.learingGoal}" escapeXml="" /></div></td>
						</tr>
						<tr>
							<th><spring:message code="lms.label.learingContent" text="-" /></th>
							<td class="no_line"><div style="width:400px"><c:out value="${set.data.learingContent}" escapeXml="" /></div></td>
						</tr>
						<tr>
							<th><spring:message code="lms.label.evalMethod" text="-" /></th>
							<td class="no_line"><div style="width:400px"><c:out value="${set.data.evalMethod}" escapeXml="" /></div></td>
						</tr>
						<tr>
							<th><spring:message code="lms.label.learingTarget" text="-" /></th>
							<td class="no_line"><div style="width:400px"><c:out value="${set.data.learingTarget}" escapeXml="" /></div></td>
						</tr>
						<tr>
							<th><spring:message code="lms.label.learingCost" text="-" /></th>
							<td class="no_line"><div style="width:400px"><c:out value="${set.data.learingCost}" escapeXml="" /></div></td>
						</tr>
						<tr>
							<th>과정비용</th>
							<td class="no_line"><input id="courseCost" name="courseCost" value="${set.data.courseCost}"/></td>
						</tr>
<c:if test="${set.data.weekCostYn eq 'Y'}">
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
									<option value="Y" <c:if test="${set.data.openYn eq 'Y'}">selected</c:if>>Y</option>
									<option value="N" <c:if test="${set.data.openYn eq 'N'}">selected</c:if>>N</option>
								</select>
							</td>
						</tr>
						<tr>
							<th>교육일수</th>
							<td class="no_line"><input id="cPeriod" name="cPeriod" maxlength="3" size="5" value="<c:out value="${set.data.cPeriod}" escapeXml="" />"/></td>
						</tr>
				
						<tr>
							<th><spring:message code="lms.label.reportRate" text="-" /></th>
							<td class="no_line"><input id="reportRate" name="reportRate" maxlength="3" size="5" value="<c:out value="${set.data.reportRate}" escapeXml="" />"/></td>
						</tr>
						<tr>
							<th><spring:message code="lms.label.examRate" text="-" /></th>
							<td class="no_line"><input id="examRate" name="examRate" maxlength="3" size="5" value="<c:out value="${set.data.examRate}" escapeXml="" />" /></td>
						</tr>
						<tr>
							<th><spring:message code="lms.label.discusstionRate" text="-" /></th>
							<td class="no_line"><input id="discussionRate" name="discussionRate" maxlength="3" size="5" value="<c:out value="${set.data.discussionRate}" escapeXml="" />" /></td>
						</tr>
						<tr>
							<th><spring:message code="lms.label.progressRate" text="-" /></th>
							<td class="no_line"><input id="progressRate" name="progressRate" maxlength="3" size="5" value="<c:out value="${set.data.progressRate}" escapeXml="" />" /></td>
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


