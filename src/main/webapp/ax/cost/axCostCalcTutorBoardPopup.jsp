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
	            key : "KIND_NAME",
	            label : "구분",
	            width : 120,
	            align : "left"
	        },{
	            key : "TITLE",
	            label : "제목",
	            width : 310,
	            align : "left"
	        },{
	        	key : "USER_NAME", 
	        	label : "작성자", 
	            width : 80,
	        	align : "left"
	        },{
	        	key : "TUTOR_NAME", 
	        	label : "튜터", 
	            width : 80,
	        	align : "left"
	        },{
	        	key : "ACCEPT_YN", 
	        	label : "적용 여부", 
	            width : 100,
	        	align : "center", 
	        	editor : { type : "checkbox", config : {height: 17, trueValue: "Y", falseValue: "N"} } ,
				styleClass: function () {
	                return "grid-cell-edit";
	            } 
	        },{
	            key : "NO_REASON",
	            label : "미적용 사유",
	            width : 200,
	            align : "left",
	            editor : { 
	            	type : "text"
				},
				styleClass: function () {
                    return "grid-cell-edit"; 
                }
	        }	], 
	  	null,
	  	{
	  		showRowSelector : false
	  	}
	);
}

function fn_params() {
	params.COURSE_ID = gfn_getUrlParams("COURSE_ID");
	params.SEQ = gfn_getUrlParams("SEQ");
	params.TUTOR_ID = $("#CB_TUTOR option:selected").val();	
}

function fn_search() {
	//mask.open();
	
	fn_params();
	
	gfn_callAjax("/cost/axCostCalcTutorBoardList.do", params, fn_callbackAjax, "search");
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
             		
             		gfn_callAjax("/cost/axCostCalcTutorBoardSave.do", $.extend(saveParams, gfn_getSaveData(grid)), fn_callbackAjax, "save");
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
		
		fn_makeGrid();
		fn_search();
	}
}

function fn_gridEvent(event, obj) {
	if ( event == "Click" ) {
		obj.self.select(obj.dindex);
	} else if ( event == "DBLClick" ) {
		if ( obj.item["KIND"] == "DATA" ) {		
	   		var urlParams = "page=/ax/board/axBoardDataPopup";
	   		urlParams += "&MODE=VIEW&SEQ=" + obj.item["SEQ"] + "&COURSE_ID=" + gfn_getUrlParams("COURSE_ID") + "&KIND=B_DATA";
	   		
	   		f_popup('/common/axOpenPage', {displayName:'boardPopup',option:'width=900,height=700', urlParams:urlParams});
		} else if ( obj.item["KIND"] == "QNA_REPLY" ) {		
	   		var urlParams = "page=/ax/board/axBoardQnaAnswerPopup";
	   		urlParams += "&MODE=VIEW&SEQ=" + obj.item["SEQ"] + "&COURSE_ID=" + gfn_getUrlParams("COURSE_ID");
	   		
	   		f_popup('/common/axOpenPage', {displayName:'boardPopup',option:'width=900,height=700', urlParams:urlParams});
		} else {		
	   		var urlParams = "page=/ax/board/axBoardFreePopup";
	   		urlParams += "&MODE=VIEW&SEQ=" + obj.item["P_SEQ"] + "&COURSE_ID=" + gfn_getUrlParams("COURSE_ID");
	   		
	   		f_popup('/common/axOpenPage', {displayName:'boardPopup',option:'width=900,height=700', urlParams:urlParams});
		}
		
	} else if ( event == "DataChanged" ) {
	}
}

</script>

<body style="padding : 10px">

<form id="frm" name="frm" method="post">

<h2>튜터 작업 확인</h2>
<div style="height:10px"></div>

<div class="form-inline">
  	<div class="form-group">
    	<label for="CB_TUTOR">튜터</label>
		<select class="form-control" id="CB_TUTOR">
			<option value="">전체</option>
		</select>
  	</div>
</div>
<div style="height:10px"></div>

<div>
    <button class="btn btn-default" data-grid-control="search">검색</button>
    <button class="btn btn-default" data-grid-control="save">저장</button>
    <button class="btn btn-default" data-grid-control="close">닫기</button>
</div>

<div style="height:10px"></div>

<div style="position: relative;height:635px;" id="grid-parent"> 
    <div data-ax5grid="first-grid" style="height: 100%;"></div>
</div>


</form>

<div class="mask"></div>

</body>
</html>

