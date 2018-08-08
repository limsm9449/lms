<%@ page contentType="text/html;charset=utf-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<head>
<title>
</title>


<%@ include file="../common/commInclude.jsp" %>


</head>

<script type="text/javascript">
$(document).ready(function() {
	parent.lfn_tran("${set.rtnMode}","${set.rtnData}");
});

</script>

<body>
</body>

</html>


