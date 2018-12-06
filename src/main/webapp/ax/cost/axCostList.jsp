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

    gfn_callAjax("/common/axDd.do", { DD_KIND : "ApprovalStatus,PaymentKind,Bank,CategoryLevel1,Year,CompanyKind,Company,Company1,Company2"}, fn_callbackAjax, "dd", { async : false });
    
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
					if ( rows[i].STATUS != "B" && rows[i].STATUS != "C") {
	            		mask.open();
	            		dialog.alert( { msg : (rows[i].__index + 1) + " 라인 : 은행입금 또는 거절(사용자 취소)이 아닙니다."	}, function () { mask.close();	} );
	            		return;
					}		        			
	        	}
	        	var approvalDup = {};
	        	for ( var i = 0; i < rows.length; i++ ) {
					if ( approvalDup[rows[i].APPROVAL_ID] == undefined ) {
						approvalDup[rows[i].APPROVAL_ID] = rows[i].APPROVAL_ID;
					} else {
	            		mask.open();
	            		dialog.alert( { msg : (rows[i].__index + 1) + " 라인 : 동일 결재ID로 여러개를 선택할 수 없습니다. 한개만 선택해 주세요."	}, function () { mask.close();	} );
	            		return;
					}		        			
	        	}
	        	for ( var i = 0; i < rows.length; i++ ) {
					grid.setValue(rows[i].__index, "STATUS", "A");
	        	}
	        	
	        	grid.repaint();
	        	
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
	        	var approvalDup = {};
	        	for ( var i = 0; i < rows.length; i++ ) {
					if ( approvalDup[rows[i].APPROVAL_ID] == undefined ) {
						approvalDup[rows[i].APPROVAL_ID] = rows[i].APPROVAL_ID;
					} else {
	            		mask.open();
	            		dialog.alert( { msg : (rows[i].__index + 1) + " 라인 : 동일 결재ID로 여러개를 선택할 수 없습니다. 한개만 선택해 주세요."	}, function () { mask.close();	} );
	            		return;
					}		        			
	        	}
	        	for ( var i = 0; i < rows.length; i++ ) {
					grid.setValue(rows[i].__index, "STATUS", "B");
	        	}
	        	
	        	grid.repaint();
	        	
	            break;
	        case "reject":
	        	var rows = grid.getList("selected");
	        	if ( rows.length == 0 ) {
            		mask.open();
            		dialog.alert( { msg : "은행 입금 정보를 선택하셔야 합니다." }, function () { mask.close();	} );
            		return;
            	}
	        	for ( var i = 0; i < rows.length; i++ ) {
					if ( rows[i].STATUS != "B") {
	            		mask.open();
	            		dialog.alert( { msg : (rows[i].__index + 1) + " 라인 : 은행입금만 거절 할 수 있습니다."	}, function () { mask.close();	} );
	            		return;
					}		        			
	        	}
	        	var approvalDup = {};
	        	for ( var i = 0; i < rows.length; i++ ) {
					if ( approvalDup[rows[i].APPROVAL_ID] == undefined ) {
						approvalDup[rows[i].APPROVAL_ID] = rows[i].APPROVAL_ID;
					} else {
	            		mask.open();
	            		dialog.alert( { msg : (rows[i].__index + 1) + " 라인 : 동일 결재ID로 여러개를 선택할 수 없습니다. 한개만 선택해 주세요."	}, function () { mask.close();	} );
	            		return;
					}		        			
	        	}
	        	for ( var i = 0; i < rows.length; i++ ) {
					grid.setValue(rows[i].__index, "STATUS", "C");
	        	}
	        	
	        	grid.repaint();
	        	
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
		    	$("#UPD_REFUND_COST").val(rows[0].PAYMENT_COST);
		    	$("#UPD_REFUND_BANK").val(gfn_getValueInList(list, "APPROVAL_ID",  rows[0].APPROVAL_ID, "BANK"));
		    	$("#UPD_REFUND_ACC_NUM").val(gfn_getValueInList(list, "APPROVAL_ID",  rows[0].APPROVAL_ID, "ACC_NUM"));
		    	
		    	gfn_showPopupDiv("insDiv");

	        	
	            break;
            case "save" :
            	fn_save();
                break;
            case "export":
                grid.exportExcel("은행입금관리.xls");
                break;
        }
    });
});

