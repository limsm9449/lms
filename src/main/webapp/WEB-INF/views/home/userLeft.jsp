<%@ page contentType="text/html;charset=utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<script type="text/javascript">

$(document).ready(function() {
	$("#top1").addClass("here");
	$("#top2").removeClass("here");
	$("#top3").removeClass("here");
	menuStart();
});


function lfn_goUserMenu(pKind) {
	if ( pKind == "attendCourseList" ) {
		gfn_goPage("/normalUser/attendCourseList",""); 
	}
}

</script>


<div id="side" class="site">
	<h2>나의<span class="blue">강의실</span></h2>
	<ul class="snb">
		<li class="l_head">나의 학습활동</li>
		<li><a href="javascript:" onclick="window.location='/normalUser/attendCourseList.do';" <% if ( menuId.equals("attendCourseList") ) { %>class="here"<% } %> >수강과정</a></li>
		<li><a href="javascript:" onclick="window.location='/normalUser/waitingCourseList.do';" <% if ( menuId.equals("waitingCourseList") ) { %>class="here"<% } %> >수강대기과정</a></li>
		<li><a href="javascript:" onclick="window.location='/normalUser/myCourseList.do';" <% if ( menuId.equals("myCourseList") ) { %>class="here"<% } %> >수강 완료 과정</a></li>
		<li class="l_head">나의 정보</li>
		<li><a href="javascript:" onclick="window.location='/member/userMemberU.do';" <% if ( menuId.equals("userMemberU") ) { %>class="here"<% } %> >회원정보수정</a></li>
		<li><a href="javascript:" onclick="window.location='/member/memberChangePassword.do';" <% if ( menuId.equals("memberChangePassword") ) { %>class="here"<% } %> >비밀번호변경</a></li>
		<li><a href="javascript:" onclick="window.location='/counsel/userCounselList.do';" <% if ( menuId.equals("userCounselList") ) { %>class="here"<% } %> >상담내역</a></li>
		<li><a href="javascript:" onclick="window.location='/member/memberRetired.do';" <% if ( menuId.equals("memberRetired") ) { %>class="here"<% } %> >회원탈퇴</a></li>
	</ul>
</div>