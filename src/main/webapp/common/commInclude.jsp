<%@ page contentType="text/html;charset=utf-8"%>
<%@ page import="com.qp.lms.common.SessionUtil"%>

<meta http-equiv="X-UA-Compatible" content="IE=Edge" />
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />

<%
	String version = "20180805";
%>


<script type="text/javascript" src="/resources/js/jquery-3.3.1.min.js"></script>
<script type="text/javascript" src="/resources/js/jquery.autoheight.js"></script>
<script type="text/javascript" src="/resources/js/paging.js"></script>
<script type="text/javascript" src="/resources/js/comm.js?version=<%=version%>"></script>
<script type="text/javascript" src="/resources/js/commPopup.js"></script>
<script type="text/javascript" src="/resources/js/category.js"></script>
<script type="text/javascript" src="/resources/js/utils.js?version=<%=version%>"></script>

<link rel="stylesheet" type="text/css" media="all" href="/resources/css/admin/base.css" />
<link rel="stylesheet" type="text/css" media="all" href="/resources/css/admin/common.css" />

<%-- datepicker --%>
<link type="text/css" href="/resources/datepicker/css/jquery-ui-1.10.2.custom.css" rel="stylesheet" />
<link type="text/css" href="/resources/datepicker/css/style.css" rel="stylesheet" />
<script type="text/javascript" src="/resources/datepicker/js/jquery-ui-1.10.2.custom.js"></script>
<script type="text/javascript" src="/resources/datepicker/js/jquery.ui.datepicker-ko.js"></script>

<%-- CLEditor --%>
<link rel="stylesheet" type="text/css" href="/resources/CLEditor/jquery.cleditor.css" />
<script type="text/javascript" src="/resources/CLEditor/jquery.cleditor.min.js"></script>

<%-- multiselect --%>
<link rel="stylesheet" type="text/css" href="/resources/multiselect/css/bootstrap-multiselect.css" />
<script type="text/javascript" src="/resources/multiselect/js/bootstrap-multiselect.js"></script>

<script type="text/javascript">
var contents = "<%=request.getContextPath()%>/cContents/";
var homepage = "<%=request.getContextPath()%>/homepage/";
var context = "";
var pprev = "<img src='<%=request.getContextPath()%>/resources/images/icon/ico_pprev.gif'>";
var prev = "<img src='<%=request.getContextPath()%>/resources/images/icon/ico_prev.gif'>";
var next = "<img src='<%=request.getContextPath()%>/resources/images/icon/ico_next.gif'>";
var nnext = "<img src='<%=request.getContextPath()%>/resources/images/icon/ico_nnext.gif'>";

var resource = {
		label : {
			all : "<spring:message code="lms.label.all" text="-" />"	
		},
		msg : {
			systemError : "<spring:message code="lms.msg.systemError" text="-" />"	
		}
}


</script>

<style>
.mask {
    position:absolute;
    left:0;
    top:0;
    z-index:9999;
    background-color:#333333;
    display:none;
}
.popupDiv {
    display: none;
    background-color: #ffffff;
    height: 200px;
    z-index:99999;
}
.grid-cell-edit {
    background: #D0F5A9;
}
.grid-cell-edit2 {
    background: #D0F5F9;
}
</style>
