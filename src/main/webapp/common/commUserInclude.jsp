<%@ page contentType="text/html;charset=utf-8"%>
<%@ page import="com.qp.lms.common.SessionUtil"%>

<meta http-equiv="X-UA-Compatible" content="IE=Edge" />
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />

<script type="text/javascript" src="/resources/js/jquery-1.9.1.min.js"></script>
<script type="text/javascript" src="/resources/js/jquery.autoheight.js"></script>
<script type="text/javascript" src="/resources/js/paging.js"></script>
<script type="text/javascript" src="/resources/js/comm.js"></script>
<script type="text/javascript" src="/resources/js/commPopup.js"></script>
<script type="text/javascript" src="/resources/js/category.js"></script>
<script type="text/javascript" src="/resources/js/utils.js"></script>

<link rel="stylesheet" type="text/css" media="all" href="/resources/css/base.css" />
<link rel="stylesheet" type="text/css" media="all" href="/resources/css/common.css" />
<link rel="stylesheet" type="text/css" media="all" href="/resources/css/layout.css" />
<link rel="stylesheet" type="text/css" media="all" href="/resources/css/main.css" />

<%-- CLEditor --%>
<link rel="stylesheet" type="text/css" href="/resources/CLEditor/jquery.cleditor.css" />
<script type="text/javascript" src="/resources/CLEditor/jquery.cleditor.min.js"></script>

<script type="text/javascript" src="/resources/js/topmenu.js"></script>

<script type="text/javascript">
var context = "";

var resource = {
		label : {
			all : "<spring:message code="lms.label.all" text="-" />"	
		},
		msg : {
			systemError : "<spring:message code="lms.msg.systemError" text="-" />"	
		}
}

<%
	if ( SessionUtil.getSession() == null )
		out.println("var sYn = 'N';");
	else 
		out.println("var sYn = 'Y';");
%>


</script>