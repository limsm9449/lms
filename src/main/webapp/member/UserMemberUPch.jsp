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
    <title>Q learning - 마이페이지 - 회원정보수정</title>

    <%@ include file="../common/commMainInclude.jsp" %>

    <link href='https://fonts.googleapis.com/css?family=Nanum+Gothic' rel='stylesheet'>
    <link rel='stylesheet' href='/resources/homepagePch/css/initialization.css'>
    <link rel='stylesheet' href='/resources/homepagePch/css/mypage/mypage_main.css'>
    <link rel='stylesheet' href='/resources/homepagePch/css/mypage/mypage_table.css'>
    <link rel='stylesheet' href='/resources/homepagePch/css/mypage/mypage_re.css'>
    <link rel='stylesheet' href='/resources/homepagePch/css/mypage/mypage.css'>
</head>


<script type="text/javascript">


$(document).ready(function() {
	$("#userYear").val("${set.data.birthDay}".substring(0,4));
	$("#userMonth").val("${set.data.birthDay}".substring(5,7));
	$("#userDay").val("${set.data.birthDay}".substring(8,10));

	var email = "${set.data.email}".split("@");
	if ( email[0] != "" ) {
		$("#email1").val(email[0]);
		
		if ( gfn_isExistValueInList($("#emailKind option"), "value", email[1]) ) {
			$("#emailKind").val(email[1]);
		} else {
			$("#email2").val(email[1]);
		}
	}
	
	$("#emailInform").prop('checked', ( "${set.data.emailInformYn}" == "Y" ? true : false ) );
});

