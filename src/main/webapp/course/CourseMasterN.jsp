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
	$("#learingGoal").cleditor({height:170});
	$("#learingContent").cleditor({height:170});
	$("#evalMethod").cleditor({height:170});
	$("#learingTarget").cleditor({height:170});
	$("#learingCost").cleditor({height:170});
});

function lfn_btn(pKind, pParam) {
	if ( pKind == "refresh" ) {
		f_submitSelf("/courseMaster/courseMasterN",$("#frm").serialize());
	} else if ( pKind =="save" ) {
		if ( lfn_validate() == false )
			return false;
		
		if ( confirm("생성하시겠습니까?") == true ) {
			btnUnbind("saveBtn");
			$.ajax({
				type :"POST",
				url : context +"/courseMaster/courseMasterNIns.do",
				dataType :"json",
				data : $("#frm").serialize(),
				success : function(json){
					if ( json.rtnMode == "EXIST") {
						alert("<spring:message code="lms.msg.existData" text="-" />");
						btnBind("saveBtn");
					} else if ( json.rtnMode == "INSERT_OK") {
						alert("<spring:message code="lms.msg.insertOk" text="-" />");
						lfn_btn("list");
					}
				},
				error : function(e) {
					alert("<spring:message code="lms.msg.systemError" text="-" />");
				}
			})
		}
	} else if ( pKind =="list" ) {
		gfn_goPage('/courseMaster/courseMasterList'); 
	}
}

