<%@ page contentType="text/html;charset=utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<html>
<head>
	<title>Login</title>
</head>

<link href="<c:url value="/resources/css/common.css" />" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="<c:url value="/resources/js/jquery-1.9.1.min.js" />"></script>


<script type="text/javascript">

$(document).ready(
	function() {
		if ( "${set.rtnMode}" == "DELETE_OK" || "${set.rtnMode}" == "INSERT_OK" )
			parent.lfn_btn("refresh");
	}
);

</script> 

<body>
</body>

</html>
