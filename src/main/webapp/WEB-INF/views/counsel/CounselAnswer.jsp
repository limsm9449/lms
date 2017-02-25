<%@ page contentType="text/html;charset=utf-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="FCK" uri="http://java.fckeditor.net" %>


<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="ko" xml:lang="ko">
<head>
<title>
</title>

<%@ include file="../common/commBoardInclude.jsp" %>

</head>

<script type="text/javascript">

var preUrl = "/counsel/"; 

$(document).ready(function() {
	$("textarea[name='answer']").cleditor();
});

function lfn_btn(pKind, pParam) {
	if ( pKind =="save" ) {
		if ( lfn_validate() == false )
			return false;
		
		if ( confirm("저장하시겠습니까?") == false )
			return false;
		
		btnUnbind("saveBtn");
		$.ajax({
			type :"POST",
			url : context + preUrl + "counselAnswerUpd.do",
			dataType :"json",
			data : $("#frm").serialize(),
			success : function(json){
				if ( json.rtnMode == "UPDATE_OK") {
					lfn_btn("list");
				}
			},
			error : function(e) {
				alert("<spring:message code="lms.msg.systemError" text="-" />");
			}
		})
	} else if ( pKind =="list" ) {
		gfn_goPage(preUrl + "counselList",top.gCondition.counsel.param); 
	}
}

function lfn_validate() {
	if ($("textarea[name='answer']").val() == "") {
	    alert('내용을 입력해주세요.');
	    return false;
	} 
	
	if ( checkByte($("textarea[name='answer']").val()) > board_contents_length ) {
		alert("입력 가능한 자릿수를 넘었습니다. (" + checkByte($("textarea[name='answer']").val()) + ")");
		$("textarea[name='answer']").Focus();
		return false;
	}	
	
	return true;
}

</script>

<body>


<form id="frm" name="frm" action="" method="post">
	<input id="seq" name="seq" value="${set.condiVO.seq}" type="hidden"/>

<div id="wrap">
	<div id="container">
    	<div id="contents">
      		<div id="content_head">
        		<h1 class="title">상담내역</h1>
        		<ul class="gnb">
	          		<li>HOME</li>
	          		<li>상담관리</li>
	          		<li class="last">상담내역</li>
        		</ul>
			</div>

			<div id="article">
				<%-- 조건 --%>
		    	<h3 class="title">답변</h3>
		      	
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
							<th>제목</th>
							<td class="no_line"><c:out value="${set.data.title}" escapeXml="true" />
							</td>
						</tr>
						<tr>
							<th>내용</th>
							<td class="no_line"><c:out value="${set.data.contents}" escapeXml="" /></td>
						</tr>
						<tr>
							<th>답변</th>
							<td class="textbox no_line">
								<textarea id="answer" name="answer"><c:out value="${set.data.answer}" escapeXml="" /></textarea>
							</td>
						</tr>
					</tbody>
				</table>

				<%-- 하단버튼 --%>
		  		<div class="tool_btn">
					<a href="#" id="saveBtn" onclick="javascript:lfn_btn('save'); return false;" class="blueBtn">저장</a>
					<a href="#" onclick="javascript:lfn_btn('list'); return false;" class="blueBtn">리스트</a>
		  		</div>
		  		
		  		<iframe id="replyFrame" name="replyFrame" class="autoHeight" scrolling="auto" frameborder="0" style="width:700px;"></iframe>
		  		
			</div>
			<!-- end content body -->
		</div>
	</div>
</div>


</form>


</body>
</html>


