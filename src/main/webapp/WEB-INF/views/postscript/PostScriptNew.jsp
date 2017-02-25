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
		
		if ( confirm("생성하시겠습니까?") == true ) {
			btnUnbind("saveBtn");
			$.ajax({
				type :"POST",
				url : context +"/postscript/postscriptIns.do",
				dataType :"json",
				data : $("#frm").serialize(),
				success : function(json){
					if ( json.rtnMode == "INSERT_OK") {
						alert("<spring:message code="lms.msg.insertOk" text="-" />");
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
	if ( $("input[name=eval]:checked").length == 0 ) {
		alert("평점을 선택하세요.");
		return false;
	}

	if ( $("#contents").val() == "" ) {
		alert("수강후기를 작성해 주세요.");
		return false;
	}
	
	if ( checkByte($('contents').val()) > course_contents_length ) {
		alert("입력 가능한 자릿수를 넘었습니다.");
		$('contents').Focus();
		return false;
	}
		
	return true;
}

</script>


<body>

<form id="frm" name="frm" action="" method="post">
	<input type="hidden" id="courseId" name="courseId" value="${set.condiVO.courseId}"/> 
	
<div id="popup_wrap">
  	<div class="pop_header">
    	<h3 class="title">수강후기</h3>
    	<p class="closeBtn" onClick="window.close();">Close</p>
  	</div>
  	<div class="pop_content">
		<%-- 테이블 --%>
   		<table summary="" class="view">
			<caption></caption>
			<thead>
			  	<tr class="guide">
					<th width="100"></th>
					<th></th>
				</tr>
			</thead>
			<tbody>
				<tr>
					<th>강좌 평점</th> 
					<td class="no_line">
						<ul class="exam">
	              			<li><input type="radio" id="eval" name="eval" value="2"/>2 점</li>
	              			<li><input type="radio" id="eval" name="eval" value="4"/>4 점</li>
	              			<li><input type="radio" id="eval" name="eval" value="6"/>6 점</li>
	              			<li><input type="radio" id="eval" name="eval" value="8"/>8 점</li>
	              			<li><input type="radio" id="eval" name="eval" value="10"/>10 점</li>
		              	</ul>
					</td>
				</tr>
				<tr>
					<th>수강후기</th>
					<td class="textbox no_line">
						<textarea id="contents" name="contents" class="polltext" style="height:100px"></textarea>
					</td>
				</tr>
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


