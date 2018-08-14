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

$(document.body).ready(function () {
    confirmDialog.setConfig({
        theme: "danger"
    });
    
	$("#contents").cleditor({height:305});

	if ( gfn_getUrlParams("IS_VIEW") == "Y" ) {
		$("#contents").cleditor()[0].disable(true).refresh();
	}

    $('[data-grid-control]').click(function () {
        switch (this.getAttribute("data-grid-control")) {
            case "save" :
            	fn_save();
                break;
            case "close" :
            	if ( isSave ) {
            		opener.fn_search();
            	}
            	
            	window.close();
                break;
        }
    });

	$("#attachFrame").attr("src","/board/attachU.do?" + "pSeq=" + gfn_getUrlParams("SEQ") + "&kind=C_REPORT");

    fn_search();
});

function fn_params() {
	params.SEQ = gfn_getUrlParams("SEQ");	
}

function fn_search() {
	//mask.open();
	
	fn_params();
	
	gfn_callAjax("/course/axCourseReportContentsList.do", params, fn_callbackAjax, "search");
}

function fn_save() {
	if ( checkByte($('contents').val()) > course_contents_length ) {
		mask.open();
		dialog.alert( { msg : "입력 가능한 자릿수를 넘었습니다." }, function () { mask.close();	} );
		return false;
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
         				CONTENTS : $('#contents').val(),
         				SEQ : params.SEQ
         		};
         		gfn_callAjax("/course/axCourseReportContentsSave.do", saveParams, fn_callbackAjax, "save");
           	} else {
           		mask.close();
           	}
       	}
   	);
}

function fn_callbackAjax(data, id) {
	//console.log("fn_callbackAjax : " + id);
	if ( id == "search" ) {
		$('#contents').text(data.list[0].CONTENTS);
		
		$("#contents").cleditor()[0].refresh();
		
		//mask.close();
	} else if ( id == "save" ){
		mask.close();

		if ( data.RtnMode && data.RtnMode != "OK" ) {
			mask.open();
			dialog.alert( { msg : "저장시 문제가 발생했습니다. (" + data.RtnMode + ")" }, function () { mask.close(); } );
		} else {
			mask.open();
			dialog.alert( { msg : "저장 되었습니다." }, function () { mask.close();	fn_search(); } );
		}
		
		isSave = true;
	}
}

</script>

<body style="padding : 10px">

<form id="frm" name="frm" method="post">

<h2>레포트 내용 관리</h2>
<div style="height:10px"></div>

<div>
    <button class="btn btn-default" data-grid-control="save">저장</button>
    <button class="btn btn-default" data-grid-control="close">닫기</button>
</div>

<div style="height:10px"></div>

<textarea id="contents" name="contents" style="width:400px;height:300px;"></textarea>
<div style="height:10px"></div>
<iframe id="attachFrame" name="attachFrame" style="width:675px;height:100px"></iframe>

</form>
	

</body>
</html>

