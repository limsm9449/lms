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
		<div id="side" class="site">
			<h2 class="s_mid">회원<span class="blue">가입</span></h2>
			<ul class="snb">
				<li><a href="javascript:" onclick="page.goPage('/guest/join');">회원가입</a></li>
				<li><a href="javascript:" onclick="page.goPage('/guest/termsconditions');">서비스이용약관</a></li>
				<li><a href="javascript:" onclick="page.goPage('/guest/privacy');" class="here">개인정보 취급방침</a></li>
			</ul>
		</div>
		<!-- end side -->
		
    	<!-- contents -->
		<div id="contents" class="site">
			<!-- location -->
			<div id="location"><a href="/" class="home">HOME</a><span>&gt;</span>회원가입<span>&gt;</span>개인정보 취급방침</div>
			<!-- title -->
			<h3 class="tit_big">개인정보취급방침</h3>
		      <div class="artcle">
		        <div class="privacy_box">
		          <div class="text_box" style="height: 2000px;">
		            <iframe src="privacyText.jsp" border="0" frameborder="0"></iframe>
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


