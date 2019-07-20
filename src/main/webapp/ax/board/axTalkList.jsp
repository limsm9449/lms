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

var params = {};
var dd = {};

$(document.body).ready(function () {
	$( window ).resize( function() {
		gfn_gridResize("grid-parent", grid); 
	} );

	$("#FROM_DT").val(gfn_currentDay(null, "-"));	 	
	$("#TO_DT").val(gfn_currentDay(null, "-"));		
	gfn_initDatepicker("FROM_DT");
	gfn_initDatepicker("TO_DT");

    gfn_callAjax("/common/axDd.do", { DD_KIND : "Company2" }, fn_callbackAjax, "dd", { async : false });
    
    confirmDialog.setConfig({
        theme: "danger"
    });
    
	grid = gfn_makeAx5Grid("first-grid",
		[ 	{
	            key : "CREATE_DATE",
	            label : "등록일자",
	            width : 120,
	            align : "center"
	        },{
  	            key : "CONTENTS",
  	            label : "내용",
  	            width : 700,
  	            align : "left"
	        },{
	            key : "USER_NAME",
	            label : "작성자",
	            width : 120,
	            align : "center"
	        }	], 
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
		    case "delete":
		    	var row = grid.getList("selected");
            	if ( row.length == 0 ) {
            		mask.open();
            		dialog.alert( { msg : "삭제할 큐톡 선택하셔야 합니다." }, function () { mask.close();	} );
            		return;
            	}

            	mask.open();
               	confirmDialog.confirm(
               		{
                       	title: "Confirm",
                       	msg: '삭제하시겠습니까?'
                   	}, 
                   	function(){
                     	if ( this.key == "ok" ) {
                     		var saveParams = {
                     			MODE : "DELETE",
                     			SEQ : row[0].SEQ
                     		};
                     		
                     		gfn_callAjax("/board/axTalkSave.do", saveParams, fn_callbackAjax, "delete");
                       	} else {
                       		mask.close();
                       	}
                   	}
               	);
		    	break;
            case "export":
                grid.exportExcel("큐톡관리.xls");
                break;
        }
    });
    
    //fn_search();
});

function fn_params() {
	params.FROM_DT = $("#FROM_DT").val();	
	params.TO_DT = $("#TO_DT").val();	
	params.TALK_ID = $("#CB_COMPANY option:selected").val();
}

function fn_search() {
	fn_params();
	
	if ( params.TALK_ID == "" ) {
		mask.open();
		dialog.alert( { msg : "채널을 선택해 주세요." }, function () { mask.close();} );
		return;	
	}
	
	gfn_callAjax("/board/axTalkList.do", params, fn_callbackAjax, "search");
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
	} else if ( id == "dd" ){
		dd = $.extend({}, data);

		gfn_cbRefresh("CB_COMPANY", data.Company2, true);
	}
}

function fn_gridEvent(event, obj) {
	if ( event == "Click" ) {
		obj.self.select(obj.dindex);
	}
}






</script>

<body style="padding : 10px">

<form id="frm" name="frm" method="post">

<h2>큐톡 관리</h2>
<div style="height:10px"></div>

<div class="form-inline"> 
  	<div class="form-group">
    	<label for="CB_COMPANY">&nbsp;채널</label>
		<select class="form-control" id="CB_COMPANY">
			<option value="">전체</option>
		</select>
  	</div>
  	<div class="form-group">
    	<label for="CB_CATEGORY">일자</label>
	   	<input class="form-control" id="FROM_DT" name="FROM_DT" maxlength="10" size="10" class="datePicker" value="" readonly/> ~ 
		<input class="form-control" id="TO_DT" name="TO_DT" maxlength="10" size="10" class="datePicker" value="" readonly/>
  	</div>
</div>
<div style="height:10px"></div>

<div>
    <button class="btn btn-default" data-grid-control="search">검색</button>
    <button class="btn btn-default" data-grid-control="delete">삭제</button>
    <button class="btn btn-default" data-grid-control="export">엑셀</button>
</div>

<div style="height:10px"></div>


<div style="position: relative;height:400px;" id="grid-parent">
    <div data-ax5grid="first-grid" style="height: 100%;"></div>
</div>

</form>


<div class="mask"></div>

</body>
</html>

