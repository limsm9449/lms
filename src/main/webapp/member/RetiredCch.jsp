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
    <title>Q learning - 마이페이지 - 회원탈퇴</title>

    <%@ include file="../common/commMainInclude.jsp" %>

    <link href='https://fonts.googleapis.com/css?family=Nanum+Gothic' rel='stylesheet'>
    <link rel='stylesheet' href='/resources/homepageCch/css/initialization.css'>
    <link rel='stylesheet' href='/resources/homepageCch/css/mypage/mypage_main.css'>
    <link rel='stylesheet' href='/resources/homepageCch/css/mypage/mypage_table.css'>
    <link rel='stylesheet' href='/resources/homepageCch/css/mypage/mypage_re.css'>
    <link rel='stylesheet' href='/resources/homepageCch/css/mypage/mypage.css'>
</head>

<script type="text/javascript">

$(document).ready(function() {
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

<body>

<form id="frm" name="frm" method="post">
	<div style="display:none">
		<!-- 이것은 자동이동을 막기위함이다. -->
		<input type="submit" onclick="return false;" />
		<input type="text"/>
	</div>
	
<frameset rows='*'>
    <div class='wrap'>
        <!-- HEAD -->
        <%@ include file="../common/mainTopCch.jsp" %>
        <!-- HEAD END -->

        <!-- CONTENTS -->
        <div class='contents_wrap process'>
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
                            <p>마이페이지</p>
                            
                        </div>
                    </div>
                    <h1>
                        <span>마이</span>페이지
                    </h1>
                </div>
                <!-- Top END -->

                <div class='classroom_subtitle'>
                </div>

                <!-- TAB AREA -->
                <div class='register_method_tab clear_fix'>
                    <a href="javascript:" onclick="page.goPage('/main/myOrder');"><button id="g1">주문/신청 <span></span>조회</button></a>
                    <a href="javascript:" onclick="page.goPage('/main/myPoint');"><button id="point_2">포인트<span></span></button></a>
                    <a href="javascript:" onclick="page.goPage('/main/myActivity');"><button>나의 <span></span>활동관리</button></a>
                    <a href="javascript:"><button class="on">회원<span></span>정보수정</button></a>
                    <a href="javascript:" onclick="page.goPage('/member/memberChangePassword');"><button>비밀번호 <span></span>변경</button></a>
                </div>

                <!-- REGISTER PC VERSION -->
                
                <div class='signup_title_box'>
                    <p class='signup_title line'>회원탈퇴</p>
                    <p>
                        <span class='circle'></span> 회원탈퇴정보입력 / 회원님의 정보보호를 위해 다시 한 번 본인임을 확인합니다.
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
                    
                    <div class='certification_name clear_fix'>
                        <p>탈퇴 사유</p>
                        <textarea name='retiredReason' id='retiredReason' cols='30' rows='10'></textarea>
                    </div>
                    
                    <div class="info_chk">
                    	<span class="out_memo"><font id="memo_t">※ 회원탈퇴 신청 전에 반드시 확인해 주시기 바랍니다.</font><Br>
회원탈퇴 신청 후에는 모든 정보가 삭제되며, 복원이 불가능하오니 신중하게 결정하여 주시기 바랍니다.<Br>
- 회원탈퇴 신청 후에는 큐피플 웹사이트에서 이용하셨던 수강정보, 결제 및 포인트, 개인정보 등 모든 정보가 
   삭제되며, 복구가 불가능합니다.<Br>
- 회원탈퇴 신청 후 재가입 시 동일한 아이디로 회원가입이 불가능합니다. 
						</span>
                    </div>
                </div>
                	
                <div class='signup_btn_box clear_fix'>
                    <button onclick='page.goHome();'>취소</button>
                    <button id="saveBtn" onclick="lfn_btn('save');" class='last'>회원탈퇴</button>
                </div>
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