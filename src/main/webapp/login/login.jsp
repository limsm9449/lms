<%@ page contentType="text/html;charset=utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<html>
<head>
	<title>Login</title>
</head>

	
<%@ include file="../common/commUserInclude.jsp" %>

<script type="text/javascript">

$(document).ready(function() {
	$("#userId").focus();
	menuStart();
});


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

function lfn_login(userId) {
	$("#userId").val(userId);
	$("#password").val("1");
	login();
}

function lfn_page() {
	if ( "<%=request.getParameter("preUrl")%>" == "null")
		page.goHome();
	else {
		if ( "<%=request.getParameter("loginAuth")%>" == "ADMIN_A" || "<%=request.getParameter("loginAuth")%>" == "ADMIN_C" || "<%=request.getParameter("loginAuth")%>" == "ADMIN_M") {
			page.goAdminHome("<%=request.getParameter("preUrl")%>");
		} else if ( "<%=request.getParameter("loginAuth")%>" == "TEACHER") {
			page.goTeacherHome("<%=request.getParameter("preUrl")%>");
		} else if ( "<%=request.getParameter("loginAuth")%>" == "C_TUTOR") {
			page.goCompManagerHome("<%=request.getParameter("preUrl")%>");
		} else if ( "<%=request.getParameter("loginAuth")%>" == "TUTOR") {
			page.goTutorHome("<%=request.getParameter("preUrl")%>");
		} else {
			window.location = "<%=request.getParameter("preUrl")%>";
		}
		
	}
}

</script> 

<body>

<form name="frm" action="loginCheck.do" method="post">

<!-- skipnav -->
<div id="skipnav"><a href="#side" class="skip">좌측메뉴 바로가기</a></div>
<div id="skipnav"><a href="#contents" class="skip">컨텐츠 바로가기</a></div>
<!-- skipnav -->
<!-- wrap -->
<div id="wrap" class="site">
  <%@ include file="../home/userTop.jsp" %>
  <hr />
  <!-- container -->
  <div id="container" class="site">
    <!-- side -->
		<div id="side" class="site">
			<h2>로그<span class="blue">인</span></h2>
			<ul class="snb">
				<li><a href="#" class="here">로그인</a></li>
				<li><a href="#" onclick="window.location='/ns/searchUserIdV.do'">아이디찾기</a></li>
				<li><a href="#" onclick="window.location='/ns/searchPasswordV.do'">비밀번호찾기</a></li>
			</ul>
		</div>
		<!-- end side -->
		
    	<!-- contents -->
		<div id="contents" class="site">
			<!-- location -->
			<div id="location"><a href="/" class="home">HOME</a><span>&gt;</span>로그인<span>&gt;</span>로그인</div>
			<!-- title -->
			<h3 class="tit_big">로그인</h3>
		    <div class="artcle">
		        <div class="joininfo_box">
		          <p class="big_1 c_white">끊임없이 발전하는<br /> 여러분의 가치<br /> 큐러닝이 함께하겠습니다.</p>
		          <p class="c_white">무료 회원가입을 하시면<br /> 각종 서비스 혜택을 받으실 수 있습니다.</p>
		          <a href="#" onclick="page.goPage('/guest/join');"><img src="/resources/images/sub/btn_go_join.png" /></a>
		        </div>
		        <div class="login_set">
		          <div class="login_box">
		            <p class="big_2"><span class="blue">큐러닝</span>에 오신 것을 환영합니다.</p>
		            <p>로그인을 위하여 아래 아이디와 비밀번호를 입력하여 주십시오.</p>
		            <div class="login_form">
		              <fieldset>
		      					<legend>로그인 폼</legend>
		      					<label for="user_id" class="input_log_id">아이디</label>
		      					<input type="text" id="userId" name="userId" class="input_log id" />
		      					<label for="user_pw" class="input_log_pw">비밀번호</label>
		      					<input type="password" id="password" name="password" class="input_log pw" />
		      					<input type="image" src="/resources/images/sub/btn_login.png" alt="로그인" class="btn_login" onclick="login()"/>
		      				</fieldset>
		      			</div>
		          </div>
		          <div class="find_id_box">
		            <p class="big_2"><span class="blue">아이디</span>를 잊으셨나요?</p>
		            <p>회원님의 개인정보로 아이디를 찾으실 수 있습니다.</p>
		            <a href="#" onclick="window.location='/ns/searchUserIdV.do'"><img src="/resources/images/sub/btn_find_id.png" /></a>
		          </div>
		          <div class="find_pws_box">
		            <p class="big_2"><span class="blue">비밀번호</span>를 잊으셨나요?</p>
		            <p>회원님의 이메일과 SMS인증으로 비밀번호를 찾으실 수 있습니다.</p>
		            <a href="#" onclick="window.location='/ns/searchPasswordV.do'"><img src="/resources/images/sub/btn_find_pwd.png" /></a>
		          </div>
		        </div>
		        <div class="welcome_img"></div>
		    </div>
		</div>
		<!-- end content -->
	</div>
  <!-- end container -->
  <!-- footer_wrap -->
	<%@ include file="../home/bottom.jsp" %>
  <!-- end footer_wrap -->
</div>

			

</form>



	
		<a href="#" onclick="javascript:lfn_login('admin'); return false;">admin</a><br>
		<a href="#" onclick="javascript:lfn_login('USER001'); return false;">USER001</a>
		<a href="#" onclick="javascript:lfn_login('USER002'); return false;">USER002</a>
		<a href="#" onclick="javascript:lfn_login('USER003'); return false;">USER003</a>
		<a href="#" onclick="javascript:lfn_login('USER004'); return false;">USER004</a>
		<a href="#" onclick="javascript:lfn_login('USER005'); return false;">USER005</a><br>
		<a href="#" onclick="javascript:lfn_login('USER006'); return false;">USER006</a>
		<a href="#" onclick="javascript:lfn_login('USER007'); return false;">USER007</a>
		<a href="#" onclick="javascript:lfn_login('USER008'); return false;">USER008</a>
		<a href="#" onclick="javascript:lfn_login('USER009'); return false;">USER009</a>
		<a href="#" onclick="javascript:lfn_login('USER010'); return false;">USER010</a><br>
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

		<br>
		<br>
		<br>
		<a href="#" onclick="self.location = '<%=request.getContextPath()%>/cms/'">관리자 페이지</a>
		<br>
		<a href="#" onclick="self.location = '<%=request.getContextPath()%>/cu/qpeople'">qpeople 회사 페이지</a>
		<br>
		<a href="#" onclick="self.location = '<%=request.getContextPath()%>/cu/samsung'">samsung 회사 페이지</a>
		
		
<iframe name="tranFrame" style="display:none;"></iframe>

</body>
</html>
