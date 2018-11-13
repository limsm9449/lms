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

$(document.body).ready(function () {
	$( window ).resize( function() {
		gfn_gridResize("grid-parent", grid); 
	} );
	
    confirmDialog.setConfig({
        theme: "danger"
    });
    
    $("#CONTENTS").cleditor({height:305});
    
	grid = gfn_makeAx5Grid("first-grid",
		[ 	{
	            key : "TITLE",
	            label : "제목",
	            width : 400,
	            align : "left"
	        },{
	            key : "CREATE_DATE",
	            label : "등록일자",
	            width : 120,
	            align : "center"
	        },{
	        	key : "VIEW_CNT", 
	        	label : "조회수", 
	            width : 70,
	        	align : "right"
	        },{ 
	        	key : "MAIN_YN", 
	        	label : "메인이벤트", 
	            width : 100, 
	        	align : "center", 
	        	editor : { type : "checkbox", config : {height: 17, trueValue: "Y", falseValue: "N"} } ,
				styleClass: function () {
                    return "grid-cell-edit";
                } 
	        },{
	            key : "IMG1",
	            label : "PC 이미지",
	            width : 100,
	            align : "center"
	        },{
	            key : "IMG2",
	            label : "모바일 이미지",
	            width : 120,
	            align : "center"
	        },{
	        	key : "COLOR", 
	        	label : "배경색", 
	            width : 80,
	        	align : "center", 
	        	editor : { type : "text" } ,
				styleClass: function () {
                    return "grid-cell-edit";
                } 
	        }
	   	], 
	  	null,
	  	{
	  		showRowSelector : false
	  	}
	);
	
	$(window).trigger("resize");
	
    $('[data-grid-control]').click(function () {
        switch (this.getAttribute("data-grid-control")) {
	        case "search":
	            fn_search();
	            break;
		    case "add":
           		var urlParams = "page=/ax/board/axBoardEventPopup";
           		urlParams += "&MODE=INSERT&SEQ=";
           		
           		f_popup('/common/axOpenPage', {displayName:'boardEventPopup',option:'width=900,height=500', urlParams:urlParams});

		    	break;
		    case "delete":
		    	var row = grid.getList("selected");
            	if ( row.length == 0 ) {
            		mask.open();
            		dialog.alert( { msg : "삭제할 글을 선택하셔야 합니다." }, function () { mask.close();	} );
            		return;
            	}

               	grid.deleteRow("selected");
               	
		    	break;
            case "save" :
            	fn_save();
                break;
            case "export":
                grid.exportExcel("이벤트 게시판.xls");
                break;
            case "editImage":
            	var row = grid.getList("selected");
            	if ( row.length == 0 ) {
            		mask.open();
            		dialog.alert( { msg : "과정을 선택하셔야 합니다." }, function () { mask.close();	} );
            	} else {
            		var urlParams = "page=/ax/board/axBoardEventImagePopup";
            		urlParams += "&SEQ=" + row[0]["SEQ"];
            		
            		f_popup('/common/axOpenPage', {displayName:'axBoardEventImagePopup',option:'width=900,height=650', urlParams:urlParams});
            	}
            		
                break;
        }
    });
    
    //fn_search();
});

function fn_save() {
	var fieldParams = {
		COLOR : { colName : "배경색", length : 6 }
   	};
   	if ( gfn_validationCheck(grid, fieldParams) ) {
       	mask.open();
       	confirmDialog.confirm(
       		{
               	title: "Confirm",
               	msg: '저장하시겠습니까?'
           	}, 
           	function(){
             	if ( this.key == "ok" ) {
             		gfn_callAjax("/board/axBoardEventSave.do", gfn_getSaveData(grid), fn_callbackAjax, "save");
               	} else {
               		mask.close();
               	}
           	}
       	);
   	}
}

function fn_params() {
	params.SEARCH_STR = $("#SEARCH_STR").val();
}

function fn_search() {
	fn_params();
	
	gfn_callAjax("/board/axBoardEventList.do", params, fn_callbackAjax, "search");
}

function fn_callbackAjax(data, id) {
	if ( data.RtnMode == "ERROR" ) {
		mask.open();
		dialog.alert( { msg : "처리시 오류가 발생했습니다. 관리자에게 문의하세요." }, function () { mask.close();	fn_search(); } );
		return;
	}
	
	if ( id == "search" ) {
		grid.setData(data.list);
	} else if ( id == "delete" ) {
		mask.close();

		mask.open();
		dialog.alert( { msg : "삭제 되었습니다." }, function () { mask.close();	fn_search(); } );
	} else if ( id == "save" ){
		mask.close();

		mask.open();
		dialog.alert( { msg : "저장 되었습니다." }, function () { mask.close();	fn_search(); } );
	}
}

function fn_gridEvent(event, obj) {
	if ( event == "Click" ) {
		obj.self.select(obj.dindex);
	} else if ( event == "DBLClick" ) {
		var mode = "UPDATE";
		
   		var urlParams = "page=/ax/board/axBoardEventPopup";
   		urlParams += "&MODE=" + mode + "&SEQ=" + obj.item["SEQ"];
   		
   		f_popup('/common/axOpenPage', {displayName:'boardEventPopup',option:'width=900,height=500', urlParams:urlParams});
	} else if ( event == "DataChanged" ) {
	}
}

</script>

<body style="padding : 10px">

<form id="frm" name="frm" method="post">

<h2>이벤트</h2>
<div style="height:10px"></div>

<div class="form-inline">
  	<div class="form-group">
    	<label for="CB_SEARCHKIND">통합검색</label>
		<input class="form-control" type="text" class="search_input" id="SEARCH_STR" name="SEARCH_STR" value="" />
  	</div>
</div>
<div style="height:10px"></div>

<div>
    <button class="btn btn-default" data-grid-control="search">검색</button>
    <button class="btn btn-default" data-grid-control="add">추가</button>
    <button class="btn btn-default" data-grid-control="delete">삭제</button>
    <button class="btn btn-default" data-grid-control="save">저장</button>
    <button class="btn btn-default" data-grid-control="export">엑셀</button>
    <button class="btn btn-default" data-grid-control="editImage">이미지 편집</button>
</div>

<div style="height:10px"></div>


<div style="position: relative;height:400px;" id="grid-parent">
    <div data-ax5grid="first-grid" style="height: 100%;"></div>
</div>

</form>


<div class="mask"></div>

</body>
</html>

