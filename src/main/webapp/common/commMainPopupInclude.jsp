<%@ page contentType="text/html;charset=utf-8"%>
<%@ page import="com.qp.lms.common.SessionUtil"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="java.util.Date"%>

<%
	Date today = new Date();
	SimpleDateFormat date = new SimpleDateFormat("yyyyMMdd");
	SimpleDateFormat time = new SimpleDateFormat("hhmmss");
    
	String timestamp = date.format(today) + time.format(today);
%>

<script type="text/javascript" src="/resources/js/jquery-3.3.1.min.js"></script>
<script type="text/javascript" src="/resources/js/comm.js?timestamp=<%=timestamp%>"></script>
<script type="text/javascript" src="/resources/js/utils.js?timestamp=<%=timestamp%>"></script>
<script type="text/javascript" src="/resources/js/category.js"></script>

<!--[if IE]>
    <link rel='stylesheet' href='/resources/homepage/css/main_ie.css'>
<![endif]-->

<link href='https://fonts.googleapis.com/css?family=Nanum+Gothic' rel='stylesheet'>

<link rel='stylesheet' href='/resources/homepagePopup/css/common/reset.css'>
<link rel='stylesheet' href='/resources/homepagePopup/css/common/common.css'>
<link rel='stylesheet' href='/resources/homepagePopup/css/popup/popup_common.css'>
<script src='/resources/homepagePopup/js/main.js?timestamp=<%=timestamp%>'></script>

<%-- datepicker --%>
<script type="text/javascript" src="/resources/jquery-ui-1.12.1.custom/jquery-ui.js"></script> 
<link type="text/css" href="/resources/jquery-ui-1.12.1.custom/jquery-ui.min.css" rel="stylesheet" />

<%-- CLEditor --%>
<link rel="stylesheet" type="text/css" href="/resources/CLEditor/jquery.cleditor.css" />
<script type="text/javascript" src="/resources/CLEditor/jquery.cleditor.min.js"></script>

<script type="text/javascript">
var contents = "<%=request.getContextPath()%>/cContents/";
var homepage = "<%=request.getContextPath()%>/homepage/";
var context = "";

var resource = {
		label : {
			all : "<spring:message code="lms.label.all" text="-" />"	
		},
		msg : {
			systemError : "<spring:message code="lms.msg.systemError" text="-" />"	
		}
}

var timestamp = "<%=timestamp%>";

</script>