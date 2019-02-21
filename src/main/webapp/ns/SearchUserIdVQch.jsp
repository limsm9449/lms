<%@ page contentType="text/html;charset=utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!DOCTYPE html>
<html lang='ko' data-useragent='Mozilla/5.0 (compatible; MSIE 10.0; Windows NT 6.2; Trident/6.0)'>

<head>
    <meta charset='utf-8'>
    <meta name='viewport' content='width=device-width, initial-scale=1, minimum-scale=1, maximum-scale=1'>
    <meta http-equiv='X-UA-Compatible' content='ie=edge'>
    <title>Q learning - 아이디/비밀번호 찾기</title>

    <%@ include file="../common/commMainInclude.jsp" %>

    <link href='https://fonts.googleapis.com/css?family=Nanum+Gothic' rel='stylesheet'>

    <link rel='stylesheet' href='/resources/homepage/css/initialization.css'>
    <link rel='stylesheet' href='/resources/homepage/css/etc/find.css'>
</head>

<script type="text/javascript">
$(document).ready(function() {
	$("#userName").focus();
});

function lfn_btn(pKind, pParam) {
	if ( pKind =="find" ) {
		if ( formValid.check("userName",{isNecess:true}) == false )
			return false;
		if ( formValid.check("email",{isNecess:true}) == false )
			return false;
			
		$.ajax({
			type :"POST",
			url : context +"/ns/searchUserId.do",
			dataType :"json",
			data : $("#frm").serialize(),
			success : function(json){
				if ( json.rtnMode == "EXIST") {
					alert("등록된 사용자 ID는 [" + json.rtnMessage + "] 입니다.");
				} else if ( json.rtnMode == "RETIRED") {
					alert("탈퇴한 회원입니다.\n재가입시 관리자에게 문의하시기 바랍니다.");
					$("#userName").select();
				} else if ( json.rtnMode == "NOT_EXIST") {
					alert("해당하는 사용자가 없습니다.");
					$("#userName").select();
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

<form id="frm" name="frm">

<frameset rows='*'>
    <div class='wrap'>
        <!-- HEAD -->
        <%@ include file="../common/mainTop.jsp" %>
        <!-- HEAD END -->

        <!-- CONTENTS -->
        <div class='contents_wrap_box' >
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
                        <p>수강신청</p>
                        <span>
                            <img src='/resources/homepage/img/course/arr_right.jpg' alt=' '>
                        </span>
                        <p>교육과정</p>
                    </div>
                </div>
            </div>
            <!-- Top END -->

            <div class='util_wrap'>
                <h1>
                    아이디 찾기
                </h1>

                <div class='certification_list'>
                    <div class='certification_name clear_fix'>
                        <p>이름</p>
                        <input type='text' name='userName' id='userName' placeholder='이름을 입력해주세요.'>
                    </div>
                    <div class='certification_name clear_fix'>
                        <p>이메일</p>
                        <input type='text' name='email' id='email' placeholder='이메일을 입력해주세요.'>
                    </div>
                </div>  
                <div class='signup_btn_box clear_fix'>
                    <button onclick='page.goHome();'>취소</button>
                    <button class='last' onclick="lfn_btn('find');">아이디 찾기</button>
                </div>
            </div>

        </div>
        <!-- CONTENTS END -->

        <!-- FOOTER -->
        <%@ include file="../common/mainBottom.jsp" %>
        <!-- FOOTER END -->
    </div>
    <script src='/resources/homepage/js/dev_sub.js'></script>
    
</frameset>

</form>

</body>

</html>