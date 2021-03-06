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
	        	key : "AUTH_KEY", 
	        	label : "인증키", 
	            width : 120,
	        	align : "left",
	            editor : { 
	            	type : "text",
	            	disabled : function () {
	                    return ( this.item.NEW_YN == "Y" ? true : false );
	                }
				},
				styleClass: function () {
                    return "grid-cell-edit";
                }
	        },{
	            key : "INFO1",
	            label : "Info 1",
	            width : 150,
	            align : "left",
	            editor : { 
	            	type : "text"
				},
				styleClass: function () {
                    return "grid-cell-edit";
                }
	        },{
	        	key : "INFO2", 
	            label : "Info 2",
	            width : 150,
	        	align : "left", 
	        	editor : { 
	        		type : "text"
	        	},
				styleClass: function () {
                    return "grid-cell-edit";
                }
	        },{
	        	key : "INFO3", 
	            label : "Info 3",
	            width : 150,
	        	align : "left", 
	        	editor : { 
	        		type : "text"
	        	},
				styleClass: function () {
                    return "grid-cell-edit";
                }
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
	  		showRowSelector : false
	  	}
	);
	
    $('[data-grid-control]').click(function () {
        switch (this.getAttribute("data-grid-control")) {
	        case "search":
	            fn_search();
	            break;
            case "add":              	
            	grid.addRow({NEW_FLAG : "Y"}, "last", {focus: "END"});

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
            case "export":
                grid.exportExcel("인증키 관리.xls");
                break;
            case "import":
            	var urlParams = "page=/ax/common/axExcelUpload";
        		urlParams += "&SCREEN=CompanyAuth";
        		
        		f_popup('/common/axOpenPage', {displayName:'excelUploadPopup',option:'width=600,height=500', urlParams:urlParams});
                break;
        }
    });
    
    fn_search();
});

function fn_params() {
	params.COMP_CD = gfn_getUrlParams("COMP_CD");	
}

function fn_search() {
	//mask.open();
	
	fn_params();
	
	gfn_callAjax("/account/axCompanyAuthList.do", params, fn_callbackAjax, "search");
}

function fn_save() {
	var fieldParams = {
		AUTH_KEY : { mendatory : true, colName : "인증키" }
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
             		gfn_callAjax("/account/axCompanyAuthSave.do", $.extend(gfn_getSaveData(grid, false), {COMP_CD : params.COMP_CD}), fn_callbackAjax, "save");
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
	} else if ( id == "excelUploadList" ){
      	for ( var i = 0; i < data.list.length; i++ ) {
       		grid.addRow( 
       			{
       				NEW_FLAG : "Y", 
       				COMP_CD : params.COMP_CD, 
       				AUTH_KEY : data.list[i].AUTH_KEY, 
       				INFO1 : data.list[i].INFO1, 
       				INFO2 : data.list[i].INFO2, 
       				INFO3 : data.list[i].INFO3 
       			}, "last", {focus: "END"});
		}
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

<h2>회사 인증키 관리</h2>
<div style="height:10px"></div>

<div>
    <button class="btn btn-default" data-grid-control="add">추가</button>
    <button class="btn btn-default" data-grid-control="delete">삭제</button>
    <button class="btn btn-default" data-grid-control="save">저장</button>
    <button class="btn btn-default" data-grid-control="close">닫기</button>    
    <button class="btn btn-default" data-grid-control="export">엑셀</button>
    <button class="btn btn-default" data-grid-control="import">엑셀 업로드</button>
</div>

<div style="height:10px"></div>


<div style="position: relative;height:680px;" id="grid-parent">
    <div data-ax5grid="first-grid" style="height: 100%;"></div>
</div>


</form>
	

</body>
</html>

