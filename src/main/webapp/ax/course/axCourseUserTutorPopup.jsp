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
    
    gfn_callAjax("/common/axDd.do", { DD_KIND : "CourseTutor", COURSE_ID : gfn_getUrlParams("COURSE_ID") }, fn_callbackAjax, "dd", { async : false });
	
    $('[data-grid-control]').click(function () {
        switch (this.getAttribute("data-grid-control")) {
	        case "search":
	            fn_search();
	            break;
            case "multiUpdate" :
		    	gfn_showPopupDiv("commDiv");
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
});

function fn_makeGrid() {
	grid = gfn_makeAx5Grid("first-grid",
		[ 	{
	            key : "USER_ID",
	            label : "수강생 ID",
	            width : 80,
	            align : "left"
	        },{
	            key : "USER_NAME",
	            label : "수강생명",
	            width : 80,
	            align : "left"
	        },{
	        	key : "TUTOR_ID", 
	        	label : "담당 튜터", 
	            width : 120,
	        	align : "left", 
	        	editor: {
                    type : "select", 
                    config : {
                        columnKeys: { optionValue: "value", optionText: "text" },
                        options: dd.CourseTutor
                    }
	        	},
	            formatter : function () {
	                return gfn_getValueInList(dd.CourseTutor, "value",  this.item.TUTOR_ID, "text");
	           	},
				styleClass: function () {
                    return "grid-cell-edit";
                }
	        }	], 
	  	null,
	  	{
	  		showRowSelector : true,
	  		multipleSelect: true
	  	}
	);
}

function fn_params() {
	params.COURSE_ID = gfn_getUrlParams("COURSE_ID");
	params.TUTOR_ID = $("#CB_TUTOR option:selected").val();	
}

function fn_search() {
	//mask.open();
	
	fn_params();
	
	gfn_callAjax("/course/axCourseUserTutorList.do", params, fn_callbackAjax, "search");
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
             		var saveParams = {
             		};
             		
             		gfn_callAjax("/course/axCourseUserTutorSave.do", $.extend(saveParams, gfn_getSaveData(grid)), fn_callbackAjax, "save");
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
	} else if ( id == "dd" ){
		dd = $.extend({}, data);
		
		gfn_cbRefresh("CB_TUTOR", data.CourseTutor, true);
		gfn_cbRefresh("DIV_CB_TUTOR", data.CourseTutor, true);
		
		fn_makeGrid();
		fn_search();
	}
}

function fn_gridEvent(event, obj) {
	if ( event == "Click" ) {
		obj.self.select(obj.dindex);
	} else if ( event == "DBLClick" ) {
	} else if ( event == "DataChanged" ) {
	}
}

function fn_hidePopupDiv(popupDivId, mode) {
	if ( popupDivId == "commDiv" ) {
    	var rows = grid.getList("selected");
    	if ( rows.length == 0 ) {
    		mask.open();
    		dialog.alert( { msg : "변경할 수강생을 선택하셔야 합니다." }, function () { mask.close();	} );
    		return;
    	}
    	for ( var i = 0; i < rows.length; i++ ) {
			grid.setValue(rows[i].__index, "TUTOR_ID", $("#DIV_CB_TUTOR option:selected").val());
    	}
	}

	gfn_hidePopupDiv(popupDivId);
}

</script>

<body style="padding : 10px">

<form id="frm" name="frm" method="post">

<h2>사용자별 담당 튜터</h2>
<div style="height:10px"></div>

<div>
	튜터
	<select id="CB_TUTOR">
		<option value="">전체</option>
	</select>
</div>

<div style="height:10px"></div>

<div>
    <button class="btn btn-default" data-grid-control="search">검색</button>
    <button class="btn btn-default" data-grid-control="multiUpdate">일괄변경</button>
    <button class="btn btn-default" data-grid-control="save">저장</button>
    <button class="btn btn-default" data-grid-control="close">닫기</button>
</div>

<div style="height:10px"></div>

<div style="position: relative;height:530px;" id="grid-parent">
    <div data-ax5grid="first-grid" style="height: 100%;"></div>
   
</div>


</form>

<div class="mask"></div>
<div class="popupDiv" id="commDiv" style="width:300px; height:200px;">
	투터
	<select id="DIV_CB_TUTOR">
	</select>
	<div style="height:30px"></div>
	<input type="button" href="#" value="확인" onclick="fn_hidePopupDiv('commDiv')"/>
    <input type="button" href="#" value="닫기" onclick="gfn_hidePopupDiv('commDiv');"/>
</div>	

</body>
</html>

