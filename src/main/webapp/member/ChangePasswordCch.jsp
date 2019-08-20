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
    <title>Q learning - 마이페이지 - 비밀번호 변경</title>

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
	$("#userPassword").focus();	
});

function lfn_btn(pKind, pParam) {
	if ( pKind =="save" ) {
<c:if test = "${session.naverUserYn eq 'Y'}">
		alert("네이버로 가입한 가입자는 비밀번호를 변경 할 수 없습니다.");
		return false;
</c:if>
<c:if test = "${session.naverUserYn eq 'N'}">
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
</c:if>
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
	<input type="hidden" id="sex" name="sex">
	<input type="hidden" id="birthDay" name="birthDay">
	
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
                    <a href='javascript:' onclick="page.goPage('/main/myOrder');"><button id="g1">주문/신청 <span></span>조회</button></a>
                    <a href='javascript:' onclick="page.goPage('/main/myPoint');"><button id="point_2">포인트<span></span></button></a>
                    <a href='javascript:' onclick="page.goPage('/main/myActivity');"><button>나의 <span></span>활동관리</button></a>
                    <a href="javascript:" onclick="page.goPage('/member/userMemberU');"><button>회원<span></span>정보수정</button></a>
                    <a href="javascript:"><button  class="on">비밀번호 <span></span>변경</button></a>
                </div>

                <!-- REGISTER PC VERSION -->
                
                <div class='signup_title_box'>
                    <p class='signup_title line'>비밀번호변경</p>
                    <p>
                        <span class='circle'></span> 현재 비밀번호를 입한 후 새로 사용할 비밀번호를 입력해 주십시오.
                    </p>
                </div>
                <div class='signup_input_list'>
                    <div class='certification_name clear_fix'>
                        <p class="patter">현재 비밀번호</p>
                        <input type='password' name='userPassword' id='userPassword' placeholder='비밀번호를 입력해주세요'>
                    </div>
                   <div class='certification_name clear_fix'>
                        <p class="patter">변경 비밀번호</p>
                        <input type='password' name='newUserPassword' id='newUserPassword' placeholder='비밀번호를 입력해주세요'>
                    </div>
                    <div class='certification_name clear_fix'>
                        <p class="patter">변경 비밀번호 확인</p>
                        <input type='password' name='newUserPassword2' id='newUserPassword2' placeholder='비밀번호를 확인해주세요'>
                    </div>
                    
                    
                </div>
                	
                <div class='signup_btn_box clear_fix'>
                    <button onclick='page.goHome();'>취소</button>
                    <button id="saveBtn" onclick="lfn_btn('save');"<c:if test = "${session.naverUserYn eq 'N'}"> class='last'</c:if>>비밀번호 변경</button>
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