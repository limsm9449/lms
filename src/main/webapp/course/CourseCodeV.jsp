<%@ page contentType="text/html;charset=utf-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="ko" xml:lang="ko">
<head>
<title>
</title>

<%@ include file="../common/commAdminInclude.jsp" %>

</head>

<script type="text/javascript">
function lfn_btn(pKind, pParam) {
	if ( pKind =="update" ) {
		gfn_goPage('/courseCode/courseCodeU',"courseCode=" +$("#courseCode").val()); 
	} else if ( pKind =="delete" ) {
		if ( confirm("삭제하시겠습니끼?") == true ) {
			btnUnbind("deleteBtn");
			$.ajax({
				type :"POST",
				url : context +"/courseCode/courseCodeUDel.do",
				dataType :"json",
				data : $("#frm").serialize(),
				success : function(json){
					if ( json.rtnMode == "DELETE_OK") {
						alert("<spring:message code="lms.msg.deleteOk" text="-" />");
						lfn_btn("list");
					}
				},
				error : function(e) {
					alert("<spring:message code="lms.msg.systemError" text="-" />");
				}
			})
		}
	} else if ( pKind =="list" ) {
		gfn_goPage('/courseCode/courseCodeList',top.gCondition.courseCode.param); 
	}
}



</script>

<body>

<form id="frm" name="frm" action="" method="post">
	<input type="hidden" id="courseCode" name="courseCode" value="${set.data.courseCode}"/>

<div id="wrap">
	<div id="container">
    	<div id="contents">
      		<div id="content_head">
        		<h1 class="title">과정 코드 관리</h1>
        		<ul class="gnb">
	          		<li>HOME</li>
	          		<li>강좌 관리</li>
	          		<li class="last">과정 코드 관리</li>
        		</ul>
			</div>

		   	<!-- content body -->
		   	<div id="article">
		      	<h3 class="title">과정 코드 상세</h3>
		      	
				<table class="view">
					<caption></caption>
					<thead>
					  	<tr class="guide">
	  						<th width="130"></th>
	  						<th></th>
	  					</tr>
					</thead>
					<tbody>
						<tr>
							<th>카테고리</th>
							<td class="no_line"><c:out value="${set.data.categoryName}" escapeXml="" /></td>
						</tr>
						<tr>
							<th>과정코드</th>
							<td class="no_line"><c:out value="${set.data.courseCode}" escapeXml="" /></td>
						</tr>
						<tr>
							<th>과정명</th>
							<td class="no_line"><c:out value="${set.data.courseName}" escapeXml="" /></td>
						</tr>
						<tr>
							<th>강사</th>
							<td class="no_line"><c:out value="${set.data.teacherName}" escapeXml="" /></td>
						</tr>
						<tr>
							<th>가로</th>
							<td class="no_line"><c:out value="${set.data.hPx}" escapeXml="" /></td>
						</tr>
						<tr>
							<th>세로</th>
							<td class="no_line"><c:out value="${set.data.vPx}" escapeXml="" /></td>
						</tr>
						<tr>
							<th>디렉토리</th>
							<td class="no_line"><c:out value="${set.data.directory}" escapeXml="" /></td>
						</tr>
						<tr>
							<th>포인트</th>
							<td class="no_line"><fmt:formatNumber value="${set.data.point}" type="number"/></td>
						</tr>
						<tr>
							<th>사용여부</th>
							<td class="no_line"><c:out value="${set.data.useYn}" escapeXml="" /></td>
						</tr>
						<tr>
							<th>설문지</th>
							<td class="no_line"><c:out value="${set.data.questGroupName}" escapeXml="" /></td>
						</tr>
					</tbody>
				</table>
				
				<%-- 하단버튼 --%>
		  		<div class="tool_btn">
					<a href="#" onclick="javascript:lfn_btn('update'); return false;" class="blueBtn">수정</a>
<c:if test="${set.data.subCnt eq 0}">
						<a href="#" id="deleteBtn" onclick="javascript:lfn_btn('delete'); return false;" class="blueBtn">삭제</a>
</c:if>
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


