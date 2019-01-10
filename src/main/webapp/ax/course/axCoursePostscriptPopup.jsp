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
var dd = {};

$(document.body).ready(function () {
    confirmDialog.setConfig({
        theme: "danger"
    });
    
    fn_makeGrid();
    
    $('[data-grid-control]').click(function () {
        switch (this.getAttribute("data-grid-control")) {
	        case "search":
	            fn_search();
	            break;
	            
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
    
    fn_search();
});

function fn_makeGrid() {
    grid = gfn_makeAx5Grid("first-grid",
   		[ 	{
   	        	key : "USER_ID", 
   	        	label : "사용자 ID", 
   	            width : 80,
   	        	align : "left"
   	        },{
   	        	key : "USER_NAME", 
   	        	label : "사용자명", 
   	            width : 80,
   	        	align : "left"
   	        },{
   	        	key : "CONTENTS", 
   	        	label : "수강후기", 
   	            width : 400,
   	        	align : "left" 
   	        },{
   	        	key : "EVAL", 
   	        	label : "점수", 
   	            width : 60,
   	        	align : "right" 
   	     	},{
	        	key : "BEST_YN", 
	        	label : "Best 여부", 
	            width : 90,
	        	align : "center", 
	        	editor : { type : "checkbox", config : {height: 17, trueValue: "Y", falseValue: "N"} } ,
				styleClass: function () {
                 	return "grid-cell-edit";
             	}    	        	
   	        },{
   	        	key : "LAST_UPDATE_DATE", 
   	        	label : "등록일자", 
   	            width : 100,
   	        	align : "center" 
   	        }	], 
   	  	null,
   	  	{
   	  		showRowSelector : false
   	  	}
   	);
   	
}

function fn_params() {
	params.COURSE_ID = gfn_getUrlParams("COURSE_ID");	
}

function fn_search() {
	//mask.open();
	
	fn_params();
	
	gfn_callAjax("/course/axCoursePostscriptList.do", params, fn_callbackAjax, "search");
}

function fn_save() {
	var fieldParams = {
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
             		gfn_callAjax("/course/axCoursePostscriptSave.do", gfn_getSaveData(grid), fn_callbackAjax, "save");
               	} else {
               		mask.close();
               	}
           	}
       	);
   	}
}

function fn_callbackAjax(data, id) {
	//console.log("fn_callbackAjax : " + id);
	if ( id == "search" ) {
		grid.setData(data.list);
		
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

function fn_gridEvent(event, obj) {
	if ( event == "Click" ) {
		obj.self.select(obj.dindex);
		$("#CONTENTS").val(obj.item.CONTENTS);
	} else if ( event == "DataChanged" ) {
	}
}

</script>

<body style="padding : 10px">

<form id="frm" name="frm" method="post">

<h2>Best 수강후기</h2>
<div style="height:10px"></div>

<div>
    <button class="btn btn-default" data-grid-control="save">저장</button>
    <button class="btn btn-default" data-grid-control="close">닫기</button>
</div>

<div style="height:10px"></div>

<div style="position: relative;height:450px;" id="grid-parent"> 
    <div data-ax5grid="first-grid" style="height: 100%;"></div>
</div>

<div style="height:10px"></div>
<div>
	<textarea id="CONTENTS" name="CONTENTS" style="width:100%; height:100px;"></textarea>
</div>

</form>
	

</body>
</html>

