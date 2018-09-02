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
	
    confirmDialog.setConfig({
        theme: "danger"
    });

    fn_makeGrid();
    
    $('[data-grid-control]').click(function () {
        switch (this.getAttribute("data-grid-control")) {
	        case "search":
	            fn_search();
	            break; 
            case "export":
                grid.exportExcel("포인트관리.xls");
                break;
            case "viewDetail":
                alert("나중에 구현예정");
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
	            width : 100,
	            align : "left"
	        },{
	            key : "USER_NAME",
	            label : "사용자명",
	            width : 90,
	            align : "left"
	        },{
	            key : "MOBILE",
	            label : "핸드폰",
	            width : 100,
	            align : "left"
	        },{
	            key : "EMAIL",
	            label : "E-mail",
	            width : 160,
	            align : "left"
	        },{
	            key : "IN_POINT",
	            label : "적립  포인트",
	            width : 150,
	            align : "right"
	        },{
	            key : "OUT_POINT",
	            label : "사용  포인트",
	            width : 150,
	            align : "right"
	        },{
	            key : "REMAIN_POINT",
	            label : "잔여  포인트",
	            width : 150,
	            align : "right"
	        }	], 
	  	null,
	  	{
	  		showRowSelector : false
	  	}
	);
	
	$(window).trigger("resize");
}

function fn_params() {
	params.SEARCH_STR = $("#SEARCH_STR").val();	
}

function fn_search() {
	//mask.open();
	
	fn_params();
	
	gfn_callAjax("/account/axPointList.do", params, fn_callbackAjax, "search");
}

function fn_callbackAjax(data, id) {
	//console.log("fn_callbackAjax : " + id);
	if ( id == "search" ) {
		grid.setData(data.list);
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

<h2>포인트 관리</h2>
<div style="height:10px"></div>

<div class="form-inline">
  	<div class="form-group">
    	<label for="CB_SEARCHKIND">사용자 ID 및 사용자명</label>
		<input class="form-control" type="text" class="search_input" id="SEARCH_STR" name="SEARCH_STR" value="" />
  	</div>
</div>
<div style="height:10px"></div>

<div>
    <button class="btn btn-default" data-grid-control="search">검색</button>
    <button class="btn btn-default" data-grid-control="export">엑셀</button>
    <button class="btn btn-default" data-grid-control="viewDetail">포인트 상세</button>
</div> 

<div style="height:10px"></div>


<div style="height:500px;" id="grid-parent">
    <div data-ax5grid="first-grid" style="height: 100%;"></div>
</div>

</form>

<div class="mask"></div>

</body>
</html>

