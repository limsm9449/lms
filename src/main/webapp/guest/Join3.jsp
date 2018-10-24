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
    <title>Q learning - 회원가입 - 회원정보입력</title>

    <%@ include file="../common/commMainInclude.jsp" %>
    
    <link href='https://fonts.googleapis.com/css?family=Nanum+Gothic' rel='stylesheet'>

    <link rel='stylesheet' href='/resources/homepage/css/initialization.css'>
    <link rel='stylesheet' href='/resources/homepage/css/etc/signup.css'>
</head>

<script type="text/javascript">
var preUrl = "/guest/"; 

$(document.body).ready(function () {
	$("#userYear").val("${set.condiVO.userYear}");
	$("#userMonth").val("${set.condiVO.userMonth}");
	$("#userDay").val("${set.condiVO.userDay}");
});

function lfn_btn(pKind, pParam) {
	if ( pKind =="save" ) {
		if ( lfn_validate() == false )
			return false;
		
		$("#sex").val($("input:radio[name=user_gender]:checked").val());
  		$("#birthDay").val("${set.condiVO.userYear}" + "-" + "${set.condiVO.userMonth}" + "-" + "${set.condiVO.userDay}");

		if ( confirm("회원가입 하시겠습니까?") == true ) {
			btnUnbind("saveBtn");
			$.ajax({
				type :"POST",
				url : context + preUrl + "joinMemberInsert.do",
				dataType :"json",
				data : $("#frm").serialize(),
				success : function(json){
					if ( json.rtnMode == "EXIST_USERID") {
						alert("아이디가 존재합니다.\n다른 아이디를 입력하세요.");
						btnBind("saveBtn");
						$("#userId").focus();
					} else if ( json.rtnMode == "EXIST_EMAIL") {
						alert("이메일주소가  존재합니다.\n다른 이메일주소를 입력하세요.");
						btnBind("saveBtn");
						$("#email").focus();
					} else if ( json.rtnMode == "INSERT_OK") {
						alert("정상적으로 회원가입이 되었습니다.\n발송된 이메일을 통해서 인증을 하셔야 로그인이 가능합니다.");
						
						window.location = "/guest/joinFinal.do";
					}
				},
				error : function(e) {
					btnBind("saveBtn");
					alert("<spring:message code="lms.msg.systemError" text="-" />");
				}
			})
		}
	} else if ( pKind =="isExistUserId" ) {
		if ( formValid.check("userId",{isNecess:true,msg:"아이디를 입력하세요.",minLeng:7,maxLeng:15}) == false ) return false;
		if ( isUserId($("#userId").val()) == false ) {
			alert("아이디는 영문자와 숫자로 구성이 되어야 합니다.");
			$("#userId").focus();
			return false;
		}

		btnUnbind("checkBtn");
		$.ajax({
			type :"POST",
			url : context + preUrl + "isExistUserId.do",
			dataType :"json",
			data : $("#frm").serialize(),
			success : function(json){
				if ( json.rtnMode == "EXIST") {
					alert("등록된 회원 아이디 입니다.");
					$("#userId").focus();
				} else {
					alert("등록 가능한 회원 아이디 입니다.");
					$("#userIdCheck").val("Y");
				}
				
				btnBind("checkBtn");
			},
			error : function(e) {
				alert("<spring:message code="lms.msg.systemError" text="-" />");
			}
		})
	}
}

function lfn_goBack() {
	page.goHome();
}

