<%@ page contentType="text/html;charset=utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="ko" xml:lang="ko">
<html>
<meta http-equiv="X-UA-Compatible" content="IE=Edge" />

<%@ include file="../common/commHomepageInclude.jsp" %>

<script type="text/javascript">
var aSlide = new Array();
<c:forEach var="row" items="${set.courseList}" varStatus="idx">
	aSlide[${idx.index}] = { 
		link : "/main/mainCourseData.do?courseId=${row.courseId}",
		title : "${row.courseName}",
		thumb : "/cImage/contents/${row.courseCode}/sImg1.jpg",
		bg : "/cImage/contents/${row.courseCode}/bImg.jpg",
		swf : "/cImage/contents/${row.courseCode}/swf.swf"
	}
</c:forEach>

function getMainContentInfo() {
  	return aSlide;
}
function goPage(_url) {
  	document.location.href = _url;
}
  

$(document).ready(function() {
	callSwf();
	
	//f_makePageNavigator("paging",${set.condiVO.pageNum},${set.totalCount},${set.pageUnit});
});

function lfn_btn(pKind, pParam) {
	if ( pKind == "search" || pKind == "paging") {
		if ( pKind == "search" )
			$("#pageNum").val(1);
		else if ( pKind == "paging" )
			$("#pageNum").val(pParam.page);
		
		f_submitSelf("/main/content");	
	}

}


function join() {
}

function findInfo() {
}

function lfn_page() {
	page.goHome();
}


</script>

<body>
<form id="frm" name="frm" method="post">


<!-- skipnav -->
<div id="skipnav"><a href="#container" class="skip">컨텐츠 바로가기</a></div>
<!-- skipnav -->
<!-- wrap -->
<div id="wrap" class="main">
  	<!-- header_wrap -->
  	<div id="header_wrap" class="main">
    	<div id="header" class="main">
      		<h1><a href="/"><img src="/resources/images/main/logo.png" alt="Qlearning" /></a></h1>
      		<ul class="gnb">
<c:if test="${empty set.sessVO}">      		
       			<li><a href="/login.do">로그인</a></li>
       			<li><a href="/guest/join.do">회원가입</a></li>
</c:if>       			
<c:if test="${!empty set.sessVO}">      		
       			<li><a href="javascript:" onclick="gfn_ajax.logout()">로그아웃</a></li>
       			<li><a href="javascript:" onclick="page.goUserHome();">나의 강의실</a></li>
</c:if>       			
       			<li><a href="javascript:" onclick="page.goPage('/user/courseList');">수강신청</a></li>
       			<li class="last"><a href="javascript:" onclick="page.goPage('/user/noticeList');">학습지원</a></li>
     		</ul>
    	</div>
  </div>
  <!-- end header_wrap -->
  
  <hr />
  <!-- main_content_view -->
  <div id="maincontent_wrap"><div id="flashDiv"></div></div>
  <!-- end mainContntView
  
  <!-- container -->
  <div id="container" class="main">
    <h3 class="title">-SITE MAP</h3>
		<!-- sitemap -->
		<ul class="sitemap">
<c:if test="${empty set.sessVO}">      		
			<li class="dp1">
				<strong>로그인</strong>
				<ul>
					<li class="dp2"><a href="javascript:" onclick="page.goPage('/login');">로그인</a></li>
					<li class="dp2"><a href="javascript:" onclick="page.goPage('/ns/searchUserIdV');">아이디찾기</a></li>
					<li class="dp2"><a href="javascript:" onclick="page.goPage('/ns/searchPasswordV');">비밀번호찾기</a></li>
				</ul>
			</li>
