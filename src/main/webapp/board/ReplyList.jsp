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
	parent.$("#replyFrame").attr('style','width:100%;height:' + ($('#article').prop("scrollHeight") + 20) + "px");
	top.lfn_resize();
});

function lfn_btn(pKind, pParam) {
	if ( pKind =="refresh" ) {
		f_submitSelf(preUrl + "replyList");	
	} else if ( pKind =="add" ) {
		if ( $("#contents").val() == "" ) {
			alert("내용을 입력하세요.");
			return;
		}
		if ( confirm("저장하시겠습니까?") == true ) {
			$.ajax({
				type :"POST",
				url : context + preUrl + "replyIns.do",
				dataType :"json",
				data : $("#frm").serialize(),
				success : function(json){
					if ( json.rtnMode == "INSERT_OK") {
						lfn_btn("refresh");
					}
				},
				error : function(e) {
					alert("<spring:message code="lms.msg.systemError" text="-" />");
				}
			})
		}
	} else if ( pKind =="cancel" ) {
		$("#contents").val("");
	} else if ( pKind =="update" ) {
		window.location = "<%=request.getContextPath()%>/board/replyU.do?seq=" + pParam.seq + "&kind=${set.condiVO.kind}&pSeq=${set.condiVO.pSeq}";
	} else if ( pKind =="replyCancel" ) {
		$("#reply_" + oldSeq).show();
		$("#btn_" + oldSeq).show();
		$("#replyFrame").remove();
	} else if ( pKind =="delete" ) {
		if ( confirm("삭제 하시겠습니까?") == false )
			return false;
		
		$.ajax({
			type :"POST",
			url : context + preUrl + "replyDel.do",
			dataType :"json",
			data : "seq=" + pParam.seq,
			success : function(json){
				if ( json.rtnMode == "DELETE_OK") {
					lfn_btn("refresh");
				}
			},
			error : function(e) {
				alert("<spring:message code="lms.msg.systemError" text="-" />");
			}
		})
	}
}

</script>

<body>

<form id="frm" name="frm" method="post">
	<input id="pSeq" name="pSeq" value="${set.condiVO.pSeq}" type="hidden"/>
	<input id="kind" name="kind" value="${set.condiVO.kind}" type="hidden"/>

			<div id="article">
				<h4 class="title">댓글</h4>
				<table>
					<caption></caption>
					<thead>
					  	<tr class="guide">
	  						<th></th>
	  						<th width="120"></th>
	  						<th width="110"></th>
  						</tr>
						<tr>
							<th>내용</th>
							<th>작성자</th>
							<th class="no_line">등록일자</th>
						</tr>
					</thead>
					<tbody>
			            <tr class="alt">
			              	<td class="textbox"><textarea id="contents" name="contents" style="width:100%;height:80px"></textarea></td>
			              	<td class="center">
								<a href="#" onClick="javascript:lfn_btn('add'); return false;" class="grayBtn">저장</a>
								<a href="#" onClick="javascript:lfn_btn('cancel'); return false;" class="grayBtn">취소</a>
			              	</td>
			              	<td class="no_line center">
			              	</td>
			            </tr>
						<c:forEach var="row" items="${set.list}" varStatus="idx">
				            <tr <c:if test="${idx.count%2 eq 0}"> class="alt"</c:if>>
				              	<td class="textbox"><pre>${row.contents}</pre></td>
				              	<td class="center">
									<c:if test="${set.userId eq row.userId}">
					              		<a href="#" onClick="javascript:lfn_btn('update',{seq:'${row.seq}'}); return false;" class="grayBtn">수정</a> <a href="#" onClick="javascript:lfn_btn('delete',{seq:'${row.seq}'}); return false;" class="grayBtn">삭제</a>
					              	</c:if>
									<c:if test="${set.userId ne row.userId}">
				              			${row.userName}
					              	</c:if>
				              	</td>
				              	<td class="no_line center">
				              		 ${row.updateDate} 
				              	</td>
							</tr>
						</c:forEach>
					</tbody>
				</table>		  		
			</div>

	 
</form>


</body>
</html>



