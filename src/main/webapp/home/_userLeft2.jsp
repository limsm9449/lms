<%@ page contentType="text/html;charset=utf-8"%>


<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<script type="text/javascript">

$(document).ready(function() {
	$("#top1").removeClass("here");
	$("#top2").addClass("here");
	$("#top3").removeClass("here");
	menuStart();
});


function lfn_goUserMenu(pKind) {
	if ( pKind == "attendCourseList" ) {
		gfn_goPage("/normalUser/attendCourseList",""); 
	}
}

</script>

<%
	request.setAttribute("courseId",request.getParameter("courseId"));
%>

<div id="side" class="site">
	<h2>수강<span class="blue">신청</span></h2>
	<ul class="snb">
		<li class="l_head">교육과정</li>
		<li><a href="javascript:" onclick="page.goPage('/main/courseList');"<% if ( menuId.equals("courseAll") ) { %>class="here"<% } %> >전체 교육과정</a></li>
<c:forEach var="row" items="${favorityCourseList}" varStatus="idx">
       	<li><a href="javascript:" onclick="page.goPage('/main/mainCourseData','courseId=${row.courseId}');"<c:if test="${row.courseId eq courseId}">class="here"</c:if> >${row.courseName}</a></li>
</c:forEach>    
		<li class="l_head">수강신청</li>
		<li><a href="javascript:" onclick="page.goNsJsp('how');"<% if ( menuId.equals("how") ) { %>class="here"<% } %> >수강신청방법</a></li>
		<li><a href="javascript:" onclick="page.goPage('/main/cart');"<% if ( menuId.equals("cart") ) { %>class="here"<% } %> >장바구니</a></li>
	</ul>
</div>