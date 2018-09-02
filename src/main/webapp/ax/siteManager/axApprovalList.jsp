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

    $('#MCB_COMPANY').multiselect(multiselectOptions);
    
    gfn_callAjax("/common/axDd.do", { DD_KIND : "CategoryLevel1,Tutor,OpenKind,Year" }, fn_callbackAjax, "dd", { async : false });
    
    $('[data-grid-control]').click(function () {
        switch (this.getAttribute("data-grid-control")) {
	        case "search":
	            fn_search();
	            break;
            case "reset":
            	fn_search();
                break;
            case "export":
                grid.exportExcel("과정Master관리.xls");
                break;
            case "viewRegister":
            	var row = grid.getList("selected");
            	if ( row.length == 0 ) {
            		mask.open();
            		dialog.alert( { msg : "결재를 선택하셔야 합니다." }, function () { mask.close();	} );
            	} else {
            		var urlParams = "page=/ax/siteManager/axApprovalUserPopup";
            		urlParams += "&APPROVAL_ID=" + row[0]["APPROVAL_ID"];
            		
            		f_popup('/common/axOpenPage', {displayName:'approvalUserPopup',option:'width=300,height=500', urlParams:urlParams});
            	}
            		
                break;
        }
    });
});

function fn_makeGrid() {
	grid = gfn_makeAx5Grid("first-grid",
		[ 	{
	            key : "COURSE_ID",
	            label : "ID",
	            width : 40,
	            align : "right"
	        },{
	            key : "CATEGORY_NAME",
	            label : "카테고리",
	            width : 150,
	            align : "left"
	        },{
	            key : "COURSE_NAME",
	            label : "과정명",
	            width : 150,
	            align : "left"
	        },{
	            key : "COURSE_CODE",
	            label : "과정코드",
	            width : 90,
	            align : "left"
	        },{
	            key : "YEAR", 
	            label : "년",
	            width : 50,
	            align : "center"
	        },{
	            key : "MONTH",
	            label : "월",
	            width : 50,
	            align : "center"
	        },{
	            key : "CHASU",
	            label : "차수",
	            width : 50,
	            align : "right"
	        },{
	            key : "CNT",
	            label : "수강생 수",
	            width : 90,
	            align : "right"
	        },{
	            key : "STATUS_NAME",
	            label : "상태",
	            width : 110,
	            align : "center"
	        },{
	            key : "CREATE_DATE",
	            label : "결재일자",
	            width : 110,
	            align : "center"
	        },{
              	key : undefined, 
              	label: "결재", 
              	columns: [	        
        	        {
			            key : "TOTAL_COST",
			            label : "총금액",
			            width : 110,
			            align : "right",
			            formatter : function () {
			                return checkThousand(this.item.TOTAL_COST);
			           	}
			        },{
			            key : "PAYMENT_POINT",
			            label : "포인트 금액", 
			            width : 110,
			            align : "right",
			            formatter : function () {
			                return checkThousand(this.item.PAYMENT_POINT);
			           	}
			        },{
			            key : "PAYMENT_COST",
			            label : "결재 금액",
			            width : 110,
			            align : "right",
			            formatter : function () {
			                return checkThousand(this.item.PAYMENT_COST);
			           	}
			        },{
			            key : "PAYMENT_KIND_NAME",
			            label : "결재 방법",
			            width : 110,
			            align : "center"
			        },{
			            key : "PAYMENT_BANK_NAME",
			            label : "결재 은행",
			            width : 200,
			            align : "left"
			        }
		        ]
	        },{
              	key : undefined, 
              	label: "환불", 
              	columns: [	        
        	        {
			            key : "REFUND_KIND_NAME",
			            label : "환불 방법",
			            width : 80,
			            align : "center"
			        },{
			            key : "REFUND_COST",
			            label : "환불 비용",
			            width : 80,
			            align : "right",
			            formatter : function () {
			                return checkThousand(this.item.REFUND_COST);
			           	}
			        },{
			            key : "REFUND_BANK",
			            label : "환불 은행",
			            width : 80,
			            align : "center"
			        },{
			            key : "REFUND_ACC_NUM",
			            label : "환불 계좌번호",
			            width : 130,
			            align : "left"
			        },{
			            key : "REFUND_DATE",
			            label : "환불 일자",
			            width : 120,
			            align : "center"
			        }
		        ]
	        }	], 
	  	null,
	  	{
	  		showRowSelector : false,
	  		frozenColumnIndex : 7
	  	}
	);
	
	$(window).trigger("resize");
}

