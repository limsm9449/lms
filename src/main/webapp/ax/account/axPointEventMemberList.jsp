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

	$("#POINT_DATE").val(gfn_currentDay(null, "-"));		
	gfn_initDatepicker("POINT_DATE");

    $('[data-grid-control]').click(function () {
        switch (this.getAttribute("data-grid-control")) {
	        case "search":
	            fn_search();
	            break;
            case "save" :
            	fn_save();
                break;
        }
    });
    
	fn_makeGrid();
});

function fn_makeGrid() {
	grid = gfn_makeAx5Grid("first-grid",
		[ 	{
            key : "USER_ID",
            label : "사용자 ID",
            width : 100,
            align : "left"
        },{
            key : "USER_NAME",
            label : "사용자명",
            width : 90,
            align : "left"
        },{
            key : "EMAIL",
            label : "E-mail",
            width : 150,
            align : "left"
        },{
            key : "BIRTH_DAY",
            label : "생일",
            width : 80,
            align : "center"
        },{
            key : "MOBILE",
            label : "핸드폰",
            width : 100,
            align : "left"
        }	], 
	  	null,
	  	{
	  		showRowSelector : true,
	  		multipleSelect: true
	  	}
	);
}

function fn_params() {
	params.CB_SEARCHKIND = $("#CB_SEARCHKIND option:selected").val();	
	params.SEARCH_STR = $("#SEARCH_STR").val();	
}

function fn_search() {
	fn_params();
	
	gfn_callAjax("/point/axPointEventMemberList.do", params, fn_callbackAjax, "search");
}

function fn_save() {
	if ( $("#POINT").val() == "" && isNaN($("#POINT").val()) ) {
		mask.open();
		dialog.alert( { msg : "이벤트 포인트를 입력하셔야 합니다." }, function () { mask.close(); } );
		return false;
	}
	if ( $("#VALID_MONTH").val() == "" && isNaN($("#VALID_MONTH").val()) ) {
		mask.open();
		dialog.alert( { msg : "유효개월수를 입력하셔야 합니다." }, function () { mask.close(); } );
		return false;
	}
	
	var rows = grid.getList("selected");
   	if ( rows.length == 0 ) {
   		mask.open();
   		dialog.alert( { msg : "선택한 회원이 없습니다." }, function () { mask.close();	} );
   		return;
   	}
   	
   	mask.open();
   	confirmDialog.confirm(
   		{
           	title: "Confirm",
           	msg: '선택한 회원들에게 포인트를 지급하시겠습니까?'
       	}, 
       	function(){
         	if ( this.key == "ok" ) {
         		var saveParams = {
         		};
         		
         		gfn_callAjax("/point/axPointEventMemberSave.do", { modified : rows, POINT_DATE : $("#POINT_DATE").val(), POINT : $("#POINT").val(), VALID_MONTH : $("#VALID_MONTH").val() }, fn_callbackAjax, "save");
           	} else {
           		mask.close();
           	}
       	}
   	);
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
			dialog.alert( { msg : "회원들에게 포인트가 지급되었습니다." }, function () { mask.close();	fn_search(); } );
		}
		
		isSave = true;
	}
}

function fn_gridEvent(event, obj) {
	if ( event == "Click" ) {
		//obj.self.select(obj.dindex);
	} else if ( event == "DBLClick" ) {
	} else if ( event == "DataChanged" ) {
	}
}


</script>

<body style="padding : 10px">

<form id="frm" name="frm" method="post">

<h2>회원 이벤트 관리</h2>
<div style="height:10px"></div>

<div class="form-inline">
  	<div class="form-group">
    	<label for="CB_SEARCHKIND">검색 유형</label>
		<select class="form-control" id="CB_SEARCHKIND" name="CB_SEARCHKIND">
	       	<option value="USER_ID" >사용자 ID</option>
	       	<option value="USER_NAME" >사용자명</option>
	       	<option value="EMAIL" >이메일</option>
	       	<option value="MOBILE" >핸드폰</option>
		</select>
		<input class="form-control" type="text" class="search_input" id="SEARCH_STR" name="SEARCH_STR" value="" />
  	</div>
</div>

<div style="height:10px"></div>

<div>
    <button class="btn btn-default" data-grid-control="search">검색</button>
    <button class="btn btn-default" data-grid-control="save">포인트 지급</button>
</div>

<div style="height:10px"></div>

<div class="form-inline">
  	<div class="form-group">
    	<label for="courseName">이벤트 일자</label>
	   	<input id="POINT_DATE" name="POINT_DATE" maxlength="10" size="10" class="form-control datePicker" value="" readonly/>
  	</div>
  	<div class="form-group">
    	<label for="courseName">이벤트 포인트</label>
    	<input type="text" class="form-control" id="POINT" name="POINT" style="width:100px;" value="1000">
  	</div>
  	<div class="form-group">
    	<label for="courseName">유효개월</label>
    	<input type="text" class="form-control" id="VALID_MONTH" name="VALID_MONTH" style="width:100px;" value="6">
  	</div>
</div>

<div style="height:10px"></div>

<div style="position: relative;height:530px;" id="grid-parent">
    <div data-ax5grid="first-grid" style="height: 100%;"></div>
   
</div>


</form>

<div class="mask"></div>

</body>
</html>