function lfn_validate() {
	if ( formValid.check("userId",{isNecess:true,msg:"아이디를 입력하세요.",minLeng:7,maxLeng:15}) == false ) return false;
	if ( formValid.check("userPassword",{isNecess:true,msg:"비밀번호를 입력하세요.",minLeng:1,maxLeng:15}) == false ) return false;
	if ( formValid.check("userPassword2",{isNecess:true,msg:"비밀번호 확인을 입력하세요.",minLeng:1,maxLeng:15}) == false ) return false;
	if ( isExistNumAlpha($("#userPassword").val()) == false ) {
		alert("영문/숫자(혼용)를 입력하셔야 합니다.");
		$("#userPassword").focus();
		return false;
	}
	if ( $("#userPassword").val() != $("#userPassword2").val() ) {
		alert("비밀번호는 일치해야 합니다.");
		$("#userPassword2").focus();
		return false;
	}
	if ( formValid.check("mobile",{isNecess:true,msg:"휴대전화번호를 입력하세요.",minLeng:11,maxLeng:12,isNum:true}) == false ) return false;
	if ( formValid.check("email",{isNecess:true,msg:"이메일주소를 입력하세요.",maxLeng:50,isEmail:true}) == false ) return false;
	if ( formValid.check("homeZipcode",{isNecess:true,msg:"우편번호를 입력하세요.",maxLeng:50}) == false ) return false;
	if ( formValid.check("homeAddr",{isNecess:true,msg:"주소를 입력하세요.",maxLeng:50}) == false ) return false;
	if ( $("#userIdCheck").val() != "Y" ) {
		alert("회원 아이디 검색을 하셔야 합니다.");
		$("#userId").focus();
		return false;
	}
	
	return true;
}

</script>

<body>

<form id="frm" name="frm" method="post">
	<input type="hidden" id="sex" name="sex">
	<input type="hidden" id="birthDay" name="birthDay">
	
<frameset rows='*'>
    <div class='wrap'>
        <!-- HEAD -->
        <%@ include file="../common/mainTop.jsp" %>
        <!-- HEAD END -->

        <!-- CONTENTS -->
        <div class='contents_wrap_box' onmouseover='sub_hide()'>
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
                        <p>회원가입</p>
                    </div>
                </div>
            </div>
            <!-- Top END -->

            <div class='util_wrap'>
                <h1>
                    회원가입
                </h1>
                <div class='util_step_box clear_fix'>
                    <div class='pd'>
                        <span><img src='/resources/homepage/img/etc/ic_step1.png' alt=''></span>
                        <p>이용약관</p>
                    </div>
                    <div class='arrow'><img src='/resources/homepage/img/etc/arr_right.png' alt=''></div>
                    <div>
                        <span><img src='/resources/homepage/img/etc/ic_step2.png' alt=''></span>
                        <p>가입여부<span></span>확인</p>
                    </div>
                    <div class='arrow'><img src='/resources/homepage/img/etc/arr_right.png' alt=''></div>
                    <div class='active'>
                        <span><img src='/resources/homepage/img/etc/ic_step3_active.png' alt=''></span>
                        <p>회원정보<span></span>입력</p>
                    </div>
                    <div class='arrow'><img src='/resources/homepage/img/etc/arr_right.png' alt=''></div>
                    <div class='last_right pd'>
                        <span><img src='/resources/homepage/img/etc/ic_step4.png' alt=''></span>
                        <p>가입완료</p>
                    </div>
                </div>
                <div class='signup_title_box'>
                    <p class='signup_title line'>회원정보입력</p>
                    <p>
                        <span class='circle'></span> 표시는 반드시 입력하셔야 하는 필수 정보입니다
                    </p>
                </div>
                <div class='signup_input_list'>
                    <div class='certification_name clear_fix'>
                        <p>이름</p>
                        <input type="text" name="userName" id="userName" value="${set.condiVO.userName}" readonly="readonly"/>
                    </div>
                    <div class='certification_gender clear_fix'>
                        <p>성별</p>
                        <input type='radio' name='user_gender' id='g_male' value="M" <c:if test="${set.condiVO.sex eq 'M' }">checked</c:if> disabled><span>남자</span>
                        <input type='radio' name='user_gender' id='g_female' value="F" <c:if test="${set.condiVO.sex eq 'F' }">checked</c:if> disabled><span>여자</span>
                    </div>
                    <div class='certification_birth clear_fix'>
                        <p>생년월일</p>
                        <select id="userYear" name="userYear" disabled>
                                <option value=''>선택</option>