function lfn_btn(pKind, pParam) {
	if ( pKind =="save" ) {
		if ( lfn_validate() == false )
			return false;
		
		if ( confirm("수정하시겠습니까?") == true ) {
			$("#sex").val($("input:radio[name=user_gender]:checked").val());
	  		$("#birthDay").val($("#userYear").val() + "-" + $("#userMonth").val() + "-" + $("#userDay").val());
			
			btnUnbind("saveBtn");
			$.ajax({
				type :"POST",
				url : context +"/member/userMemberUpd.do",
				dataType :"json",
				data : $("#frm").serialize(),
				success : function(json){
					if ( json.rtnMode == "UPDATE_OK") {
						alert("<spring:message code="lms.msg.updateOk" text="-" />");
	
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
	if ( formValid.check("homeZipcode",{isNecess:true,msg:"우편번호를 입력하세요.",maxLeng:50}) == false ) return false;
	if ( formValid.check("homeAddr",{isNecess:true,msg:"주소를 입력하세요.",maxLeng:50}) == false ) return false;

	if ( formValid.check("mobile",{isNecess:true,msg:"휴대전화번호를 입력하세요.",minLeng:11,maxLeng:12,isNum:true}) == false ) return false;
	
	if ( formValid.check("email1",{isNecess:true,msg:"이메일주소를 입력하세요.",maxLeng:50}) == false ) return false;
	if ( $("#emailKind").val() == "" && $("#email2").val() == "" ) {
		alert("이메일 주소를 정확히 입력하셔야 합니다.");
		$("#email2").focus();
		return false;
	}
	if ( $("#emailKind").val() == "" ) {
		$("#email").val($("#email1").val() + "@" + $("#email2").val());
	} else {
		$("#email").val($("#email1").val() + "@" + $("#emailKind").val());
	}
	
	$("#emailInformYn").val( ( $("input:checkbox[id='emailInform']").is(":checked") ? "Y" : "N" ) );
	
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
	<input type="hidden" id="sex" name="sex">
	<input type="hidden" id="birthDay" name="birthDay">
	
<frameset rows='*'>
    <div class='wrap'>
        <!-- HEAD -->
        <%@ include file="../common/mainTopPch.jsp" %>
        <!-- HEAD END -->

        <!-- CONTENTS -->
        <div class='contents_wrap process'>
            <!-- QUICK MENU -->
            <%@ include file="../common/mainQuickMenuPch.jsp" %>
            
            <div class='contents_wrap_box'>
                <!-- Top -->
                <div class='top_area'>
                    <div class='clear_fix'>
                        <div class='process_history_box clear_fix'>
                            <span>
                                <img src='/resources/homepagePch/img/course/ic_home.jpg' alt=' '>
                            </span>
                            <p>HOME</p>
                            <span>
                                <img src='/resources/homepagePch/img/course/arr_right.jpg' alt=' '>
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
                    <p class='signup_title line'>회원정보수정</p>
                    <p>
                        <span class='circle'></span> 표시는 반드시 입력하셔야 하는 필수 정보입니다
                    </p>
                    <a  href="#" id="sign_out" onclick="page.goPage('/member/memberRetired');">회원탈퇴</a>
                </div>
                <div class='signup_input_list'>
                    <div class='certification_name clear_fix'>
                        <p>이름</p>
                        <input type="text" name="userName" id="userName" value="${set.data.userName}" disabled>
                    </div>
                    <div class='certification_gender clear_fix'>
                        <p>성별</p>
                        <input type='radio' name='user_gender' id='g_male' value="M" <c:if test="${set.data.sex eq 'M' }">checked</c:if> ><span>남자</span>
                        <input type='radio' name='user_gender' id='g_female' value="F" <c:if test="${set.data.sex eq 'F' }">checked</c:if> ><span>여자</span>
                    </div>
                    <div class='certification_birth clear_fix'>
                        <p>생년월일</p>
                        <select id="userYear" name="userYear">
                                <option value=''>선택</option>
<c:forEach var="i" begin="${set.birthFromYear}" end="${set.birthToYear}" step="1" varStatus ="status">
    							<option value="${i}">${i}</option> 
</c:forEach>   
                            </select>
                        년
                        <select id="userMonth" name="userMonth">
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
                            <select id="userDay" name="userDay">
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
                    <div class='info_input_address clear_fix'>
                        <p>주소</p>
                        <input type='text' name='homeZipcode' id='homeZipcode' placeholder='우편번호' value="${set.data.homeZipcode}">
                        <button onClick="window.open('${set.zipcodeUrl}', 'zipcode','width=900,height=650');">우편번호검색</button>
                        <input class="address_txt" type='text' name='homeAddr' id='homeAddr' placeholder='주소를 입력해주세요.'  value="${set.data.homeAddr}">
                    </div>
                    <div class='info_input_phone clear_fix'>
                        <p>휴대폰 번호</p>
                        <input type='text' name='mobile' id='mobile' value="${set.data.mobile}">
                    </div>
                    <div class='info_input_e-mail clear_fix'>
                        <p>E-Mail</p>
                        <input type="hidden" name="email" id="email" value=""/>
                        <input type='text' name='email1' id='email1' placeholder='' class="eMailtxt">
                        <span class="e-mail_b">@</span>
                        <input type='text' name='email2' id='email2' placeholder='' class="eMailtxt2">
                        <select name='emailKind' id='emailKind' onchange="$('#email2').val('')">
                            <option value=''>직접입력</option>
                            <option value='naver.com'>naver.com</option>
                            <option value='gmail.com'>gmail.com</option>
                            <option value='daum.net'>daum.net</option>
                            <option value='nate.com'>nate.com</option>
                            <option value='hotmail.com'>hotmail.com</option>
                            <option value='yahoo.com'>yahoo.com</option>
                            <option value='empas.com'>empas.com</option>
                            <option value='korea.com'>korea.com</option>
                            <option value='dreamwiz.com'>dreamwiz.com</option>
                        </select>
                    </div>
                    <div class="info_chk">
                    	큐러닝에서 제공하는 강의 안내 및 이벤트, 각종 소식에 대한 알림을 이메일로 받으시겠습니까?  
                        <input type="hidden" name="emailInformYn" id="emailInformYn" value=""/>
                        <input type="checkbox" name="emailInform" value="Y" id="emailInform">
                    </div>
                </div>
                	
                <div class='signup_btn_box clear_fix'>
                    <button onclick='page.goHome();'>취소</button>
                    <button id="saveBtn" onclick="lfn_btn('save');" class='last'>회원정보 수정</button>
                </div>
            </div>

        </div>
        <!-- CONTENTS END -->

        <!-- FOOTER -->
        <%@ include file="../common/mainBottomPch.jsp" %>
        <!-- FOOTER END -->
    </div>
</frameset>

</form>

<script src='/resources/homepagePch/js/main.js'></script>


</body>
</html>