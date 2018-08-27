<%@ page contentType="text/html;charset=utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<html>
<head>
</head>

<%@ include file="../common/commMenuInclude.jsp" %>

<script type="text/javascript">

$(document).ready(function(){
<c:if test="${auth eq 'ADMIN'}">         		
	gfn_openMenu('axCourseList');
</c:if>	
<c:if test="${auth eq 'CONTENTS_MANAGER'}">         		
	gfn_openMenu('axCourseCodeList');
</c:if>	
<c:if test="${auth eq 'SITE_MANAGER'}">         		
	gfn_openMenu('axCourseList');
</c:if>	
<c:if test="${auth eq 'TEACHER'}">         		
</c:if>	
<c:if test="${auth eq 'TUTOR'}">         		
</c:if>	

$("#firstMenu").addClass("here");
});

function gfn_menu(pThis) {
	$(".mainMenu").each(function(){
		$(this).removeClass("here");
	});
	$(".subMenuUl").each(function(){
		$(this).css("display", "none");
	});
	
	$(pThis).addClass("here");
	$(pThis).next().css("display", "block");
	
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

function f_goMenu(pDoUrl,pParam) {
	var params = "";
	if ( pParam != undefined && pParam.urlParams != undefined )
		params = "?" + pParam.urlParams;

	document.frm.action = context + pDoUrl + ".do" + params;	
	//document.frm.target = "content";
	//document.frm.method = "POST";	
	document.frm.submit();
}

var pageObj = {
	axAccountUser : 		{	page : "/ax/account/axAccountUser"	},
	axCategoryLevel1List : 	{	page : "/ax/category/axCategoryLevel1List"	},
	axCategoryLevel2List : 	{	page : "/ax/category/axCategoryLevel2List"	},
	axCategoryLevel3List : 	{	page : "/ax/category/axCategoryLevel3List"	},
	axQuestGroupList : 		{	page : "/ax/quest/axQuestGroupList"	},
	axCourseCodeList : 		{	page : "/ax/course/axCourseCodeList"	},
	axCourseMasterList : 	{	page : "/ax/course/axCourseMasterList"	},
	axCourseReportList : 	{	page : "/ax/course/axCourseReportList"	},
	axCourseExamList : 		{	page : "/ax/course/axCourseExamList"	},
	axCourseExamTypeList :	{	page : "/ax/course/axCourseExamTypeList"	},
	axCourseList :			{	page : "/ax/course/axCourseList"	},
	axCostList :			{	page : "/ax/cost/axCostList"	},
	axCostDistributionList :{	page : "/ax/cost/axCostDistributionList"	},
	axScoreList :			{	page : "/ax/score/axScoreList"	},
	axUserScoreList :		{	page : "/ax/score/axUserScoreList"	},
	axAccountList :			{	page : "/ax/account/axAccountList"	},
	axCompanyList :			{	page : "/ax/account/axCompanyList"	},
	axPointList :			{	page : "/ax/account/axPointList"	},
	axBoardNoticeList :		{	page : "/ax/board/axBoardNoticeList"	},
	axBoardFaqList :		{	page : "/ax/board/axBoardFaqList"	},
	axBoardReportList :		{	page : "/ax/board/axBoardReportList"	},
	axBoardDataList :		{	page : "/ax/board/axBoardDataList"	},
	axBoardFreeList :		{	page : "/ax/board/axBoardFreeList"	},
	axBoardQnaList :		{	page : "/ax/board/axBoardQnaList"	},
	axBoardDiscussionList :	{	page : "/ax/board/axBoardDiscussionList"	},
	axCounselList :			{	page : "/ax/counsel/axCounselList"	},
	axConfigList :			{	page : "/ax/setting/axConfigList"	},
	axMailList :			{	page : "/ax/setting/axMailList"	},
	axBankList :			{	page : "/ax/setting/axBankList"	},
	axCodeList :			{	page : "/ax/setting/axCodeList"	},
	axLogList :				{	page : "/ax/log/axLogList"	}
}

var pageParam = {}

function gfn_openMenu(pageId, params) {
	if ( params ) {
		pageParam[pageId] = params;
	}

	//console.log(pageObj[pageId].page);
	f_menuContent("/common/axOpenPage", {urlParams : "page=" + pageObj[pageId].page});
}
</script> 

<body>

<form id="frm" name="frm" method="post" target="content">

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
	        		<a href="#" onclick="gfn_openMenu('axAccountUser'); "><img src="/resources/images/admin/common/btn_mem_info.png" /></a>
	        		<a href="#" onclick="gfn_ajax.logout()"><img src="/resources/images/admin/common/btn_logout.png" /></a>
	      		</div>
	    	</div>
	    	<hr />
	    	<!-- end left header -->
	    	<!-- snb -->
	    	<div id="menu">
        		<ul class="snb">
<c:if test="${auth eq 'ADMIN'}">         		
          			<li><a href="#" class="mainMenu linker" onclick="gfn_menu(this);"><span>카테고리 관리</span></a>
			            <ul style="display:none" class="subMenuUl">
			              	<li><a href="#" class="subMenu linker" onclick="gfn_openMenu('axCategoryLevel1List'); gfn_subMenu(this);"><span>대분류 관리</span></a></li>
			              	<li><a href="#" class="subMenu linker" onclick="gfn_openMenu('axCategoryLevel2List'); gfn_subMenu(this);"><span>중분류 관리</span></a></li>
			              	<li><a href="#" class="subMenu linker" onclick="gfn_openMenu('axCategoryLevel3List'); gfn_subMenu(this);"><span>소분류 관리</span></a></li>
			         	</ul>
	          		</li>
	          		<li><a href="#" class="mainMenu linker" onclick="gfn_openMenu('axQuestGroupList'); gfn_menu(this)"><span>설문지 관리</span></a>
			      	</li>
	          		<li><a href="#" class="mainMenu linker" onclick="gfn_menu(this)"><span>과정 관리</span></a>
			            <ul style="display:none" class="subMenuUl">
			              	<li><a href="#" class="subMenu linker" onclick="gfn_openMenu('axCourseCodeList'); gfn_subMenu(this);"><span>과정 코드 관리</span></a></li>
			              	<li><a href="#" class="subMenu linker" onclick="gfn_openMenu('axCourseMasterList'); gfn_subMenu(this);"><span>과정 Master 관리</span></a></li>
			              	<li><a href="#" class="subMenu linker" onclick="gfn_openMenu('axCourseReportList'); gfn_subMenu(this);"><span>과정 레포트 관리</span></a></li>
			              	<li><a href="#" class="subMenu linker" onclick="gfn_openMenu('axCourseExamList'); gfn_subMenu(this);"><span>과정 시험 관리</span></a></li>
			              	<li><a href="#" class="subMenu linker" onclick="gfn_openMenu('axCourseExamTypeList'); gfn_subMenu(this);"><span>과정 시험 유형 관리</span></a></li>
			         	</ul>
			      	</li>
	          		<li><a href="#" class="mainMenu linker" onclick="gfn_openMenu('axCourseList'); gfn_menu(this)"><span>강의 관리</span></a>
			      	</li>
	          		<li><a href="#" class="mainMenu linker" onclick="gfn_openMenu('axScoreList'); gfn_menu(this)"><span>성적 관리</span></a>
			      	</li>
	          		<li><a href="#" class="mainMenu linker" onclick="gfn_openMenu('axCostList'); gfn_menu(this)"><span>입금 관리</span></a>
			      	</li>
	          		<li><a href="#" class="mainMenu linker" onclick="gfn_openMenu('axCostDistributionList'); gfn_menu(this)"><span>정산 관리</span></a>
			      	</li>
	          		<li><a href="#" class="mainMenu linker" onclick="gfn_menu(this)"><span>계정 관리</span></a>
			            <ul style="display:none" class="subMenuUl">
			              	<li><a href="#" class="subMenu linker" onclick="gfn_openMenu('axAccountList'); gfn_subMenu(this);"><span>사용자 관리</span></a></li>
			              	<li><a href="#" class="subMenu linker" onclick="gfn_openMenu('axCompanyList'); gfn_subMenu(this);"><span>회사 관리</span></a></li>
			              	<li><a href="#" class="subMenu linker" onclick="gfn_openMenu('axPointList'); gfn_subMenu(this);"><span>포인트 관리</span></a></li>
			         	</ul>
			      	</li>
	          		<li><a href="#" class="mainMenu linker" onclick="gfn_menu(this)"><span>게시물 관리</span></a>
			            <ul style="display:none" class="subMenuUl">
			              	<li><a href="#" class="subMenu linker" onclick="gfn_openMenu('axBoardNoticeList'); gfn_subMenu(this);"><span>공지사항</span></a></li>
			              	<li><a href="#" class="subMenu linker" onclick="gfn_openMenu('axBoardFaqList'); gfn_subMenu(this);"><span>FAQ</span></a></li>
			              	<li><a href="#" class="subMenu linker" onclick="gfn_openMenu('axBoardFreeList'); gfn_subMenu(this);"><span>자유게시판</span></a></li>
			              	<li><a href="#" class="subMenu linker" onclick="gfn_openMenu('axBoardDataList'); gfn_subMenu(this);"><span>자료실</span></a></li>
			              	<li><a href="#" class="subMenu linker" onclick="gfn_openMenu('axBoardReportList'); gfn_subMenu(this);"><span>레포트</span></a></li>
			              	<li><a href="#" class="subMenu linker" onclick="gfn_openMenu('axBoardQnaList'); gfn_subMenu(this);"><span>Q&A</span></a></li>
			              	<li><a href="#" class="subMenu linker" onclick="gfn_openMenu('axBoardDiscussionList'); gfn_subMenu(this);"><span>토론</span></a></li>
			         	</ul>
			      	</li>
	          		<li><a href="#" class="mainMenu linker" onclick="gfn_openMenu('axCounselList'); gfn_menu(this)"><span>상담내역</span></a>
			      	</li>
	          		<li><a href="#" class="mainMenu linker" onclick="gfn_openMenu('axLogList'); gfn_menu(this)"><span>로그 관리</span></a>
			      	</li>
	          		<li><a href="#" class="mainMenu linker" onclick="gfn_menu(this)"><span>설정 관리</span></a>
			            <ul style="display:none" class="subMenuUl">
			              	<li><a href="#" class="subMenu linker" onclick="gfn_openMenu('axConfigList'); gfn_subMenu(this);"><span>환경설정</span></a></li>
			              	<li><a href="#" class="subMenu linker" onclick="gfn_openMenu('axMailList'); gfn_subMenu(this);"><span>메일 담당자</span></a></li>
			              	<li><a href="#" class="subMenu linker" onclick="gfn_openMenu('axBankList'); gfn_subMenu(this);"><span>은행</span></a></li>
			              	<li><a href="#" class="subMenu linker" onclick="gfn_openMenu('axCodeList'); gfn_subMenu(this);"><span>코드</span></a></li>
			         	</ul>
			      	</li>
</c:if>
<c:if test="${auth eq 'CONTENTS_MANAGER'}">         		
	          		<li><a href="#" class="mainMenu linker" onclick="gfn_menu(this)"><span>과정 관리</span></a>
			            <ul style="display:none" class="subMenuUl">
			              	<li><a href="#" class="subMenu linker" onclick="gfn_openMenu('axCourseCodeList'); gfn_subMenu(this);"><span>과정 코드 관리</span></a></li>
			              	<li><a href="#" class="subMenu linker" onclick="gfn_openMenu('axCourseMasterList'); gfn_subMenu(this);"><span>과정 Master 관리</span></a></li>
			              	<li><a href="#" class="subMenu linker" onclick="gfn_openMenu('axCourseReportList'); gfn_subMenu(this);"><span>과정 레포트 관리</span></a></li>
			              	<li><a href="#" class="subMenu linker" onclick="gfn_openMenu('axCourseExamList'); gfn_subMenu(this);"><span>과정 시험 관리</span></a></li>
			              	<li><a href="#" class="subMenu linker" onclick="gfn_openMenu('axCourseExamTypeList'); gfn_subMenu(this);"><span>과정 시험 유형 관리</span></a></li>
			         	</ul>
			      	</li>
</c:if>
<c:if test="${auth eq 'SITE_MANAGER'}">         		
</c:if>
<c:if test="${auth eq 'TEACHER'}">         		
</c:if>
<c:if test="${auth eq 'TUTOR'}">         		
	          		<li><a href="#" class="mainMenu linker" onclick="gfn_openMenu('axCourseList'); gfn_menu(this)"><span>강의 관리</span></a>
			      	</li>
	          		<li><a href="#" class="mainMenu linker" onclick="gfn_openMenu('axScoreList'); gfn_menu(this)"><span>성적 관리</span></a>
			      	</li> 
</c:if>
        		</ul>
      		</div>
    	</div>
    	<!-- end side -->
    </div>
</div>    
	
</form>

</body>
</html>
