<%@ page contentType="text/html;charset=utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<script type="text/javascript">

$(document).ready(function() {
	$("#top1").removeClass("here");
	$("#top2").removeClass("here");
	$("#top3").addClass("here");
	menuStart();
});


function lfn_goUserMenu(pKind) {
	if ( pKind == "attendCourseList" ) {
		gfn_goPage("/normalUser/attendCourseList",""); 
	}
}

</script>


<div id="side" class="site">
	<h2>학습<span class="blue">지원</span></h2>
	<ul class="snb">
		<li><a href="javascript:" onclick="window.location='/user/noticeList.do';" <% if ( menuId.equals("noticeList") ) { %>class="here"<% } %> >공지사항</a></li>
		<li><a href="javascript:" onclick="window.location='/user/faqList.do';" <% if ( menuId.equals("faqList") ) { %>class="here"<% } %> >FAQ</a></li>
		<li><a href="javascript:" onclick="page.goPage('/main/mailQuestion');" <% if ( menuId.equals("mailQuesttion") ) { %>class="here"<% } %> >1:1메일문의</a></li>
		<li><a href="javascript:" onclick="window.location='/guest/bankInfo.do';" <% if ( menuId.equals("bankInfo") ) { %>class="here"<% } %> >입금계좌안내</a></li>
	</ul>
</div>