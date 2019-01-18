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
    <title>Q learning - 나의강의실 - 상담 수정</title>

    <%@ include file="../common/commMainInclude.jsp" %>

    <link href='https://fonts.googleapis.com/css?family=Nanum+Gothic' rel='stylesheet'>
    <link rel='stylesheet' href='/resources/homepageQch/css/initialization.css'>
    <link rel='stylesheet' href='/resources/homepageQch/css/mypage/mypage_register.css'>    
</head>

<script type="text/javascript">

$(document).ready(function() {
	$("textarea[name='contents']").cleditor();
});

function lfn_btn(pKind, pParam) {
	if ( pKind =="save" ) {
		if ( lfn_validate() == false )
			return false;
		
		if ( confirm("저장하시겠습니까?") == true ) {
			btnUnbind("saveBtn");
			$.ajax({
				type :"POST",
				url : context + "/counsel/userCounselUpd.do",
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
		}
	} else if ( pKind =="list" ) {
		gfn_goPage("/counsel/userCounselList",""); 
	}
}

function lfn_validate() {
	if ($("#title").val() == "") {
	    alert('제목을 입력해 주세요.');
	    $("#title").select();
	    return false;
	}  

	if ($("#category").val() == "") {
	    alert('분류를 선택해 주세요.');
	    $("#category").select();
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

<form id="frm" name="frm" method="post">
	<input type="hidden" id="seq" name="seq" value="${set.condiVO.seq}"/>

<frameset rows='*'>
    <div class='wrap'>
        <!-- PC HEADER -->
        <%@ include file="../common/mainTopQch.jsp" %>
        <!-- HEAD END -->
        
        <!-- CONTENTS -->
        <div class='contents_wrap process'>
            <!-- QUICK MENU -->
            <%@ include file="../common/mainQuickMenuQch.jsp" %>

            <div class='contents_wrap_box'>
                <!-- Top -->
                <div class='top_area'>
                    <div class='clear_fix'>
                        <div class='process_history_box clear_fix'>
                            <span>
                                <img src='/resources/homepageQch/img/course/ic_home.jpg' alt=' '>
                            </span>
                            <p>HOME</p>
                            <span>
                                <img src='/resources/homepageQch/img/course/arr_right.jpg' alt=' '>
                            </span>
                            <p>상담 수정</p>
                        </div>
                    </div>
                    <h1>
                        상담 <span>수정</span>
                    </h1>
                </div>
                <!-- Top END -->

                <div class='notice_register clear_fix'>
                    <div class='form_box clear_fix'>
                        <div class='title'>
                            <p>제목</p>
                        </div>
                        <div>
                            <input type='text' name='title' id='title' value="${set.data.title}">
                        </div>
                    </div>
                    <div class='form_box clear_fix'>
                        <div class='title'>
                            <p>분류</p>
                        </div>
                        <div>
                            <select name='category' id='category' class='type'>
                                <option value=''>분류를 선택해주세요.</option>
<c:forEach var="row" items="${set.ddCategory}">
				              	<option value="${row.ddKey}" <c:if test="${set.data.category eq row.ddKey}">selected</c:if>>${row.ddValue}</option>
</c:forEach>
                            </select>
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
                </div>

                <div class='detail_btn_area'>
                    <button onclick="lfn_btn('list');">취소</button>
                    <button id="saveBtn" onclick="lfn_btn('save');" class='bg_color'>수정하기</button>
                </div> 
            </div>
        </div>
        <!-- CONTENTS END -->

        <!-- FOOTER -->
        <%@ include file="../common/mainBottomQch.jsp" %>
        <!-- FOOTER END -->
    </div>
</frameset>

</form>

<script src='/resources/homepageQch/js/main.js'></script>

</body>
</html>