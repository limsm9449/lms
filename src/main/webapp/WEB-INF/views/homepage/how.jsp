<%@ page contentType="text/html;charset=utf-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
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
	f_makePageNavigator("paging",${set.condiVO.pageNum},${set.totalCount},${set.pageUnit});
});

function lfn_btn(pKind, pParam) {
	if ( pKind == "search" || pKind == "paging" || pKind == "refresh" ) {
		if ( pKind == "search" )
			$("#pageNum").val(1);
		else if ( pKind == "paging" )
			$("#pageNum").val(pParam.page);
		
		f_submitSelf("/user/faqList");
	} else if ( pKind == "view") {
		$("#seq").val(pParam.seq);
		
		gfn_goPage("/user/faqV",$("#frm").serialize());
	}
}

</script>

<body>

<form name="frm" id="frm" method="post">

<input id="seq" name="seq" type="hidden" value="">

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
   	 		String menuId = "how";
   	 	%>
		<%@ include file="../home/userLeft2.jsp" %>
		<!-- end side -->
		
    	<!-- contents -->
		<div id="contents" class="site">
			<!-- location -->
			<div id="location"><a href="/" class="home">HOME</a><span>&gt;</span>수강신청<span>&gt;</span>수강신청방법</div>
			<!-- title -->
			<h3 class="tit_big">수강신청방법</h3>
		      <div class="artcle">
		      	<ol class="how">
		      		<li class="bg1">
		      			<p class="big_2"><span class="blue">로그인</span></p>
		      			<p>큐러닝 웹사이트(www.qlearning.co.kr) 회원가입 후 로그인 합니다.</p>
		      		</li>
		      		<li class="bg2">
		      			<p class="big_2"><span class="blue">수강신청</span></p>
		      			<p>강좌 자세히 보기 페이지에서 수강신청을 클릭합니다.</p>
								<p>※ 관심과정으로 등록 후 관심목록에서 수강신청을 하셔도 됩니다.</p>
		      		</li>
		      		<li class="bg3">
		      			<p class="big_2"><span class="blue">결제</span></p>
		      			<p>수강신청 시 결제페이지의 안내에 따라 결제를 진행하시기 바랍니다.</p>
		      		</li>
		      		<li class="bg4">
		      			<p class="big_2"><span class="blue">학습</span></p>
		      			<p>결제 완료 시 자동승인 후 당일부터 과정별 교육기간 동안 학습합니다.</p>
		      		</li>
		      		<li class="bg5">
		      			<p class="big_2"><span class="blue">수료증 발급</span></p>
		      			<p>나의강의실 페이지에서 수강완료를 클릭하시면 수료증을 발급받을 수 있습니다.</p>
		      		</li>
		      	</ol>
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

