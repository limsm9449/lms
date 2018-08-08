<%@ page contentType="text/html;charset=utf-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions"  prefix="fn"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="ko" xml:lang="ko">
<head>
<title>
</title>

<%@ include file="../common/commBoardInclude.jsp" %>


</head>

<script type="text/javascript">
var preUrl = "/board/"; 

$(document).ready(function() {
	//사이즈를 조절해준다.
	parent.$("#replyFrame").attr('style','width:100%;height:' + (document.body.scrollHeight + 20) + "px");
	top.lfn_resize();
});


function lfn_btn(pKind, pParam) {
	if ( pKind =="save" ) {
		if ( $("#contents").val() == "" ) {
			alert("내용을 입력하세요.");
			return;
		}
		if ( confirm("저장하시겠습니까?") == true ) {
			$.ajax({
				type :"POST",
				url : context + preUrl + "replyUpd.do",
				dataType :"json",
				data : $("#frm").serialize(),
				success : function(json){
					if ( json.rtnMode == "UPDATE_OK") {
						window.location = "/board/replyList.do?" + "&kind=${set.condiVO.kind}&pSeq=${set.condiVO.pSeq}";
					}
				},
				error : function(e) {
					alert("<spring:message code="lms.msg.systemError" text="-" />");
				}
			})
		};
	} else if ( pKind =="replyCancel" ) {
		window.location = "/board/replyList.do?" + "&kind=${set.condiVO.kind}&pSeq=${set.condiVO.pSeq}";
	}
}

</script>

<body>

<form id="frm" name="frm" method="post">
	<input id="seq" name="seq" value="${set.condiVO.seq}" type="hidden"/>

	<div id="article">
		<h4 class="title">댓글 수정</h4>
		<table>
			<caption></caption>
			<thead>
			  	<tr class="guide">
 						<th></th>
 						<th width="120"></th>
						</tr>
				<tr>
					<th>내용</th>
					<th>기능</th>
				</tr>
			</thead>
			<tbody>
	            <tr class="alt">
	              	<td class="textbox"><textarea id="contents" name="contents" style="width:100%;height:150px">${set.data.contents}</textarea></td>
	              	<td class="center">
						<a href="#" onClick="javascript:lfn_btn('save'); return false;" class="grayBtn">저장</a>
						<a href="#" onClick="javascript:lfn_btn('replyCancel'); return false;" class="grayBtn">취소</a>
	              	</td>
	            </tr>
			</tbody>
		</table>		  		
	</div>
</form>

</body>
</html>



</div>
</div>
