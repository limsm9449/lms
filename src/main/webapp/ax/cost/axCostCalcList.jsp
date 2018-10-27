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

    confirmDialog.setConfig({
        theme: "danger"
    });

    gfn_callAjax("/common/axDd.do", { DD_KIND : "CategoryLevel1,Year"}, fn_callbackAjax, "dd", { async : false });
    
    $('[data-grid-control]').click(function () {
        switch (this.getAttribute("data-grid-control")) {
	        case "search":
	            fn_search();
	            break;
	        case "tutorConfirm":
	        	var row = grid.getList("selected");
            	if ( row.length == 0 ) {
            		mask.open();
            		dialog.alert( { msg : "과정을 선택하셔야 합니다." }, function () { mask.close();	} );
            	} else {
            		var urlParams = "page=/ax/cost/axCostCalcTutorBoardPopup";
            		urlParams += "&COURSE_ID=" + row[0]["COURSE_ID"];
            		
            		f_popup('/common/axOpenPage', {displayName:'popup',option:'width=1000,height=820', urlParams:urlParams});
            	}
	        	
	            break;
	        case "calc":
	        	var row = grid.getList("selected");
	        	if ( row.length == 0 ) {
	        		mask.open();
            		dialog.alert( { msg : "과정을 선택하셔야 합니다." }, function () { mask.close();	} );
            		return;
            	} else if ( parseInt(row[0]["TUTOR_PAYMENT_CNT"]) > 0 || row[0]["TEACHER_PAYMENT_YN"] == "Y" || row[0]["CP_PAYMENT_YN"] == "Y") {
	        		mask.open(); 
            		dialog.alert( { msg : "배분 금액이 지급되어서 배분금액을 계산할 수 없습니다." }, function () { mask.close();	} );
            		return;
            	}
	        	
	        	mask.open();
	           	confirmDialog.confirm(
	           		{
	                   	title: "Confirm",
	                   	msg: '배분 금액을 계산하시겠습니까?'
	               	}, 
	               	function(){
	               		var saveParams = { COURSE_ID : row[0]["COURSE_ID"] };
	                 	if ( this.key == "ok" ) {
	                 		gfn_callAjax("/cost/axCostCalcUserSave.do", saveParams, fn_callbackAjax, "calcSave");
	                   	} else {
	                   		mask.close();
	                   	}
	               	}
	           	);
	        	
	            break;
	        case "payment":
	        	var row = grid.getList("selected");
            	if ( row.length == 0 ) {
            		mask.open(); 
            		dialog.alert( { msg : "과정을 선택하셔야 합니다." }, function () { mask.close();	} );
            	} else {
            		var urlParams = "page=/ax/cost/axCostCalcPaymentPopup";
            		urlParams += "&COURSE_ID=" + row[0]["COURSE_ID"];
            		
            		f_popup('/common/axOpenPage', {displayName:'popup',option:'width=750,height=420', urlParams:urlParams});
            	}
	        	
	            break;
            case "save" :
            	fn_save();
                break;
            case "export":
                grid.exportExcel("정산관리.xls");
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
	            key : "USER_CNT",
	            label : "수강생",
	            width : 70,
	            align : "right"
	        },{
              	key : undefined, 
              	label: "정산 비용", 
              	columns: [	        
			        {
			        	key : "CP_COST_RATE",
			            label : "CP 비용 비율(%)",
			            width : 130,
			            align : "right",
			            editor : { 
			            	type : "number",
			            	disabled : function () {
		                        return ( !fn_edit(this.item) || this.item.CP_YN != "Y" ? true : false ); 
		                    }
						},
						styleClass: function () {
		                    return ( fn_edit(this.item) && this.item.CP_YN == "Y" ? "grid-cell-edit" : "");
		                }
			        },{
			            key : "TEACHER_COST_RATE",
			            label : "강사 비용 비율(%)",
			            width : 130,
			            align : "right",
			            editor : { 
			            	type : "number",
			            	disabled : function () {
		                        return ( !fn_edit(this.item) || this.item.TEACHER_YN != "Y" ? true : false );
		                    }
						},
						styleClass: function () {
		                    return (fn_edit(this.item) && this.item.TEACHER_YN == "Y" ? "grid-cell-edit" : "");
		                }
			        },{
			            key : "REPORT_COST",
			            label : "레포트 비용",
			            width : 100,
			            align : "right",
			            editor : { 
			            	type : "number",
			            	disabled : function () {
		                        return ( !fn_edit(this.item) ? true : false ); 
		                    }
						},
						styleClass: function () {
		                    return (fn_edit(this.item) ? "grid-cell-edit" : "");
		                },
			            formatter : function () {
			                return checkThousand(this.item.REPORT_COST);
			           	}
			        },{
			            key : "EVAL_COST",
			            label : "평가비용",
			            width : 80,
			            align : "right",
			            editor : { 
			            	type : "number",
			            	disabled : function () {
		                        return ( !fn_edit(this.item) ? true : false ); 
		                    }
						},
						styleClass: function () {
		                    return (fn_edit(this.item) ? "grid-cell-edit" : "");
		                },
			            formatter : function () {
			                return checkThousand(this.item.EVAL_COST);
			           	}
			        },{
			            key : "DATA_COST",
			            label : "자료실 건당 비용",
			            width : 120,
			            align : "right",
			            editor : { 
			            	type : "number",
			            	disabled : function () {
		                        return ( !fn_edit(this.item) ? true : false ); 
		                    }
						},
						styleClass: function () {
		                    return (fn_edit(this.item) ? "grid-cell-edit" : "");
		                },
			            formatter : function () {
			                return checkThousand(this.item.DATA_COST);
			           	}
			        },{
			            key : "ANSWER_COST",
			            label : "답변 건당 비용",
			            width :100,
			            align : "right",
			            editor : { 
			            	type : "number",
			            	disabled : function () {
		                        return ( !fn_edit(this.item) ? true : false ); 
		                    }
						},
						styleClass: function () {
		                    return (fn_edit(this.item) ? "grid-cell-edit" : "");
		                },
			            formatter : function () {
			                return checkThousand(this.item.ANSWER_COST);
			           	}
			        }
		        ]
	        },{
              	key : undefined, 
              	label: "배분 금액", 
              	columns: [	        
			        {
			        	key : "TOTAL_COST",
			            label : "전체 비용",
			            width : 90,
			            align : "right",
			            formatter : function () {
			            	return checkThousand(this.item.TOTAL_COST);
			           	}
			        },{
			        	key : "TUTOR_COST",
			            label : "튜터 비용",
			            width : 90,
			            align : "right",
			            formatter : function () {
			            	return checkThousand(this.item.TUTOR_COST);
			           	}
			        },{
			        	key : "TEACHER_COST",
			            label : "강사 비용",
			            width : 90,
			            align : "right",
			            formatter : function () {
			            	return checkThousand(this.item.TEACHER_COST);
			           	}
			        },{
			        	key : "CP_COST",
			            label : "CP 비용",
			            width : 90,
			            align : "right",
			            formatter : function () {
			            	return checkThousand(this.item.CP_COST);
			           	}
			        },{
			        	key : "COMPANY_COST",
			            label : "회사 비용",
			            width : 90,
			            align : "right",
			            formatter : function () {
			            	return checkThousand(this.item.COMPANY_COST);
			           	}
			        }
		        ]
	        },{
	        	key : undefined, 
              	label: "지급여부", 
              	columns: [	        
			        {
			        	key : "TUTOR_CNT",
			            label : "튜터 인원수",
			            width : 100,
			            align : "right"
			        },{
			        	key : "TUTOR_PAYMENT_CNT",
			            label : "튜터 지급 인원수",
			            width : 150,
			            align : "right"
			        },{
			        	key : "TEACHER_PAYMENT_YN",
			            label : "강사",
			            width : 70,
			            align : "center"
			        },{
			        	key : "CP_PAYMENT_YN",
			            label : "CP",
			            width : 70,
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
			showRowSelector : false,
	  		frozenColumnIndex : 6 
	  	}
	);
	
	$(window).trigger("resize"); 
} 

function fn_edit(item) {
	if ( parseInt(item.TUTOR_PAYMENT_CNT) > 0 || item.TEACHER_PAYMENT_YN == "Y" || item.CP_PAYMENT_YN == "Y" ) {
		return false;
	}
	
	return true;
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
	
	gfn_callAjax("/cost/axCostCalcList.do", params, fn_callbackAjax, "search");
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
             		gfn_callAjax("/cost/axCostCalcSave.do", gfn_getSaveData(grid), fn_callbackAjax, "save");
               	} else {
               		mask.close();
               	}
           	}
       	);
   	}
}

