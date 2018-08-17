<%@ page contentType="text/html;charset=utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<html>
<head>
	<title>Login</title>
</head>

<%@ include file="../../common/commAxAdminInclude.jsp" %>

<script type="text/javascript">

$(document).ready(
	function() {
		var data = {
			rtnMode : "${rtnMode}", 
			list : ${listJson}
		};
		
		parent.lfn_tran( data );
	}
);

</script> 

<body>
</body>

</html>
