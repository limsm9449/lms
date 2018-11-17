<%@ page contentType="text/html;charset=utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!DOCTYPE html>
<html lang='ko'>
<head>
    <meta charset='utf-8'>
    <meta name='viewport' content='width=device-width, initial-scale=1, minimum-scale=1, maximum-scale=1'>
    <meta http-equiv='X-UA-Compatible' content='ie=edge'>
    <title>File</title>

	<%@ include file="../common/commMainInclude.jsp" %>
	
    <link rel='stylesheet' href='/resources/homepage/css/initialization.css'>
    <link rel='stylesheet' href='/resources/homepage/css/etc/iframe_file_view.css'>
    <style>
        html{
            overflow-y : hidden;
        }
    </style>    
</head>

<script type="text/javascript">

var preUrl = "/board/"; 

$(document).ready(function() {
});

function lfn_btn(pKind, pParam) {
	if ( pKind =="download" ) {
		$("#seq").val(pParam.seq);
		document.frm.action = context + preUrl + "attachDownload.do";
		document.frm.target = "tranFrameS";
		document.frm.method = "POST";	
		document.frm.submit();
	} 
}

</script>

<body style='background:#fff'>
<form id="frm" name="frm" action="" method="post" enctype="multipart/form-data">
	<input id="seq" name="seq" value="0" type="hidden"/>

    <div class='ifame_wrap'>
        <div class='item_head clear_fix'>
            <p class='name'>파일이름</p>
            <p>파일크기</p>
        </div>
        <div class='item_list'>
<c:forEach var="row" items="${set.list}" varStatus="idx">
            <div class='clear_fix'>
				<p class='name'><a href="#" onclick="javascript:lfn_btn('download',{seq:'${row.seq}'}); return false;">${row.orgFileName}</a>B</p>
	            <p><fmt:formatNumber value="${row.fileSize/1000}" pattern="#,##0"/> KB</p>
            </div>
</c:forEach>            
        </div>
    </div>
</form>

<iframe id="tranFrameS" name="tranFrameS" style="display:none;"></iframe>
    
</body>
</html>