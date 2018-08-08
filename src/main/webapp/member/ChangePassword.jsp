<%@ page contentType="text/html;charset=utf-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="ko" xml:lang="ko">
<head>
<title>
</title>

<%@ include file="../common/commUserInclude.jsp" %>


</head>

<script type="text/javascript">

$(document).ready(function() {
	$("#userPassword").focus();	
});

function lfn_btn(pKind, pParam) {
	if ( pKind =="save" ) {
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
					} else if ( json.rtnMode == "PASSWORD_OK") {
						alert("비밀번호가 변경되었습니다.");
						window.location = "/member/memberChangePassword.do";
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
		<%
   	 		String menuId = "memberChangePassword";
   	 	%>
		<%@ include file="../home/userLeft.jsp" %>
		<!-- end side -->
		
    	<!-- contents -->
		<div id="contents" class="site">
			<!-- location -->
			<div id="location"><a href="/" class="home">HOME</a><span>&gt;</span>나의정보<span>&gt;</span>비밀번호 변경</div>
			<!-- title -->
			<h3 class="tit_big">비밀번호 변경</h3>
		      <div class="artcle">
		        <div class="msg_box">
		          <p>현재 비밀번호를 입력한 후 새로 사용할 비밀번호를 입력해 주십시오.</p>
		        </div>
		        <div class="repassword_box">
		          <form name="frm" method="post">
		          <div class="pass_form">
		            <fieldset>
		    					<legend>비밀번호 변경</legend>
		    					<label for="now_pw">현재 비밀번호</label>
		    					<div class="input_pw"><input type="password" id="userPassword" name="userPassword" /></div>
		    					<label for="new_pw">변경 비밀번호</label>
		    				  <div class="input_pw"><input type="password" id="newUserPassword" name="newUserPassword" /><span>※ 영문/숫자(혼용) 6~12글자 이내로 입력</span></div>
		    					<label for="new_pw2">변경 비밀번호 확인</label>
		    					<div class="input_pw"><input type="password" id="newUserPassword2" name="newUserPassword2" /><span>※ 비밀번호를 한번 더 입력, 잊지 않도록 주의하세요.</span></div>
		    				</fieldset>
		    			</div>
		          <div class="center_btn">
		            <a href="javascript:" id="saveBtn" onclick="lfn_btn('save');"><img src="/resources/images/sub/btn_ok.png" /></a>&nbsp;<a href="javascript:" onclick="window.location='/member/memberChangePassword.do';"><img src="/resources/images/sub/btn_censel.png" /></a>
		          </div>
		          </form>
		        </div>
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


</body>
</html>



</div>
</div>
	