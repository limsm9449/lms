<%@ page contentType="text/html;charset=utf-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="FCK" uri="http://java.fckeditor.net" %>


<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="ko" xml:lang="ko">
<head>
<title>
</title>

<%@ include file="../common/commUserInclude.jsp" %>
<script type="text/javascript" src="jquery.autoheight.js"></script>

</head>

<script type="text/javascript">
var preUrl = "/board/";

function lfn_btn(pKind, pParam) {
	if ( pKind =="update" ) {
		gfn_goPage(preUrl + "userBoardQnaU",$("#frm").serialize()); 
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
		gfn_goPage(preUrl + "userBoardQnaList",opener.top.gCondition.boardQna.param); 
	} else if ( pKind =="boardQnaAnswerN" ) {
		lfn_setCondition();
		
		gfn_goPage(preUrl + "userBoardQnaAnswerN","pSeq=${set.condiVO.seq}&courseId=${set.condiVO.courseId}&isPopup=${set.condiVO.isPopup}");		
	} else if ( pKind =="boardQnaAnswerU" ) {
		lfn_setCondition();
		
		gfn_goPage(preUrl + "userBoardQnaAnswerU","seq=" + pParam.seq + "&courseId=${set.condiVO.courseId}&&isPopup=${set.condiVO.isPopup}");		
	} else if ( pKind =="boardQnaAnswerDel" ) {
		if ( confirm("삭제 하시겠습니까?") == false )
			return false;
		
		$.ajax({
			type :"POST",
			url : context + preUrl + "boardQnaAnswerDel.do",
			dataType :"json",
			data : "seq=" + pParam.seq,
			success : function(json){
				if ( json.rtnMode == "DELETE_OK") {
					gfn_goPage(preUrl + "userBoardQnaV",$("#frm").serialize());
				}
			},
			error : function(e) {
				alert("<spring:message code="lms.msg.systemError" text="-" />");
			}
		})
	}
}

function lfn_setCondition() {
	opener.top.gCondition.boardQnaAnswer = {
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


<div id="popup_wrap">
  <div class="pop_header">
    <h3 class="title">Q&A - 상세</h3>
    <p class="closeBtn" onClick="window.close();">Close</p>
  </div>
  <div class="pop_content">
    <div id="bod_search_r">
      <a href="#" onclick="javascript:lfn_btn('list'); return false;"><img src="/resources/images/sub/btn_go_list.png" alt="목록으로 돌아가기" /></a>
    </div>
    <div id="bodview_box">
      <div class="title"><c:out value="${set.data.title}" escapeXml="true" /></div>
      <div class="tool_box">
        <dl>
          <dt>작성자</dt>
          <dd>${set.data.userName}</dd>
          <dd class="btn"><a href="#" onclick="javascript:lfn_btn('boardQnaAnswerN'); return false;">답글</a></dd>
<c:if test="${set.condiVO.isEdit eq 'Y' && set.userId eq set.data.userId}">
          <dd class="btn"><a href="#" onclick="javascript:lfn_btn('update'); return false;">수정</a></dd>
          <dd class="btn"><a href="#" id="saveBtn" onclick="javascript:lfn_btn('delete'); return false;">삭제</a></dd>
</c:if>
        </dl>
        <hr class="dash" />
        <dl>
          <dt>조회</dt>
          <dd>${set.data.viewCnt}</dd>
          <dt class="date">등록일</dt>
          <dd>${set.data.createDate}</dd>
        </dl>
      </div>
      <div class="text" style="width:828px">
        <c:out value="${set.data.contents}" escapeXml="" />
      </div>
<c:forEach var="row" items="${set.answerList}" varStatus="idx">
    <div id="bodview_box" class="reply">
      <div class="title">답변</div>
      <div class="tool_box">
        <dl>
          <dt>작성자</dt>
          <dd>${row.userId}</dd>
          <dt class="date">등록일</dt>
          <dd>${row.createDate}</dd>
<c:if test="${set.userId eq row.userId}">
          <dd class="btn"><a href="#" onClick="javascript:lfn_btn('boardQnaAnswerU',{seq:'${row.seq}'}); return false;">수정</a></dd>
          <dd class="btn"><a href="#" onClick="javascript:lfn_btn('boardQnaAnswerDel',{seq:'${row.seq}'}); return false;">삭제</a></dd>
</c:if>
        </dl>
      </div>
      <div class="text">
        <c:out value="${row.contents}" escapeXml="" />
      </div>
    </div>
</c:forEach>
    </div>
    <div id="bod_search_r">
      <a href="#" onclick="javascript:lfn_btn('list'); return false;"><img src="/resources/images/sub/btn_go_list.png" alt="목록으로 돌아가기" /></a>
    </div>
  </div>
</div>


</form>

</body>
</html>


