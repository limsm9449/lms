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

function lfn_btn(pKind, pParam) {
	if ( pKind == "updCourseEvalForEval" ) {
		if ( lfn_validate() == false )
			return false;
		
		if ( confirm("저장 하시겠습니까?") == true ) {
			btnUnbind("saveBtn");
			$.ajax({
				type :"POST",
				url : context +"/teacher/updCourseEvalForEval.do",
				dataType :"json",
				data : $("#frm").serialize(),
				success : function(json){
					if ( json.rtnMode == "UPDATE_OK") {
						alert("수정되었습니다.");
						lfn_btn("list");
					}
				},
				error : function(e) {
					alert("<spring:message code="lms.msg.systemError" text="-" />");
				}
			})
		}
	} else if ( pKind == "list") {
		gfn_goPage("/teacher/courseEval","courseId=" + $("#courseId").val());
	}
}

function lfn_validate() {
	<c:if test="${set.evaluation.reportRate ge 0}">
		if ( formValid.check("report",{isNecess:true,isNum:true}) == false ) return false;
		if ( parseInt($("#report").val()) < 0 || parseInt($("#report").val()) > 100 ) {
			alert("점수는 0 ~ 100까지만 가능합니다.");
			$("#report").select();
			return false;
		}
	</c:if>
	<c:if test="${set.evaluation.discussionRate ge 0}">
		if ( formValid.check("discussion",{isNecess:true,isNum:true}) == false ) return false;
		if ( parseInt($("#discussion").val()) < 0 || parseInt($("#discussion").val()) > 100 ) {
			alert("점수는 0 ~ 100까지만 가능합니다.");
			$("#discussion").select();
			return false;
		}
	</c:if>
	
	return true;
}


</script>

<body>

<form id="frm" name="frm" action="" method="post">
	<input id="courseId" name="courseId" type="hidden" value="${set.condiVO.courseId}"/>
	<input id="userId" name="userId" type="hidden" value="${set.condiVO.userId}"/>
	
<div id="wrap">
	<div id="container">
    	<div id="contents">
      		<div id="content_head">
        		<h1 class="title">담당 강좌 리스트</h1>
        		<ul class="gnb">
	          		<li>HOME</li>
	          		<li>강좌관리</li>
	          		<li class="last">담당 강좌 리스트</li>
        		</ul>
			</div>

			<div id="article">
				<%-- 조건 --%>
		    	<h3 class="title insertool">진도 상세</h3>
		    	
				<%-- 테이블 --%>
		   		<table summary="" class="view">
					<thead>
					  	<tr class="guide">
	  						<th width="150"></th>
	  						<th width="150"></th>
	  						<th width="150"></th>
	  						<th width="150"></th>
	  						<th width="150"></th>
  						</tr>
						<tr>
							<th class="center">레포트 점수(${set.evaluation.reportRate})</th>
							<th class="center">시험 점수(${set.evaluation.examRate})</th>
							<th class="center">토론 점수(${set.evaluation.discussionRate})</th>
							<th class="center">강의진도 점수(${set.evaluation.progressRate})</th>
							<th class="no_line center">합계 점수</th>
						</tr>
					</thead>
					<tbody>
						<tr>
							<td class="center">
								<c:choose>
									<c:when test="${set.evaluation.reportRate ne '0' && set.evaluation.completeYn eq 'N'}">
										${set.evaluation.reportCalc} / <input name="report" id="report" type="text" value="${set.evaluation.report}" style="width:40px">
									</c:when>
									<c:otherwise>
										${set.evaluation.reportCalc}
									</c:otherwise>
								</c:choose>
							</td>
							<td class="center">
								${set.evaluation.examCalc}
							</td>
							<td class="center">
								<c:choose>
									<c:when test="${set.evaluation.discussionRate ne '0' && set.evaluation.completeYn eq 'N'}">
										${set.evaluation.discussionCalc} / <input name="discussion" id="discussion" type="text" value="${set.evaluation.discussion}" style="width:40px">
									</c:when>
									<c:otherwise>
										${set.evaluation.discussionCalc}
									</c:otherwise>
								</c:choose>
							</td>
							<td class="right">${set.evaluation.progressCalc}</td>
							<td class="no_line right">${set.evaluation.total}</td>
						</tr>
					</tbody>
				</table>	

				<%-- 테이블 --%>
		   		<table summary="" class="view">
					<thead>
					  	<tr class="guide">
	  						<th width="550"></th>
	  						<th width="70"></th>
	  						<th></th>
  						</tr>
						<tr>
							<th>주차</th>
							<th>진도율</th>
							<th class="no_line">학습일자</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach var="row" items="${set.week}" varStatus="idx">
				            <tr <c:if test="${idx.count%2 eq 1}"> class="alt"</c:if>>
								<td>${row.week}. ${row.title}</td>
								<td class="right">${row.progressRate} %</td>
								<td class="no_line center">${row.studyStart} ~ ${row.studyEnd}</td>
							</tr>
						</c:forEach>					
					</tbody>
				</table>	
				
