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

<link rel="stylesheet" type="text/css" href="/resources/jquery_splitter/css/jquery.splitter.css"/>
<script src="/resources/jquery_splitter/js/jquery.splitter.js"></script>

</head>

<script type="text/javascript">
var mask = new ax5.ui.mask();
var confirmDialog = new ax5.ui.dialog();
var dialog = new ax5.ui.dialog( { title: '<i class="axi axi-ion-alert"></i> Alert' } );
var grid1 = null;
var grid2 = null;

var params = {};
var dd = {};

$(document.body).ready(function () {
	var splitter = $('#splitter').height(200).split({
	    orientation: 'vertical',
	    limit: 10,
	    position: '50%',
	    onDrag: function(event) {
	        //console.log(splitter.position());
	        if ( grid1 ) { 
	        	gfn_gridResize2("splitter", grid1, grid2);
	        }
	    }
	});
	
	$( window ).resize( function() {
        if ( grid1 ) { 
			gfn_gridResize2("splitter", grid1, grid2);
        }
	} );
	
    confirmDialog.setConfig({
        theme: "danger"
    });

    gfn_callAjax("/common/axDd.do", { DD_KIND : "PointKind" }, fn_callbackAjax, "dd", { async : false });

    $('[data-grid-control]').click(function () {
        switch (this.getAttribute("data-grid-control")) {
	        case "search":
	            fn_search();
	            break; 
            case "export":
                grid.exportExcel("포인트관리.xls");
                break;
        }
    });
    
    //fn_search();
});

function fn_makeGrid() {
	grid1 = gfn_makeAx5Grid("left-first-grid",
		[ 	{
	            key : "USER_ID",
	            label : "사용자 ID",
	            width : 80,
	            align : "left"
	        },{
	            key : "USER_NAME",
	            label : "사용자명",
	            width : 90,
	            align : "left"
	        },{
	            key : "IN_POINT",
	            label : "적립",
	            width : 70,
	            align : "right",
	            formatter : function () {
	                return checkThousand(this.item.IN_POINT);
	           	} 
	        },{
	            key : "OUT_POINT",
	            label : "사용",
	            width : 70,
	            align : "right",
	            formatter : function () {
	                return checkThousand(this.item.OUT_POINT);
	           	} 
	        },{
	            key : "REMAIN_POINT",
	            label : "잔여",
	            width : 70,
	            align : "right",
	            formatter : function () {
	                return checkThousand(this.item.REMAIN_POINT);
	           	} 
	        },{
	            key : "DELETE_POINT",
	            label : "소멸 예정",
	            width : 90,
	            align : "right",
	            formatter : function () {
	                return checkThousand(this.item.DELETE_POINT);
	           	} 
	        },{
	            key : "EMAIL",
	            label : "E-mail",
	            width : 160,
	            align : "left"
	        }	], 
	  	null,
	  	{
	  		showRowSelector : false
	  	}
	);
	
	grid2 = gfn_makeAx5Grid("right-first-grid",
		[ 	{
	            key : "POINT_DATE_STR",
	            label : "일자",
	            width : 110,
	            align : "center"
	        },{
				key : "POINT_CODE", 
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
	                return gfn_getValueInList(dd.PointKind, "value",  this.item.POINT_CODE, "text", true);
	           	}
	        },{
	            key : "POINT",
	            label : "포인트",
	            width : 70, 
	            align : "right",
	            formatter : function () {
	                return checkThousand(this.item.POINT);
	           	}
	        },{
	            key : "VALID_DATE_STR",
	            label : "유효일자",
	            width : 110,
	            align : "center"
	        },{
	            key : "IN_POINT_USE",
	            label : "사용",
	            width : 50,
	            align : "right",
	            formatter : function () {
	                return checkThousand(this.item.IN_POINT_USE);
	           	}
	        },{
	            key : "DELETED_POINT",
	            label : "소멸",
	            width : 90,
	            align : "right",
	            formatter : function () {
	                return checkThousand(this.item.DELETED_POINT);
	           	} 
	        },{
	            key : "DELETE_POINT",
	            label : "소멸 예정",
	            width : 90,
	            align : "right",
	            formatter : function () {
	                return checkThousand(this.item.DELETE_POINT);
	           	}
	        },{
	            key : "REF_ID",
	            label : "참조1",
	            width : 110,
	            align : "right"
	        },{
	            key : "REF_ID2",
	            label : "참조2",
	            width : 110,
	            align : "left"
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
	
	gfn_callAjax("/point/axPointList.do", params, fn_callbackAjax, "search");
}

function fn_callbackAjax(data, id) {
	//console.log("fn_callbackAjax : " + id);
	if ( id == "search" ) {
		grid1.setData(data.list);
	} else if ( id == "searchDetail" ) {
		grid2.setData(data.list);
	} else if ( id == "dd" ){
		dd = $.extend({}, data);

		fn_makeGrid();
	}
}

function fn_gridEvent(event, obj) {
	if ( event == "Click" ) {
		obj.self.select(obj.dindex);
	} else if ( event == "DBLClick" ) {
		params.USER_ID = obj.item.USER_ID;	
		
		gfn_callAjax("/point/axPointDetailList.do", params, fn_callbackAjax, "searchDetail");
	} else if ( event == "DataChanged" ) {
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
</div> 

<div style="height:10px"></div>

<div id="splitter">
    <div id="leftPane">
	    <div style="height:500px;" id="left-grid-parent">
		    <div data-ax5grid="left-first-grid" style="height: 100%; width:100%;"></div>
		</div>
    </div>
    <div id="rightPane">
	    <div style="height:500px;" id="right-grid-parent">
		    <div data-ax5grid="right-first-grid" style="height: 100%; width:100%;"></div>
		</div>
    </div>
</div>


</form>

<div class="mask"></div>

</body>
</html>

