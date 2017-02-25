<%@ page contentType="text/html;charset=utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<html>
<head>
	<title>Login</title>
</head>

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
	
	document.frm.target = "tranFrame";	
	document.frm.submit();
}

function lfn_page() {
	page.goUserHome();
}

</script> 

<body>

<form name="frm" action="/loginCheck.do" method="post">
<input type="hidden" id="compCd" name="compCd" value="${set.companyData.compCd}"/>


<div id="wrap">
  	<!-- container -->
  	<div id="container">    
    	<!-- content ---------------------------------------------------------------------------------------------->
    	<div id="contents">
      		<div id="content_head">
        		<h1 class="title"><img src="/resources/images/admin/login/logo.png" alt="Qlearning logo" />&nbsp;&nbsp;${set.companyData.compName}</h1>
      		</div>
      		<div class="login_bg">
	  			<h3 class="title"><img src="/resources/images/admin/login/txt_login.png" alt="login" /></h3>
	  			<p class="tit_cmt">큐러닝 시스템에 오신것을 환영합니다.</p>
	  			<!-- login  -->
	  			<div class="login_form">
	  				<fieldset>
	  					<legend>로그인 폼</legend>
	  					<label for="user_id" class="input_log_id">아이디</label>
	  					<input type="text" id="userId" name="userId" class="input_log id" />
	  					<label for="user_pw" class="input_log_pw">비밀번호</label>
	  					<input type="password" id="password" name="password" class="input_log pw" />
	  					<input type="image" src="/resources/images/admin/login/btn_login.png" alt="로그인" class="btn_login" onclick="login()"/>
	  				</fieldset>
	  			</div>
	  				
	  				<a href="/guest/join.do?compCd=${set.companyData.compCd}"><spring:message code="lms.btn.join" text="-" /></a>
					<a href="#" onclick="javascript:Popup.showFindUserId(); return false;">아이디</a> /
					<a href="#" onclick="javascript:Popup.showFindPassword(); return false;">비밀번호</a> 찾기
	  				
			</div>
			<!-- end content body -->
	    </div>
    	<!-- end content ---------------------------------------------------------------------------------------------->
  	</div>
  	<!-- end container -->
</div>

</form>

<iframe name="tranFrame" style="display:none;"></iframe>

</body>
</html>
