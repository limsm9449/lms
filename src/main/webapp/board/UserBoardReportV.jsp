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

</head>

<script type="text/javascript">

var preUrl = "/board/"; 

$(document).ready(function() {
	$("#attachFrame").attr("src","/board/attachV.do?" + "pSeq=${set.condiVO.seq}&kind=B_REPORT");
	
});

function lfn_btn(pKind, pParam) {
	if ( pKind =="delete" ) {
		if ( confirm("삭제 하시겠습니까?") == false )
			return false;
		
		btnUnbind("deleteBtn");
		$.ajax({
			type :"POST",
			url : context + preUrl + "boardReportDel.do",
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
		gfn_goPage(preUrl + "userBoardReportU",$("#frm").serialize()); 
	} else if ( pKind =="list" ) {
		gfn_goPage(preUrl + "userBoardReportList",opener.top.gCondition.boardReport.param); 
	}
}

</script>

<body>


<form id="frm" name="frm" action="" method="post">
	<input id="courseId" name="courseId" value="${set.condiVO.courseId}" type="hidden"/>
	<input id="isPopup" name="isPopup" value="${set.condiVO.isPopup}" type="hidden"/>
	<input id="seq" name="seq" value="${set.condiVO.seq}" type="hidden"/>

<div id="popup_wrap">
  <div class="pop_header">
    <h3 class="title">레포트 - 상세</h3>
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
    </div>
    <div class="text">
        <iframe id="attachFrame" name="attachFrame" style="width:100%;height:100px"></iframe>
    </div>
    <div id="bod_search_r">
      <a href="#" onclick="javascript:lfn_btn('list'); return false;"><img src="/resources/images/sub/btn_go_list.png" alt="목록으로 돌아가기" /></a>
    </div>
  </div>
</div>



</form>


</body>
</html>


