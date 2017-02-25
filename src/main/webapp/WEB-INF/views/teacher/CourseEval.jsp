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
	$("#allChk").click(function(){
		$("input[id='userIds']").each(function(i) {
			if ( $(this).prop("disabled") == false ) {	    	
		        if ( $("#allChk").is(":checked") )
		            $(this).prop("checked", "checked");
		        else
		            $(this).prop("checked", "");
			}
	    });
	});
});

function lfn_btn(pKind, pParam) {
	if ( pKind == "courseEvalV" ) {
		gfn_goPage("/teacher/courseEvalV","courseId=" + pParam.courseId + "&userId=" + pParam.userId);
	} else if ( pKind == "list") {
		gfn_goPage("/teacher/myCourse",top.gCondition.myCourse.param);
	} else if ( pKind == "complete") {
		if ( lfn_validate() == false )
			return false;

		if ( confirm("완료처리 하시겠습니까?") == true ) {
			btnUnbind("saveBtn");
			$.ajax({
				type :"POST",
				url : context +"/teacher/evalCompleteUpd.do",
				dataType :"json",
				data : $("#frm").serialize(),
				success : function(json){
					if ( json.rtnMode == "UPDATE_OK") {
						alert("<spring:message code="lms.msg.updateOk" text="-" />");
						lfn_btn("list");
					}
					btnBind("saveBtn");
				},
				error : function(e) {
					alert("<spring:message code="lms.msg.systemError" text="-" />");
				}
			})
		}
	}
}

function lfn_validate() {
	var isCheck = false;
	$("[id=userIds]").each(function() {
     	if ( $(this).is(":checked") ) {
	    	isCheck = true;
	   	}
	});
	if ( isCheck == false ) {
		alert("선택한 대상자가 없습니다.");
		return false;
	}

	var isValidate = true;
	$("[id=userIds]").each(function(idx) {
     	if ( $(this).is(":checked") ) {
     		if ( parseInt($("[id=total]")[idx].value) == 0 ) { 
     			isValidate = false;
     		}
     		if ( parseInt($("[id=progress]")[idx].value) < 80 ) { 
     			isValidate = false;
     		}
	   	}
	});
	if ( isValidate == false ) {
		alert("총점은 0점 이상, 강의 진도는 80점 이상이여야 합니다.");
		return false;
	}

	return true;
}


</script>

<body>



<form id="frm" name="frm" method="post">
<input id="courseId" name="courseId" type="hidden" value="${set.condiVO.courseId}"/>

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
		    	<h3 class="title insertool">수강생 성적</h3>

				<div class="course_tool">
					<a href="#" onclick="javascript:Popup.showBoard('NOTICE','${set.condiVO.courseId}'); return false;">공지사항</a>
					<a href="#" onclick="javascript:Popup.showBoard('FREE','${set.condiVO.courseId}'); return false;">자유게시판</a>
					<a href="#" onclick="javascript:Popup.showBoard('DATA','${set.condiVO.courseId}'); return false;">자료실</a>
					<a href="#" onclick="javascript:Popup.showBoard('QNA','${set.condiVO.courseId}'); return false;">Q&A</a>
<c:if test="${set.course.isReport eq 'Y'}">
						<a href="#" onclick="javascript:Popup.showBoard('REPORT','${set.condiVO.courseId}'); return false;">레포트</a>
</c:if>
<c:if test="${set.course.isDiscussion eq 'Y'}">
						<a href="#" onclick="javascript:Popup.showBoard('DISCUSSION','${set.condiVO.courseId}'); return false;">토론게시판</a>
</c:if>
				</div>



				<%-- 테이블 --%>
		   		<table summary="" >
					<caption></caption>
					<thead>
					  	<tr class="guide">
	  						<th></th>
	  						<th width="150"></th>
	  						<th width="100"></th>
	  						<th width="100"></th>
	  						<th width="100"></th>
	  						<th width="100"></th>
	  						<th width="100"></th>
	  						<th width="80"></th>
  						</tr>
						<tr>
							<th><input id="allChk" name="allChk" type="checkbox"/></th>
							<th>이름</th>
							<th>레포트</th>
							<th>시험</th>
							<th>토론</th>
							<th>강의진도</th>
							<th>총점</th>
							<th class="no_line">완료상태</th>
						</tr>
					</thead>
					<tbody>
						<c:if test="${empty set.courseEvals}">
							<tr><td colspan="8" class="no_line center">검색된 데이타가 없습니다.</td></tr>
						</c:if>	
						<c:forEach var="row" items="${set.courseEvals}" varStatus="idx">
				            <tr <c:if test="${idx.count%2 eq 1}"> class="alt"</c:if>>
<c:choose>
	<c:when test="${row.completeYn eq 'N'}">
				            	<td class="center"><input type="checkbox" id="userIds" name="userIds" value="${row.userId}"></td>
	</c:when>
	<c:otherwise>
				            	<td class="center"><input type="checkbox" id="userIds" name="userIds" value="${row.userId}" disabled></td>
	</c:otherwise>
</c:choose>		            
				            	<td class="subject"><a href="#" onclick="javascript:lfn_btn('courseEvalV',{courseId:'${row.courseId}',userId:'${row.userId}'}); return false;" class="click">${row.userName}</a></td>
				            	<td class="right">${row.report}</td>
				            	<td class="right">${row.exam}</td>
				            	<td class="right">${row.discussion}</td>
				            	<td class="right"><input id="progress" name="progress" type="hidden" value="${row.progress}"/>${row.progress}</td>
				            	<td class="right"><input id="total" name="total" type="hidden" value="${row.total}"/>${row.total}</td>
				            	<td class="no_line center">${row.completeYn}</td>
				            </tr>
						</c:forEach>
					</tbody>
				</table>
				
				<%-- 하단버튼 --%>
				<div class="tool_btn">
					<a href="#" id="saveBtn" onclick="javascript:lfn_btn('complete'); return false;" class="blueBtn">완료처리</a>
					<a href="#" onclick="javascript:lfn_btn('list'); return false;" class="blueBtn">리스트</a>
				</div>
		   	</div>
		</div>
	</div>
</div>	
	
</form>

</body>
</html>


