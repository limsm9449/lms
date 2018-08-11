<%@ page contentType="text/html;charset=utf-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="ko" xml:lang="ko">
<head>
<meta http-equiv="X-UA-Compatible" content="IE=8,chrome=1"/>
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

$(document.body).ready(function () {
	$( window ).resize( function() {
		gfn_gridResize("grid-parent", grid);
	} );
	
    confirmDialog.setConfig({
        theme: "danger"
    });

	grid = gfn_makeAx5Grid("first-grid",
		[ 	{
	            key : "NEW_FLAG",
	            width : 0
	        },{
	            key : "LEVEL1_CODE",
	            label : "대분류 코드",
	            width : 120,
	            align : "center"
	        },{
	        	key : "LEVEL1_NAME", 
	        	label : "대분류 코드명", 
	            width : 200,
	        	align : "left"
	        },{
	            key : "CODE",
	            label : "중분류 코드",
	            width : 120,
	            align : "center",
	            editor : { 
	            	type : "text",
	            	disabled : function () {
                        return ( this.item.NEW_FLAG != "Y" ? true : false );
                    },
                    attributes : {
                        "maxlength" : 5,
                        "data-maxlength" : 5
                    }
				},
				styleClass: function () {
                    return (this.item.NEW_FLAG === "Y") ? "grid-cell-edit" : "";
                }
	        },{
	        	key : "CODE_NAME", 
	        	label : "중분류 코드명", 
	            width : 200,
	        	align : "left", 
	        	editor : { type : "text"} ,
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
	
	$(window).trigger("resize");
	
    $('[data-grid-control]').click(function () {
        switch (this.getAttribute("data-grid-control")) {
		    case "search":
		        fn_search();
		        break;
		    case "add":
		    	gfn_showPopupDiv("categoryDiv");

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
		        grid.exportExcel("CategoryLevel2.xls");
		        break;
        }
    });
    
    gfn_callAjax("/common/axDd.do", { DD_KIND : "CategoryLevel1" }, fn_callbackAjax, "dd", { async : false });
    
    fn_search();
});


function fn_hidePopupDiv(popupDivId) {
	gfn_hidePopupDiv(popupDivId);
	
	if ( $("#INS_CB_LEVEL1 option:selected").val() == "" ) {
		mask.open();
		dialog.alert( { msg : "대분류를 선택하셔야 합니다." }, function () { mask.close(); } );
	} else {
		grid.addRow( 
			{
				NEW_FLAG : "Y", 
				CODE : $("#INS_CB_LEVEL1 option:selected").val() + "**", 
				CODE_NAME : "코드명을 입력하세요.", 
				USE_YN : "Y", 
				LEVEL1_CODE : $("#INS_CB_LEVEL1 option:selected").val(), 
				LEVEL1_NAME : $("#INS_CB_LEVEL1 option:selected").text()
			}, "last", {focus: "END"});
	}
}

function fn_params() {
	params.LEVEL1_CODE = $("#CB_LEVEL1 option:selected").val();	
}

function fn_search() {
	//mask.open();
	fn_params();
	
	gfn_callAjax("/category/axCategoryLevel2List.do", params, fn_callbackAjax, "search");
}

function fn_save() {
	var fieldParams = {
			DUP_FIELDS : "CODE",	
   		CODE : { mendatory : true, length : 5, colName : "중분류 코드" },
   		CODE_NAME : { mendatory : true, colName : "중분류 코드명" }
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
             		gfn_callAjax("/category/axCategoryLevel2Save.do", gfn_getSaveData(grid), fn_callbackAjax, "save");
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
	} else if ( id == "dd" ){
		gfn_cbRefresh("CB_LEVEL1", data.CategoryLevel1, true);
		
		gfn_cbRefresh("INS_CB_LEVEL1", data.CategoryLevel1, true);
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

function gfn_cbRefresh(id, options, isAll) {
	console.log(options);
	
	$("#" + id).find("option").remove();
	
	if ( isAll ) {
		$("#" + id).append("<option value=''>전체</option>")
	}
	for ( var i = 0; i < options.length; i++ ) {
		$("#" + id).append("<option value='" + options[i].value + "'>" + options[i].text + "</option>")
	}

	$("#" + id + "option:eq(0)").attr("selected", "selected");
}
</script>

<body style="padding : 10px">

<form id="frm" name="frm" method="post">

<h2>중분류 관리</h2>
<div style="height:10px"></div>

<div>
	대분류
	<select id="CB_LEVEL1">
		<option value="">전체</option>
	</select>
</div>

<div style="height:10px"></div>
        
<div>
    <button class="btn btn-default" data-grid-control="search">검색</button>
    <button class="btn btn-default" data-grid-control="add">추가</button>
    <button class="btn btn-default" data-grid-control="delete">삭제</button>
    <button class="btn btn-default" data-grid-control="reset">초기화</button>
    <button class="btn btn-default" data-grid-control="save">저장</button>
    <button class="btn btn-default" data-grid-control="export">엑셀</button>
</div>

<div style="height:10px"></div>

<div style="position: relative;height:400px;" id="grid-parent">
    <div data-ax5grid="first-grid" style="height: 100%;"></div>
</div>

</form>
	

<div class="mask"></div>
<div class="popupDiv" id="categoryDiv" style="width:300px; height:200px;">
	대분류
	<select id="INS_CB_LEVEL1">
	</select>
	
	<div style="height:30px"></div>
    <input type="button" href="#" value="확인" onclick="fn_hidePopupDiv('categoryDiv')"/>
    <input type="button" href="#" value="닫기" onclick="gfn_hidePopupDiv('categoryDiv');"/>
</div>

</body>
</html>

