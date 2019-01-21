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
	        	label : "주차", 
	            width : 70,
	        	align : "center",
	            editor : { 
	            	type : "number"
				},
				styleClass: function () {
                    return "grid-cell-edit";
                }
	        },{
	        	key : "PAGE", 
	        	label : "페이지", 
	            width : 80,
	        	align : "center",
	            editor : { 
	            	type : "number"
				},
				styleClass: function () {
                    return "grid-cell-edit";
                }
	        },{
	            key : "TITLE",
	            label : "목차",
	            width : 800,
	            align : "left",
	            editor : { 
	            	type : "text"
				},
				styleClass: function () {
                    return "grid-cell-edit";
                }
	        }	], 
	  	null,
	  	{
			showRowSelector : true,
	  		multipleSelect: true
	  	}
	);
	
    $('[data-grid-control]').click(function () {
        switch (this.getAttribute("data-grid-control")) {
	        case "search":
	            fn_search();
	            break;
            case "add":              	
            	grid.addRow({NEW_FLAG : "Y", COURSE_CODE : params.COURSE_CODE, WEEK : 1, PAGE : 1, TITLE : "목차를 입력하세요."}, "last", {focus: "END"});

                break;
            case "delete":
                grid.deleteRow("selected");
	        	
                break;
            case "save" :
            	fn_save();
                break;
            case "up" :
            	var all = grid.getList();
            	var row = grid.getList("selected");
            	if ( row.length == 0 ) {
            		mask.open();
            		dialog.alert( { msg : "항목을 선택하셔야 합니다." }, function () { mask.close();	} );
            	} else {
                	var rowIdx = row[0]["__index"];

                	if ( rowIdx > 0 ) {
                		grid.setValue(rowIdx, "WEEK", all[rowIdx - 1].WEEK);
                		grid.setValue(rowIdx, "PAGE", all[rowIdx - 1].PAGE);
                		grid.setValue(rowIdx, "TITLE", all[rowIdx - 1].TITLE);
                		grid.setValue(rowIdx, "NEW_FLAG", all[rowIdx - 1].NEW_FLAG);

                		grid.setValue(rowIdx - 1, "WEEK", row[0].WEEK);
                		grid.setValue(rowIdx - 1, "PAGE", row[0].PAGE);
                		grid.setValue(rowIdx - 1, "TITLE", row[0].TITLE);
                		grid.setValue(rowIdx - 1, "NEW_FLAG", row[0].NEW_FLAG);
                		
                		grid.select(rowIdx - 1);
                	}
            	}
	            
                break;
            case "down" :
            	var all = grid.getList();
            	var row = grid.getList("selected");
            	if ( row.length == 0 ) {
            		mask.open();
            		dialog.alert( { msg : "항목을 선택하셔야 합니다." }, function () { mask.close();	} );
            	} else {
                	var rowIdx = row[0]["__index"];

                	if ( rowIdx < all.length - 1 ) {
                		grid.setValue(rowIdx, "WEEK", all[rowIdx + 1].WEEK);
                		grid.setValue(rowIdx, "PAGE", all[rowIdx + 1].PAGE);
                		grid.setValue(rowIdx, "TITLE", all[rowIdx + 1].TITLE);
                		grid.setValue(rowIdx, "NEW_FLAG", all[rowIdx + 1].NEW_FLAG);

                		grid.setValue(rowIdx + 1, "TITLE", row[0].TITLE);
                		grid.setValue(rowIdx + 1, "PAGE", row[0].PAGE);
                		grid.setValue(rowIdx + 1, "TITLE", row[0].TITLE);
                		grid.setValue(rowIdx + 1, "NEW_FLAG", row[0].NEW_FLAG);
                		
                		grid.select(rowIdx + 1);
                	}
            	}

            	break;
            case "close" :
            	if ( isSave ) {
            		opener.fn_search();
            	}
            	
            	window.close();
                break;
            case "export":
                grid.exportExcel("과정 주차별 페이지 관리.xls");
                break;
            case "import":
            	var urlParams = "page=/ax/common/axExcelUpload";
        		urlParams += "&SCREEN=CourseResourcePage&COURSE_CODE=" + gfn_getUrlParams("COURSE_CODE");
        		
        		f_popup('/common/axOpenPage', {displayName:'excelUploadPopup',option:'width=600,height=500', urlParams:urlParams});
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
	
	gfn_callAjax("/course/axCourseResourcePageList.do", params, fn_callbackAjax, "search");
}

function fn_save() {
	var fieldParams = {
		DUP_FIELDS : "WEEK,PAGE",	
		TITLE : { mendatory : true, colName : "목차" },
		WEEK : { mendatory : true, colName : "주차", type : "number" },
   		PAGE : { mendatory : true, colName : "페이지", type : "number" }
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
             		gfn_callAjax("/course/axCourseResourcePageSave.do", $.extend(gfn_getSaveData(grid, true), {COURSE_CODE : params.COURSE_CODE}), fn_callbackAjax, "save");
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
      	var allList = grid.getList();
      	var maxSeq = 0;
      	for ( var i = 0; i < allList.length; i++ ) {
			if ( parseInt(allList[i].SEQ) > maxSeq ) {
				maxSeq = parseInt(allList[i].SEQ);
			}
      	}

      	for ( var i = 0; i < data.list.length; i++ ) {
       		grid.addRow( 
       			{
       				NEW_FLAG : "Y", 
       				COURSE_CODE : params.COURSE_CODE, 
       				WEEK : data.list[i].WEEK, 
       				PAGE : data.list[i].PAGE, 
       				TITLE : data.list[i].TITLE
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

<h2>과정 주차별 페이지 관리</h2>
<div style="height:10px"></div>

<div>
    <button class="btn btn-default" data-grid-control="add">추가</button>
    <button class="btn btn-default" data-grid-control="delete">삭제</button>
    <button class="btn btn-default" data-grid-control="save">저장</button>
    <button class="btn btn-default" data-grid-control="up">Up</button>
    <button class="btn btn-default" data-grid-control="down">Down</button>
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