<c:forEach var="i" begin="${set.birthFromYear}" end="${set.birthToYear}" step="1" varStatus ="status">
    							<option value="${i}">${i}</option> 
</c:forEach>   
                            </select>
                        년
                        <select id="userMonth" name="userMonth" disabled>
                                <option value=''>선택</option>
<c:forEach var="i" begin="1" end="12" step="1" varStatus ="status">
	<c:if test="${i < 10}">
                                <option value="0${i}">${i}</option>
	</c:if>     
	<c:if test="${i >= 10}">
                                <option value="${i}">${i}</option>
	</c:if>     
</c:forEach>    
                            </select>
                            월
                            <select id="userDay" name="userDay" disabled>
                                <option value=''>선택</option>
<c:forEach var="i" begin="1" end="31" step="1" varStatus ="status">
	<c:if test="${i < 10}">
                                <option value="0${i}">${i}</option>
	</c:if>     
	<c:if test="${i >= 10}">
                                <option value="${i}">${i}</option>
	</c:if>     
</c:forEach>     
                            </select>
                        일
                    </div>
                    <div class='certification_name clear_fix'>
                        <p>아이디</p>
                        <input type="text" name="userId" id="userId" onchange="$('#userIdCheck').val('N');"/>
		                  <input type="hidden" name="userIdCheck" id="userIdCheck" />
		                  <a href="#" id="checkBtn" onClick="javascript:lfn_btn('isExistUserId'); return false;"><img src="/resources/images/sub/btn_id_chk.png" /></a>
                    </div>
                    <div class='info_input_phone clear_fix'>
                        <p>휴대폰 번호</p>
                        <select name='agency' id='agency'>
                            <option value='선택'>선택</option>
                            <option value='SK'>SK</option>
                            <option value='KT'>KT</option>
                            <option value='LG'>LG U+</option>
                            <option value='알뜰폰'>알뜰폰</option>
                        </select>
                        <input type='text' name='mobile' id='mobile' placeholder='- 없이 숫자만'>
                        <button>인증번호요청</button>
                    </div>
                    <div class='certification_name clear_fix'>
                        <p>비밀번호</p>
                        <input type='password' name='userPassword' id='userPassword' placeholder='8자리 이상 입력해주세요'>
                    </div>
                    <div class='certification_name clear_fix'>
                        <p>비밀번호 확인</p>
                        <input type='password' name='userPassword2' id='userPassword2' placeholder='비밀번호를 확인해주세요'>
                    </div>
                    <div class='certification_name clear_fix'>
                        <p>E-Mail</p>
                        <input type="text" name="email" id="email" value=""/>
                    </div>
                    <div class='info_input_address clear_fix'>
                        <p>주소</p>
                        <input type='text' name='homeZipcode' id='homeZipcode' placeholder='우편번호'>
                        <button onClick="window.open('${set.zipcodeUrl}', 'zipcode','width=900,height=650');">우편번호검색</button>
                        <input type='text' name='homeAddr' id='homeAddr' placeholder='주소를 입력해주세요.'>
                    </div>
                </div>
                <div class='signup_btn_box clear_fix'>
                    <button onclick='page.goHome();'>취소</button>
                    <button class='last' id="saveBtn" onclick="lfn_btn('save');">회원가입</button>
                </div>
            </div>

        </div>
        <!-- CONTENTS END -->

        <!-- FOOTER -->
        <%@ include file="../common/mainBottom.jsp" %>
        <!-- FOOTER END -->
    </div>
</form>
    
    <!-- Local -->
    <script src='/resources/homepage/js/sub.js'></script>

    <!-- Server -->
    <!-- <script src='/resources/homepage/js/dev_sub.js'></script> -->
</frameset>
</body>

</html>