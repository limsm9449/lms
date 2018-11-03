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
    <title>Q learning - 나의강의실 - 회원탈퇴</title>

    <%@ include file="../common/commMainInclude.jsp" %>
    
    <link href='https://fonts.googleapis.com/css?family=Nanum+Gothic' rel='stylesheet'>
    <link rel='stylesheet' href='/resources/homepage/css/initialization.css'>
    <link rel='stylesheet' href='/resources/homepage/css/support/notice_register.css'>
</head>

<script type="text/javascript">

$(document).ready(function() {
	//$("textarea[name='retiredReason']").cleditor();
	$("textarea[name='retiredReason']").val("");
});

function lfn_btn(pKind, pParam) {
	if ( pKind =="save" ) {
		if ( lfn_validate() == false )
			return false;
		
		if ( confirm("회원탈퇴를 하시겠습니까?") == false )
			return false;
		
		btnUnbind("saveBtn");
		$.ajax({
			type :"POST",
			url : context + "/member/memberRetiredUpdate.do",
			dataType :"json",
			data : $("#frm").serialize(),
			success : function(json){
				if ( json.rtnMode == "RETIRED_OK") {
					alert("회원 탈퇴가 정상적으로 처리 되었습니다.");
					top.location = "/";
				} else if ( json.rtnMode == "INFO_ERROR") {
					alert("회원정보가 일치하지 않습니다.");
					btnBind("saveBtn");
				}
			},
			error : function(e) {
				alert("<spring:message code="lms.msg.systemError" text="-" />");
			}
		})
	}
}

function lfn_validate() {
	if ( formValid.check("userId",{isNecess:true}) == false )
		return false;
	if ( formValid.check("userPassword",{isNecess:true}) == false )
		return false;
	if ($("textarea[name='retiredReason']").val() == "") {
	    alert('내용을 입력해주세요.');
	    return false;
	} 
	if ( checkByte($("textarea[name='retiredReason']").val()) > board_contents_length ) {
		alert("입력 가능한 자릿수를 넘었습니다. (" + checkByte($("textarea[name='retiredReason']").val()) + ")");
		$("textarea[name='retiredReason']").Focus();
		return false;
	}	
	
	return true;
}

</script>

<body style='background:#fff'>

<form id="frm" name="frm" method="post">

    <frameset rows='*'>
        <div class='wrap'>
            <!-- PC HEADER -->
            <%@ include file="../common/mainTop.jsp" %>
            <!-- HEAD END -->

            <!-- CONTENTS -->
            <div class='contents_wrap process' onmouseover='sub_hide()'>
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
                                <p>나의강의실</p>
                                <span>
                                    <img src='/resources/homepage/img/course/arr_right.jpg' alt=' '>
                                </span>
                                <p>회원탈퇴</p>
                            </div>
                        </div>
                        <h1>
                            나의 <span>강의실</span>
                        </h1>
                    </div>
                    <!-- Top END -->

                    <div class='util_wrap'>
                        <h1>
                            회원탈퇴
                        </h1>
                        <div class='signup_title_box'>
                            <p>
                                회원탈퇴정보입력 / 회원님의 정보보호를 위해 다시 한 번 본인임을 확인합니다.
                            </p>
                        </div>
                        <div class='signup_input_list'>
                            <div class='certification_name clear_fix'>
                                <p>아이디</p>
                                <input type='text' name='userId' id='userId' value="" placeholder='아이디를 입력해주세요'>
                            </div>
                            <div class='certification_name clear_fix'>
                                <p>비밀번호</p>
                                <input type='password' name='userPassword' id='userPassword' value="" placeholder='비밀번호를 입력해주세요'>
                            </div>
                            
                            <div class='info_input_address clear_fix'>
                                <p>탈퇴 사유</p>
                                <textarea name='retiredReason' id='retiredReason' cols='30' rows='10'></textarea>
                            </div>
                        </div>
                        <div class='withdraw_note'>
                            <p>
                                <strong>※ 회원탈퇴 신청 전에 반드시 확인해 주시기 바랍니다.</strong>
                                회원탈퇴 신청 후에는 모든 정보가 삭제되며, 복원이 불가능하오니 신중하게 결정하여 주시기 바랍니다.<br>
                                - 회원탈퇴 신청 후에는 큐피플 웹사이트에서 이용하셨던 수강정보, 결제 및 포인트, 개인정보 등 모든 정보가 삭제되며, 복구가 불가능합니다.<br>
                                - 회원탈퇴 신청 후 재가입 시 동일한 아이디로 회원가입이 불가능합니다.
                            </p>
                        </div>
                        <div class='detail_btn_area'>
                            <button onclick='page.goHome();'>탈퇴취소</button>
                            <button id="saveBtn" onclick="lfn_btn('save');" class='bg_color'>회원탈퇴확인</button>
                        </div>
                    </div>
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