<c:if test="${!empty set.userExamList}">		
		    	<h3 class="title insertool">시험</h3>
				<%-- 테이블 --%>
		   		<table summary="">
					<caption></caption>
					<thead>
					  	<tr class="guide">
	  						<th width="40"></th>
	  						<th></th>
	  						<th width="100"></th>
  						</tr>
						<tr>
							<th>순번</th>
							<th>질문</th>
							<th class="no_line">답</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach var="row" items="${set.userExamList}" varStatus="idx">
				            <tr <c:if test="${idx.count%2 eq 1}"> class="alt"</c:if>>
				              	<td class="center"><c:out value="${row.seq}" escapeXml="" /></td>
				              	<td class="subject">
				              		<p class="quest"><c:out value="${row.question}" escapeXml="" /></p>
				              		<c:if test="${row.type eq 'G'}">
					              		<ul class="exam">
					              			<li><input type="radio" <c:if test="${row.userAnswer eq '1'}">checked</c:if> disabled/><c:out value="${row.qa1}" escapeXml="" /></li>
					              			<li><input type="radio" <c:if test="${row.userAnswer eq '2'}">checked</c:if> disabled/><c:out value="${row.qa2}" escapeXml="" /></li>
					              			<li><input type="radio" <c:if test="${row.userAnswer eq '3'}">checked</c:if> disabled/><c:out value="${row.qa3}" escapeXml="" /></li>
					              			<li><input type="radio" <c:if test="${row.userAnswer eq '4'}">checked</c:if> disabled/><c:out value="${row.qa4}" escapeXml="" /></li>
						              	</ul>
				              		</c:if>
				              		<c:if test="${row.type eq 'J'}">
				              			<textarea class="polltext" disabled><c:out value="${row.userAnswer}" escapeXml="" /></textarea>
				              		</c:if>
				              	</td>
				              	<td class="no_line center"><c:out value="${row.answer}" escapeXml="" /><c:if test="${row.userAnswer ne row.answer}"> (틀림)</c:if></td>
				            </tr>
						</c:forEach>						
					</tbody>
				</table>
</c:if>

				<%-- 하단버튼 --%>
				<div class="tool_btn">
					<c:if test="${set.evaluation.completeYn eq 'N' && (set.evaluation.discussionRate ne '0' || set.evaluation.reportRate ne '0')}">
						<a href="#" id="saveBtn" onclick="javascript:lfn_btn('updCourseEvalForEval'); return false;" class="blueBtn">저장</a>
					</c:if>				
					<a href="#" onclick="javascript:lfn_btn('list'); return false;" class="blueBtn">리스트</a>
				</div>
		   	</div>
		</div>
	</div>
</div>	

</form>


</body>
</html>


