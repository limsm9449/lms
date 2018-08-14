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

	$("#FROM_DT").val(gfn_addDay(gfn_currentDay(), -10, "-"));		
	$("#TO_DT").val(gfn_currentDay(null, "-"));		
	gfn_initDatepicker("FROM_DT");
	gfn_initDatepicker("TO_DT");
	
    confirmDialog.setConfig({
        theme: "danger"
    });

    gfn_callAjax("/common/axDd.do", { DD_KIND : "ApprovalStatus,PaymentKind,Bank" }, fn_callbackAjax, "dd", { async : false });
    
    $('[data-grid-control]').click(function () {
        switch (this.getAttribute("data-grid-control")) {
	        case "search":
	            fn_search();
	            break;
	        case "bankConfirm":
	        	var rows = grid.getList("selected");
	        	if ( rows.length == 0 ) {
            		mask.open();
            		dialog.alert( { msg : "입금 정보를 선택하셔야 합니다." }, function () { mask.close();	} );
            		return;
            	}
	        	for ( var i = 0; i < rows.length; i++ ) {
					if ( rows[i].STATUS != "B") {
	            		mask.open();
	            		dialog.alert( { msg : (rows[i].__index + 1) + " 라인 : 은행입금이 아닙니다."	}, function () { mask.close();	} );
	            		return;
					}		        			
	        	}
	        	for ( var i = 0; i < rows.length; i++ ) {
					grid.setValue(rows[i].__index, "STATUS", "A");
	        	}
	        	
	            break;
	        case "approvalToBank":
	        	var rows = grid.getList("selected");
	        	if ( rows.length == 0 ) {
            		mask.open();
            		dialog.alert( { msg : "입금 정보를 선택하셔야 합니다." }, function () { mask.close();	} );
            		return;
            	}
	        	for ( var i = 0; i < rows.length; i++ ) {
					if ( rows[i].STATUS != "A" ) {
	            		mask.open();
	            		dialog.alert( { msg : (rows[i].__index + 1) + " 라인 : 승인 상태가 아닙니다."	}, function () { mask.close();	} );
	            		return;
					}		        			
					if ( rows[i].PAYMENT_KIND != "CASH" ) {
	            		mask.open();
	            		dialog.alert( { msg : (rows[i].__index + 1) + " 라인 : 은행입금 승인만 취소를 할 수 있습니다."	}, function () { mask.close();	} );
	            		return;
					}
	        	}
	        	for ( var i = 0; i < rows.length; i++ ) {
					grid.setValue(rows[i].__index, "STATUS", "B");
	        	}
	        	
	            break;
	        case "reject":
	        	var rows = grid.getList("selected");
	        	if ( rows.length == 0 ) {
            		mask.open();
            		dialog.alert( { msg : "입금 정보를 선택하셔야 합니다." }, function () { mask.close();	} );
            		return;
            	}
	        	for ( var i = 0; i < rows.length; i++ ) {
					if ( rows[i].STATUS != "B") {
	            		mask.open();
	            		dialog.alert( { msg : (rows[i].__index + 1) + " 라인 : 은행입금만 거절 할 수 있습니다."	}, function () { mask.close();	} );
	            		return;
					}		        			
	        	}
	        	for ( var i = 0; i < rows.length; i++ ) {
					grid.setValue(rows[i].__index, "STATUS", "C");
	        	}
	        	
	            break;
	        case "refund":
	        	var rows = grid.getList("selected");
	        	if ( rows.length == 0 ) {
            		mask.open();
            		dialog.alert( { msg : "입금 정보를 선택하셔야 합니다." }, function () { mask.close();	} );
            		return;
            	}
	        	if ( rows.length > 1 ) {
            		mask.open();
            		dialog.alert( { msg : "환불은 입금 정보를 한개만 선택하셔야 합니다." }, function () { mask.close();	} );
            		return;
            	}
				if ( rows[0].STATUS != "A") {
            		mask.open();
            		dialog.alert( { msg : (rows[0].__index + 1) + " 라인 : 승인된 정보만 환불할 수 있습니다."	}, function () { mask.close();	} );
            		return;
				}		        			
		    	$("#UPD_REFUND_KIND").val("CASH");
		    	$("#UPD_REFUND_COST").val(rows[0].PAYMENT_COST);
		    	$("#UPD_REFUND_BANK").val(gfn_getValueInList(list, "APPROVAL_ID",  rows[0].APPROVAL_ID, "BANK"));
		    	$("#UPD_REFUND_ACC_NUM").val(gfn_getValueInList(list, "APPROVAL_ID",  rows[0].APPROVAL_ID, "ACC_NUM"));
		    	
		    	gfn_showPopupDiv("insDiv");

	        	
	            break;
            case "save" :
            	fn_save();
                break;
            case "export":
                grid.exportExcel("입금관리.xls");
                break;
        }
    });
});

