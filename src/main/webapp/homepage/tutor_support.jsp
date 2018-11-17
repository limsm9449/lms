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
    <title>Q learning - 튜터 지원</title>

	<%@ include file="../common/commMainInclude.jsp" %>
	
    <link href='https://fonts.googleapis.com/css?family=Nanum+Gothic' rel='stylesheet'>
    <link rel='stylesheet' href='/resources/homepage/css/initialization.css'>
    <link rel='stylesheet' href='/resources/homepage/css/support/mail.css'>
</head>

<script type="text/javascript">

var tempUserId = new Date().getTime();
$(document).ready(function() {
	$("#attachUserId").val(tempUserId);
	
	$("#attachFrame").attr("src","/main/attachI.do?" + "kind=TUTOR_SUPP&mode=TEMP&userId=" + tempUserId);
});

function lfn_btn(pKind, pParam) {
	if ( pKind == "inquiry" ) {
		if ( $("#userName").val() == "") {
			alert("이름을 입력하세요.");
			$("#userName").focus();
			return;
		}
		if ( $("#mobile").val() == "") {
			alert("휴대푠을 입력하세요.");
			$("#mobile").focus();
			return;
		}
		if ( $("#tel").val() == "") {
			alert("전화번호를 입력하세요.");
			$("#tel").focus();
			return;
		}
		if ( $("#email").val() == "") {
			alert("이메일을 입력하세요.");
			$("#email").focus();
			return;
		}
		if ( $("#aboutMe").val() == "") {
			alert("자기소개를 입력하세요.");
			$("#aboutMe").focus();
			return;
		}
		if ( $("#motive").val() == "") {
			alert("지원과정을 입력하세요.");
			$("#motive").focus();
			return;
		}

		$.ajax({
			type :"POST",
			url : context + "/main/tutorInquiry.do",
			dataType :"json",
			data : $("#frm").serialize(),
			success : function(json){
				if ( json.rtnMode == "OK") {
					alert("문의하였습니다.");
					page.goHome();
				} else {
					alert("<spring:message code="lms.msg.systemError" text="-" />");
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

<form name="frm" id="frm" method="post">
	<input type='hidden' name='attachUserId' id='attachUserId'>

    <frameset rows='*'>
        <div class='wrap'>
            <!-- HEAD -->
	       	<%@ include file="../common/mainTop.jsp" %>
	       	<!-- HEAD END -->
	
	        <!-- CONTENTS -->
	        <div class='contents_wrap process' >
	        	<div class='contents_wrap_box'>
		            <!-- QUICK MENU -->
		            <%@ include file="../common/mainQuickMenu.jsp" %>

                    <!-- Top -->
                    <div class='top_area'>
                        <div class='clear_fix'>
                            <div class='process_history_box clear_fix'>
                                <span>
                                    <img src='/resources/homepage/img/course/ic_home.jpg' alt=' '>
                                </span>
                                <p>HOME</p>
                                <span>
                                    <img src='/resources/homepage/img/course/arr_right.jpg' alt=' '>
                                </span>
                                <p>튜터지원</p>
                            </div>
                        </div>
                        <h1>
                            튜터<span>지원</span>
                        </h1>
                        <!-- <div class='top_text_box clear_fix'>
                            <span><img src='/resources/homepage/img/support/mail_bg.jpg' alt=' '></span>
                            <p class='top_title'>
                                <strong>큐러닝</strong>에 문의하세요.
                            </p>
                            <p>
                                온라인 교육문의 및 학습지원센터를 통해서도 찾지 못하신 문의는 1:1 메일문의로 <span></span>자세히 안내받으실 수 있습니다. <span></span>컨텐츠 오류와 같이 학습 중 불편한 사항이나 건의하고자 하는 내용, 그리고 <span></span>큐러닝을 칭찬하는 모든 사항들을 이곳에 남겨주세요. <span></span>빠른 시일 내에 답변해드리겠습니다.
                            </p>
                            <p class='time'>
                                &#8251; 1:1 메일 상담시간 : 평일 08:00 ~ 17:00
                            </p>
                        </div> -->
                    </div>
                    <!-- Top END -->

                    <!-- Contents -->
                    <div class='mail_ask clear_fix'>
                        <div class='form_box clear_fix flex'>
                            <div class='title'>
                                <p>이름</p>
                            </div>
                            <div>
                                <input type='text' name='userName' id='userName' value="${session.userName}">
                            </div>
                        </div>
                        <div class='form_box phone clear_fix flex'>
                            <div class='title'>
                                <p>휴대폰</p>
                            </div>
                            <input type='text' name='mobile' id='mobile' value="${session.mobile}" placeholder='- 없이 숫자만'>
                        </div>
                        <div class='form_box clear_fix flex'>
                            <div class='title'>
                                <p>전화번호</p>
                            </div>
                            <div>
                                <input type='text' name='tel' id='tel'>
                            </div>
                        </div>
                        <div class='form_box clear_fix flex'>
                            <div class='title'>
                                <p>이메일</p>
                            </div>
                            <div>
                                <input type='text' name='email' id='email' value="${session.email}">
                            </div>
                        </div>
                        <div class='form_box clear_fix flex'>
                            <div class='title'>
                                <p>자기소개</p>
                            </div>
                            <div>
                                <textarea name='aboutMe' id='aboutMe' placeholder='학력/경력 : &#13;&#10;자격증 : &#13;&#10;소개 : '></textarea>
                            </div>
                        </div>
                        <div class='form_box clear_fix flex'>
                            <div class='title'>
                                <p>지원과정</p>
                            </div>
                            <div>
                                <textarea name='motive' id='motive' placeholder='분야 : &#13;&#10;과정 : &#13;&#10;기타 : '></textarea>
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
                        <a href='#' onclick="javascript:page.goHome();">취소</a>
                        <a href='#' onclick="javascript:lfn_btn('inquiry'); return false;"  class='bg_color'>문의하기</a>
                    </div> 
                    <!-- Contents END -->
                </div>
            </div>
            <!-- CONTENTS END -->

            <!-- FOOTER -->
            <%@ include file="../common/mainBottom.jsp" %>
            <!-- FOOTER END -->
        </div>
    </frameset>

</form>    
    <script src='/resources/homepage/js/dev_sub.js'></script>
    
</body>

</html>