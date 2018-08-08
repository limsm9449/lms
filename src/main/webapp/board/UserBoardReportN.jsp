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
	$("#attachFrame").attr("src","/board/attachI.do?" + "pSeq=${set.condiVO.seq}&kind=B_REPORT&mode=TEMP");
	$("textarea[name='contents']").cleditor();
	$("textarea[name='contents']").val("");
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
			url : context + preUrl + "boardReportIns.do",
			dataType :"json",
			data : $("#frm").serialize(),
			success : function(json){
				if ( json.rtnMode == "INSERT_OK") {
					lfn_btn("list");
				}
			},
			error : function(e) {
				alert("<spring:message code="lms.msg.systemError" text="-" />");
			}
		})
	} else if ( pKind =="list" ) {
		gfn_goPage(preUrl + "userBoardReportList",opener.top.gCondition.boardReport.param); 
	}
}

function lfn_validate() {
	if ($("#title").val() == "") {
	    alert('제목을 입력해 주세요.');
	    $("#title").select();
	    return false;
	}  
	
	if ($("textarea[name='contents']").val() == "") {
	    alert('내용을 입력해주세요.');
	    return false;
	} 
	
	if ( formValid.check("title",{maxLeng:200}) == false )
		return false;
	if ( checkByte($("textarea[name='contents']").val()) > board_contents_length ) {
		alert("입력 가능한 자릿수를 넘었습니다. (" + checkByte($("textarea[name='contents']").val()) + ")");
		$("textarea[name='contents']").Focus();
		return false;
	}	
	
	return true;
}


</script>

<body>


<form id="frm" name="frm" action="" method="post" enctype="multipart/form-data">
	<input id="courseId" name="courseId" value="${set.condiVO.courseId}" type="hidden"/>
	<input id="isPopup" name="isPopup" value="${set.condiVO.isPopup}" type="hidden"/>


<div id="popup_wrap">
  <div class="pop_header">
    <h3 class="title">레포트 - 글쓰기</h3>
    <p class="closeBtn" onClick="window.close();">Close</p>
  </div>
  <div class="pop_content">
    <div id="bod_search_r">
      <a href="#" onclick="javascript:lfn_btn('list'); return false;"><img src="/resources/images/sub/btn_go_list.png" alt="목록으로 돌아가기" /></a>
    </div>
    <table class="bod_input">
      <caption>input</caption>
			<thead>
			  <tr class="guide">
					<th width="90"></th>
					<th></th>
				</tr>
			</thead>
			<tbody>
        <tr>
          <th><label for="subject">제목</label></th>
          <td><input id="title" name="title" type="text" value="" style="width:100%"/></td>
        </tr>
        <tr class="last_line">
          <th><label for="contents">내용</label></th>
          <td>
            <textarea id="contents" name="contents"></textarea>
          </td>
        </tr>
      </tbody>  
    </table>
    <div class="center_btn">
      <a href="#" id="saveBtn" onclick="javascript:lfn_btn('save'); return false;"><img src="/resources/images/sub/btn_reg.png" /></a>&nbsp;<a href="#" onclick="javascript:lfn_btn('list'); return false;"><img src="/resources/images/sub/btn_censel.png" /></a>
    </div>
    <div class="text">
        <iframe id="attachFrame" name="attachFrame" style="width:100%;height:100px"></iframe>
    </div>
    <div id="bod_search_r">
      <a href="#" onclick="javascript:lfn_btn('list'); return false;"><img src="/resources/images/sub/btn_go_list.png" alt="목록으로 돌아가기" /></a>
    </div>
    <br /><br />
  </div><!-- end pop_content -->
</div>



</body>
</html>


