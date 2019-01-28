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
var params = {}
var dd = {};

$(document.body).ready(function () {
	gfn_callAjax("/common/axDd.do", { DD_KIND : "ExamType", COURSE_CODE : gfn_getUrlParams("COURSE_CODE") }, fn_callbackAjax, "dd", { async : false });
}); 

var rows = null;
function fn_callbackAjax(data, id) {
	if ( data.RtnMode == "ERROR" ) {
		mask.open();
		dialog.alert( { msg : "처리시 오류가 발생했습니다. 관리자에게 문의하세요." }, function () { mask.close();	fn_search(); } );
		return;
	}
	
	if ( id == "dd" ){
		dd = $.extend({}, data);

		gfn_cbRefresh("CB_EXAM_TYPE", data.ExamType, true);
	}
}

function fn_delete() {
	opener.fn_examTypeSelect({}, "DELETE");
	
	window.close();
}

function fn_ok() {
	if ( $("#CB_EXAM_TYPE option:selected").val() == "" ) {
		mask.open();
		dialog.alert( { msg : "평가 유형을 선택하셔야 합니다." }, function () { mask.close(); } );
		return;
	} 

	opener.fn_examTypeSelect(
		{
			CB_EXAM_TYPE : $("#CB_EXAM_TYPE option:selected").val()
			,CB_EXAM_TYPE_NAME : $("#CB_EXAM_TYPE option:selected").text()
		}, "OK"
	);
	
	window.close();
}

function fn_close() {
	window.close();
}


</script>

<body style="padding : 10px">

<h2>평가유형</h2>

<div style="height:10px"></div>

<div class="form-inline">
  	<div class="form-group">
    	<label for="CB_EXAM_TYPE">평가유형</label>
		<select class="form-control" id="CB_EXAM_TYPE" name="CB_EXAM_TYPE">
		</select>
  	</div>
</div>

<div style="height:40px"></div>

<div class="form-group">
 	<div class="col-sm-offset-3 col-sm-9">
		<button class="btn btn-default" onclick="fn_delete()">삭제</button>
		<button class="btn btn-default" onclick="fn_ok()">확인</button>
		<button class="btn btn-default" onclick="fn_close()">닫기</button>
 	</div>
</div>

</form>
<div class="mask"></div>	

</body>
</html>

