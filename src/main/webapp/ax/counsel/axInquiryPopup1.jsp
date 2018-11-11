<%@ page contentType="text/html;charset=utf-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="ko" xml:lang="ko">
<head>
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1"/>
<title>
</title>

<%@ include file="../../common/commAxAdminInclude.jsp" %>

</head>

<script type="text/javascript">
var mask = new ax5.ui.mask();
var confirmDialog = new ax5.ui.dialog();
var dialog = new ax5.ui.dialog( { title: '<i class="axi axi-ion-alert"></i> Alert' } );
var grid = null;
var params = {}

var SEQ = gfn_getUrlParams("SEQ");

$(document.body).ready(function () {
	$("#attachFrame").attr("src","/board/attachV.do?" + "pSeq=" + SEQ + "&kind=COMP_LEARN");
	
   	fn_search();
}); 

function fn_params() {
	params.SEQ = SEQ;
}

function fn_search() {
	fn_params();
	
	gfn_callAjax("/counsel/axInquiryOne.do", params, fn_callbackAjax, "search");
}

function fn_callbackAjax(data, id) {
	if ( data.RtnMode == "ERROR" ) {
		mask.open();
		dialog.alert( { msg : "처리시 오류가 발생했습니다. 관리자에게 문의하세요." }, function () { mask.close();	fn_search(); } );
		return;
	}
	
	if ( id == "search" ) {
		$('#TITLE').val(data.row.TITLE);
		
		$('#CONTENTS').val(data.row.CONTENTS);
	}
}

function fn_close() {
	window.close();
}

</script>

<body style="padding : 10px">

<h2>문의 내용</h2>

<form class="form-horizontal">
  	<div class="form-group">
    	<label for="TITLE" class="col-sm-2 control-label">제목</label>
    	<div class="col-sm-10">
      		<input type="text" class="form-control" id="TITLE" placeholder="제목">
    	</div>
  	</div>
  	<div class="form-group">
    	<label for="inputPassword3" class="col-sm-2 control-label">내용</label>
    	<div class="col-sm-10">
      		<textarea id="CONTENTS" name="CONTENTS" style="width:100%;height:480px"></textarea>
    	</div>
  	</div>
  	<div class="form-group">
    	<label for="inputPassword3" class="col-sm-2 control-label">첨부파일</label>
    	<div class="col-sm-10">
      		<iframe id="attachFrame" name="attachFrame" style="width:100%;height:100px"></iframe>
    	</div>
  	</div>
  	<div class="form-group">
    	<div class="col-sm-offset-9 col-sm-3">
			<button class="btn btn-default" onclick="fn_close()">닫기</button>
    	</div>
  	</div>

</form>
	


<div class="mask"></div>
	

</body>
</html>

