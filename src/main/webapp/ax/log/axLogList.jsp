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
var list = {};

$(document.body).ready(function () {
	$( window ).resize( function() {
		gfn_gridResize("grid-parent", grid);
	} );

	$("#FROM_DT").val(gfn_currentDay(null, "-"));	 	
	$("#TO_DT").val(gfn_currentDay(null, "-"));		
	gfn_initDatepicker("FROM_DT");
	gfn_initDatepicker("TO_DT");
	
    confirmDialog.setConfig({
        theme: "danger"
    });

    fn_makeGrid();
    fn_search();
    
    $('[data-grid-control]').click(function () {
        switch (this.getAttribute("data-grid-control")) {
	        case "search":
	            fn_search();
	            break;
            case "export":
                grid.exportExcel("로그관리.xls");
                break;
        }
    });
});

function fn_makeGrid() {
	grid = gfn_makeAx5Grid("first-grid",
		[ {
	            key : "USER_ID",
	            label : "사용자 ID",
	            width : 100,
	            align : "left"
	        },{
	            key : "USER_NAME",
	            label : "사용자명",
	            width : 80,
	            align : "left"
	        },{
	            key : "URL",
	            label : "Url",
	            width : 180,
	            align : "left"
	        },{
	            key : "PARAMETER",
	            label : "파라미터", 
	            width : 400,
	            align : "left"
	        },{
	            key : "CREATE_DATE_STR",
	            label : "접속시간", 
	            width : 120,
	            align : "center"
	        }	], 
	  	null,
	  	{
	  		showRowSelector : true,
	  		multipleSelect: true
	  	}
	);
	
	$(window).trigger("resize");
} 

function fn_params() {
	params.FROM_DT = $("#FROM_DT").val();	
	params.TO_DT = $("#TO_DT").val();	
	params.CB_SEARCHKIND = $("#CB_SEARCHKIND option:selected").val();
	params.SEARCH_STR = $("#SEARCH_STR").val();
}

function fn_search() {
	//mask.open();
	
	fn_params();
	
	gfn_callAjax("/log/axLogList.do", params, fn_callbackAjax, "search");
}

function fn_callbackAjax(data, id) {
	//console.log("fn_callbackAjax : " + id);
	if ( id == "search" ) {
		list = data.list;
		grid.setData(data.list);
	}
}

function fn_gridEvent(event, obj) {
	if ( event == "Click" ) {
		//obj.self.select(obj.dindex);
	}
}


</script>

<body style="padding : 10px">

<form id="frm" name="frm" method="post">

<h2>로그 관리</h2>
<div style="height:10px"></div>

<div>
	일자
   	<input id="FROM_DT" name="FROM_DT" maxlength="10" size="10" class="datePicker" value="" readonly/> ~ 
	<input id="TO_DT" name="TO_DT" maxlength="10" size="10" class="datePicker" value="" readonly/>
	검색
	<select id="CB_SEARCHKIND">
		<option value="">전체</option>
		<option value="USER_ID">사용자 ID</option>
		<option value="USER_NAME">사용자명</option>
	</select>
	<input type="text" id="SEARCH_STR" name="SEARCH_STR" value=""/>
</div>

<div style="height:10px"></div>

<div>
    <button class="btn btn-default" data-grid-control="search">검색</button>
    <button class="btn btn-default" data-grid-control="export">엑셀</button>
</div> 

<div style="height:10px"></div>


<div style="height:500px;" id="grid-parent">
    <div data-ax5grid="first-grid" style="height: 100%;"></div>
</div>

</form>

<div class="mask"></div>

</body>
</html>

