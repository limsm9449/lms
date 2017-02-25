<%@ page contentType="text/html;charset=utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<html>
<%@ include file="../common/commInclude.jsp" %>

<body>
<h2>top...</h2>

<a href="#" onclick="javascript:page.goHome();">home</a>

<c:choose>
	<c:when test="${!empty set.sessVO}">
		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a href="#" onclick="javascript:page.goUserHome();">나의 강의실</a>
		
		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a href="#" onclick="javascript:top.content.location = context + '/main/cart.do';">cart</a>
		
		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a href="#" onclick="gfn_ajax.logout()">Log Out</a>	
		
	</c:when>
	<c:otherwise>
		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		<a href="#" onclick="javascript:top.content.location = homepage + 'html/a.jsp';">추천과정</a>
		<a href="#" onclick="javascript:top.content.location = homepage + 'html/b.jsp';">경영/리더쉽</a>
		<a href="#" onclick="javascript:top.content.location = homepage + 'html/c.jsp';">직무/자격</a>
		나의 강의실
	</c:otherwise>
</c:choose>


</body>

<script type="text/javascript">
function goPage(url) {
	top.content.location = url;	
}

</script> 

</html>
