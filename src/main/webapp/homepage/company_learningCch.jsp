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
    <title>Q learning - 기업교육문의2</title>

	<%@ include file="../common/commMainInclude.jsp" %>

    <link href='https://fonts.googleapis.com/css?family=Nanum+Gothic' rel='stylesheet'>
   	<link rel='stylesheet' href='/resources/homepageCch/css/initialization.css'>
    <link rel='stylesheet' href='/resources/homepageCch/css/notice/notice_main.css'>
    <link rel='stylesheet' href='/resources/homepageCch/css/notice/mail.css'>
</head>

<script type="text/javascript">

var tempUserId = new Date().getTime();
$(document).ready(function() {
	$("#attachUserId").val(tempUserId);
	
	$("#attachFrame").attr("src","/main/attachI.do?" + "kind=COMP_LEARN&mode=TEMP&userId=" + tempUserId);
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
		if ( $("#companyName").val() == "") {
			alert("사업자명을 입력하세요.");
			$("#aboutMe").focus();
			return;
		}
		if ( $("#title").val() == "") {
			alert("제목을 입력하세요.");
			$("#title").focus();
			return;
		}
		if ( $("#contents").val() == "") {
			alert("내용을 입력하세요.");
			$("#motive").focus();
			return;
		}
		
		$.ajax({
			type :"POST",
			url : context + "/main/companyInquiry.do",
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
	       	<%@ include file="../common/mainTopCch.jsp" %>
	       	<!-- HEAD END -->
	
	        <!-- CONTENTS -->
	        <div class='contents_wrap process' >
	            <!-- QUICK MENU -->
	            <%@ include file="../common/mainQuickMenuCch.jsp" %>

	        	<div class='contents_wrap_box'>
                    <!-- Top -->
                    <div class='top_area'>
                        <div class='clear_fix'>
                            <div class='process_history_box clear_fix'>
                                <span>
                                    <img src='/resources/homepageCch/img/course/ic_home.jpg' alt=' '>
                                </span>
                                <p>HOME</p>
                                <span>
                                    <img src='/resources/homepageCch/img/course/arr_right.jpg' alt=' '>
                                </span>
                                <p>기업교육 문의</p>
                            </div>
                        </div>
                        <h1>
                            기업<span>교육</span> 문의
                        </h1>
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
                            <div>
                            	<input type='text' name='mobile' id='mobile' value="${session.mobile}" placeholder='- 없이 숫자만'>
                            </div>
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
                                <input type='text' name='email' id='email' value="${session.userName}">
                            </div>
                        </div>
                        <div class='form_box clear_fix flex'>
                            <div class='title'>
                                <p class='long'>사업장명(회사)</p>
                            </div>
                            <div>
                                <input type='text' name='companyName' id='companyName'>
                            </div>
                        </div>
                        <div class='form_box clear_fix flex'>
                            <div class='title'>
                                <p>제목</p>
                            </div>
                            <div>
                                <input type='text' name='title' id='title'>
                            </div>
                        </div>
                        
                        <div class='form_box clear_fix flex'>
                            <div class='title'>
                                <p>내용</p>
                            </div>
                            <div>
                                <textarea name='contents' id='contents' placeholder='아래 내용을 입력해주시면 보다 더 빠르고 정확한 상담이 가능합니다.&#13;&#10;&#13;&#10;교육대상 : 예) 신입사원, 개발부서, CS팀 등&#13;&#10;교육인원 : 예) 10명, 50명, 100명 등&#13;&#10;교육 일시 : 예) 6월 말(예정), 매달 1회 등&#13;&#10;남겨주실 말씀 : 예) 솔루션이나 연수원도 같이 상담받고 싶어요'></textarea>
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
            <%@ include file="../common/mainBottomCch.jsp" %>
            <!-- FOOTER END -->
        </div>
    </frameset>

</form>
    
    <script src='/resources/homepageCch/js/main.js'></script>
    
</body>

</html>