function lfn_validate() {
	if ( formValid.check("courseCode",{isNecess:true}) == false )
		return false;
	if ( formValid.check("tutorId",{isNecess:true}) == false )
		return false;
	
	if ($('learingGoal').val() == "") {
	    alert('내용을 입력해주세요.');
	    $('learingGoal').Focus();
	    return false;
	}   
	if ($('learingContent').val() == "") {
	    alert('내용을 입력해주세요.');
	    $('learingContent').Focus();
	    return false;
	}   
	if ($('evalMethod').val() == "") {
	    alert('내용을 입력해주세요.');
	    $('evalMethod').Focus();
	    return false;
	}   
	if ($('learingTarget').val() == "") {
	    alert('내용을 입력해주세요.');
	    $('learingTarget').Focus();
	    return false;
	}   
	if ($('learingCost').val() == "") {
	    alert('내용을 입력해주세요.');
	    $('learingCost').Focus();
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
	
	if ( checkByte($('learingGoal').val()) > course_contents_length ) {
		alert("입력 가능한 자릿수를 넘었습니다.");
		$('learingGoal').Focus();
		return false;
	}
	if ( checkByte($('learingContent').val()) > course_contents_length ) {
		alert("입력 가능한 자릿수를 넘었습니다.");
		$('learingContent').Focus();
		return false;
	}
	if ( checkByte($('evalMethod').val()) > course_contents_length ) {
		alert("입력 가능한 자릿수를 넘었습니다.");
		$('evalMethod').Focus();
		return false;
	}
	if ( checkByte($('learingTarget').val()) > course_contents_length ) {
		alert("입력 가능한 자릿수를 넘었습니다.");
		$('learingTarget').Focus();
		return false;
	}
	if ( checkByte($('learingCost').val()) > course_contents_length ) {
		alert("입력 가능한 자릿수를 넘었습니다.");
		$('learingCost').Focus();
		return false;
	}
	
<c:if test="${set.condiVO.weekCostYn eq 'Y'}">
	var weekCosts = $("[id=weekCosts]");
	for ( i = 0; i < weekCosts.length; i++ ) {
		if ( formValid.check("weekCosts",{isNecess:true,isNum:true},i) == false )
			return false;
	}
</c:if>	
}


</script>

<body>

<form id="frm" name="frm" action="" method="post">

<div id="wrap">
	<div id="container">
    	<div id="contents">
      		<div id="content_head">
        		<h1 class="title">과정 Master 관리</h1>
        		<ul class="gnb">
	          		<li>HOME</li>
	          		<li>강좌 관리</li>
	          		<li class="last">과정 Master 관리</li>
        		</ul>
			</div>

			<div id="article">
		    	<h3 class="title">과정 Master 생성</h3>
		    	
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
							<th><spring:message code="lms.label.courseName" text="-" /></th>
							<td class="no_line">
								<select id="courseCode" name="courseCode" onchange="lfn_btn('refresh')">
									<option value="">선택</option>
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
									<option value="">선택</option>
									<c:forEach var="row" items="${set.ddTutor}">
							             	<option value="${row.ddKey}" <c:if test="${set.condiVO.tutorId eq row.ddKey}">selected</c:if>>${row.ddValue}</option>
									</c:forEach>
								</select>
							</td>
						</tr>
						<tr>
							<th>과정비용유형</th>
							<td class="no_line">
								<select id="weekCostYn" name="weekCostYn" onchange="lfn_btn('refresh')">
									<c:forEach var="row" items="${set.ddWeekCost}">
							             	<option value="${row.ddKey}" <c:if test="${set.condiVO.weekCostYn eq row.ddKey}">selected</c:if>>${row.ddValue}</option>
									</c:forEach>
								</select>
							</td>
						</tr>
						<tr>
							<th><spring:message code="lms.label.learingGoal" text="-" /></th>
							<td class="textbox no_line">
								<textarea id="learingGoal" name="learingGoal"></textarea>
							</td>
						</tr>
						<tr>
							<th><spring:message code="lms.label.learingContent" text="-" /></th>
							<td class="textbox no_line">
								<textarea id="learingContent" name="learingContent"></textarea>
							</td>
						</tr>
						<tr>
							<th><spring:message code="lms.label.evalMethod" text="-" /></th>
							<td class="textbox no_line">
								<textarea id="evalMethod" name="evalMethod"></textarea>
							</td>
						</tr>
						<tr>
							<th><spring:message code="lms.label.learingTarget" text="-" /></th>
							<td class="textbox no_line">
								<textarea id="learingTarget" name="learingTarget"></textarea>
							</td>
						</tr>
						<tr>
							<th><spring:message code="lms.label.learingCost" text="-" /></th>
							<td class="textbox no_line">
								<textarea id="learingCost" name="learingCost"></textarea>
							</td>
						</tr>
						<tr>
							<th>홍보영상</th>
							<td class="no_line">
								<select id="promotionVideoYn" name="promotionVideoYn">
					             	<option value="Y">Y</option>
					             	<option value="N" selected>N</option>
								</select>
							</td>
						</tr>
						<tr>
							<th>과정비용</th>
							<td class="textbox no_line"><input id="courseCost" name="courseCost" value="0"/></td>
						</tr>
<c:if test="${set.condiVO.weekCostYn eq 'Y'}">
						<tr>
							<th>차시별 비용</th>
							<td class="no_line">
								<ol id="study_list">
									<c:forEach var="row" items="${set.weekCostList}" varStatus="idx">
								    	<li>${row.title}<span class="price"><input type="hidden" id="weeks" name="weeks" value="${row.week}"/><input id="weekCosts" name="weekCosts" value="0" style="width:70px"/></span></li>
									</c:forEach>
								</ol>
							</td>
						</tr>	
</c:if>
						<tr>
							<th><spring:message code="lms.label.reportRate" text="-" /></th>
							<td class="no_line"><input id="reportRate" name="reportRate" value="0"/></td>
						</tr>
						<tr>
							<th><spring:message code="lms.label.examRate" text="-" /></th>
							<td class="no_line"><input id="examRate" name="examRate" value="0"/></td>
						</tr>
						<tr>
							<th><spring:message code="lms.label.discusstionRate" text="-" /></th>
							<td class="no_line"><input id="discussionRate" name="discussionRate" value="0"/></td>
						</tr>
						<tr>
							<th><spring:message code="lms.label.progressRate" text="-" /></th>
							<td class="no_line"><input id="progressRate" name="progressRate" value="100"/></td>
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


