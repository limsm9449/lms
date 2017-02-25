<%@ page contentType="text/html;charset=utf-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<head>
<title>
</title>


<%@ include file="../common/commInclude.jsp" %>


</head>

<script type="text/javascript">

var preUrl = "/compUser/"; 

function lfn_btn(pKind, pParam) {
	if ( pKind == "excelUpload" ) {
		document.frm.action = context + preUrl + "excelUpload.do";
		document.frm.target = "tranFrameS";
		document.frm.method = "POST";	
		document.frm.submit();
	}
}

function lfn_tran(pKind) {
	if ( pKind == "UPLOAD_OK") {
		opener.lfn_btn("search");
		self.close();
	}
}


</script>

<body>

* 일괄등록	
<form id="frm" name="frm" action="" method="post" enctype="multipart/form-data">
	<input type="file" name="newFile" size="30" onChange="javascript:lfn_btn('excelUpload'); return false;">
</form>

<iframe id="tranFrameS" name="tranFrameS" style="display:none;"></iframe>

</body>
</html>


