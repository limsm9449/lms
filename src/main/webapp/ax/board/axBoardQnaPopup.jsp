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
	if ( MODE == "INSERT" || MODE == "UPDATE" ) {
	    $("#CONTENTS").cleditor({height:490});
	} else {
		$("#CONTENTS").cleditor({height:150});
	}
    $("#CONTENTS").cleditor()[0].refresh();

    grid = gfn_makeAx5Grid("first-grid",
   		[ 	{
   	            key : "CONTENTS",
   	            label : "내용",
   	            width : 420,
   	            align : "left"
   	        },{
   	            key : "USER_NAME",
   	            label : "작성자",
   	            width : 120,
   	            align : "center"
   	        },{
   	            key : "CREATE_DATE",
   	            label : "등록일자",
   	            width : 120,
   	            align : "center"
   	        }	], 
   	  	null,
   	  	{
   	  		showRowSelector : false
   	  	}
   	);
    $( window ).resize( function() {
    	if ( MODE == "" ) {
			gfn_gridResize("grid-parent", grid, 470);
    	}
	} ).resize();
    
    if ( MODE == "INSERT" ) {
    	$("#gridDiv").hide();
    	$("#replyDiv").hide();
    } else if ( MODE == "UPDATE" ) {
    	$("#gridDiv").hide();
    	$("#replyDiv").hide();

    	fn_search();
   	} else {
    	fn_search();
    	
    	$("#TITLE").attr("readonly", true);
    	$("#btn_save").hide();
   		
   		//조회수 증가
   		var saveParams = {
 				MODE : "VIEW",
 				SEQ : SEQ
 		};
 		gfn_callAjax("/board/axBoardQnaSave.do", saveParams, fn_callbackAjax, "-");
   	}
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
		
		if ( MODE == "UPDATE" ) {
			$("#CONTENTS").cleditor()[0].refresh();
		} else {
			$("#CONTENTS").cleditor()[0].disable(true).refresh();
		}
		
		grid.setData(data.replyList);
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
	} else if ( id == "replySave" ){
		mask.close();

		if ( data.RtnMode && data.RtnMode != "OK" ) {
			mask.open();
			dialog.alert( { msg : "저장시 문제가 발생했습니다. (" + data.RtnMode + ")" }, function () { mask.close(); } );
		} else {
			mask.open();
			dialog.alert( { msg : "저장 되었습니다." }, function () { mask.close(); $("#QNA_CONTENTS").val(""); } );
		}
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
         				COURSE_ID : COURSE_ID
         		};
         		gfn_callAjax("/board/axBoardQnaSave.do", saveParams, fn_callbackAjax, "save");
           	} else {
           		mask.close();
           	}
       	}
   	);
}

function fn_replySave(kind) {
	if ( kind == "DELETE" || kind == "UPDATE" ) {
		var row = grid.getList("selected");
    	if ( row.length == 0 ) {
    		mask.open();
    		dialog.alert( { msg : "댓글을 선택하셔야 합니다." }, function () { mask.close();	} );
			return;
    	}
	} else {
		if ( $("#QNA_CONTENTS").val() == "" ) {
			mask.open();
			dialog.alert( { msg : "내용을 입력하셔야 합니다." }, function () { mask.close(); } );
			return;
		}
	}

	var confirmMsg = "";
	if ( kind == "INSERT" ) {
		confirmMsg = "답글을 추가하시겠습니까?";
	} else if ( kind == "DELETE" ) {
		confirmMsg = "답글을 삭제하시겠습니까?";
	} else {
		confirmMsg = "답글을 수정하시겠습니까?";
	}
	mask.open();
   	confirmDialog.confirm(
   		{
           	title: "Confirm",
           	msg: confirmMsg
       	}, 
       	function(){
         	if ( this.key == "ok" ) {
         		if ( kind == "INSERT" ) {
         			grid.addRow( 
           				{
           					KIND : "QNA", 
           					P_SEQ : SEQ, 
           					CONTENTS : $("#QNA_CONTENTS").val(),
           					NEW_FLAG : "Y"
           				}, "first", {focus: "END"});
         		} else if ( kind == "DELETE" ) {
               		grid.deleteRow("selected");
         		} else {
        			var row = grid.getList("selected");
        			grid.setValue(row[0].__index, "CONTENTS", $("#QNA_CONTENTS").val());
         		}
         		
         		gfn_callAjax("/board/axBoardQnaReplySave.do", gfn_getSaveData(grid), fn_callbackAjax, "replySave");
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

function fn_gridEvent(event, obj) {
	if ( event == "Click" ) {
		obj.self.select(obj.dindex);
		$("#QNA_CONTENTS").val(obj.item.CONTENTS);
	} else if ( event == "DBLClick" ) {
	} else if ( event == "DataChanged" ) {
	}
}

</script>

<body style="padding : 10px">

<h2>Q&A 게시물</h2>

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
  	<div class="form-group" id="gridDiv">
    	<label for="inputPassword3" class="col-sm-2 control-label">답글</label>
    	<div class="col-sm-10">
      		<div data-ax5grid="first-grid" style="height:200px;"></div>
    	</div>
  	</div>
  	<div class="form-group" id="replyDiv">
    	<div class="col-sm-2">
    	</div>
    	<div class="col-sm-7">
    		<textarea id="QNA_CONTENTS" style="width:490px;height:100px;"></textarea>
    	</div>
    	<div class="col-sm-3">
			<button class="btn btn-default" onclick="fn_replySave('INSERT')" id="btn_replyInsert">추가</button>
			<button class="btn btn-default" onclick="fn_replySave('DELETE')" id="btn_replyDelete">삭제</button>
			<button class="btn btn-default" onclick="fn_replySave('UPDATE')" id="btn_replyUpdate">저장</button>
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

