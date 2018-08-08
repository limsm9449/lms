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
	if ( pKind =="update" ) {
		gfn_goPage(preUrl + "boardQnaU",$("#frm").serialize()); 
	} else if ( pKind =="delete" ) {
		if ( confirm("삭제 하시겠습니까?") == false )
			return false;
		
		btnUnbind("saveBtn");
		$.ajax({
			type :"POST",
			url : context + preUrl + "boardQnaDel.do",
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
	} else if ( pKind =="list" ) {
		gfn_goPage(preUrl + "boardQnaList",top.gCondition.boardQna.param); 
	} else if ( pKind =="boardQnaAnswerN" ) {
		lfn_setCondition();
		
		gfn_goPage(preUrl + "boardQnaAnswerN","pSeq=" + pParam.pSeq + "&courseId=${set.condiVO.courseId}&isPopup=${set.condiVO.isPopup}");		
	} else if ( pKind =="boardQnaAnswerU" ) {
		lfn_setCondition();
		
		gfn_goPage(preUrl + "boardQnaAnswerU","seq=" + pParam.seq + "&courseId=${set.condiVO.courseId}&&isPopup=${set.condiVO.isPopup}");		
	} else if ( pKind =="boardQnaAnswerDel" ) {
		if ( confirm("삭제 하시겠습니까?") == false )
			return false;
		
		btnUnbind("saveBtn");
		$.ajax({
			type :"POST",
			url : context + preUrl + "boardQnaAnswerDel.do",
			dataType :"json",
			data : "seq=" + pParam.seq,
			success : function(json){
				if ( json.rtnMode == "DELETE_OK") {
					gfn_goPage(preUrl + "boardQnaV",$("#frm").serialize());
				}
			},
			error : function(e) {
				alert("<spring:message code="lms.msg.systemError" text="-" />");
			}
		})
	}
}

function lfn_setCondition() {
	top.gCondition.boardQnaAnswer = {
		param : "seq=" + $("#seq").val() + 
				"&courseId=" + $("#courseId").val() + 
				"&isPopup=" + $("#isPopup").val() 
	}	
}
</script>

<body>

<form id="frm" name="frm" action="" method="post">
	<input id="courseId" name="courseId" value="${set.condiVO.courseId}" type="hidden"/>
	<input id="isPopup" name="isPopup" value="${set.condiVO.isPopup}" type="hidden"/>
	<input id="seq" name="seq" value="${set.condiVO.seq}" type="hidden"/>
	<input id="qSeq" name="qSeq" value="${set.condiVO.seq}" type="hidden"/>

<div id="wrap">
	<div id="container">
    	<div id="contents">
<c:if test="${set.condiVO.courseId eq 0}"> 
      		<div id="content_head">
        		<h1 class="title">Q&A</h1>
        		<ul class="gnb">
	          		<li>HOME</li>
	          		<li>게시물 관리</li>
	          		<li class="last">Q&A</li>
        		</ul>
			</div>
</c:if>

			<div id="article">
				<%-- 조건 --%>
		    	<h3 class="title">게시물 상세</h3>
		      	
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
							<th>제목</th>
							<td class="no_line"><c:out value="${set.data.title}" escapeXml="true" />
							</td>
						</tr>
						<tr>
							<th>내용</th>
							<td class="no_line"><c:out value="${set.data.contents}" escapeXml="" /></td>
						</tr>
						<tr>
							<th>작성자</th>
							<td class="no_line">${set.data.userName}
							</td>
						</tr>
						<tr>
							<th>조회수</th>
							<td class="no_line">${set.data.viewCnt}
							</td>
						</tr>
						<tr>
							<th>등록일자</th>
							<td class="no_line">${set.data.createDate}
							</td>
						</tr>
					</tbody>
				</table>

				<%-- 하단버튼 --%>
		  		<div class="tool_btn">
					<a href="#" onclick="javascript:lfn_btn('boardQnaAnswerN',{pSeq:'${set.condiVO.seq}'}); return false;" class="blueBtn">답글</a>
<c:if test="${set.condiVO.isEdit eq 'Y' && set.userId eq set.data.userId}">
					<a href="#" onclick="javascript:lfn_btn('update'); return false;" class="blueBtn">수정</a>
					<a href="#" id="saveBtn" onclick="javascript:lfn_btn('delete'); return false;" class="blueBtn">삭제</a>
</c:if>
					<a href="#" onclick="javascript:lfn_btn('list'); return false;" class="blueBtn">리스트</a>
		  		</div>

				<h4 class="title">답글</h4>
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
						<c:if test="${empty set.answerList}">
							<tr>
								<td colspan="3" class="no_line center">답글이 없습니다.</td>
							</tr>
						</c:if>
						<c:forEach var="row" items="${set.answerList}" varStatus="idx">
				            <tr <c:if test="${idx.count%2 eq 1}"> class="alt"</c:if>>
				              	<td class="textbox">${row.contents}</td>
				              	<td class="center">
									<c:if test="${set.userId eq row.userId}">
					              		<a href="#" onClick="javascript:lfn_btn('boardQnaAnswerU',{seq:'${row.seq}'}); return false;" class="grayBtn">수정</a> <a href="#" onClick="javascript:lfn_btn('boardQnaAnswerDel',{seq:'${row.seq}'}); return false;" class="grayBtn">삭제</a>
					              	</c:if>
									<c:if test="${set.userId ne row.userId}">
				              			${row.userName}
					              	</c:if>
				              	</td>
				              	<td class="no_line center">
				              		 ${row.createDate} 
				              	</td>
							</tr>
						</c:forEach>
					</tbody>
				</table>		  		
			</div>
			<!-- end content body -->
		</div>
	</div>
</div>

</form>

</body>
</html>


