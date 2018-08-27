<%@ page contentType="text/html;charset=utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<html>

<title>QLearning LCMS</title>
<meta http-equiv="X-UA-Compatible" content="IE=Edge" />

<%@ include file="../common/commAdminInclude.jsp" %>

<link rel="stylesheet" type="text/css" media="all" href="<c:url value="/resources/css/admin/frame.css"/>" />

<script type="text/javascript">
var gCondition = {
}
</script>

<script type="text/javascript">
$(document).ready(function(e) {
 	$('#content').load(function() {
 		lfn_resize();
 	});
});

function lfn_resize() {
	gfn_resize();
}
	
</script>

</head>

<body onresize="lfn_resize()">

<div class="top"><div id="header"></div></div>
<div class="left"><iframe src="/compManagerLeft.do" name="left" id="left" scrolling="no" frameborder="0" border="0"></iframe></div>
<div class="right"><iframe src="content.jsp" name="content" id="content" scrolling="no" frameborder="0" border="0"></iframe></div>
<div class="bottom"><iframe src="/adminBottom.do" name="bottom" id="bottom" scrolling="no" frameborder="0" border="0"></iframe></div>

</body>

</html>
