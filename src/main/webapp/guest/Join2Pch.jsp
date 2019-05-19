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
    <title>Q learning - 회원가입 - 가입여부확인</title>

    <%@ include file="../common/commMainInclude.jsp" %>

    <link href='https://fonts.googleapis.com/css?family=Nanum+Gothic' rel='stylesheet'>

    <link rel='stylesheet' href='/resources/homepagePch/css/initialization.css'>
    <link rel='stylesheet' href='/resources/homepagePch/css/etc/signup.css'>
</head>

<script type="text/javascript">
function form_chk() {
  	var f = document.frm;
  
  	if (f.userName.value=="") {
    	alert("이름을 입력해 주세요.");
    	f.userName.focus();
    	return;
  	}
  	
  	var chk_v = $("input:radio[name=user_gender]:checked").val();
  	if (chk_v=="") {
	    alert("성별을 선택해 주세요.");
    	return;
  	} else {
  		$("#sex").val(chk_v);
  	}
  
  	if (f.userYear.value=="") {
    	alert("생년을 선택해 주세요.");
    	f.userYear.focus();
    	return;
  	} else if (f.userMonth.value=="") {
    	alert("생월을 선택해 주세요.");
    	f.userMonth.focus();
    	return;
  	} else if (f.userDay.value=="") {
    	alert("생일을 선택해 주세요.");
    	f.userDay.focus();
    	return;
  	} else {
  		$("#birthDay").val(f.userYear.value + "-" + f.userMonth.value + "-" + f.userDay.value);
  	}
  
	$.ajax({
		type :"POST",
		url : context + "/guest/joinCheck.do",
		dataType :"json",
		data : $("#frm").serialize(),
		success : function(json){
			if ( json.rtnMode == "EXIST") {
				alert("이미 가입하셨습니다.");
				page.goPage('/ns/searchUserIdV');
			} else if ( json.rtnMode == "NOT_EXIST") {
				document.frm.action = context + "/guest/join3.do";
				document.frm.target = "_self";
				document.frm.method = "POST";	
				document.frm.submit();
			}
		},
		error : function(e) {
			alert("<spring:message code="lms.msg.systemError" text="-" />");
		}
	})
}
</script>

<body>

<form id="frm" name="frm" method="post" >
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
        
        <!-- QUICK MENU -->
        <%@ include file="../common/mainQuickMenuPch.jsp" %>

        <!-- CONTENTS -->
        <div class='contents_wrap_box' >

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
                        <span><img src='/resources/homepagePch/img/etc/ic_step1.png' alt=''></span>
                        <p>이용약관</p>
                    </div>
                    <div class='arrow'><img src='/resources/homepagePch/img/etc/arr_right.png' alt=''></div>
                    <div class='active'>
                        <span><img src='/resources/homepagePch/img/etc/ic_step2_active.png' alt=''></span>
                        <p>가입여부<span></span>확인</p>
                    </div>
                    <div class='arrow'><img src='/resources/homepagePch/img/etc/arr_right.png' alt=''></div>
                    <div>
                        <span><img src='/resources/homepagePch/img/etc/ic_step3.png' alt=''></span>
                        <p>회원정보<span></span>입력</p>
                    </div>
                    <div class='arrow'><img src='/resources/homepagePch/img/etc/arr_right.png' alt=''></div>
                    <div class='last_right pd'>
                        <span><img src='/resources/homepagePch/img/etc/ic_step4.png' alt=''></span>
                        <p>가입완료</p>
                    </div>
                </div>
                <div class='signup_title_box'>
                    <p class='signup_title'>가입여부확인</p>
                    <p>
                        주민등록번호 입력 없이 메일 인증으로 회원가입이 가능합니다.
                    </p>
                </div>
                <div class='signup_certification_box'>
                    <div class='certification_list'>
                        <div class='certification_name clear_fix'>
                            <p>이름(한글/영문)</p>
                            <input type='text' name='userName' id='userName'>
                        </div>
                        <div class='certification_gender clear_fix'>
                            <p>성별</p>
                            <input type='radio' name='user_gender' id='g_male' value="M"><span>남자</span>
                            <input type='radio' name='user_gender' id='g_female' value="F"><span>여자</span>
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
                    </div>
                    <div class='certification_note'>
                        <p>
                            주민등록 번호 입력 없이 메일 인증으로 회원가입이 가능합니다.<span></span><strong>이름, 생년월일, 성별은 가입 후에 변경이 불가능합니다. 추후 본인확인을 위해 정확하게 가입 부탁드립니다.</strong><span></span>회원가입 후 고용보험과정을 수강 신청 시 노동부에 고용보험신고를 위해 주민등록 번호를 수집하고 있습니다.<span></span>가급적 신분증과 동일한 정보를 입력하시면 향후 고용보험 과정 수강 시 본인 확인이 용이합니다.
                        </p>
                    </div>
                </div>
                <div class='signup_btn_box clear_fix'>
                    <button onclick='page.goHome();'>취소</button>
                    <button class='last' onclick="form_chk();">다음</button>
                </div>
            </div>

        </div>
        <!-- CONTENTS END -->

        <!-- FOOTER -->
        <%@ include file="../common/mainBottomPch.jsp" %>
        <!-- FOOTER END -->
    </div>
</form>
    
    <!-- Local -->
    <script src='/resources/homepagePch/js/main.js'></script>
</frameset>
</body>

</html>