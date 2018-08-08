<%@ page contentType="text/html;charset=utf-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="ko" xml:lang="ko">
<head>
<title>
</title>

<%@ include file="../common/commUserInclude.jsp" %>

<%-- CLEditor --%>
<link rel="stylesheet" type="text/css" href="<c:url value="/resources/CLEditor/jquery.cleditor.css"/>" />
<script type="text/javascript" src="<c:url value="/resources/CLEditor/jquery.cleditor.min.js"/>"></script>


</head>

<script type="text/javascript">

$(document).ready(function() {
	$("textarea[name='retiredReason']").cleditor();
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
   	 		String menuId = "memberRetired";
   	 	%>
		<%@ include file="../home/userLeft.jsp" %>
		<!-- end side -->
		
    	<!-- contents -->
		<div id="contents" class="site">
			<!-- location -->
			<div id="location"><a href="/" class="home">HOME</a><span>&gt;</span>나의정보<span>&gt;</span>회원탈퇴</div>
			<!-- title -->
			<h3 class="tit_big">회원탈퇴</h3>
		      <div class="artcle">
		        <div class="msg_box">
		          <p>회원탈퇴정보입력 / 회원님의 정보보호를 위해 다시 한 번 본인임을 확인합니다.</p>
		        </div>
		        <div class="withdraw_box">
		          <form name="frm" method="post">
		          <div class="info_form">
		            <fieldset>
		    					<legend>회원탈퇴</legend>
		    					<label for="your_id">아이디</label>
		    					<div class="input_info"><input type="text" id="userId" name="userId" /></div>
		    					<label for="your_pw">비밀번호</label>
		    				  <div class="input_info"><input type="password" id="userPassword" name="userPassword" /></div>
		    					<label for="your_pw">탈퇴 사유</label>
		    				  <div class="input_info"><textarea id="retiredReason" name="retiredReason"></textarea></div>
		    				</fieldset>
		    			</div>
		    			<div class="div_description">
		    			  <p class="strong">※ 회원탈퇴 신청 전에 반드시 확인해 주시기 바랍니다.</p>
		            <p>회원탈퇴 신청 후에는 모든 정보가 삭제되며, 복원이 불가능하오니 신중하게 결정하여 주시기 바랍니다.</p>
		            <ul>
		              <li>- 회원탈퇴 신청 후에는 큐피플 웹사이트에서 이용하셨던 수강정보, 결제 및 포인트, 개인정보 등 모든 정보가 삭제되며, 복구가 불가능합니다.</li>
		              <li>- 회원탈퇴 신청 후 재가입 시 동일한 아이디로 회원가입이 불가능합니다.</li>
		            </ul>
		          </div>
		          <div class="center_btn">
		            <a href="javascript:" id="saveBtn" onclick="javascript:lfn_btn('save'); return false;"><img src="/resources/images/sub/btn_ok.png" /></a>&nbsp;<a href="javascript:" onclick="window.location='/member/memberRetired.do';"><img src="/resources/images/sub/btn_censel.png" /></a>
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
	