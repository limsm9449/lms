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
</head>

<script type="text/javascript">

var preUrl = "/board/"; 

$(document).ready(function() {
});

function lfn_btn(pKind, pParam) {
	if ( pKind =="delete" ) {
		$("#seq").val(pParam.seq);
		document.frm.action = context + preUrl + "attachDel.do";
		document.frm.target = "tranFrameS";
		document.frm.method = "POST";	
		document.frm.submit();
	} else if ( pKind =="attachIns" ) {
		document.frm.action = context + preUrl + "attachIns.do";
		document.frm.target = "tranFrameS";
		document.frm.method = "POST";	
		document.frm.submit();
	} else if ( pKind =="refresh" ) {
		gfn_goPage(preUrl + "attachI",$("#frm").serialize());
	} 
}

</script>

<body style='background:#fff'>
<form id="frm" name="frm" action="" method="post" enctype="multipart/form-data">
	<input id="seq" name="seq" value="0" type="hidden"/>
	<input id="pSeq" name="pSeq" value="${set.condiVO.pSeq}" type="hidden"/>
	<input id="kind" name="kind" value="${set.condiVO.kind}" type="hidden"/>
	<input id="mode" name="mode" value="TEMP" type="hidden"/>

    <div class='ifame_wrap'>
        <input type='file' name='newFile' id='newFile' onChange="javascript:lfn_btn('attachIns'); return false;">
        <div class='item_head clear_fix'>
            <p class='name'>파일이름</p>
            <p>파일크기</p>
        </div>
        <div class='item_list'>
<c:forEach var="row" items="${set.list}" varStatus="idx">
            <div class='clear_fix'>
                <p class='name'>${row.orgFileName} &nbsp;&nbsp;&nbsp;<a href="javascript:" class="grayBtn" onclick="javascript:lfn_btn('delete',{seq:'${row.seq}'}); return false;">삭제</a></p>
                <p><fmt:formatNumber value="${row.fileSize/1000}" pattern="#,##0"/> KB</p>
            </div>
</c:forEach>            
        </div>
        <div class='item_amount'>
            <p>파일개수 : <span>${fn:length(set.list)}</span>개</p>
        </div>
    </div>
</form>

<iframe id="tranFrameS" name="tranFrameS" style="display:none;"></iframe>
    
</body>
</html>