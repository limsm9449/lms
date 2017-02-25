<%@ page contentType="text/html;charset=utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<html>
<head>
	<title>Login</title>
</head>

<%@ include file="../common/commMenuInclude.jsp" %>


<script type="text/javascript">

$(document).ready(function() {
	$("#defaultMenu").trigger("click");
});

function gfn_menu(pThis) {
	<%--
	$(".mainMenu").each(function(){
		$(this).removeClass("here");
	});
	$(".subMenuUl").each(function(){
		$(this).css("display", "none");
	});
	
	$(pThis).addClass("here");
	$(pThis).next().css("display", "block");
	--%>
	parent.lfn_resize();
}

function gfn_subMenu(pThis) {
	$(".subMenu").each(function(){
		$(this).removeClass("here");
	});
	
	$(pThis).addClass("here");
	
	parent.lfn_resize();
}

function lfn_subMenuInit() {
	$(".subMenu").each(function(){
		$(this).removeClass("here");
	});
}

</script> 

<body>

<form id="frm" name="frm" method="post">

<div id="wrap">
  	<!-- header -->
  	<div id="header_wrap"><div id="header"></div></div>
  	<!-- end header -->
  	<hr />
  	<!-- container -->
  	<div id="container">
    	<!-- side -->
    	<div id="side">
      		<!-- left header -->
      		<div id="side_header">
	      		<h1 class="logo"><img src="/resources/images/admin/common/logo.png" alt="Q Learning" /></h1>
	      		<p class="logmsg f-small">${set.loginVO.userName}님이 로그인하셨습니다.</p>
	      		<div class="log_btn">
	        		<a href="#" onclick="f_menuContent('/member/memberU'); lfn_subMenuInit();"><img src="/resources/images/admin/common/btn_mem_info.png" /></a>
	        		<a href="#" onclick="gfn_ajax.logout()"><img src="/resources/images/admin/common/btn_logout.png" /></a>
	      		</div>
	    	</div>
	    	<hr />
	    	<!-- end left header -->
	    	<!-- snb -->
	    	<div id="menu">
        		<ul class="snb">
	          		<li><a href="#" class="mainMenu linker" onclick="gfn_menu(this)"><span>강좌관리</span></a>
			            <ul class="subMenuUl">
			              	<li><a href="#" id="defaultMenu" name="defaultMenu" class="subMenu linker" onclick="f_menuContent('/tutor/myCourse'); gfn_subMenu(this);"><span>담당 강좌 리스트</span></a></li>
			         	</ul>
			      	</li>
	          		<li><a href="#" class="mainMenu linker" onclick="gfn_menu(this)"><span>비용관리</span></a>
			            <ul class="subMenuUl">
			              	<li><a href="#" class="subMenu linker" onclick="f_menuContent('/cost/tutorCostPayList'); gfn_subMenu(this);"><span>이익금 지급 관리</span></a></li>
			         	</ul>
			      	</li>
        		</ul>
      		</div>
    	</div>
    	<!-- end side -->
    </div>
</div>    
	
	
	
</form>

</body>
</html>