function fn_makeGrid() {
	grid = gfn_makeAx5Grid("first-grid",
		[ {
	            key : "REQUEST_DATE",
	            label : "신청일자",
	            width : 100,
	            align : "center"
	        },{
	            key : "USER_ID",
	            label : "신청자 ID",
	            width : 80,
	            align : "left"
	        },{
	            key : "USER_NAME",
	            label : "신청자명",
	            width : 80,
	            align : "left"
	        },{
	            key : "STATUS",
	            label : "신청상태", 
	            width : 80,
	            align : "center", 
	        	editor: {
                    type : "select",
	            	disabled : function () {
                        return true;
                    },
                    config : { 
                        columnKeys: { optionValue: "value", optionText: "text" },
                        options: dd.ApprovalStatus
                    } 
	        	}, 
	            formatter : function () {
	                return gfn_getValueInList(dd.ApprovalStatus, "value",  this.item.STATUS, "text");
	           	},
				styleClass: function () {
                    return (this.item.STATUS == "A" || this.item.STATUS == "B" ? "grid-cell-edit" : "");
                }
	        },{
              	key : undefined, 
              	label: "결재", 
              	columns: [	
              		{
			            key : "TOTAL_COST",
			            label : "총금액",
			            width : 80,
			            align : "right"
			        },{
			            key : "PAYMENT_POINT",
			            label : "포인트 금액",
			            width : 100,
			            align : "right"
			        },{
			            key : "PAYMENT_COST",
			            label : "결재 금액",
			            width : 80,
			            align : "right"
			        },{
			            key : "PAYMENT_KIND",
			            label : "결재 방법",
			            width : 80,
			            align : "center", 
			        	editor: {
		                    type : "select",
			            	disabled : function () {
		                        return true;
		                    },
		                    config : { 
		                        columnKeys: { optionValue: "value", optionText: "text" },
		                        options: dd.PaymentKind
		                    } 
			        	},
			            formatter : function () {
			                return gfn_getValueInList(dd.PaymentKind, "value",  this.item.PAYMENT_KIND, "text");
			           	}
			        },{
			            key : "PAYMENT_BANK",
			            label : "결재 은행",
			            width : 200,
			            align : "left", 
			        	editor: {
		                    type : "select",
			            	disabled : function () {
		                        return true;
		                    },
		                    config : { 
		                        columnKeys: { optionValue: "value", optionText: "text" },
		                        options: dd.Bank
		                    } 
			        	},
			            formatter : function () {
			                return gfn_getValueInList(dd.Bank, "value",  this.item.PAYMENT_BANK, "text");
			           	}
			        },{
			            key : "PAYMENT_DATE",
			            label : "결재 일자",
			            width : 120,
			            align : "center"
			        }
			  	]
	        },{
              	key : undefined, 
              	label: "환불", 
              	columns: [	 
              		{
			            key : "REFUND_KIND",
			            label : "환불 방법",
			            width : 80,
			            align : "center", 
			        	editor: {
		                    type : "select",
			            	disabled : function () {
		                        return true;
		                    },
		                    config : { 
		                        columnKeys: { optionValue: "value", optionText: "text" },
		                        options: dd.PaymentKind
		                    } 
			        	},
			            formatter : function () {
			                return gfn_getValueInList(dd.PaymentKind, "value",  this.item.REFUND_KIND, "text");
			           	}
              		},{
			            key : "REFUND_COST",
			            label : "환불 비용",
			            width : 80,
			            align : "right", 
			        	editor: {
		                    type : "number",
			            	disabled : function () {
		                        return (this.item.UPD_FLAG == "Y" ? false : true);
		                    } 
			        	},
						styleClass: function () {
		                    return (this.item.UPD_FLAG == "Y" ? "grid-cell-edit" : "");
		                }
              		},{
			            key : "REFUND_BANK",
			            label : "환불 은행",
			            width : 80,
			            align : "center", 
			        	editor: {
		                    type : "text",
			            	disabled : function () {
		                        return (this.item.UPD_FLAG == "Y" ? false : true);
		                    } 
			        	},
						styleClass: function () {
		                    return (this.item.UPD_FLAG == "Y" ? "grid-cell-edit" : "");
		                }
              		},{
			            key : "REFUND_ACC_NUM",
			            label : "환불 계좌번호",
			            width : 130, 
			            align : "left", 
			        	editor: {
		                    type : "text",
			            	disabled : function () {
		                        return (this.item.UPD_FLAG == "Y" ? false : true);
		                    } 
			        	},
						styleClass: function () {
		                    return (this.item.UPD_FLAG == "Y" ? "grid-cell-edit" : "");
		                }
              		},{
			            key : "REFUND_DATE",
			            label : "환불 일자",
			            width : 120,
			            align : "center"
              		}
              	]
	        },{
	            key : "LAST_UPDATE_USER",
	            label : "수정자",
	            width : 80,
	            align : "center"
	        },{
	            key : "LAST_UPDATE_DATE",
	            label : "수정일자",
	            width : 110,
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
	params.USER = $("#USER").val();
	params.CB_SEARCH_STATUS = $("#CB_SEARCH_STATUS option:selected").val();
}

function fn_search() {
	//mask.open();
	
	fn_params();
	
	gfn_callAjax("/cost/axCostList.do", params, fn_callbackAjax, "search");
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
             		gfn_callAjax("/cost/axCostSave.do", gfn_getSaveData(grid), fn_callbackAjax, "save");
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
		list = data.list;
		grid.setData(data.list);
		
		//mask.close();
	} else if ( id == "dd" ){
		dd = $.extend({}, data);

		
		gfn_cbRefresh("CB_SEARCH_STATUS", data.ApprovalStatus, true);
		gfn_cbRefresh("UPD_REFUND_KIND", data.PaymentKind, false);
		
		fn_makeGrid();
		fn_search();
	} else if ( id == "save" ){
		mask.close();

		mask.open();
		dialog.alert( { msg : "저장 되었습니다." }, function () { mask.close();	fn_search(); } );
	}
}

function fn_gridEvent(event, obj) {
	if ( event == "Click" ) {
		//obj.self.select(obj.dindex);
	}
}

function fn_hidePopupDiv(popupDivId) {
	if ( popupDivId == "insDiv" ) {
		var rows = grid.getList("selected");

		if ( $("#UPD_REFUND_COST").val() == "" || isNaN($("#UPD_REFUND_COST").val()) ) {
			alert("환불비용을 입력하세요.");
			return;
		} 

		if ( parseInt($("#UPD_REFUND_COST").val()) > parseInt(rows[0].PAYMENT_COST) ) {
			alert("환불비용이 결재금액보다 급니다.");
			return;
		} 
	
		if ( $("#UPD_REFUND_BANK").val() == "" ) {
			alert("환불은행을 입력하세요.");
			return;
		} 
		
		if ( $("#UPD_REFUND_ACC_NUM").val() == "" ) {
			alert("환불계좌번호를 입력하세요.");
			return;
		} 
		
		grid.setValue(rows[0].__index, "STATUS", "R");
		grid.setValue(rows[0].__index, "REFUND_KIND", $("#UPD_REFUND_KIND").val());
		grid.setValue(rows[0].__index, "REFUND_COST", $("#UPD_REFUND_COST").val());
		grid.setValue(rows[0].__index, "REFUND_BANK", $("#UPD_REFUND_BANK").val());
		grid.setValue(rows[0].__index, "REFUND_ACC_NUM", $("#UPD_REFUND_ACC_NUM").val());
		grid.setValue(rows[0].__index, "UPD_FLAG", "Y");
		grid.repaint();
	}

	gfn_hidePopupDiv(popupDivId);
}


</script>

<body style="padding : 10px">

<form id="frm" name="frm" method="post">

<h2>입금 관리</h2>
<div style="height:10px"></div>

<div>
	신청상태
	<select id="CB_SEARCH_STATUS">
	</select>
	일자
   	<input id="FROM_DT" name="FROM_DT" maxlength="10" size="10" class="datePicker" value="" readonly/> ~ 
	<input id="TO_DT" name="TO_DT" maxlength="10" size="10" class="datePicker" value="" readonly/>
	신청자
	<input type="text" id="USER" name="USER" value=""/>
</div>

<div style="height:10px"></div>

<div>
    <button class="btn btn-default" data-grid-control="search">검색</button>
    <button class="btn btn-default" data-grid-control="bankConfirm">은행 입금 확인</button>
    <button class="btn btn-default" data-grid-control="approvalToBank">은행 입금 확인 취소</button>
    <button class="btn btn-default" data-grid-control="reject">거절</button>
    <button class="btn btn-default" data-grid-control="refund">환불</button>
    <button class="btn btn-default" data-grid-control="save">저장</button>
    <button class="btn btn-default" data-grid-control="export">엑셀</button>
</div> 

<div style="height:10px"></div>


<div style="height:500px;" id="grid-parent">
    <div data-ax5grid="first-grid" style="height: 100%;"></div>
</div>

</form>

<div class="mask"></div>
<div class="popupDiv" id="insDiv" style="width:300px; height:200px;">
	환불방법
	<select id="UPD_REFUND_KIND">
	</select>
	<br></br>
	환불비용
	<input type="text" id="UPD_REFUND_COST"/>
	<br></br>
	환불은행
	<input type="text" id="UPD_REFUND_BANK"/>
	<br></br>
	환불계좌번호
	<input type="text" id="UPD_REFUND_ACC_NUM"/>
	<br></br>
	
	<div style="height:30px"></div>
	<input type="button" href="#" value="확인" onclick="fn_hidePopupDiv('insDiv')"/>
    <input type="button" href="#" value="닫기" onclick="gfn_hidePopupDiv('insDiv');"/>
</div>

</body>
</html>

