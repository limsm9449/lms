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

var MODE = gfn_getUrlParams("MODE");
var SEQ = gfn_getUrlParams("SEQ");
var COURSE_ID = gfn_getUrlParams("COURSE_ID");

$(document.body).ready(function () {
   	$("#TITLE").attr("readonly", true);

   	$("#CONTENTS").cleditor({height:240});
    $("#CONTENTS").cleditor()[0].refresh();
    $("#CONTENTS").cleditor()[0].disable(true).refresh();
	
    if ( MODE == "VIEW" ) {
    	$("#ANSWER").cleditor({height:240});
    	$("#ANSWER").cleditor()[0].disable(true).refresh();
    	
    	$("#btn_save").hide();
    }  else {
    	$("#ANSWER").cleditor({height:240});
    	$("#ANSWER").cleditor()[0].refresh();
    }

   	fn_search();
}); 

function fn_params() {
	params.SEQ = SEQ;
	params.COURSE_ID = COURSE_ID;	 
}

function fn_search() {
	fn_params();
	
	gfn_callAjax("/board/axBoardQnaOne.do", params, fn_callbackAjax, "search");
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
		$('#ANSWER').val(data.row.ANSWER);

		$("#CONTENTS").cleditor()[0].refresh();
		$("#ANSWER").cleditor()[0].refresh();
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
	}
}

function fn_save() {
	if ( $("#TITLE").val() == "" ) {
		mask.open();
		dialog.alert( { msg : "제목을 입력하셔야 합니다." }, function () { mask.close(); } );
		return;
	}
	if ( $("#CONTENTS").val() == "" ) {
		mask.open();
		dialog.alert( { msg : "내용을 입력하셔야 합니다." }, function () { mask.close(); } );
		return;
	}
	if ( $("#ANSWER").val() == "" ) {
		mask.open();
		dialog.alert( { msg : "답변을 입력하셔야 합니다." }, function () { mask.close(); } );
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
         				ANSWER : $('#ANSWER').val(),
         				SEQ : SEQ,
         				COURSE_ID : COURSE_ID
         		};
         		gfn_callAjax("/board/axBoardQnaAnswerSave.do", saveParams, fn_callbackAjax, "save");
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

</script>

<body style="padding : 10px">

<h2>Q&A 답변</h2>

<form class="form-horizontal">
  	<div class="form-group">
    	<label for="TITLE" class="col-sm-2 control-label">제목</label>
    	<div class="col-sm-10">
      		<input type="text" class="form-control" id="TITLE" placeholder="제목">
    	</div>
  	</div>
  	<div class="form-group">
    	<label for="CONTENTS" class="col-sm-2 control-label">내용</label>
    	<div class="col-sm-10">
      		<textarea id="CONTENTS" name="CONTENTS"></textarea>
    	</div>
  	</div>
  	<div class="form-group">
    	<label for="CONTENTS" class="col-sm-2 control-label">답변</label>
    	<div class="col-sm-10">
      		<textarea id="ANSWER" name="ANSWER"></textarea>
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

