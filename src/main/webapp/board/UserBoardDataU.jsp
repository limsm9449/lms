<%@ page contentType="text/html;charset=utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!DOCTYPE html>
<html lang='ko'>

<head>
    <meta charset='utf-8'>
    <meta name='viewport' content='width=device-width, initial-scale=1, minimum-scale=1, maximum-scale=1'>
    <meta http-equiv='X-UA-Compatible' content='ie=edge'>
    <title>Q learning - 자료실 등록</title>

    <%@ include file="../common/commMainInclude.jsp" %>

    <link href='https://fonts.googleapis.com/css?family=Nanum+Gothic' rel='stylesheet'>
    <link rel='stylesheet' href='/resources/homepage/css/initialization.css'>
    <link rel='stylesheet' href='/resources/homepage/css/support/notice_register.css'>
</head>

<script type="text/javascript">

var preUrl = "/board/"; 

$(document).ready(function() {
	$("textarea[name='contents']").cleditor({height:250});
	$("#attachFrame").attr("src","/board/attachU.do?" + "pSeq=${set.condiVO.seq}&kind=B_DATA");
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
			url : context + preUrl + "boardDataUpd.do",
			dataType :"json",
			data : $("#frm").serialize(),
			success : function(json){
				if ( json.rtnMode == "UPDATE_OK") {
					page.goPage('/board/userBoardDataList', decodeURIComponent('${set.condiVO.prevParams}'));
				}
			},
			error : function(e) {
				alert("<spring:message code="lms.msg.systemError" text="-" />");
			}
		})
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

<body style='background:#fff'>
<form id="frm" name="frm" action="" method="post">
	<input id="courseId" name="courseId" value="${set.condiVO.courseId}" type="hidden"/>
	<input id="seq" name="seq" value="${set.condiVO.seq}" type="hidden"/>
	<input id="prevParams" name="prevParams" type="hidden" value="${set.condiVO.prevParams}">

<frameset rows='*'>
    <div class='wrap'>
        <!-- CONTENTS -->
        <div class='contents_wrap process'>
            <div class='contents_wrap_box popup'>
                <!-- TOP -->
                <div class='top_area'>
                    <h1>
                        자료실<span>수정</span>
                    </h1>
                    <div class='top_text_box clear_fix'>
                        <span><img src='/resources/homepage/img/support/notice_bg.jpg' alt=' '></span>
                        <p class='top_title'>Reference Room</p>
                        <p>
                            유익한 자료를 제공합니다. <span></span>필요한 자료들을 찾아보고 활용하세요.
                        </p>
                    </div>
                </div>
                <!-- TOP END -->

                <div class='notice_register clear_fix'>
                    <div class='form_box clear_fix'>
                        <div class='title'>
                            <p>제목</p>
                        </div>
                        <div>
                            <input type='text' name='title' id='title' value="<c:out value="${set.data.title}" escapeXml="true" />">
                        </div>
                    </div>
                    <div class='form_box clear_fix flex'>
                        <div class='title'>
                            <p>내용</p>
                        </div>
                        <div class='editor_area'>
                        	<textarea id="contents" name="contents">${set.data.contents}</textarea>
                        </div>
                    </div>
                    <div class='form_box clear_fix flex'>
                        <div class='title'>
                            <p>파일첨부</p>
                        </div>
                        <div>
                            <iframe id="attachFrame" name="attachFrame" frameborder='0'></iframe>
                        </div>
                    </div>
                </div>

                <div class='detail_btn_area'>
                    <a href="#" onclick="page.goPage('/board/userBoardDataList', decodeURIComponent('${set.condiVO.prevParams}'));">취소</a>
                    <a href="#" id="saveBtn" onclick="javascript:lfn_btn('save'); return false;" class='bg_color'>수정하기</a>
                </div> 

            </div>
        </div>
        <!-- CONTENTS END -->
    </div>
</frameset>

</form>
<script src='/resources/homepage/js/dev_sub.js?timestamp=<%=timestamp%>'></script>
</body>
</html>