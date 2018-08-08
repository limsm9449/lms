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
    menuStart();
});


function lfn_btn(pKind, pParam) {
	if ( pKind == "next" ) {
		if ( $("input[name=chk_agree_1]:checked").length == 0) {
			alert("이용약관에 동의하셔야 합니다.");
			return false;
		}

		if ( $("input[name=chk_agree_2]:checked").length == 0) {
			alert("개인정보취급방침 동의하셔야 합니다.");
			return false;
		}

		gfn_goPage("/guest/join2",$("#frm").serialize());
	}
}

</script>

<body>


<form id="frm" name="frm" method="post">
	<input type="hidden" id="compCd" name="compCd" value="<c:out value="${set.condiVO.compCd}"/>">

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
			<h2 class="s_mid">회원<span class="blue">가입</span></h2>
			<ul class="snb">
				<li><a href="javascript:" onclick="page.goPage('/guest/join');" class="here">회원가입</a></li>
				<li><a href="javascript:" onclick="page.goPage('/guest/termsconditions');">서비스이용약관</a></li>
				<li><a href="javascript:" onclick="page.goPage('/guest/privacy');">개인정보 취급방침</a></li>
			</ul>
		</div>
		<!-- end side -->
		
    	<!-- contents -->
		<div id="contents" class="site">
			<!-- location -->
			<div id="location"><a href="/" class="home">HOME</a><span>&gt;</span>회원가입<span>&gt;</span>이용약관</div>
			<!-- title -->
			<h3 class="tit_big">회원가입</h3>
		      <div class="artcle">
		        <div class="joinflow_box">
		          <img src="/resources/images/sub/img_joinflow_1.png" alt="가입순서 1단계 이용약관" />
		          <p class="big_2"><span class="blue">이용약관</span></p>
		          <p>
		            큐러닝에 오신 것을 환영합니다. 무료 회원가입으로 크레듀의 각종 서비스를 제공 받으실 수 있습니다.<br />
		            고객님께서 입력하신 회원정보와 웹사이트의 모든 정보는 완벽한 보안체계에 의해 암호화 되어 안전하게 보호 됩니다.<br />
		            큐러닝은 공정거래위원회에서 심의한 표준약관을 따르고 있습니다.
		          </p>
		        </div>
		        <div class="conditions_box">
		          <p class="big_2">회원 이용 약관</p>
		          <div class="text_box">
		            <iframe src="termsconditionsText.jsp" border="0" frameborder="0"></iframe>
		          </div>
		          <input type="checkbox" name="chk_agree_1" id="chk_agree_1" /><label for="chk_agree_1">회원 이용 약관에 동의합니다.</label>
		        </div>
		        <div class="privacy_box">
		          <p class="big_2">개인정보취급방침</p>
		          <div class="text_box">
		            <iframe src="privacyText.jsp" border="0" frameborder="0"></iframe>
		          </div>
		          <input type="checkbox" name="chk_agree_2" id="chk_agree_2" /><label for="chk_agree_2">개인정보취급방침에 동의합니다.</label>
		        </div>
		        <div class="center_btn">
		          <a href="#" onclick="javascript:lfn_btn('next');"><img src="/resources/images/sub/btn_ok.png" /></a>&nbsp;<a href="/"><img src="/resources/images/sub/btn_censel.png" /></a>
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