function fn_params() {
	params.LEVEL1_CODE = $("#CB_LEVEL1 option:selected").val();	
	params.LEVEL2_CODE = $("#CB_LEVEL2 option:selected").val();	
	params.LEVEL3_CODE = $("#CB_LEVEL3 option:selected").val();	
	params.YEAR = $("#CB_YEAR option:selected").val();	
	params.chasu = $("#chasu").val();	
	params.courseName = $("#courseName").val();	
}

function fn_search() {
	//mask.open();
	fn_params();
	
	if ( params.chasu != "" && isNaN(params.chasu) ) {
		mask.open();
		dialog.alert( { msg : "차수는 정수를 입력하셔야 합니다." }, function () { mask.close(); } );
		return false;
	}
	
	gfn_callAjax("/siteManager/axApprovalList.do", params, fn_callbackAjax, "search");
}


function fn_callbackAjax(data, id) {
	//console.log("fn_callbackAjax : " + id);
	if ( id == "search" ) {
		grid.setData(data.list);
		
		//mask.close();
	} else if ( id == "dd" ){
		dd = $.extend({}, data);
		
		gfn_cbRefresh("CB_LEVEL1", data.CategoryLevel1, true);

		gfn_cbRefresh("CB_OPEN_KIND", data.OpenKind, true);
		gfn_cbRefresh("CB_YEAR", data.Year, true);

		fn_makeGrid();
		fn_search();
	} else if ( id == "CB_LEVEL1" ){
		gfn_cbRefresh("CB_LEVEL2", data.CategoryLevel2, true);
	} else if ( id == "CB_LEVEL2" ){
		gfn_cbRefresh("CB_LEVEL3", data.CategoryLevel3, true);
	}
}

function fn_gridEvent(event, obj) {
	if ( event == "Click" ) {
		obj.self.select(obj.dindex);
	} else if ( event == "DBLClick" ) {
	} else if ( event == "DataChanged" ) {
	}
}

function fn_cbChange(id) {
	if ( id == "CB_LEVEL1" ) {
	    gfn_callAjax("/common/axDd.do", { DD_KIND : "CategoryLevel2", LEVEL1_CODE : $("#CB_LEVEL1 option:selected").val()}, fn_callbackAjax, "CB_LEVEL1", { async : false });
	} else  if ( id == "CB_LEVEL2" ) {
	    gfn_callAjax("/common/axDd.do", { DD_KIND : "CategoryLevel3", LEVEL2_CODE : $("#CB_LEVEL2 option:selected").val()}, fn_callbackAjax, "CB_LEVEL2", { async : false });
	}
}


</script>

<body style="padding : 10px">

<form id="frm" name="frm" method="post">

<h2>수강신청 이력 관리</h2>
<div style="height:10px"></div>

<div>
	대분류
	<select id="CB_LEVEL1" onchange="fn_cbChange('CB_LEVEL1')">
		<option value="">전체</option>
	</select>
	중분류
	<select id="CB_LEVEL2" onchange="fn_cbChange('CB_LEVEL2')">
		<option value="">전체</option>
	</select>
	소분류
	<select id="CB_LEVEL3">
		<option value="">전체</option>
	</select>
	년도
	<select id="CB_YEAR">
		<option value="">전체</option>
	</select>
	차수
	<input type="text" class="search_input" id="chasu" name="chasu" value="" style="width:70px"/>
	과정명
	<input type="text" class="search_input" id="courseName" name="courseName" value="" />
</div>

<div style="height:10px"></div>

<div>
    <button class="btn btn-default" data-grid-control="search">검색</button>
    <button class="btn btn-default" data-grid-control="reset">초기화</button>
    <button class="btn btn-default" data-grid-control="export">엑셀</button>
    <button class="btn btn-default" data-grid-control="viewRegister">수강생</button>
</div>

<div style="height:10px"></div>


<div style="position: relative;height:400px;" id="grid-parent">
    <div data-ax5grid="first-grid" style="height: 100%;"></div>
</div>

</form>

<div class="mask"></div>


</body>
</html>

