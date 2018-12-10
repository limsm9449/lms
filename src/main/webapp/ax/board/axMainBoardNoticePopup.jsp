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
var isSave = false;
var dd = {}

var MODE = gfn_getUrlParams("MODE");
var SEQ = gfn_getUrlParams("SEQ");

$(document.body).ready(function () {
    $("#CONTENTS").cleditor({height:290});
    $("#CONTENTS").cleditor()[0].refresh();

    gfn_callAjax("/common/axDd.do", { DD_KIND : "CompanyKind,Company,Company1,Company2" }, fn_callbackAjax, "dd", { async : false });
}); 

function fn_ddAfter() {
    if ( MODE == "INSERT" ) {
   	} else {
    	fn_search();
    	
    	$("#CB_COMPANY").attr("disabled", true);
    	$("#CB_COMPANY2").attr("disabled", true);
   	}
}

function fn_params() {
	params.SEQ = SEQ;
}

function fn_search() {
	fn_params();
	
	gfn_callAjax("/board/axMainBoardNoticeOne.do", params, fn_callbackAjax, "search");
}

function fn_callbackAjax(data, id) {
	if ( data.RtnMode == "ERROR" ) {
		mask.open();
		dialog.alert( { msg : "처리시 오류가 발생했습니다. 관리자에게 문의하세요." }, function () { mask.close();	fn_search(); } );
		return;
	}
	
	if ( id == "search" ) {
		$('#CB_COMPANY').val(data.row.COMP_KIND);
		fn_cbChange("CB_COMPANY");
				
		$('#CB_COMPANY2').val(data.row.COMP_CD);
		$('#TITLE').val(data.row.TITLE); 
		
		$('#CONTENTS').val(data.row.CONTENTS);
		$("#CONTENTS").cleditor()[0].refresh();
	} else if ( id == "save" ){
		mask.close();

		if ( data.RtnMode && data.RtnMode != "OK" ) {
			mask.open();
			dialog.alert( { msg : "저장시 문제가 발생했습니다. (" + data.RtnMode + ")" }, function () { mask.close(); } );
		} else {
			mask.open();
			dialog.alert( { msg : "저장 되었습니다." }, function () { mask.close(); fn_close(); } );
		}
		
		isSave = true;
	} else if ( id == "dd" ){
dd = $.extend({}, data);
		
		gfn_cbRefresh("CB_COMPANY", data.CompanyKind, true);
		
		fn_ddAfter();
	}
}

function fn_save() {
	if ( $("#CB_COMPANY").val() == "" ) {
		alert("회사구분을 선택하셔야 합니다.");
		return;
	}
	if ( $("#CB_COMPANY").val() != "B2C" && $("#CB_COMPANY2").val() == "" ) {
		alert("회사를 선택하셔야 합니다.");
		return;
	}
	if ( $("#TITLE").val() == "" ) {
		alert("제목을 입력하셔야 합니다.");
		return;
	}
	if ( $("#CONTENTS").val() == "" ) {
		alert("내용을 입력하셔야 합니다.");
		return;
	}

	mask.open();
   	confirmDialog.confirm(
   		{
           	title: "Confirm",
           	msg: '저장하시겠습니까?'
       	}, 
       	function(){
         	if ( this.key == "ok" ) {
         		var saveParams = {
         				TITLE : $('#TITLE').val(),
         				CONTENTS : $('#CONTENTS').val(),
         				MODE : MODE,
         				SEQ : SEQ,
         				COMP_CD : (  $("#CB_COMPANY").val() == "B2C" ? "B2C" : $('#CB_COMPANY2').val() )
         		};
         		gfn_callAjax("/board/axMainBoardNoticeSave.do", saveParams, fn_callbackAjax, "save");
           	} else {
           		mask.close();
           	}
       	}
   	);
}

function fn_close() {
	if ( isSave ) {
		opener.fn_search();
	}
	
	window.close();
}

function fn_cbChange(id) {
	if ( id == "CB_COMPANY" ) {
		if ( $("#CB_COMPANY").val() == "B2B" ) {
			gfn_cbRefresh("CB_COMPANY2", dd.Company1, true);
		} else if ( $("#CB_COMPANY").val() == "C2C" ) {
			gfn_cbRefresh("CB_COMPANY2", dd.Company2, true);
		} else {
			gfn_cbRefresh("CB_COMPANY2", null, true);
		}
	}
}

</script>

<body style="padding : 10px">

<h2>공지사항 게시물</h2>

<form class="form-horizontal">
	<div class="form-group">
    	<label for="CB_COMPANY" class="col-sm-2 control-label">회사구분</label>
    	<div class="col-sm-10">
    		<select id="CB_COMPANY" class="form-control" onchange="fn_cbChange('CB_COMPANY')">
				<option value="">전체</option>
			</select>
    	</div>
  	</div>
  	<div class="form-group">
    	<label for="CB_COMPANY2" class="col-sm-2 control-label">회사</label>
    	<div class="col-sm-10">
      		<select class="form-control" id="CB_COMPANY2">
				<option value="">전체</option>
			</select>
    	</div>
  	</div>
  	<div class="form-group">
    	<label for="TITLE" class="col-sm-2 control-label">제목</label>
    	<div class="col-sm-10">
      		<input type="text" class="form-control" id="TITLE" placeholder="제목">
    	</div>
  	</div>
  	<div class="form-group">
    	<label for="inputPassword3" class="col-sm-2 control-label">내용</label>
    	<div class="col-sm-10">
      		<textarea id="CONTENTS" name="CONTENTS"></textarea>
    	</div>
  	</div>
  	<div class="form-group">
    	<div class="col-sm-offset-9 col-sm-3">
			<button class="btn btn-default" onclick="fn_save()" id="btn_save">저장</button>
			<button class="btn btn-default" onclick="fn_close()">닫기</button>
    	</div>
  	</div>

</form>
	


<div class="mask"></div>
	

</body>
</html>

