<%@ page contentType="text/html;charset=utf-8"%>
<%@ page import="java.util.Calendar"%>

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
			<div id="location"><a href="/" class="home">HOME</a><span>&gt;</span>회원가입<span>&gt;</span>가입완료</div>
			<!-- title -->
			<h3 class="tit_big">회원가입</h3>
		      <div class="artcle">
		        <div class="joinflow_box">
		          <img src="/resources/images/sub/img_joinflow_4.png" alt="가입순서 4단계 가입완료" />
		          <p class="big_2"><span class="blue">회원가입완료</span></p>
		          <p>큐러닝 회원가입이 정상적으로 완료되었습니다. <br />국내 최고의 온라인 교육 서비스를 제공하도록 최선을 다하겠습니다.</p>
		        </div>
		        <div class="join_congratulate_box">
		          <p class="big_1 c_white">메일 인증을 완료하셔야 정상적으로 로그인 하실 수 있습니다.</p>
		          <p class="msg c_white" style="width:285px">입력하신 메일주소로 인증 메일이 도착하지 않았다면 스팸메일로 분류되지 않았는지 확인해 보십시오.<br /></p>
		          <div class="right_btn"><a href="javascript:" onclick="page.goHome();" alt="메인페이지로 이동"><img src="/resources/images/sub/btn_go_main.png" /></a></div>
		        </div>
		        <div class="banner_faq_box">
		          <div class="banner"><a href="#"><img src="/resources/images/sub/img_joinfinal_banner_1.jpg" title="김정구 교수의 미래창조경영 위기와 역경을 기회로" /></a></div>
		          <div class="faq">
		            <p class="big_2">자주찾는 질문<span class="blue">FAQ</span></p>
		            <p class="more"><a href="javascript:" onclick="page.goPage('/user/faqList');"><img src="/resources/images/sub/btn_more.png" title="FAQ 더보기" /></a></p>
		            <ul>
<c:forEach var="row" items="${set.faqList}" varStatus="idx">
		              <li><a href="#" onClick="gfn_goPage('/user/faqV','seq=${row.seq}');"><nobr>${row.title}</nobr></a></li>
</c:forEach>		              
		            </ul>
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


