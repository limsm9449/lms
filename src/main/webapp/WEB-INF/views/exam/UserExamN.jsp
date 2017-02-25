<%@ page contentType="text/html;charset=utf-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="FCK" uri="http://java.fckeditor.net" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>


<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="ko" xml:lang="ko">
<head>
<title>
</title>

<%@ include file="../common/commAdminInclude.jsp" %>

</head>

<script type="text/javascript">
var gCondition = {
}

function lfn_btn(pKind, pParam) {
	if ( pKind =="save" ) {
		if ( lfn_validate() == false )
			return false;
		
		if ( confirm("시험은 한번만 저장하실 수 있습니다.\n저장하시겠습니까?") == true ) {
			btnUnbind("saveBtn");
			$.ajax({
				type :"POST",
				url : context +"/exam/userExamIns.do",
				dataType :"json",
				data : $("#frm").serialize(),
				success : function(json){
					if ( json.rtnMode == "INSERT_OK") {
						alert("정상적으로 저장이 되었습니다.");
						opener.lfn_btn("refresh");
						window.close();
					}
				},
				error : function(e) {
					alert("<spring:message code="lms.msg.systemError" text="-" />");
				}
			})
		}
	}
}

function lfn_validate() {
	//Validation 검사
	types = $("[id=types]");
	answers = $("[id=answers]");
	for ( i = 0; i < types.length; i++ ) {
		if ( types[i].value == "G") {
			if ( $("input[name=answers" + i + "]:checked").length == 0 ) {
				alert((i + 1) + " 문항의 답을 선택하세요.");
				return false;
			}

			answers[i].value = $("input[name=answers" + i + "]:checked").val();
		} else {
			if ( $("#memos" + i).val() == "" ) {
				alert((i + 1) + " 문항의 답을 입력하세요.");
				return false;
			}

			answers[i].value = $("#memos" + i).val();
		}
	}
		
	return true;
}

</script>


<body>

<form id="frm" name="frm" action="" method="post">
	<input type="hidden" id="courseId" name="courseId" value="${set.condiVO.courseId}"/> 
	
<div id="popup_wrap">
  	<div class="pop_header">
    	<h3 class="title">시험</h3>
    	<p class="closeBtn" onClick="window.close();">Close</p>
  	</div>
  	<div class="pop_content">
		<%-- 테이블 --%>
   		<table summary="">
			<caption></caption>
			<thead>
			  	<tr class="guide">
 						<th width="50"></th>
 						<th></th>
						</tr>
				<tr>
					<th>순번</th>
					<th class="no_line">질문</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach var="row" items="${set.list}" varStatus="idx">
		            <tr <c:if test="${idx.count%2 eq 1}"> class="alt"</c:if>>
		              	<td class="center"><c:out value="${row.seq}" escapeXml="" /></td>
		              	<td class="no_line subject">
		              		<p class="quest"><c:out value="${row.question}" escapeXml="" /></p>
		              		<input type="hidden" id="types" name="types" value="${row.type}"/> 
		              		<input type="hidden" id="seqs" name="seqs" value="${row.seq}"/> 
		              		<input type="hidden" id="answers" name="answers" value=""/> 
		              		<c:if test="${row.type eq 'G'}">
			              		<ul class="exam">
			              			<li><input type="radio" id="answers${idx.index}" name="answers${idx.index}" value="1"/><c:out value="${row.qa1}" escapeXml="" /></li>
			              			<li><input type="radio" id="answers${idx.index}" name="answers${idx.index}" value="2"/><c:out value="${row.qa2}" escapeXml="" /></li>
			              			<li><input type="radio" id="answers${idx.index}" name="answers${idx.index}" value="3"/><c:out value="${row.qa3}" escapeXml="" /></li>
			              			<li><input type="radio" id="answers${idx.index}" name="answers${idx.index}" value="4"/><c:out value="${row.qa4}" escapeXml="" /></li>
				              	</ul>
		              			<textarea id="memos${idx.index}" name="memos${idx.index}" class="polltext" style="display:none"></textarea>
		              		</c:if>
		              		<c:if test="${row.type eq 'J'}">
		              			<textarea id="memos${idx.index}" name="memos${idx.index}" class="polltext"></textarea>
		              			<input type="radio" id="answers${idx.index}" name="answers${idx.index}" value="1" style="display:none"/>
		              			<input type="radio" id="answers${idx.index}" name="answers${idx.index}" value="2" style="display:none"/>
		              			<input type="radio" id="answers${idx.index}" name="answers${idx.index}" value="3" style="display:none"/>
		              			<input type="radio" id="answers${idx.index}" name="answers${idx.index}" value="4" style="display:none"/>
		              		</c:if>
		              	</td>
		            </tr>
				</c:forEach>
			</tbody>
		</table>
					
		<%-- 하단버튼 --%>
  		<div class="tool_btn" >
			<a href="#" id="saveBtn" onclick="javascript:lfn_btn('save'); return false;" class="blueBtn">저장</a>
  		</div>
	</div>
	
</div>

</form>

</body>
</html>


