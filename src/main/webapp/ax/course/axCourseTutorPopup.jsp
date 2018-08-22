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
var dd = {};

$(document.body).ready(function () {
    confirmDialog.setConfig({
        theme: "danger"
    });
    
    gfn_callAjax("/common/axDd.do", { DD_KIND : "Tutor" }, fn_callbackAjax, "dd", { async : false });


    $('[data-grid-control]').click(function () {
        switch (this.getAttribute("data-grid-control")) {
	        case "search":
	            fn_search();
	            break;
	            
            case "add":
               	var allList = grid.getList();
               	
            	grid.addRow({NEW_FLAG : "Y", COURSE_ID : params.COURSE_ID, FROM_CNT : (allList.length + 1) * 100 + 1, TO_CNT : (allList.length + 2) * 100, USE_YN : "Y"}, "last", {focus: "END"});
                break;
            case "delete": 
                grid.deleteRow("selected");
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
});

function fn_makeGrid() {
    grid = gfn_makeAx5Grid("first-grid",
   		[ 	{
   	        	key : "TUTOR_ID", 
   	        	label : "튜터", 
   	            width : 100,
   	        	align : "center", 
   	        	editor: {
   	                type : "select", 
   	                config : {
   	                    columnKeys: { optionValue: "value", optionText: "text" },
   	                    options: dd.Tutor
   	                },
	            	disabled : function () {
                        return ( this.item.NEW_FLAG == "Y" ? false : true );
                    }
   	        	},
   	            formatter : function () {
   	                return gfn_getValueInList(dd.Tutor, "value",  this.item.TUTOR_ID, "text");
   	           	},
   				styleClass: function () {
   	                return ( this.item.NEW_FLAG == "Y" ? "grid-cell-edit" : "" );
   	            }
   	        },{
   	            key : "FROM_CNT",
   	            label : "시작 인원수",
   	            width : 120,
   	            align : "right",
   	            editor : { 
   	            	type : "number"
   				},
   				styleClass: function () {
                       return "grid-cell-edit";
                   }
   	        },{
   	        	key : "TO_CNT", 
   	        	label : "종료 인원수", 
   	            width : 120,
   	        	align : "right", 
   	        	editor : { 
   	        		type : "number"
   	        	},
   				styleClass: function () {
                       return "grid-cell-edit";
                   }
   	     	},{
	        	key : "USE_YN", 
	        	label : "사용 여부", 
	            width : 90,
	        	align : "center", 
	        	editor : { type : "checkbox", config : {height: 17, trueValue: "Y", falseValue: "N"} } ,
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

function fn_params() {
	params.COURSE_ID = gfn_getUrlParams("COURSE_ID");	
}

function fn_search() {
	//mask.open();
	
	fn_params();
	
	gfn_callAjax("/course/axCourseTutorList.do", params, fn_callbackAjax, "search");
}

function fn_save() {
	var fieldParams = {
		TUTOR_ID : { mendatory : true, colName : "튜터" },
   		FROM_CNT : { mendatory : true, colName : "시작 인원수", type : "number" },
   		TO_CNT : { mendatory : true, colName : "종료 인원수", type : "number" }
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
             		gfn_callAjax("/course/axCourseTutorSave.do", gfn_getSaveData(grid), fn_callbackAjax, "save");
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
	} else if ( id == "dd" ){
		dd = $.extend({}, data);
		
		fn_makeGrid();
		fn_search();
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

<h2>과정별 튜터</h2>
<div style="height:10px"></div>

<div>
    <button class="btn btn-default" data-grid-control="add">추가</button>
    <button class="btn btn-default" data-grid-control="delete">삭제</button>
    <button class="btn btn-default" data-grid-control="save">저장</button>
    <button class="btn btn-default" data-grid-control="close">닫기</button>
</div>

<div style="height:10px"></div>


<div style="position: relative;height:210px;" id="grid-parent"> 
    <div data-ax5grid="first-grid" style="height: 100%;"></div>
</div>


</form>
	

</body>
</html>

