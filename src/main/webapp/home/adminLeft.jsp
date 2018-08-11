<%@ page contentType="text/html;charset=utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<html>
<head>
</head>

<%@ include file="../common/commMenuInclude.jsp" %>

<script type="text/javascript">

$(document).ready(function(){
	f_menuContent('/normalCourse/normalCourseList');
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
	axAccountList :			{	page : "/ax/account/axAccountList"	},
	axCompanyList :			{	page : "/ax/account/axCompanyList"	},
	axPointList :			{	page : "/ax/account/axPointList"	}
}


function gfn_openMenu(pageId) {
	console.log(pageObj[pageId].page);
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
	        		<a href="#" onclick="f_menuContent('/member/memberU'); lfn_subMenuInit();"><img src="/resources/images/admin/common/btn_mem_info.png" /></a>
	        		<a href="#" onclick="gfn_ajax.logout()"><img src="/resources/images/admin/common/btn_logout.png" /></a>
	      		</div>
	    	</div>
	    	<hr />
	    	<!-- end left header -->
	    	<!-- snb -->
	    	<div id="menu">
        		<ul class="snb">
          			<li><a href="#" class="mainMenu linker" onclick="gfn_menu(this);"><span>카테고리 관리(New)</span></a>
			            <ul style="display:none" class="subMenuUl">
			              	<li><a href="#" class="subMenu linker" onclick="gfn_openMenu('axCategoryLevel1List'); gfn_subMenu(this);"><span>대분류 관리</span></a></li>
			              	<li><a href="#" class="subMenu linker" onclick="gfn_openMenu('axCategoryLevel2List'); gfn_subMenu(this);"><span>중분류 관리</span></a></li>
			              	<li><a href="#" class="subMenu linker" onclick="gfn_openMenu('axCategoryLevel3List'); gfn_subMenu(this);"><span>소분류 관리</span></a></li>
			         	</ul>
	          		</li>
	          		<li><a href="#" class="mainMenu linker" onclick="gfn_menu(this)"><span>설문지 관리(New)</span></a>
			            <ul style="display:none" class="subMenuUl">
			              	<li><a href="#" class="subMenu linker" onclick="gfn_openMenu('axQuestGroupList'); gfn_subMenu(this);"><span>설문지 그룹관리</span></a></li>
			         	</ul>
			      	</li>
	          		<li><a href="#" class="mainMenu linker" onclick="gfn_menu(this)"><span>과정 관리(New)</span></a>
			            <ul style="display:none" class="subMenuUl">
			              	<li><a href="#" class="subMenu linker" onclick="gfn_openMenu('axCourseCodeList'); gfn_subMenu(this);"><span>과정 코드 관리</span></a></li>
			              	<li><a href="#" class="subMenu linker" onclick="gfn_openMenu('axCourseMasterList'); gfn_subMenu(this);"><span>과정 Master 관리</span></a></li>
			              	<li><a href="#" class="subMenu linker" onclick="gfn_openMenu('axCourseReportList'); gfn_subMenu(this);"><span>과정 레포트 관리</span></a></li>
			              	<li><a href="#" class="subMenu linker" onclick="gfn_openMenu('axCourseExamList'); gfn_subMenu(this);"><span>과정 시험 관리</span></a></li>
			              	<li><a href="#" class="subMenu linker" onclick="gfn_openMenu('axCourseExamTypeList'); gfn_subMenu(this);"><span>과정 시험 유형 관리</span></a></li>
			         	</ul>
			      	</li>
	          		<li><a href="#" class="mainMenu linker" onclick="gfn_menu(this)"><span>강의 관리(New)</span></a>
			            <ul style="display:none" class="subMenuUl">
			              	<li><a href="#" class="subMenu linker" onclick="gfn_openMenu('axCourseList'); gfn_subMenu(this);"><span>강의 관리</span></a></li>
			         	</ul>
			      	</li>
	          		<li><a href="#" class="mainMenu linker" onclick="gfn_menu(this)"><span>계정 관리(New)</span></a>
			            <ul style="display:none" class="subMenuUl">
			              	<li><a href="#" class="subMenu linker" onclick="gfn_openMenu('axAccountList'); gfn_subMenu(this);"><span>사용자 관리</span></a></li>
			              	<li><a href="#" class="subMenu linker" onclick="gfn_openMenu('axCompanyList'); gfn_subMenu(this);"><span>회사 관리</span></a></li>
			              	<li><a href="#" class="subMenu linker" onclick="gfn_openMenu('axPointList'); gfn_subMenu(this);"><span>포인트 관리</span></a></li>
			         	</ul>
			      	</li>
<c:if test="${set.loginVO.adminYn eq 'A'}">	
          			<li><a href="#" class="mainMenu linker" onclick="gfn_menu(this);"><span>카테고리 관리</span></a>
			            <ul style="display:none" class="subMenuUl">
			              	<li><a href="#" class="subMenu linker" onclick="f_menuContent('/category/categoryList'); gfn_subMenu(this);"><span>카테고리 관리(Old)</span></a></li>
			         	</ul>
	          		</li>
</c:if>	
<c:if test="${set.loginVO.adminYn eq 'C' || set.loginVO.adminYn eq 'A'}">	
	          		<li><a href="#" class="mainMenu linker" onclick="gfn_menu(this)"><span>설문지 관리</span></a>
			            <ul style="display:none" class="subMenuUl">
			              	<li><a href="#" class="subMenu linker" onclick="f_menuContent('/quest/questGroupList'); gfn_subMenu(this);"><span>설문지 그룹관리</span></a></li>
			              	<li><a href="#" class="subMenu linker" onclick="f_menuContent('/quest/questList'); gfn_subMenu(this);"><span>설문지 관리</span></a></li>
			              	<li><a href="#" class="subMenu linker" onclick="f_menuContent('/quest/questManageList'); gfn_subMenu(this);"><span>과정별 설문지 관리</span></a></li>
			         	</ul>
			      	</li>
	          		<li><a href="#" class="mainMenu linker" onclick="gfn_menu(this)"><span>강좌관리</span></a>
			            <ul style="display:none" class="subMenuUl">
			              	<li><a href="#" class="subMenu linker" onclick="f_menuContent('/courseCode/courseCodeList'); gfn_subMenu(this);"><span>과정 코드 관리</span></a></li>
			              	<li><a href="#" class="subMenu linker" onclick="f_menuContent('/courseResource/courseResourceList'); gfn_subMenu(this);"><span>과정 주차 관리</span></a></li>
			              	<li><a href="#" class="subMenu linker" onclick="f_menuContent('/courseMaster/courseMasterList'); gfn_subMenu(this);"><span>과정 Master 관리</span></a></li>
			              	<li><a href="#" class="subMenu linker" onclick="f_menuContent('/courseImage/courseImageList'); gfn_subMenu(this);"><span>과정 이미지 관리</span></a></li>
			              	<li><a href="#" class="subMenu linker" onclick="f_menuContent('/courseExam/courseExamList'); gfn_subMenu(this);"><span>과정 시험 관리</span></a></li>
			         	</ul>
			      	</li>
</c:if>	
<c:if test="${set.loginVO.adminYn eq 'A' || set.loginVO.adminYn eq 'M'}">	
	          		<li><a href="#" class="mainMenu linker" onclick="gfn_menu(this)"><span>일반강좌관리</span></a>
	            		<ul style="display:none" class="subMenuUl">
	              			<li><a href="#" class="subMenu linker" id="firstMenu" onclick="f_menuContent('/normalCourse/normalCourseList'); gfn_subMenu(this);"><span>강좌관리</span></a></li>
	              			<li><a href="#" class="subMenu linker" onclick="f_menuContent('/normalCourse/popularCourseList'); gfn_subMenu(this);"><span>인기강좌관리</span></a></li>
	            		</ul>
	          		</li>
	          		<li><a href="#" class="mainMenu linker" onclick="gfn_menu(this)"><span>기업강좌관리</span></a>
	            		<ul style="display:none" class="subMenuUl">
	              			<li><a href="#" class="subMenu linker" onclick="f_menuContent('/companyCourse/companyCourseList'); gfn_subMenu(this);"><span>강좌관리</span></a></li>
	              			<li><a href="#" class="subMenu linker" onclick="f_menuContent('/company/companyList'); gfn_subMenu(this);"><span>회사관리</span></a></li>
	            		</ul>
	          		</li>
	          		<li><a href="#" class="mainMenu linker" onclick="gfn_menu(this)"><span>입금관리</span></a>
	            		<ul style="display:none" class="subMenuUl">
	              			<li><a href="#" class="subMenu linker" onclick="f_menuContent('/cost/costApprovalList'); gfn_subMenu(this);"><span>입금관리</span></a></li>
	              			<li><a href="#" class="subMenu linker" onclick="f_menuContent('/cost/costBankList'); gfn_subMenu(this);"><span>은행입금 관리</span></a></li>
	              			<li><a href="#" class="subMenu linker" onclick="f_menuContent('/cost/costRefundList'); gfn_subMenu(this);"><span>환불 관리</span></a></li>
	            		</ul>
	          		</li>
</c:if>	
<c:if test="${set.loginVO.adminYn eq 'A'}">		 
          			<li><a href="#" class="mainMenu linker" onclick="gfn_menu(this)"><span>비용관리</span></a>
            			<ul style="display:none" class="subMenuUl">
              				<li><a href="#" class="subMenu linker" onclick="f_menuContent('/cost/costNotPayList'); gfn_subMenu(this);"><span>이익금 미지금 관리</span></a></li>
              				<li><a href="#" class="subMenu linker" onclick="f_menuContent('/cost/costPayList'); gfn_subMenu(this);"><span>이익금 지급관리</span></a></li>
              				<li><a href="#" class="subMenu linker" onclick="f_menuContent('/cost/costRateList'); gfn_subMenu(this);"><span>분배비율관리</span></a></li>
            			</ul>
          			</li>
</c:if>	
<c:if test="${set.loginVO.adminYn eq 'A' || set.loginVO.adminYn eq 'M'}">	
          			<li><a href="#" class="mainMenu linker" onclick="gfn_menu(this)"><span>성적 관리</span></a>
            			<ul style="display:none" class="subMenuUl">
              				<li><a href="#" class="subMenu linker" onclick="f_menuContent('/evaluation/courseList'); gfn_subMenu(this);"><span>진도 관리</span></a></li>
              				<li><a href="#" class="subMenu linker" onclick="f_menuContent('/exam/examManageList'); gfn_subMenu(this);"><span>시험 관리</span></a></li>
            			</ul>
          			</li>
          			<li><a href="#" class="mainMenu linker" onclick="gfn_menu(this)"><span>수강후기 관리</span></a>
            			<ul style="display:none" class="subMenuUl">
              				<li><a href="#" class="subMenu linker" onclick="f_menuContent('/postscript/postscriptList'); gfn_subMenu(this);"><span>수강후기 관리</span></a></li>
            			</ul>
          			</li>
          			<li><a href="#" class="mainMenu linker" onclick="gfn_menu(this)"><span>게시물관리</span></a>
		            	<ul style="display:none" class="subMenuUl">
		              		<li><a href="#" class="subMenu linker" onclick="f_menuContent('/board/boardNoticeList',{urlParams:'courseId=0'}); gfn_subMenu(this);"><span>공지사항</span></a></li>
		              		<li><a href="#" class="subMenu linker" onclick="f_menuContent('/board/boardFaqList'); gfn_subMenu(this);"><span>FAQ</span></a></li>
		              		<li><a href="#" class="subMenu linker" onclick="f_menuContent('/board/boardFreeList',{urlParams:'courseId=0'}); gfn_subMenu(this);"><span>자유게시판</span></a></li>
		              		<li><a href="#" class="subMenu linker" onclick="f_menuContent('/board/boardDataList',{urlParams:'courseId=0'}); gfn_subMenu(this);"><span>자료실</span></a></li>
		              		<li><a href="#" class="subMenu linker" onclick="f_menuContent('/board/boardReportList',{urlParams:'courseId=0'}); gfn_subMenu(this);"><span>레포트</span></a></li>
		              		<li><a href="#" class="subMenu linker" onclick="f_menuContent('/board/boardQnaList',{urlParams:'courseId=0'}); gfn_subMenu(this);"><span>Q&A</span></a></li>
		              		<li><a href="#" class="subMenu linker" onclick="f_menuContent('/board/boardDiscussionList',{urlParams:'courseId=0'}); gfn_subMenu(this);"><span>토론</span></a></li>
		            	</ul>
		          	</li>
		          	<li><a href="#" class="mainMenu linker" onclick="gfn_menu(this);"><span>상담관리</span></a>
		            	<ul style="display:none" class="subMenuUl">
		              		<li><a href="#" class="subMenu linker" onclick="f_menuContent('/counsel/counselList'); gfn_subMenu(this);"><span>상담내역</span></a></li>
		            	</ul>
		          	</li>
		          	<li><a href="#" class="mainMenu linker" onclick="gfn_menu(this);"><span>사용자</span></a>
		            	<ul style="display:none" class="subMenuUl">
		              		<li><a href="#" class="subMenu linker" onclick="f_goMenu('/member/memberList'); gfn_subMenu(this);"><span>사용자 관리</span></a></li>
		              		<li><a href="#" class="subMenu linker" onclick="f_menuContent('/member/teacherList'); gfn_subMenu(this);"><span>강사 관리</span></a></li>
		              		<li><a href="#" class="subMenu linker" onclick="f_menuContent('/point/pointUserList'); gfn_subMenu(this);"><span>Point관리</span></a></li>
		            	</ul>
		          	</li>
</c:if>	
<c:if test="${set.loginVO.adminYn eq 'A'}">		 
          			<li><a href="#" class="mainMenu linker" onclick="gfn_menu(this)"><span>시스템 관리</span></a>
            			<ul style="display:none" class="subMenuUl">
              				<li><a href="#" class="subMenu linker" onclick="f_menuContent('/set/settingList'); gfn_subMenu(this);"><span>환경설정</span></a></li>
              				<li><a href="#" class="subMenu linker" onclick="f_goMenu('/set/mailList'); gfn_subMenu(this);"><span>1:1 메일 담당자</span></a></li>
              				<li><a href="#" class="subMenu linker" onclick="f_goMenu('/set/bankList'); gfn_subMenu(this);"><span>은행</span></a></li>
              				<li><a href="#" class="subMenu linker" onclick="f_goMenu('/system/logList'); gfn_subMenu(this);"><span>로그</span></a></li>
            			</ul>
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
