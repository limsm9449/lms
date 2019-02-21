<%@ page contentType="text/html;charset=utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<html>
<head>
</head>

<%@ include file="../../common/commAxAdminInclude.jsp" %>

<link rel="stylesheet" type="text/css" media="all" href="/resources/css/admin/left.css?timestamp=<%=timestamp%>" />

<script type="text/javascript">
	isReload = false;
</script>

<script type="text/javascript">

$(document).ready(function(){
	$(".mainMenu").each(function(){
		$(this).removeClass("here"); 
	});
	$(".subMenuUl").each(function(){
		$(this).css("display", "none");
	});
	$(".subMenu").each(function(){
		$(this).removeClass("here");
	});
	
<c:if test="${auth eq 'ADMIN'}">         		
	gfn_openMenu('axCourseList');

	$("#firstGroup").addClass("here");
</c:if>	
<c:if test="${auth eq 'CONTENTS_MANAGER'}">         		
	gfn_openMenu('axCourseCodeListCm');
	
	$("#cmFirstGroup").addClass("here");
	$("#cmFirstGroup").next().css("display", "block");
	
	$("#cmFirst").addClass("here");
</c:if>	
<c:if test="${auth eq 'SITE_MANAGER'}">         		
	gfn_openMenu('axCourseListSm');

	$("#smFirstGroup").addClass("here");
</c:if>	
<c:if test="${auth eq 'TEACHER'}">         		
	gfn_openMenu('axCourseListTe');
	
	$("#tuFirstGroup").addClass("here");
</c:if>	
<c:if test="${auth eq 'TUTOR'}">         		
	gfn_openMenu('axCourseListTu');
	
	$("#tuFirstGroup").addClass("here");
</c:if>	
<c:if test="${auth eq 'CHANNEL'}">         		
gfn_openMenu('axCourseListCh');

$("#chFirstGroup").addClass("here");
</c:if>	

//$("#firstMenu").addClass("here");
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
	axAccountUser : 			{	page : "/ax/account/axAccountUser"	},
	axCategoryLevel1List : 		{	page : "/ax/category/axCategoryLevel1List"	},
	axCategoryLevel2List : 		{	page : "/ax/category/axCategoryLevel2List"	},
	axCategoryLevel3List : 		{	page : "/ax/category/axCategoryLevel3List"	},
	axQuestGroupList : 			{	page : "/ax/quest/axQuestGroupList"	},
	axCourseCodeList : 			{	page : "/ax/course/axCourseCodeList"	},
	axCourseMasterList : 		{	page : "/ax/course/axCourseMasterList"	},
	axCourseReportList : 		{	page : "/ax/course/axCourseReportList"	},
	axCourseExamList : 			{	page : "/ax/course/axCourseExamList"	},
	axCourseExamTypeList :		{	page : "/ax/course/axCourseExamTypeList"	},
	axCourseList :				{	page : "/ax/course/axCourseList"	},
	axCourseEventPointList :	{	page : "/ax/course/axCourseEventPointList"	},
	axMainPageList :			{	page : "/ax/course/axMainPageList"	},
	axCostList :				{	page : "/ax/cost/axCostList"	},
	axCardCostList :			{	page : "/ax/cost/axCardCostList"	},
	axCostCalcStatusList :		{	page : "/ax/cost/axCostCalcStatusList"	},
	axCostCalcList :			{	page : "/ax/cost/axCostCalcList"	},
	axIncomeList :				{	page : "/ax/cost/axIncomeList"	},
	axIncomeMonthList :			{	page : "/ax/cost/axIncomeMonthList"	},
	axScoreList :				{	page : "/ax/score/axScoreList"	},
	axUserScoreList :			{	page : "/ax/score/axUserScoreList"	},
	axAccountList :				{	page : "/ax/account/axAccountList"	},
	axCompanyList :				{	page : "/ax/account/axCompanyList"	},
	axCompanyC2cList :			{	page : "/ax/account/axCompanyC2cList"	},
	axCompanyUserList :			{	page : "/ax/account/axCompanyUserList"	},
	axPointCodeList :			{	page : "/ax/account/axPointCodeList"	},	
	axPointList :				{	page : "/ax/account/axPointList"	},
	axPointEventMemberList :	{	page : "/ax/account/axPointEventMemberList"	},
	axMainBoardNoticeList :		{	page : "/ax/board/axMainBoardNoticeList"	},
	axBoardFaqList :			{	page : "/ax/board/axBoardFaqList"	},
	axBoardReportList :			{	page : "/ax/board/axBoardReportList"	},
	axBoardDataList :			{	page : "/ax/board/axBoardDataList"	},
	axBoardFreeList :			{	page : "/ax/board/axBoardFreeList"	},
	axBoardQnaList :			{	page : "/ax/board/axBoardQnaList"	},
	axBoardDiscussionList :		{	page : "/ax/board/axBoardDiscussionList"	},
	axMainBoardEventList :		{	page : "/ax/board/axMainBoardEventList"	},
	axCounselList :				{	page : "/ax/counsel/axCounselList"	},
	axInquiryList :				{	page : "/ax/counsel/axInquiryList"	},
	axMainFrameList :			{	page : "/ax/setting/axMainFrameList"	},
	axConfigList :				{	page : "/ax/setting/axConfigList"	},
	axMailList :				{	page : "/ax/setting/axMailList"	},
	axBankList :				{	page : "/ax/setting/axBankList"	},
	axSmtpList :				{	page : "/ax/setting/axSmtpList"	},
	axCodeList :				{	page : "/ax/setting/axCodeList"	},
	axLogList :					{	page : "/ax/log/axLogList"	},
	axLoginLogList :			{	page : "/ax/log/axLoginLogList"	},
	axLoginMonthLogList :		{	page : "/ax/log/axLoginMonthLogList"	},
	axMailLogList :				{	page : "/ax/log/axMailLogList"	},
	axCourseCodeListCm : 		{	page : "/ax/contentsManager/axCourseCodeList"	},
	axCourseListCm :			{	page : "/ax/contentsManager/axCourseList"	},
	axIncomeListCm :			{	page : "/ax/contentsManager/axIncomeList"	},
	axCourseListSm :			{	page : "/ax/siteManager/axCourseList"	},
	axMainPageListSm :			{	page : "/ax/siteManager/axMainPageList"	},
	axScoreListSm :				{	page : "/ax/siteManager/axScoreList"	},
	axUserScoreListSm :			{	page : "/ax/siteManager/axUserScoreList"	},
	axApprovalListSm :			{	page : "/ax/siteManager/axApprovalList"	},
	axMainBoardNoticeListSm :	{	page : "/ax/siteManager/axMainBoardNoticeList"	},
	axMainBoardEventListSm 	:	{	page : "/ax/siteManager/axMainBoardEventList"	},
	axCourseListTu :			{	page : "/ax/tutor/axCourseList"	},
	axIncomeListTu :			{	page : "/ax/tutor/axIncomeList"	},
	axCourseListTe :			{	page : "/ax/teacher/axCourseList"	},
	axIncomeListTe :			{	page : "/ax/teacher/axIncomeList"	},
	axCourseListCh :			{	page : "/ax/channel/axCourseList"	},
	axScoreListCh :				{	page : "/ax/channel/axScoreList"	},
	axIncomeListCh :			{	page : "/ax/channel/axIncomeList"	}
}

var pageParam = {}

function gfn_openMenu(pageId, params) {
	if ( params ) {
		pageParam[pageId] = params;
	} else {
		pageParam[pageId] = null;
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
<c:choose>
	<c:when test="${session.compCd eq 'B2C'}">
			      		<h1 class="logo"><img src="/resources/images/admin/common/logo.png" alt="Q Learning" /></h1>
	</c:when>
	<c:otherwise>
			      		<h1 class="logo"><img src="/cImage/company/${session.compCd}_gnb.jpg" alt="${session.compName}" /></h1>
	</c:otherwise>
</c:choose>      		
	      		
	      		<p class="logmsg f-small">${set.loginVO.userName}님</p>
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
			              	<li><a href="#" class="subMenu linker" onclick="gfn_openMenu('axCourseReportList'); gfn_subMenu(this);"><span>과정 리포트 관리</span></a></li>
			              	<li><a href="#" class="subMenu linker" onclick="gfn_openMenu('axCourseExamList'); gfn_subMenu(this);"><span>과정 평가 관리</span></a></li>
			              	<li><a href="#" class="subMenu linker" onclick="gfn_openMenu('axCourseExamTypeList'); gfn_subMenu(this);"><span>과정 평가 유형 관리</span></a></li>
			         	</ul>
			      	</li>
	          		<li><a href="#" class="mainMenu linker" onclick="gfn_openMenu('axCourseList'); gfn_menu(this)" id="firstGroup"><span>강의 관리</span></a></li>
	          		<li><a href="#" class="mainMenu linker" onclick="gfn_openMenu('axScoreList'); gfn_menu(this)"><span>성적 관리</span></a></li>
	          		<li><a href="#" class="mainMenu linker" onclick="gfn_menu(this)"><span>입금 관리</span></a>
			            <ul style="display:none" class="subMenuUl">
			              	<li><a href="#" class="subMenu linker" onclick="gfn_openMenu('axCostList'); gfn_subMenu(this);"><span>은행 입금 관리</span></a></li>
			              	<li><a href="#" class="subMenu linker" onclick="gfn_openMenu('axCardCostList'); gfn_subMenu(this);"><span>카드 입급 관리</span></a></li>
			         	</ul>
			         </li>
	          		<li><a href="#" class="mainMenu linker" onclick="gfn_menu(this)"><span>정산 관리</span></a>
			            <ul style="display:none" class="subMenuUl">
			              	<li><a href="#" class="subMenu linker" onclick="gfn_openMenu('axCostCalcStatusList'); gfn_subMenu(this);"><span>정산 현황 관리</span></a></li>
			              	<li><a href="#" class="subMenu linker" onclick="gfn_openMenu('axCostCalcList'); gfn_subMenu(this);"><span>정산 관리</span></a></li>
			         	</ul>
	          		</li>
	          		<li><a href="#" class="mainMenu linker" onclick="gfn_menu(this)"><span>수입 관리</span></a>
			            <ul style="display:none" class="subMenuUl">
			              	<li><a href="#" class="subMenu linker" onclick="gfn_openMenu('axIncomeList'); gfn_subMenu(this);"><span>수입 관리</span></a></li>
			              	<li><a href="#" class="subMenu linker" onclick="gfn_openMenu('axIncomeMonthList'); gfn_subMenu(this);"><span>월별 수입 관리</span></a></li>
			         	</ul>
	          		</li>
	          		<li><a href="#" class="mainMenu linker" onclick="gfn_menu(this)"><span>계정 관리</span></a>
			            <ul style="display:none" class="subMenuUl">
			              	<li><a href="#" class="subMenu linker" onclick="gfn_openMenu('axAccountList'); gfn_subMenu(this);"><span>사용자 관리</span></a></li>
			              	<li><a href="#" class="subMenu linker" onclick="gfn_openMenu('axCompanyList'); gfn_subMenu(this);"><span>회사 관리</span></a></li>
			              	<li><a href="#" class="subMenu linker" onclick="gfn_openMenu('axCompanyC2cList'); gfn_subMenu(this);"><span>개인채널 관리</span></a></li>
			         	</ul>
			      	</li>
	          		<li><a href="#" class="mainMenu linker" onclick="gfn_menu(this)"><span>포인트 관리</span></a>
			            <ul style="display:none" class="subMenuUl">
			              	<li><a href="#" class="subMenu linker" onclick="gfn_openMenu('axPointCodeList'); gfn_subMenu(this);"><span>포인트 코드 관리</span></a></li>
			              	<li><a href="#" class="subMenu linker" onclick="gfn_openMenu('axCourseEventPointList'); gfn_subMenu(this);"><span>강의 이벤트 관리</span></a></li>
			              	<li><a href="#" class="subMenu linker" onclick="gfn_openMenu('axPointEventMemberList'); gfn_subMenu(this);"><span>회원 이벤트 관리</span></a></li>
			              	<li><a href="#" class="subMenu linker" onclick="gfn_openMenu('axPointList'); gfn_subMenu(this);"><span>포인트 관리</span></a></li>
			         	</ul>
			      	</li>
	          		<li><a href="#" class="mainMenu linker" onclick="gfn_menu(this)"><span>게시물 관리</span></a>
			            <ul style="display:none" class="subMenuUl">
			              	<li><a href="#" class="subMenu linker" onclick="gfn_openMenu('axBoardFaqList'); gfn_subMenu(this);"><span>FAQ</span></a></li>
			              	<li><a href="#" class="subMenu linker" onclick="gfn_openMenu('axMainBoardNoticeList'); gfn_subMenu(this);"><span>공지사항</span></a></li>
			              	<!-- li><a href="#" class="subMenu linker" onclick="gfn_openMenu('axBoardReportList'); gfn_subMenu(this);"><span>레포트</span></a></li>
			              	<li><a href="#" class="subMenu linker" onclick="gfn_openMenu('axBoardDataList'); gfn_subMenu(this);"><span>자료실</span></a></li>
			              	<li><a href="#" class="subMenu linker" onclick="gfn_openMenu('axBoardFreeList'); gfn_subMenu(this);"><span>자유게시판</span></a></li>
			              	<li><a href="#" class="subMenu linker" onclick="gfn_openMenu('axBoardQnaList'); gfn_subMenu(this);"><span>Q&A</span></a></li>
			              	<li><a href="#" class="subMenu linker" onclick="gfn_openMenu('axBoardDiscussionList'); gfn_subMenu(this);"><span>토론</span></a></li-->
			              	<li><a href="#" class="subMenu linker" onclick="gfn_openMenu('axMainBoardEventList'); gfn_subMenu(this);"><span>이벤트</span></a></li>
			         	</ul>
			      	</li>
	          		<li><a href="#" class="mainMenu linker" onclick="gfn_menu(this)"><span>문의 관리</span></a>
			            <ul style="display:none" class="subMenuUl">
			              	<li><a href="#" class="subMenu linker" onclick="gfn_openMenu('axCounselList'); gfn_subMenu(this)"><span>상담내역</span></a></li>
			              	<li><a href="#" class="subMenu linker" onclick="gfn_openMenu('axInquiryList'); gfn_subMenu(this);"><span>기업교육/튜터지원 문의</span></a></li>
			         	</ul>
			      	</li>
	          		<li><a href="#" class="mainMenu linker" onclick="gfn_menu(this)"><span>로그 관리</span></a>
			            <ul style="display:none" class="subMenuUl">
			              	<li><a href="#" class="subMenu linker" onclick="gfn_openMenu('axLoginMonthLogList'); gfn_subMenu(this);"><span>월별 로그인 로그</span></a></li>
			              	<li><a href="#" class="subMenu linker" onclick="gfn_openMenu('axLoginLogList'); gfn_subMenu(this);"><span>로그인 로그</span></a></li>
			              	<li><a href="#" class="subMenu linker" onclick="gfn_openMenu('axLogList'); gfn_subMenu(this)"><span>접속 로그</span></a></li>
			              	<li><a href="#" class="subMenu linker" onclick="gfn_openMenu('axMailLogList'); gfn_subMenu(this)"><span>메일 로그</span></a></li>
			         	</ul>
			      	</li>

			      	</li>
	          		<li><a href="#" class="mainMenu linker" onclick="gfn_menu(this)"><span>설정 관리</span></a>
			            <ul style="display:none" class="subMenuUl">
			              	<li><a href="#" class="subMenu linker" onclick="gfn_openMenu('axMainFrameList'); gfn_subMenu(this);"><span>메인 프레임 설정</span></a></li>
			              	<li><a href="#" class="subMenu linker" onclick="gfn_openMenu('axConfigList'); gfn_subMenu(this);"><span>환경설정</span></a></li>
			              	<li><a href="#" class="subMenu linker" onclick="gfn_openMenu('axMailList'); gfn_subMenu(this);"><span>메일 담당자</span></a></li>
			              	<li><a href="#" class="subMenu linker" onclick="gfn_openMenu('axBankList'); gfn_subMenu(this);"><span>은행</span></a></li>
			              	<li><a href="#" class="subMenu linker" onclick="gfn_openMenu('axSmtpList'); gfn_subMenu(this);"><span>메일 SMTP</span></a></li>
			              	<li><a href="#" class="subMenu linker" onclick="gfn_openMenu('axCodeList'); gfn_subMenu(this);"><span>코드</span></a></li>
			         	</ul>
			      	</li>
	          		<li><a href="#" class="mainMenu linker" onclick="gfn_openMenu('axMainPageList'); gfn_menu(this)" id="firstGroup"><span>메인 페이지 관리(?)</span></a></li>
</c:if>
<c:if test="${auth eq 'CONTENTS_MANAGER'}">         		
	          		<li><a href="#" class="mainMenu linker" onclick="gfn_menu(this)" id="cmFirstGroup"><span>과정 관리</span></a>
			            <ul style="display:none" class="subMenuUl">
			              	<li><a href="#" class="subMenu linker" onclick="gfn_openMenu('axCourseCodeListCm'); gfn_subMenu(this);" id="cmFirst"><span>과정 코드 관리</span></a></li>
			              	<li><a href="#" class="subMenu linker" onclick="gfn_openMenu('axCourseMasterList'); gfn_subMenu(this);"><span>과정 Master 관리</span></a></li>
			              	<li><a href="#" class="subMenu linker" onclick="gfn_openMenu('axCourseReportList'); gfn_subMenu(this);"><span>과정 레포트 관리</span></a></li>
			              	<li><a href="#" class="subMenu linker" onclick="gfn_openMenu('axCourseExamList'); gfn_subMenu(this);"><span>과정 평가 관리</span></a></li>
			              	<li><a href="#" class="subMenu linker" onclick="gfn_openMenu('axCourseExamTypeList'); gfn_subMenu(this);"><span>과정 평가 유형 관리</span></a></li>
			         	</ul>
			      	</li>
	          		<li><a href="#" class="mainMenu linker" onclick="gfn_openMenu('axCourseListCm'); gfn_menu(this)"><span>강의 관리</span></a></li>
	          		<li><a href="#" class="mainMenu linker" onclick="gfn_openMenu('axIncomeListCm'); gfn_menu(this)"><span>수입 관리</span></a></li>
</c:if>
<c:if test="${auth eq 'SITE_MANAGER'}">         		
	          		<li><a href="#" class="mainMenu linker" onclick="gfn_openMenu('axCourseListSm'); gfn_menu(this)" id="smFirstGroup"><span>강의 관리</span></a></li>
	          		<li><a href="#" class="mainMenu linker" onclick="gfn_openMenu('axMainPageListSm'); gfn_menu(this)"><span>메인 페이지 관리</span></a></li>
	          		<li><a href="#" class="mainMenu linker" onclick="gfn_openMenu('axCompanyUserList'); gfn_menu(this)"><span>직원 관리</span></a></li>
	          		<li><a href="#" class="mainMenu linker" onclick="gfn_openMenu('axScoreListSm'); gfn_menu(this)"><span>성적 관리</span></a></li> 
	          		<li><a href="#" class="mainMenu linker" onclick="gfn_openMenu('axApprovalListSm'); gfn_menu(this)"><span>수강신청 이력 관리</span></a></li> 
	          		<li><a href="#" class="mainMenu linker" onclick="gfn_menu(this)"><span>게시물 관리</span></a>
			            <ul style="display:none" class="subMenuUl">
			              	<li><a href="#" class="subMenu linker" onclick="gfn_openMenu('axMainBoardNoticeListSm'); gfn_subMenu(this);"><span>공지사항</span></a></li>
			              	<li><a href="#" class="subMenu linker" onclick="gfn_openMenu('axMainBoardEventListSm'); gfn_subMenu(this);"><span>이벤트</span></a></li>
			         	</ul>
			      	</li>
</c:if>
<c:if test="${auth eq 'TEACHER'}">         		
	          		<li><a href="#" class="mainMenu linker" onclick="gfn_openMenu('axCourseListTe'); gfn_menu(this)" id="tuFirstGroup"><span>강의 관리</span></a></li>
	          		<li><a href="#" class="mainMenu linker" onclick="gfn_openMenu('axIncomeListTe'); gfn_menu(this)"><span>수입 관리</span></a></li>
</c:if>
<c:if test="${auth eq 'TUTOR'}">         		
	          		<li><a href="#" class="mainMenu linker" onclick="gfn_openMenu('axCourseListTu'); gfn_menu(this)" id="tuFirstGroup"><span>강의 관리</span></a></li>
	          		<li><a href="#" class="mainMenu linker" onclick="gfn_openMenu('axScoreList'); gfn_menu(this)"><span>성적 관리</span></a></li> 
	          		<li><a href="#" class="mainMenu linker" onclick="gfn_openMenu('axIncomeListTu'); gfn_menu(this)"><span>수입 관리</span></a></li>
</c:if>
<c:if test="${auth eq 'CHANNEL'}">         		
	          		<li><a href="#" class="mainMenu linker" onclick="gfn_openMenu('axCourseListCh'); gfn_menu(this)" id="chFirstGroup"><span>강의 관리</span></a></li>
	          		<li><a href="#" class="mainMenu linker" onclick="gfn_openMenu('axScoreListCh'); gfn_menu(this)"><span>성적 관리</span></a></li> 
	          		<li><a href="#" class="mainMenu linker" onclick="gfn_openMenu('axIncomeListCh'); gfn_menu(this)"><span>수입 관리</span></a></li>
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