function fn_callbackAjax(data, id) {
	if ( data.RtnMode == "ERROR" ) {
		mask.open();
		dialog.alert( { msg : "처리시 오류가 발생했습니다. 관리자에게 문의하세요." }, function () { mask.close();	fn_search(); } );
		return;
	}
	
	if ( id == "search" ) {
		list = data.list;
		grid.setData(data.list);
		
		//mask.close();
	} else if ( id == "dd" ){
		dd = $.extend({}, data);

		
		gfn_cbRefresh("CB_LEVEL1", data.CategoryLevel1, true);
		gfn_cbRefresh("CB_YEAR", data.Year, true);
		
		fn_makeGrid();
		fn_search();
	} else if ( id == "CB_LEVEL1" ){
		gfn_cbRefresh("CB_LEVEL2", data.CategoryLevel2, true);
	} else if ( id == "CB_LEVEL2" ){
		gfn_cbRefresh("CB_LEVEL3", data.CategoryLevel3, true);
	} else if ( id == "save" ){
		mask.close();

		mask.open();
		dialog.alert( { msg : "저장 되었습니다." }, function () { mask.close();	fn_search(); } );
	} else if ( id == "calcSave" ){
		mask.close();

		mask.open();
		dialog.alert( { msg : "배분 금액이 계산되었습니다." }, function () { mask.close();	fn_search(); } );
	} 
}

function fn_gridEvent(event, obj) {
	if ( event == "Click" ) {
		obj.self.select(obj.dindex);
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

<h2>정산 관리</h2>
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
    	<label for="chasu">&nbsp;차수</label>
    	<input type="text" class="form-control" id="chasu" name="chasu">
  	</div>
  	<div class="form-group">
    	<label for="courseName">&nbsp;과정명</label>
    	<input type="text" class="form-control" id="courseName" name="courseName">
  	</div>
</div>

<div style="height:10px"></div>

<div>
    <button class="btn btn-default" data-grid-control="search">검색</button>
    <button class="btn btn-default" data-grid-control="tutorConfirm">튜터 작업 확인</button>
    <button class="btn btn-default" data-grid-control="calc">배분 금액 계산</button>
    <button class="btn btn-default" data-grid-control="payment">금액 지급</button>
    <button class="btn btn-default" data-grid-control="save">저장</button>
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