</c:if>       			
			<li class="dp1">
				<strong>나의 강의실</strong>
				<ul>
					<li class="dp2"><a href="javascript:" onclick="page.goPage('/normalUser/attendCourseList');">수강과정</a></li>
					<li class="dp2"><a href="javascript:" onclick="page.goPage('/normalUser/waitingCourseList');">수강대기/취소과정</a></li>
					<li class="dp2"><a href="javascript:" onclick="page.goPage('/normalUser/myCourseList');">수강 완료 과정</a></li>
				</ul>
			</li>
			<li class="dp1">
				<strong>나의 정보</strong>
				<ul>
					<li class="dp2"><a href="javascript:" onclick="page.goPage('/member/userMemberU');">회원정보수정</a></li>
					<li class="dp2"><a href="javascript:" onclick="page.goPage('/member/memberChangePassword');">비밀번호변경</a></li>
					<li class="dp2"><a href="javascript:" onclick="page.goPage('/counsel/userCounselList');">상담내역</a></li>
					<li class="dp2"><a href="javascript:" onclick="page.goPage('/member/memberRetired');">회원탈퇴</a></li>
				</ul>
			</li>
			<li class="dp1">
				<strong>수강신청</strong>
				<ul>
				  <li class="dp2"><a href="javascript:" onclick="page.goPage('/user/courseList');"">교육과정</a></li>
					<li class="dp2"><a href="javascript:" onclick="page.goNsJsp('how');">수강신청방법</a></li>
					<li class="dp2"><a href="javascript:" onclick="page.goPage('/main/cart');">장바구니</a></li>
					<li class="dp2"><a href="javascript:" onclick="alert('준비중');">주문/신청 조회</a></li>
				</ul>
			</li>
			<li class="dp1">
				<strong>학습지원</strong>
				<ul>
					<li class="dp2"><a href="javascript:" onclick="page.goPage('/user/noticeList');">공지사항</a></li>
					<li class="dp2"><a href="javascript:" onclick="page.goPage('/user/faqList');">FAQ</a></li>
					<li class="dp2"><a href="javascript:" onclick="page.goPage('/main/mailQuestion');">1:1 메일문의</a></li>
					<li class="dp2"><a href="javascript:" onclick="page.goPage('/guest/bankInfo');">입금계좌안내</a></li>
				</ul>
			</li>
<c:if test="${empty set.sessVO}">      		
			<li class="dp1">
				<strong>회원가입</strong>
				<ul>
					<li class="dp2"><a href="javascript:" onclick="page.goPage('/guest/join');">회원가입</a></li>
					<li class="dp2"><a href="javascript:" onclick="page.goPage('/guest/termsconditions');">서비스이용약관</a></li>
					<li class="dp2"><a href="javascript:" onclick="page.goPage('/guest/privacy');">개인정보 취급방침</a></li>
				</ul>
			</li>
</c:if>       			
		</ul>
		<!-- end sitemap -->
  </div>
  <!-- end container -->
  
  <!-- footer_wrap -->
	<div id="footer_wrap" class="main">
		<div class="footer">
			<!-- sublink -->
			<ul class="sublink">
			  <li><a href="javascript:" onclick="">회사소개</a></li>
				<li><a href="javascript:" onclick="page.goPage('/guest/termsconditions');">서비스이용약관</a></li>
				<li><a href="javascript:" onclick="page.goPage('/guest/privacy');">개인정보취급방침</a></li>
				<li><a href="javascript:" onclick="">찾아오시는길</a></li>
				<li><a href="javascript:" onclick="">사이트맵</a></li>
			</ul>
			<!-- end sublink -->
      <h1 class="logo"><img src="/resources/images/admin/common/bottom_logo.png" alt="Qpeople" /></h1>
      <div class="info">
				<address>서울 금천구 가산동 371-50번지 에이스하이엔드3차 410/411호 | Tel:02-888-7805(내선200) | Fax:02-888-7908</address>
				<p>Copyrights 2014 Qpeople Academy. ALL Right Reserved</p>
			</div>
    </div>
    <!-- end footer -->
  </div>
  <!-- end footer_wrap -->
</div>





</form>


<iframe name="tranFrame" style="display:none;"></iframe>

</body>

</html>
