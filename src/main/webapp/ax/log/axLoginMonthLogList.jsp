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

	gfn_callAjax("/common/axDd.do", { DD_KIND : "Year2" }, fn_callbackAjax, "dd", { async : false });
	
    confirmDialog.setConfig({
        theme: "danger"
    });

    $('[data-grid-control]').click(function () {
        switch (this.getAttribute("data-grid-control")) {
	        case "search":
	            fn_search();
	            break;
            case "export":
                grid.exportExcel("로그인로그관리.xls");
                break;
        }
    });
});

function fn_makeGrid() {
	var columns = [
		{
	        key : "USER_ID",
	        label : "사용자 ID",
	        width : 100,
	        align : "left"
	    },{
	        key : "USER_NAME",
	        label : "사용자명",
	        width : 80,
	        align : "left"
	    }
	];
	
	for ( var i = 1 ; i <= new Date(parseInt($("#CB_YEAR").val()), parseInt($("#CB_MONTH").val()), 0).getDate(); i++ ) {
		columns.push(
			{
		        key : (i < 10 ? "DAY_0" + i : "DAY_" + i),
		        label : i + " 일",
		        width : 60,
		        align : "right"
		    }
		);
	}
	
	if ( grid ) {
		grid.destroy();
	}
	
	grid = gfn_makeAx5Grid("first-grid", columns, 
	  	null,
	  	{
	  		showRowSelector : false, 
	  	}
	);
	
	$(window).trigger("resize");
} 

function fn_params() {
	params.YEAR_MONTH = $("#CB_YEAR").val() + "-" + $("#CB_MONTH").val();	
	params.CB_SEARCHKIND = $("#CB_SEARCHKIND option:selected").val();
	params.SEARCH_STR = $("#SEARCH_STR").val();
}

function fn_search() {
	//mask.open();
	fn_makeGrid();
	
	fn_params();
	
	gfn_callAjax("/log/axLoginMonthLogList.do", params, fn_callbackAjax, "search");
}

function fn_callbackAjax(data, id) {
	//console.log("fn_callbackAjax : " + id);
	if ( id == "search" ) {
		list = data.list;
		grid.setData(data.list);
	} else if ( id == "dd" ){
		dd = $.extend({}, data);
		
		gfn_cbRefresh("CB_YEAR", data.Year2, true);
		
		$("#CB_YEAR").val((new Date()).getFullYear());
		$("#CB_MONTH").val((new Date()).getMonth() + 1);
		
		fn_makeGrid();
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

<h2>월별 로그인 로그</h2>
<div style="height:10px"></div>

<div class="form-inline">
  	<div class="form-group">
    	<label for="CB_YEAR">년됴</label>
	   	<select class="form-control" id="CB_YEAR">
			<option value="">전체</option>
		</select>
    	<label for="CB_YEAR">월</label>
	   	<select class="form-control" id="CB_MONTH">
			<option value="01">1</option>
			<option value="02">2</option>
			<option value="03">3</option>
			<option value="04">4</option>
			<option value="05">5</option>
			<option value="06">6</option>
			<option value="07">7</option>
			<option value="08">8</option>
			<option value="09">9</option>
			<option value="10">10</option>
			<option value="11">11</option>
			<option value="12">12</option>
		</select>
  	</div>
  	<div class="form-group">
    	<label for="CB_SEARCHKIND">검색</label>
		<select class="form-control" id="CB_SEARCHKIND">
			<option value="">선택</option>
			<option value="USER_ID">사용자 ID</option>
			<option value="USER_NAME">사용자명</option>
		</select>
		<input class="form-control" type="text" id="SEARCH_STR" name="SEARCH_STR" value=""/>
  	</div>
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

