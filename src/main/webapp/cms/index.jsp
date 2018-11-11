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
    <title>Q learning - 나의강의실</title>

    <%@ include file="../common/commMainInclude.jsp" %>

    <link href='https://fonts.googleapis.com/css?family=Nanum+Gothic' rel='stylesheet'>
    <link rel='stylesheet' href='/resources/homepage/css/initialization.css'>
    <link rel='stylesheet' href='/resources/homepage/css/etc/admin_login.css'>
</head>

<script type="text/javascript">

function lfn_cms_login() {
	if ( $("#userId").val() == "") {
		alert("<spring:message code="lms.msg.inputUserId" text="-" />");
		$("#userId").focus();
		return;
	}
	if ( $("#password").val() == "") {
		alert("<spring:message code="lms.msg.inputPassword" text="-" />");
		$("#password").focus();
		return;
	}
	if ( $("#auth").val() == "") {
		alert("권한을 선택하세요.");
		$("#auth").focus();
		return;
	}
	
	document.frm.target = "tranFrame";	
	document.frm.submit();
}

function lfn_page() {
	page.goAdminHome();
}

function lfn_login(userId) {
	$("#userId").val(userId);
	$("#password").val("1");
	lfn_cms_login();
}

</script> 

<body style='background:#fff'>

<form name="frm" action="/loginCheck.do" method="post">

<frameset rows='*'>
    <div class='wrap_login'>
        <span><img src='/resources/homepage/img/logo.png' alt=''></span>
        <div class='login_box clear_fix'>
            <h1>Login</h1>
            <p>큐러닝 관리자 시스템에 오신 것을 환영합니다</p>
            <div class='login_form_box'>
                <p>아이디</p>
                <input type='text' name='userId' id='userId'>
                <p>비밀번호</p>
                <input type='password' name='password' id='password'>
                <p>인증</p>
				<select id="auth" name="auth" class="input_log auth">
   		          	<option value="">권한 선택</option>
   					<option value="ADMIN" selected="">Admin</option>
   					<option value="CONTENTS_MANAGER">컨텐츠 관리자</option>
   					<option value="SITE_MANAGER">사이트 관리자</option>
   					<option value="TEACHER">Teacher</option>
   					<option value="TUTOR">Tutor</option>
           		</select>
            </div>
            <button onclick = 'lfn_cms_login()'>로그인</button>
        </div>
    </div>
</frameset>

</form>
<iframe name="tranFrame" style="display:none;"></iframe>

		<br>
		<br>
		<br>
		<br>
		<a href="#" onclick="javascript:lfn_login('admin'); return false;">admin</a><br>
		<a href="#" onclick="javascript:lfn_login('admin2'); return false;">Contents admin</a><br>
		<a href="#" onclick="javascript:lfn_login('admin3'); return false;">Manage admin</a><br>
		<a href="#" onclick="javascript:lfn_login('USER001'); return false;">USER001</a>
		<a href="#" onclick="javascript:lfn_login('USER002'); return false;">USER002</a>
		<a href="#" onclick="javascript:lfn_login('USER003'); return false;">USER003</a>
		<a href="#" onclick="javascript:lfn_login('USER004'); return false;">USER004</a>
		<a href="#" onclick="javascript:lfn_login('USER005'); return false;">USER005</a><br>
		<a href="#" onclick="javascript:lfn_login('TUTOR1'); return false;">TUTOR1</a>
		<a href="#" onclick="javascript:lfn_login('TUTOR2'); return false;">TUTOR2</a>
		<a href="#" onclick="javascript:lfn_login('TUTOR3'); return false;">TUTOR3</a>
		<a href="#" onclick="javascript:lfn_login('TUTOR4'); return false;">TUTOR4</a>
		<a href="#" onclick="javascript:lfn_login('TUTOR5'); return false;">TUTOR5</a><br>
		<a href="#" onclick="javascript:lfn_login('TEACHER1'); return false;">TEACHER1</a>
		<a href="#" onclick="javascript:lfn_login('TEACHER2'); return false;">TEACHER2</a>
		<a href="#" onclick="javascript:lfn_login('TEACHER3'); return false;">TEACHER3</a>
		<a href="#" onclick="javascript:lfn_login('TEACHER4'); return false;">TEACHER4</a>
		<a href="#" onclick="javascript:lfn_login('TEACHER5'); return false;">TEACHER5</a><br>
		<a href="#" onclick="javascript:lfn_login('c1user001'); return false;">c1user001</a>
		<a href="#" onclick="javascript:lfn_login('c5user001'); return false;">c5user001</a>
		
<script src='/resources/homepage/js/dev_sub.js?timestamp=<%=timestamp%>'></script>
</body>
</html>