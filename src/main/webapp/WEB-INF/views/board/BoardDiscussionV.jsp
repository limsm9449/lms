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
<script type="text/javascript" src="jquery.autoheight.js"></script>

</head>

<script type="text/javascript">
var preUrl = "/board/"; 

function lfn_btn(pKind, pParam) {
	if ( pKind =="delete" ) {
		if ( confirm("삭제 하시겠습니까?") == false )
			return false;
		
		btnUnbind("deleteBtn");
		$.ajax({
			type :"POST",
			url : context + preUrl + "boardDiscussionDel.do",
			dataType :"json",
			data : $("#frm").serialize(),
			success : function(json){
				if ( json.rtnMode == "DELETE_OK") {
					lfn_btn("list");
				}
			},
			error : function(e) {
				alert("<spring:message code="lms.msg.systemError" text="-" />");
			}
		})
	} else if ( pKind =="update" ) {
		gfn_goPage(preUrl + "boardDiscussionU",$("#frm").serialize()); 
	} else if ( pKind =="reply" ) {
		gfn_goPage(preUrl + "boardDiscussionN",$("#frm").serialize()); 
	} else if ( pKind =="list" ) {
		gfn_goPage(preUrl + "boardDiscussionList",top.gCondition.boardDiscussion.param); 
	}
}
</script>

<body>

<form id="frm" name="frm" action="" method="post">
	<input id="isPopup" name="isPopup" value="${set.condiVO.isPopup}" type="hidden"/>
	<input id="courseId" name="courseId" value="${set.data.courseId}" type="hidden"/>
	<input id="seq" name="seq" value="${set.data.seq}" type="hidden"/>
	<input id="ref" name="ref" value="${set.data.ref}" type="hidden"/>
	<input id="ord" name="ord" value="${set.data.ord}" type="hidden"/>
	<input id="step" name="step" value="${set.data.step}" type="hidden"/>

<div id="wrap">
	<div id="container">
    	<div id="contents">
<c:if test="${set.condiVO.courseId eq 0}"> 
      		<div id="content_head">
        		<h1 class="title">토론 게시판</h1>
        		<ul class="gnb">
	          		<li>HOME</li>
	          		<li>게시물 관리</li>
	          		<li class="last">토론 게시판</li>
        		</ul>
			</div>
</c:if>

			<div id="article">
				<%-- 조건 --%>
		    	<h3 class="title">게시물 상세</h3>
		      	
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
							<th>사용자ID</th>
							<td class="no_line">${set.data.userName}
							</td>
						</tr>
						<tr>
							<th>등록일자</th>
							<td class="no_line">${set.data.createDate}
							</td>
						</tr>
						<tr>
							<th>조회수</th>
							<td class="no_line">${set.data.viewCnt}
							</td>
						</tr>
					</tbody>
				</table>
				
				<%-- 하단버튼 --%>
		  		<div class="tool_btn">
					<a href="#" onclick="javascript:lfn_btn('reply'); return false;" class="blueBtn">답글</a>
<c:if test="${set.condiVO.isEdit eq 'Y' && set.userId eq set.data.userId}">
					<a href="#" onclick="javascript:lfn_btn('update'); return false;" class="blueBtn">수정</a>
					<a href="#" id="deleteBtn" onclick="javascript:lfn_btn('delete'); return false;" class="blueBtn">삭제</a>
</c:if>
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


