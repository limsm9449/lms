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

var openParams = null;

$(document.body).ready(function () {
	openParams = parent.document.getElementById("left").contentWindow.pageParam["axPointDetailList"];

	$( window ).resize( function() {
		gfn_gridResize("grid-parent", grid);
	} );
	
    confirmDialog.setConfig({
        theme: "danger"
    });

    gfn_callAjax("/common/axDd.do", { DD_KIND : "PointKind" }, fn_callbackAjax, "dd", { async : false });
    
    $('[data-grid-control]').click(function () {
        switch (this.getAttribute("data-grid-control")) {
            case "export":
                grid.exportExcel("포인트상세.xls");
                break;
        }
    });
    
    //fn_search();
});

function fn_makeGrid() {
	grid = gfn_makeAx5Grid("first-grid",
		[ 	{
				key : "KIND", 
	        	label : "포인트 구분", 
	            width : 140,
	        	align : "left", 
	        	editor: {
	                type : "select", 
	                config : {
	                    columnKeys: { optionValue: "value", optionText: "text" },
	                    options: dd.PointKind
	                },
	            	disabled : function () {
                        return true;
                    }
	        	},
	            formatter : function () {
	                return gfn_getValueInList(dd.PointKind, "value",  this.item.KIND, "text", true);
	           	}
	        },{
	            key : "IN_POINT",
	            label : "적립",
	            width : 140,
	            align : "right",
	            editor : { 
	            	type : "number",
	            	disabled : function () {
                        return true;
                    }
				},
	            formatter : function () {
	                return checkThousand(this.item.IN_POINT);
	           	}
	        },{
	            key : "OUT_POINT",
	            label : "사용",
	            width : 140,
	            align : "right",
	            editor : { 
	            	type : "number",
	            	disabled : function () {
                        return true;
                    }
				},
	            formatter : function () {
	                return checkThousand(this.item.OUT_POINT);
	           	}
	        },{
	            key : "REMAIN_POINT",
	            label : "잔여  포인트",
	            width : 150,
	            align : "right",
	            editor : { 
	            	type : "number",
	            	disabled : function () {
                        return true;
                    }
				},
	            formatter : function () {
	                return checkThousand(this.item.REMAIN_POINT);
	           	}
	        },{
	            key : "CREATE_DATE_STR",
	            label : "일자",
	            width : 110,
	            align : "center"
	        }	], 
	  	null,
	  	{
	  		showRowSelector : false
	  	}
	);
	
	$(window).trigger("resize");
}

function fn_params() {
	if ( openParams ) {
		params.USER_ID = openParams.USER_ID; 
	}
}

function fn_search() {
	//mask.open();
	
	fn_params();
	
	gfn_callAjax("/point/axPointDetailList.do", params, fn_callbackAjax, "search");
}

function fn_callbackAjax(data, id) {
	//console.log("fn_callbackAjax : " + id);
	if ( id == "search" ) {
		grid.setData(data.list);
	} else if ( id == "dd" ){
		dd = $.extend({}, data);

		fn_makeGrid();
		
		fn_search();
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

<h2>포인트 상세</h2>
<div style="height:10px"></div>

<div>
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

