<%@ page contentType="text/html;charset=utf-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="ko" xml:lang="ko">
<head>
<title>
</title>

<%@ include file="../common/commUserInclude.jsp" %>

<script type="text/javascript">
<!--
  $(function() { 
    $(".tab_content").hide(); 
    $(".tab_content:first").show(); 
    
    $("ul.tabs li").click(function() { 
      $("ul.tabs li").removeClass("active");
      $(this).addClass("active");
      $(".tab_content").hide(); 
      var activeTab = $(this).attr("rel"); 
      $("#"+activeTab).fadeIn() 
    }); 
  });
//-->  
</script>

</head>

<script type="text/javascript">

$(document).ready(function() {
	$("#userId").focus();
});

function lfn_btn(pKind, pParam) {
	if ( pKind =="type1" || pKind =="type2" ) {
		if ( pKind == "type1" ) {
			if ( formValid.check("userId",{isNecess:true}) == false )
				return false;
			if ( formValid.check("userName1",{isNecess:true}) == false )
				return false;
			if ( formValid.check("email",{isNecess:true}) == false )
				return false;
			
			$("#type").val("type1");
		} else {
			if ( formValid.check("userId",{isNecess:true}) == false )
				return false;
			if ( formValid.check("userName2",{isNecess:true}) == false )
				return false;
			if ( formValid.check("mobile1",{isNecess:true}) == false )
				return false;
			if ( formValid.check("mobile2",{isNecess:true}) == false )
				return false;
			if ( formValid.check("mobile3",{isNecess:true}) == false )
				return false;
			
			$("#type").val("type2");
		}
			
		$.ajax({
			type :"POST",
			url : context +"/ns/searchPassword.do",
			dataType :"json",
			data : $("#frm").serialize(),
			success : function(json){
				if ( json.rtnMode == "CHANGE_PASSWORD") {
					alert("임시패스워드를 Email로 발송하였습니다.\n접속후에 패스워드를 변경해주세요.");
				} else if ( json.rtnMode == "INCORRECT_PASSWORD") {
					alert("해당하는 사용자가 없습니다.");
					$("#userId").select();
				} else if ( json.rtnMode == "INCORRECT_USER") {
					alert("아이디가 틀립니다.");
					$("#userId").select();
				} else if ( json.rtnMode == "RETIRED") {
					alert("탈퇴한 회원입니다.\n재가입시 관리자에게 문의하시기 바랍니다.");
					$("#userId").select();
				}
			},
			error : function(e) {
				alert("<spring:message code="lms.msg.systemError" text="-" />");
			}
		})
	} else if ( pKind =="findPassword" ) {
		gfn_goPage('/ns/searchPasswordV'); 
	}
}

</script>

<body>


<form id="frm" name="frm">

<input type="hidden" id="type" name="type"/>

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
				<li><a href="/login.do" class="here">로그인</a></li>
				<li><a href="#" onclick="window.location='/ns/searchUserIdV.do'">아이디찾기</a></li>
				<li><a href="#">비밀번호찾기</a></li>
			</ul>
		</div>
		<!-- end side -->

		<!-- contents -->
		<div id="contents" class="site">
			<!-- location -->
			<div id="location"><a href="/" class="home">HOME</a><span>&gt;</span>로그인<span>&gt;</span>비밀번호 찾기</div>
			<!-- title -->
			<h3 class="tit_big">비밀번호 찾기</h3>
		      <div class="artcle">
		        <div class="msg_box">
		          <p class="big_2"><span class="blue">비밀번호 찾기</span></p>
		          <p>실인증 또는 아이핀 인증 회원정보로 찾기 중 하나를 선택하여 비밀번호 찾기를 진행하여 주십시요.</p>
		        </div>
		        <div class="pw_find_box">
		          <ul class="tabs">
		            <li class="active" rel="tab1"><span>등록한 메일 정보로 찾기</span></li>
		            <li rel="tab2"><span>등록한 휴대폰 번호로 찾기</span></li>
		            <li rel="tab3"><span>아이핀(i-pin)으로 찾기</span></li>
		          </ul>
		          <div class="tab_contents">
		            <!-- tab1 -->
		            <div id="tab1" class="tab_content">
		              <fieldset>
		                <legend>이메일로 확인</legend>
		                <dl>
		                  <dt><label for="user_name">이름(한글/영문)</label></dt>
		                  <dd><input type="text" id="userName1" name="userName1" style="width: 180px;" /></dd>
		                  <dt><label for="user_id">아이디</label></dt>
		                  <dd><input type="text" id="userId1" name="userId1" style="width: 180px;" /></dd>
		                  <dt><label for="user_email">이메일</label></dt>
		                  <dd><input type="text" id="email" name="email" style="width: 180px;" /></dd>
		                </dl>
		              </fieldset>
		              <div class="center_btn">
		                <a href="#" onclick="lfn_btn('type1');"><img src="/resources/images/sub/btn_pw_find.png" /></a>
		              </div>
		            </div>
		            <!-- end tab1 -->
		            <!-- tab2 -->
		            <div id="tab2" class="tab_content">
		              <fieldset>
		                <legend>휴대폰 번호로 확인</legend>
		                <dl>
		                  <dt><label for="user_name">이름(한글/영문)</label></dt>
		                  <dd><input type="text" id="userName2" name="userName2" style="width: 180px;" /></dd>
		                  <dt><label for="user_id">아이디</label></dt>
		                  <dd><input type="text" id="userId2" name="userId2" style="width: 180px;" /></dd>
		                  <dt><label for="user_year">휴대폰 번호</label></dt>
		                  <dd>
		                    <select name="mobile1" id="mobile1">
		  		              	<option value="">선택</option>
		  		              	<option value="010">010</option>
		  		              	<option value="011">011</option>
		  		              	<option value="016">016</option>
		  		              	<option value="017">017</option>
		  		              	<option value="018">018</option>
		  		              	<option value="019">019</option>
							  </select>
							  <input type="text" name="mobile2" id="mobile2" maxlength="4" title="휴대전화 중간번호" />
							  <input type="text" name="mobile3" id="mobile3" maxlength="4" title="휴대전화 마지막번호" />
		                  </dd>
		                </dl>
		              </fieldset>
		              <div class="center_btn">
		                <a href="#" onclick="lfn_btn('type2');"><img src="/resources/images/sub/btn_pw_find.png" /></a>
		              </div>
		            </div>
		            <!-- end tab2 -->
		            <!-- tab3 -->
		            <div id="tab3" class="tab_content">
		              <p class="center">아이핀 인증을 통한 회원정보 찾기를 원하시면 아이핀 인증 버튼을 눌러 아이핀 인증 절차를 진행하여 주십시오.</p>
		              <div class="center_btn">
		                <a href="#"><img src="/resources/images/sub/btn_ipin.png" /></a>
		              </div>
		            </div>
		            <!-- end tab3 -->
		          </div>
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


	