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
    
	grid = gfn_makeAx5Grid("first-grid",
		[ 	{
	        	key : "WEEK", 
	        	label : "차시", 
	            width : 100,
	        	align : "center"
	        },{
	            key : "TITLE",
	            label : "목차",
	            width : 500,
	            align : "left"
	        },{
	        	key : "WEEK_COST", 
	        	label : "차시 비용", 
	            width : 120,
	        	align : "right", 
	        	editor : { 
	        		type : "number"
	        	},
				styleClass: function () {
                    return "grid-cell-edit";
                },
	            formatter : function () {
	                return checkThousand(this.item.WEEK_COST);
	           	}
	        }	], 
	  	null,
	  	{
	  		showRowSelector : false
	  	}
	);
	
    $('[data-grid-control]').click(function () {
        switch (this.getAttribute("data-grid-control")) {
	        case "search":
	            fn_search();
	            break;
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
    
    fn_search();
});

function fn_params() {
	params.COURSE_CODE = gfn_getUrlParams("COURSE_CODE");	
}

function fn_search() {
	//mask.open();
	
	fn_params();
	
	gfn_callAjax("/course/axCourseMasterWeekCostList.do", params, fn_callbackAjax, "search");
}

function fn_save() {
	var fieldParams = {
   		WEEK_COST : { mendatory : true, colName : "비용", type : "number" }
   	};
   	if ( gfn_validationCheck(grid, fieldParams) ) {
   		var courseCost = parseInt(gfn_getUrlParams("COURSE_COST"));	

   		var costSum = 0;
   		var allList = grid.getList();
       	for ( var i = 0; i < allList.length; i++ ) {
       		costSum += parseInt(allList[i].WEEK_COST)
       	}
       	if ( courseCost != costSum ) {
       		mask.open();
			dialog.alert( { msg : "차시비용의 합계는 " + checkThousand(costSum) + " 입니다. <br>총비용은 " + checkThousand(courseCost) + "입니다."}, function () { mask.close(); } );
			return;
       	}
   		
   		mask.open();
       	confirmDialog.confirm(
       		{
               	title: "Confirm",
               	msg: '저장하시겠습니까?'
           	}, 
           	function(){
             	if ( this.key == "ok" ) {
             		gfn_callAjax("/course/axCourseMasterWeekCostSave.do", gfn_getSaveData(grid, true), fn_callbackAjax, "save");
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
		
		//mask.close();
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
	} else if ( event == "DataChanged" ) {
	}
}

</script>

<body style="padding : 10px">

<form id="frm" name="frm" method="post">

<h2>차시별 비용 관리</h2>
<div style="height:10px"></div>

<div>
    <button class="btn btn-default" data-grid-control="save">저장</button>
    <button class="btn btn-default" data-grid-control="close">닫기</button>    
</div>

<div style="height:10px"></div>


<div style="position: relative;height:680px;" id="grid-parent">
    <div data-ax5grid="first-grid" style="height: 100%;"></div>
</div>


</form>
	

</body>
</html>

