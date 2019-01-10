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

$(document.body).ready(function () {
	$( window ).resize( function() {
		gfn_gridResize("grid-parent", grid);  
	} );
	
    confirmDialog.setConfig({
        theme: "danger"
    });
    
	grid = gfn_makeAx5Grid("first-grid",
		[ 	{
	            key : "POINT_CODE",
	            label : "포인트 코드",
	            width : 160,
	            align : "left",
	            editor : { 
	            	type : "text",
	            	disabled : function () {
                        return ( this.item.NEW_FLAG != "Y" ? true : false );
                    },
                    attributes : {
                        "maxlength" : 3,
                        "data-maxlength" : 3
                    }
				},
				styleClass: function () {
                    return (this.item.NEW_FLAG === "Y") ? "grid-cell-edit" : "";
                }
	        },{
	        	key : "POINT_NAME", 
	        	label : "포인트 코드명", 
	            width : 200,
	        	align : "left", 
	        	editor : { type : "text"},
				styleClass: function () {
                    return "grid-cell-edit";
                } 
	        },{
	        	key : "VALID_MONTH", 
	        	label : "유효개월수", 
	            width : 90,
	        	align : "right", 
	        	editor : { type : "number"},
				styleClass: function () {
                    return "grid-cell-edit";
                }
	        },{
	        	key : "POINT", 
	        	label : "포인트/비율", 
	            width : 90,
	        	align : "right", 
	        	editor : { type : "number"},
				styleClass: function () {
                    return "grid-cell-edit";
                },
	            formatter : function () {
	                return checkThousand(this.item.POINT);
	           	}  
	        },{
	        	key : "ORD", 
	        	label : "정렬", 
	            width : 60,
	        	align : "right", 
	        	editor : { type : "number"},
				styleClass: function () {
                    return "grid-cell-edit";
                }  
	        },{
	            key : "LAST_UPDATE_DATE",
	            label : "수정일자",
	            width : 110,
	            align : "center"
	        }	], 
	  	null,
	  	{
	  		showRowSelector : false
	  	}
	);
	
	$(window).trigger("resize");
	
    $('[data-grid-control]').click(function () {
        switch (this.getAttribute("data-grid-control")) {
	        case "search":
	            fn_search();
	            break;
            case "add":
            	grid.addRow({NEW_FLAG : "Y", POINT_CODE : "", POINT_NAME : "코드명을 입력하세요.", VALID_MONTH : "0", POINT : "0"}, "last", {focus: "END"});
                break;
            case "delete":
                grid.deleteRow("selected");
                break;
            case "reset":
            	fn_search();
                break;
            case "save" :
            	fn_save();
                break;
            case "export":
                grid.exportExcel("포인트코드관리.xls");
                break;
        }
    });
    
    //fn_search();
});

function fn_search() {
	//mask.open();
	
	gfn_callAjax("/point/axPointCodeList.do", {}, fn_callbackAjax, "search");
}

function fn_save() {
	var fieldParams = {
		DUP_FIELDS : "POINT_CODE",	
		POINT_CODE : { mendatory : true, colName : "포인트 코드" },
		POINT_NAME : { mendatory : true, colName : "포인트 코드명" }
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
             		gfn_callAjax("/point/axPointCodeSave.do", gfn_getSaveData(grid), fn_callbackAjax, "save");
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
		if ( data.RtnMode == "DUPLICATION" ) {
			mask.open();
			dialog.alert( { msg : "이미 등록된 데이타가 있습니다." }, function () { mask.close(); } );
		} else {
			mask.open();
			dialog.alert( { msg : "저장 되었습니다." }, function () { mask.close();	fn_search(); } );
		}
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

<h2>포인트 코드 관리</h2>
<div style="height:10px"></div>

<div>
    <button class="btn btn-default" data-grid-control="search">검색</button>
    <button class="btn btn-default" data-grid-control="add">추가</button>
    <button class="btn btn-default" data-grid-control="delete">삭제</button>
    <button class="btn btn-default" data-grid-control="save">저장</button>
    <button class="btn btn-default" data-grid-control="export">엑셀</button>
</div>

<div style="height:10px"></div>


<div style="position: relative;height:400px;" id="grid-parent">
    <div data-ax5grid="first-grid" style="height: 100%;"></div>
</div>


</form>
	

</body>
</html>

