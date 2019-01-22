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
    <title>Q learning - 나의강의실 - 회원정보수정</title>

    <%@ include file="../common/commMainInclude.jsp" %>

    <link href='https://fonts.googleapis.com/css?family=Nanum+Gothic' rel='stylesheet'>

    <link rel='stylesheet' href='/resources/homepage/css/initialization.css'>
    <link rel='stylesheet' href='/resources/homepage/css/support/notice_register.css'>
</head>

<script type="text/javascript">

$(document).ready(function() {
	$("#userPassword").focus();	
});

function lfn_btn(pKind, pParam) {
	if ( pKind =="save" ) {
		if ( lfn_validate() == false )
			return false;
		
		if ( confirm("저장하시겠습니까?") == true ) {
			btnUnbind("saveBtn");
			$.ajax({
				type :"POST",
				url : context +"/member/memberChangePasswordUpdate.do",
				dataType :"json",
				data : $("#frm").serialize(),
				success : function(json){
					if ( json.rtnMode == "PASSWORD_ERROR") {
						alert("기존 비밀번호가 틀립니다.");
						$("#userPassword").focus();
						btnBind("saveBtn");
					} else if ( json.rtnMode == "PASSWORD_OK") {
						alert("비밀번호가 변경되었습니다.");
						page.goHome();
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
	if ( formValid.check("userPassword",{isNecess:true,maxLeng:15}) == false )
		return false;
	if ( formValid.check("newUserPassword",{isNecess:true,minLeng:6,maxLeng:12}) == false )
		return false;
	if ( formValid.check("newUserPassword2",{isNecess:true,minLeng:6,maxLeng:12}) == false )
		return false;
	if ( isExistNumAlpha($("#newUserPassword").val()) == false ) {
		alert("영문/숫자(혼용)를 입력하셔야 합니다.");
		$("#newUserPassword").focus();
		return false;
	}
	if ( $("#newUserPassword").val() != $("#newUserPassword2").val() ) {
		alert("비밀번호는 일치해야 합니다.");
		$("#newUserPassword2").focus();
		return false;
	}
}

</script>

<body>

<form id="frm" name="frm" method="post">
	<div style="display:none">
		<!-- 이것은 자동이동을 막기위함이다. -->
		<input type="submit" onclick="return false;" />
		<input type="text"/>
	</div>
	<input type="hidden" name="userId" id="userId" value="${set.data.userId}" />
	<input type="hidden" id="sex" name="sex">
	<input type="hidden" id="birthDay" name="birthDay">
	
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
                        <p>나의강의실</p>
                        <span>
                            <img src='/resources/homepage/img/course/arr_right.jpg' alt=' '>
                        </span> 
                        <p>비밀번호 변경</p>
                    </div>
                </div>
            </div>
            <!-- Top END -->
			
			<div class='util_wrap'>
                <h1>
                    비밀번호 변경
                </h1>
                <div class='signup_title_box'>
                    <p>
                        현재 비밀번호를 입력한 후 새로 사용할 비밀번호를 입력해 주십시오.
                    </p>
                </div>
                <div class='signup_input_list'>
                    <div class='certification_name clear_fix'>
                        <p>현재 비밀번호</p>
                        <input type='password' name='userPassword' id='userPassword' placeholder='비밀번호를 입력해주세요'>
                    </div>
                    <div class='certification_name clear_fix'>
                        <p>변경 비밀번호</p>
                        <input type='password' name='newUserPassword' id='newUserPassword' placeholder='비밀번호를 입력해주세요'>
                        <p class='note'>
                            영문/숫자(혼용) 6~12글자 이내로 입력
                        </p>
                    </div>
                    <div class='certification_name clear_fix'>
                        <p>변경 비밀번호 확인</p>
                        <input type='password' name='newUserPassword2' id='newUserPassword2' placeholder='비밀번호를 확인해주세요'>
                        <p class='note'>
                            비밀번호를 한번 더 입력, 잊지 않도록 주의하세요.
                        </p>
                    </div>
                </div>
                <div class='detail_btn_area'>
                    <button onclick='page.goHome();'>변경취소</button>
                    <button id="saveBtn" onclick="lfn_btn('save');" class='bg_color'>변경완료</button>
                </div>
            </div>
        </div>
        <!-- CONTENTS END -->

        <!-- FOOTER -->
        <%@ include file="../common/mainBottom.jsp" %>
        <!-- FOOTER END -->
    </div>

    <script src='/resources/homepage/js/dev_sub.js?timestamp=<%=timestamp%>'></script>

</frameset>

</form>

</body>

</html>