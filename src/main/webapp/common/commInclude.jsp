<%@ page contentType="text/html;charset=utf-8"%>
<%@ page import="com.qp.lms.common.SessionUtil"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="java.util.Date"%>

<meta http-equiv="X-UA-Compatible" content="IE=Edge" />
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />

<%
	Date today = new Date();
	SimpleDateFormat date = new SimpleDateFormat("yyyyMMdd");
	SimpleDateFormat time = new SimpleDateFormat("hhmmss");
    
	String timestamp = date.format(today) + time.format(today);
%>


<script type="text/javascript" src="/resources/js/jquery-3.3.1.min.js"></script>
<script type="text/javascript" src="/resources/js/jquery.autoheight.js"></script>
<script type="text/javascript" src="/resources/js/paging.js"></script>
<script type="text/javascript" src="/resources/js/comm.js?timestamp=<%=timestamp%>"></script>
<script type="text/javascript" src="/resources/js/commPopup.js"></script>
<script type="text/javascript" src="/resources/js/category.js"></script>
<script type="text/javascript" src="/resources/js/utils.js?timestamp=<%=timestamp%>"></script>

<%-- datepicker --%>
<script type="text/javascript" src="/resources/jquery-ui-1.12.1.custom/jquery-ui.js"></script> 
<link type="text/css" href="/resources/jquery-ui-1.12.1.custom/jquery-ui.min.css" rel="stylesheet" />

<%-- CLEditor --%>
<link rel="stylesheet" type="text/css" href="/resources/CLEditor/jquery.cleditor.css" />
<script type="text/javascript" src="/resources/CLEditor/jquery.cleditor.min.js"></script>

<!-- bootstrap -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>

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

var timestamp = "<%=timestamp%>";

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
.date-range {
    padding: 6px 12px;
    font-size: 14px;
    font-weight: 400;
    line-height: 1;
    color: #555;
    text-align: center;
    background-color: #eee;
    border: 1px solid #ccc;
    border-radius: 4px;
    border-left: 0;
    border-top-left-radius: 0;
    border-bottom-left-radius: 0;
    cursor: pointer;
    width: auto;
    white-space: nowrap;
    vertical-align: middle;
    display: table-cell;
}

</style>
