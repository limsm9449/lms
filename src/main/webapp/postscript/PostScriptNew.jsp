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
    <title>Q learning - 질문하기</title>

    <%@ include file="../common/commMainInclude.jsp" %>

    <link href='https://fonts.googleapis.com/css?family=Nanum+Gothic' rel='stylesheet'>
    <link rel='stylesheet' href='/resources/homepage/css/initialization.css'>
    <link rel='stylesheet' href='/resources/homepage/css/support/notice_register.css'>
</head>


<script type="text/javascript">
var eval = 0;

function lfn_btn(pKind, pParam) {
	if ( pKind =="save" ) {
		if ( lfn_validate() == false )
			return false;
		
		$("#eval").val(eval);
		 
		if ( confirm("수강후기를 등록하시겠습니까?") == true ) {
			btnUnbind("saveBtn");
			$.ajax({
				type :"POST",
				url : context +"/postscript/postscriptIns.do",
				dataType :"json",
				data : $("#frm").serialize(),
				success : function(json){
					if ( json.rtnMode == "INSERT_OK") {
						alert("<spring:message code="lms.msg.insertOk" text="-" />");
						opener.location.reload();
						window.close();
					}
				},
				error : function(e) {
					alert("<spring:message code="lms.msg.systemError" text="-" />");
				}
			})
		}
	}
}

function lfn_validate() {
	//Validation 검사
	if ( $("#contents").val() == "" ) {
		alert("수강후기를 작성해 주세요.");
		return false;
	}
	
	if ( checkByte($('contents').val()) > course_contents_length ) {
		alert("입력 가능한 자릿수를 넘었습니다.");
		$('contents').Focus();
		return false;
	}

	if ( eval == 0 ) {
		alert("평점을 선택하세요.");
		return false;
	}

	return true;
}

</script>

<body style='background:#fff'>

<form id="frm" name="frm" action="" method="post">
	<input type="hidden" id="courseId" name="courseId" value="${set.condiVO.courseId}"/> 
	<input type="hidden" id="eval" name="eval" value=""/> 
	

<frameset rows='*'>
    <div class='wrap'>
        <!-- CONTENTS -->
        <div class='contents_wrap process'>
            <div class='contents_wrap_box popup'>
                <!-- TOP -->
                <div class='top_area'>
                    <h1>
                        수강후기 <span>등록</span>
                    </h1>
                    <div class='top_text_box clear_fix'>
                        <span><img src='/resources/homepage/img/support/notice_bg.jpg' alt=' '></span>
                        <p class='top_title'>NEWS & NOTICE!</p>
                        <p>
                            큐러닝의 소식과 공지사항을 알려드립니다. <span></span>항상 유익하고 풍성한 소식 놓치지 말고 확인하세요.
                        </p>
                    </div>
                </div>
                <!-- TOP END -->

                <div class='notice_register clear_fix'>
                    <div class='form_box clear_fix flex'>
                        <div class='title'>
                            <p>내용</p>
                        </div>
                        <div class='editor_area'>
                        	<textarea id="contents" name="contents" style="width:650px;height:300px;"></textarea>
                        </div>
                    </div>
                    <div class='form_box clear_fix'>
                        <div class='title'>
                            <p>평점</p>
                        </div>
                        <div class='form_box_score'>
                            <span onclick='review_score(1); eval = 1;' class='score first_left'></span>
                            <span onclick='review_score(2); eval = 2;' class='score'></span>
                            <span onclick='review_score(3); eval = 3;' class='score'></span>
                            <span onclick='review_score(4); eval = 4;' class='score'></span>
                            <span onclick='review_score(5); eval = 5;' class='score'></span>
                        </div>
                    </div>
                </div>

                <div class='detail_btn_area'>
                    <button id="saveBtn" onclick="lfn_btn('save'); return false;" class='bg_color'>저장</button>
                    <button onclick='window.close();'>취소</button>
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