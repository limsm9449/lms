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
    
    fn_makeGrid();
	fn_search();
	
    $('[data-grid-control]').click(function () {
        switch (this.getAttribute("data-grid-control")) {
            case "save" :
            	fn_save();
                break;
            case "close" :
            	if ( isSave ) {
            		opener.fn_search();
            	}
            	
            	window.close();
                break;
        }
    });
});

function fn_makeGrid() {
	grid = gfn_makeAx5Grid("first-grid",
		[ 	{
	            key : "KIND_NAME",
	            label : "구분",
	            width : 60,
	            align : "center"
	        },{
	            key : "USER_NAME",
	            label : "이름",
	            width : 80,
	            align : "left"
	        },{
	        	key : "COST", 
	        	label : "금액", 
	            width : 120,
	        	align : "right",
	            formatter : function () {
	                return checkThousand(this.item.COST);
	           	}
	        },{
	        	key : "BANK", 
	        	label : "은행", 
	            width : 100, 
	        	align : "left",
	            editor : { 
	            	type : "text"
				},
				styleClass: function () {
                    return "grid-cell-edit";
                }
	        },{
	        	key : "ACC_NUM", 
	        	label : "계좌번호", 
	            width : 200,
	        	align : "left",
	            editor : { 
	            	type : "text"
				},
				styleClass: function () {
                    return "grid-cell-edit";
                }
	        },{
	        	key : "PAYMENT_DATE",
	            label : "지급일",
	            width : 110,
	            align : "center",
	            editor : { 
	            	type : "date"
				},
				styleClass: function () {
                    return "grid-cell-edit";
                }
	        }	], 
	  	null,
	  	{
	  		showRowSelector : false
	  	}
	);
}
KIND
USER_ID
COST






function fn_params() {
	params.COURSE_ID = gfn_getUrlParams("COURSE_ID");
	params.TUTOR_ID = $("#CB_TUTOR option:selected").val();	
}

function fn_search() {
	//mask.open();
	
	fn_params();
	
	gfn_callAjax("/cost/axCostCalcPaymentList.do", params, fn_callbackAjax, "search");
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
             		var saveParams = {
             		};
             		
             		gfn_callAjax("/cost/axCostCalcPaymentSave.do", $.extend(saveParams, gfn_getSaveData(grid)), fn_callbackAjax, "save");
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
		grid.setData(data.list);
	} else if ( id == "save" ){
		mask.close();

		if ( data.RtnMode && data.RtnMode != "OK" ) {
			mask.open();
			dialog.alert( { msg : "저장시 문제가 발생했습니다. (" + data.RtnMode + ")" }, function () { mask.close(); } );
		} else {
			mask.open();
			dialog.alert( { msg : "저장 되었습니다." }, function () { mask.close();	fn_search(); } );
		}
		
		isSave = true;
	}
}

function fn_gridEvent(event, obj) {
	if ( event == "Click" ) {
		obj.self.select(obj.dindex);
	} else if ( event == "DBLClick" ) {
	} else if ( event == "DataChanged" ) {
	}
}

</script>

<body style="padding : 10px">

<form id="frm" name="frm" method="post">

<h2>금액 지급</h2>
<div style="height:10px"></div>

<div>
    <button class="btn btn-default" data-grid-control="save">저장</button>
    <button class="btn btn-default" data-grid-control="close">닫기</button>
</div>

<div style="height:10px"></div>

<div style="position: relative;height:280px;" id="grid-parent"> 
    <div data-ax5grid="first-grid" style="height: 100%;"></div>
</div>


</form>

<div class="mask"></div>

</body>
</html>

