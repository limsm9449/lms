<%@ page contentType="text/html;charset=utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<html>
<head>
	<title>Login</title>
	

<style>
  /* layout */
  #wrap { width: 100%; height: 100%; text-align: center; margin: 0; padding: 0; border-top: 5px solid #0096dd; }
  #container { width: 710px; margin: 110px auto 0; }
  #content_head { width: 642px; margin-bottom: 60px; padding: 0 0 20px 30px;border-bottom: 2px solid #36a9b4; }
  #content_head h1 { text-align: left; font: bold 16px 'Nanum Gothic'; color: #555; }
  #content_head h1 img { vertical-align: bottom; margin: 0 5px -8px 0; }
  
  h3.title { text-align: left; margin-left: 40px; }
  p.tit_cmt { text-align: left; margin-left: 40px; font: 12px 'Nanum Gothic'; color: #555; }
  legend { display: none; }
  input[type="image"] { border: 0; width: auto; height: auto; }
  
  /* LOGIN form */
  .login_bg { width: 100%; background:url(../images/admin/login/img_login.jpg) no-repeat right 30px; }
  .login_form {position:relative; width: 672px; height: 220px; border-bottom: 1px solid #e0e0e0; }
  .login_form label {font: 14px 'Nanum Gothic'; color: #555; padding-right:10px; vertical-align:middle;}
  
  .login_form .input_log_id, .login_form .input_log_pw, .login_form .input_log_auth {width: 80px; text-align: right; padding-right: 20px; }
  .login_form .input_log.id, .login_form .input_log.pw, .login_form .input_log.auth {width: 170px; height: 22px; border: 1px solid #e0e0e0;}
  .login_form .input_log.auth {width: 172px;}
  .login_form .input_log_id {position:absolute; left:0; top:32px;}
  .login_form .input_log.id {position:absolute; left:100px; top:30px;}
  .login_form .input_log_pw {position:absolute; left:0; top:59px;}
  .login_form .input_log.pw {position:absolute; left:100px; top:57px;}
  .login_form .input_log_auth {position:absolute; left:0; top:86px;}
  .login_form .input_log.auth {position:absolute; left:100px; top:84px;}
  .login_form .btn_login {position:absolute; left:280px; top:30px;}
</style>
	
</head>

<%@ include file="../common/commInclude.jsp" %>

<script type="text/javascript">

function login() {
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
	if ( $("#auth").val() == "ADMIN_A" || $("#auth").val() == "ADMIN_C" || $("#auth").val() == "ADMIN_M") {
		page.goAdminHome();
	} else if ( $("#auth").val() == "TEACHER") {
		page.goTeacherHome();
	} else if ( $("#auth").val() == "C_TUTOR") {
		page.goCompManagerHome();
	} else if ( $("#auth").val() == "TUTOR") {
		page.goTutorHome();
	}
}



function lfn_login(userId) {
	$("#userId").val(userId);
	$("#password").val("1");
	login();
}

</script> 

<body>

<form name="frm" action="/loginCheck.do" method="post">

<div id="wrap">
  	<!-- container -->
  	<div id="container">    
    	<!-- content ---------------------------------------------------------------------------------------------->
    	<div id="contents">
      		<div id="content_head">
        		<h1 class="title"><img src="/resources/images/admin/login/logo.png" alt="Qlearning logo" />System administrator</h1>
      		</div>
      		<div class="login_bg">
	  			<h3 class="title"><img src="/resources/images/admin/login/txt_login.png" alt="login" /></h3>
	  			<p class="tit_cmt">큐러닝 관리자 시스템에 오신것을 환영합니다.</p>
	  			<!-- login  -->
	  			<div class="login_form">
	  				<fieldset>
	  					<legend>로그인 폼</legend>
	  					<label for="user_id" class="input_log_id">아이디</label>
	  					<input type="text" id="userId" name="userId" class="input_log id" />
	  					<label for="user_pw" class="input_log_pw">비밀번호</label>
	  					<input type="password" id="password" name="password" class="input_log pw" />
	  					<label for="user_auth" class="input_log_auth">인증</label>
	  					<select id="auth" name="auth" class="input_log auth">
	    		          	<option value="">권한 선택</option>
	    					<option value="ADMIN_A" selected="">Admin</option>
	    					<option value="ADMIN_C">Contents Admin</option>
	    					<option value="ADMIN_M">Manage Admin</option>
	    					<option value="TEACHER">Teacher</option>
	    					<option value="C_TUTOR">Company Manager</option>
	    					<option value="TUTOR">Tutor</option>
	            		</select>
	  					<input type="image" src="/resources/images/admin/login/btn_login.png" alt="로그인" class="btn_login" onclick="login()"/>
	  				</fieldset>
	  			</div>
			</div>
			<!-- end content body -->
	    </div>
    	<!-- end content ---------------------------------------------------------------------------------------------->
  	</div>
  	<!-- end container -->
</div>

		
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



</body>
</html>