function fn_makeGrid() {
	grid = gfn_makeAx5Grid("first-grid",
		[ 	{
	            key : "APPROVAL_ID",
	            label : "결재ID",
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
	            key : "REQUEST_DATE",
	            label : "신청일자",
	            width : 100,
	            align : "center"
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
			            align : "right",
			            formatter : function () {
			                return checkThousand(this.item.TOTAL_COST);
			           	}
			        },{
			            key : "PAYMENT_POINT",
			            label : "포인트 금액",
			            width : 100,
			            align : "right",
			            formatter : function () {
			                return checkThousand(this.item.PAYMENT_POINT);
			           	}
			        },{
			            key : "PAYMENT_COST",
			            label : "결재 금액",
			            width : 80,
			            align : "right",
			            formatter : function () {
			                return checkThousand(this.item.PAYMENT_COST);
			           	}
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
	            key : "CATEGORY_NAME",
	            label : "카테고리",
	            width : 150,
	            align : "left"
	        },{
	            key : "COURSE_ID",
	            label : "ID",
	            width : 40,
	            align : "right"
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
	        	key : "COMP_CD", 
	        	label : "회사", 
	            width : 100,
	        	align : "center", 
	        	editor: {
	                type : "select", 
	                config : {
	                    columnKeys: { optionValue: "value", optionText: "text" },
	                    options: dd.Company
	                },
	            	disabled : function () {
	                    return true;
	                }
	        	},
	            formatter : function () {
	                return gfn_getValueInList(dd.Company, "value",  this.item.COMP_CD, "text");
	           	}
	        },{
              	key : undefined, 
              	label: "환불", 
              	columns: [	 
              		{
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
		                },
			            formatter : function () {
			                return checkThousand(this.item.REFUND_COST);
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
	  		multipleSelect: true,
	  		frozenColumnIndex : 5,
	  		mergeCells : ["APPROVAL_ID"]
	  	}
	);
	
	$(window).trigger("resize"); 
} 

function fn_params() {
	params.FROM_DT = $("#FROM_DT").val();	
	params.TO_DT = $("#TO_DT").val();	
	params.USER = $("#USER").val();
	params.CB_SEARCH_STATUS = $("#CB_SEARCH_STATUS option:selected").val();
	params.LEVEL1_CODE = $("#CB_LEVEL1 option:selected").val();	
	params.LEVEL2_CODE = $("#CB_LEVEL2 option:selected").val();	
	params.LEVEL3_CODE = $("#CB_LEVEL3 option:selected").val();	
	params.YEAR = $("#CB_YEAR option:selected").val();	
	params.MONTH = $("#CB_MONTH option:selected").val();	
	params.chasu = $("#chasu").val();	
	params.courseName = $("#courseName").val();	
	params.COMPANY = $("#CB_COMPANY option:selected").val();	
	params.COMPANY2 = $("#CB_COMPANY2 option:selected").val();	
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

		
		gfn_cbRefresh("CB_COMPANY", data.CompanyKind, true);
		gfn_cbRefresh("CB_SEARCH_STATUS", data.ApprovalStatus, true);
		gfn_cbRefresh("CB_LEVEL1", data.CategoryLevel1, true);
		gfn_cbRefresh("CB_YEAR", data.Year, true);
		
		fn_makeGrid();
		//fn_search();
	} else if ( id == "CB_LEVEL1" ){
		gfn_cbRefresh("CB_LEVEL2", data.CategoryLevel2, true);
	} else if ( id == "CB_LEVEL2" ){
		gfn_cbRefresh("CB_LEVEL3", data.CategoryLevel3, true);
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

function fn_cbChange(id) {
	if ( id == "CB_LEVEL1" ) {
	    gfn_callAjax("/common/axDd.do", { DD_KIND : "CategoryLevel2", LEVEL1_CODE : $("#CB_LEVEL1 option:selected").val()}, fn_callbackAjax, "CB_LEVEL1", { async : false });
	} else  if ( id == "CB_LEVEL2" ) {
	    gfn_callAjax("/common/axDd.do", { DD_KIND : "CategoryLevel3", LEVEL2_CODE : $("#CB_LEVEL2 option:selected").val()}, fn_callbackAjax, "CB_LEVEL2", { async : false });
	} else if ( id == "CB_COMPANY" ) {
		if ( $("#CB_COMPANY").val() == "B2B" ) {
			gfn_cbRefresh("CB_COMPANY2", dd.Company1, true);
		} else if ( $("#CB_COMPANY").val() == "C2C" ) {
			gfn_cbRefresh("CB_COMPANY2", dd.Company2, true);
		} else {
			gfn_cbRefresh("CB_COMPANY2", null, true);
		}
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

<h2>은행 입금 관리</h2>
<div style="height:10px"></div>

<div class="form-inline">
  	<div class="form-group">
    	<label for="CB_LEVEL1">카테고리</label>
		<select class="form-control" id="CB_LEVEL1" onchange="fn_cbChange('CB_LEVEL1')">
			<option value="">전체</option>
		</select>
		<select class="form-control" id="CB_LEVEL2" onchange="fn_cbChange('CB_LEVEL2')">
			<option value="">전체</option>
		</select>
		<select class="form-control" id="CB_LEVEL3">
			<option value="">전체</option>
		</select>
  	</div>
  	<div class="form-group">
    	<label for="CB_YEAR">&nbsp;년도</label>
		<select class="form-control" id="CB_YEAR">
			<option value="">전체</option>
		</select>
  	</div>
  	<div class="form-group">
    	<label for="CB_MONTH">&nbsp;월</label>
		<select class="form-control" id="CB_MONTH">
			<option value="">전체</option>
<c:forEach var="i" begin="1" end="12" step="1" varStatus ="status">
<c:if test="${i < 10}">
               <option value="0${i}">${i}</option>
</c:if>     
<c:if test="${i >= 10}">
               <option value="${i}">${i}</option>
</c:if>     
</c:forEach>    
		</select>
  	</div>
  	<div class="form-group">
    	<label for="chasu">&nbsp;차수</label>
    	<input type="text" class="form-control" id="chasu" name="chasu" style="width:60px;">
  	</div>
  	<div class="form-group">
    	<label for="courseName">&nbsp;과정명</label>
    	<input type="text" class="form-control" id="courseName" name="courseName">
  	</div>
</div>
<div style="height:10px"></div>
<div class="form-inline">
  	<div class="form-group">
    	<label for="CB_SEARCH_STATUS">&nbsp;신청상태</label>
		<select class="form-control" id="CB_SEARCH_STATUS">
		</select>
  	</div>
  	<div class="form-group">
    	<label for="courseName">&nbsp;일자</label>
	   	<input id="FROM_DT" name="FROM_DT" maxlength="10" size="10" class="form-control datePicker" value="" readonly/> ~ 
		<input id="TO_DT" name="TO_DT" maxlength="10" size="10" class="form-control datePicker" value="" readonly/>
  	</div>
  	<div class="form-group">
    	<label for="courseName">&nbsp;신청자</label>
    	<input type="text" class="form-control" id="USER" name="USER" style="width:100px;">
  	</div>
  	<div class="form-group">
    	<label for="CB_COMPANY">&nbsp;회사 구분</label>
		<select class="form-control" id="CB_COMPANY" onchange="fn_cbChange('CB_COMPANY')">
			<option value="">전체</option>
		</select>
		<select class="form-control" id="CB_COMPANY2">
			<option value="">전체</option>
		</select>
  	</div>
</div>

<div style="height:10px"></div>

<div>
    <button class="btn btn-default" data-grid-control="search">검색</button>
    <button class="btn btn-default" data-grid-control="bankConfirm">은행 입금 승인</button>
    <button class="btn btn-default" data-grid-control="approvalToBank">은행 입금 승인 취소</button>
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

