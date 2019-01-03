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

var kind = gfn_getUrlParams("kind");

$(document.body).ready(function () {
	gfn_callAjax("/common/axDd.do", { DD_KIND : "CategoryLevel1" }, fn_callbackAjax, "dd", { async : false });
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

		gfn_cbRefresh("CB_LEVEL1", data.CategoryLevel1, true);
	} else if ( id == "CB_LEVEL1" ){
		gfn_cbRefresh("CB_LEVEL2", data.CategoryLevel2, true);
	}
}

function fn_cbChange(id) {
	if ( id == "CB_LEVEL1" ) {
	    gfn_callAjax("/common/axDd.do", { DD_KIND : "CategoryLevel2", LEVEL1_CODE : $("#CB_LEVEL1 option:selected").val()}, fn_callbackAjax, "CB_LEVEL1", { async : false });
	}
}

function fn_ok() {
	if ( $("#CB_LEVEL1 option:selected").val() == "" || $("#CB_LEVEL2 option:selected").val() == "" ) {
		mask.open();
		dialog.alert( { msg : "대/중분류를 선택하셔야 합니다." }, function () { mask.close(); } );
		return;
	}
	
	opener.fn_categorySelect(
		{
			CB_LEVEL1_CODE : $("#CB_LEVEL1 option:selected").val()
			,CB_LEVEL1_NAME : $("#CB_LEVEL1 option:selected").text()
			,CB_LEVEL2_CODE : $("#CB_LEVEL2 option:selected").val()
			,CB_LEVEL2_NAME : $("#CB_LEVEL2 option:selected").text()
		}
	);
	
	window.close();
}

function fn_close() {
	window.close();
}


</script>

<body style="padding : 10px">

<h2>카테고리 중분류</h2>

<div style="height:10px"></div>

<div class="form-inline">
  	<div class="form-group">
    	<label for="CB_LEVEL1">대분류</label>
		<select class="form-control" id="CB_LEVEL1" name="CB_LEVEL1"  onchange="fn_cbChange('CB_LEVEL1')">
		</select>
  	</div>
</div>
<div class="form-inline">
  	<div class="form-group">
    	<label for="CB_LEVEL2">중분류</label>
		<select class="form-control" id="CB_LEVEL2" name="CB_LEVEL2">
		</select>
  	</div>
</div>

<div class="form-group">
 	<div class="col-sm-offset-3 col-sm-9">
		<button class="btn btn-default" onclick="fn_ok()">확인</button>
		<button class="btn btn-default" onclick="fn_close()">닫기</button>
 	</div>
</div>

</form>
	

</body>
</html>

