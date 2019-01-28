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
	            width : 70,
	        	align : "center",
				styleClass: function () {
                    return "grid-cell-edit";
                }
	        },{
	            key : "TITLE",
	            label : "목차",
	            width : 500,
	            align : "left",
	            editor : { 
	            	type : "text"
				},
				styleClass: function () {
                    return "grid-cell-edit";
                }
	        },{
	        	key : "DIRECTORY", 
	        	label : "경로", 
	            width : 60,
	        	align : "left", 
	        	editor : { 
	        		type : "text"
	        	},
				styleClass: function () {
                    return "grid-cell-edit";
                }
	        },{
	        	key : "PAGE_CNT", 
	        	label : "페이지", 
	            width : 70,
	        	align : "right", 
	        	editor : { 
	        		type : "number"
	        	},
				styleClass: function () {
                    return "grid-cell-edit";
                }
	        },{
	        	key : "WEEK_TIME", 
	        	label : "학습시간(분)", 
	            width : 100,
	        	align : "right", 
	        	editor : { 
	        		type : "number"
	        	},
				styleClass: function () {
                    return "grid-cell-edit";
                }
	        },{
	        	key : "PREVIEW_PAGE", 
	        	label : "미리보기 페이지", 
	            width : 120,
	        	align : "right", 
	        	editor : { 
	        		type : "number"
	        	},
				styleClass: function () {
                    return "grid-cell-edit";
                }
	        },{
	        	key : "ADD_PAGE_CNT", 
	        	label : "등록 페이지", 
	            width : 100,
	        	align : "right" 
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
            	grid.addRow({NEW_FLAG : "Y", COURSE_CODE : params.COURSE_CODE, TITLE : "목차를 입력하세요.", DIRECTORY : "**", PAGE_CNT : 0, PREVIEW_PAGE : 0, WEEK_TIME : 30}, "last", {focus: "END"});

            	fn_changeWeek();

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
                		grid.setValue(rowIdx, "TITLE", all[rowIdx - 1].TITLE);
                		grid.setValue(rowIdx, "DIRECTORY", all[rowIdx - 1].DIRECTORY);
                		grid.setValue(rowIdx, "PAGE_CNT", all[rowIdx - 1].PAGE_CNT);
                		grid.setValue(rowIdx, "PREVIEW_PAGE", all[rowIdx - 1].PREVIEW_PAGE);
                		grid.setValue(rowIdx, "WEEK_TIME", all[rowIdx - 1].WEEK_TIME);
                		grid.setValue(rowIdx, "NEW_FLAG", all[rowIdx - 1].NEW_FLAG);

                		grid.setValue(rowIdx - 1, "TITLE", row[0].TITLE);
                		grid.setValue(rowIdx - 1, "DIRECTORY", row[0].DIRECTORY);
                		grid.setValue(rowIdx - 1, "PAGE_CNT", row[0].PAGE_CNT);
                		grid.setValue(rowIdx - 1, "PREVIEW_PAGE", row[0].PREVIEW_PAGE);
                		grid.setValue(rowIdx - 1, "WEEK_TIME", row[0].WEEK_TIME);
                		grid.setValue(rowIdx - 1, "NEW_FLAG", row[0].NEW_FLAG);
                		
                		grid.select(rowIdx - 1);

                		fn_changeWeek();
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
                		grid.setValue(rowIdx, "TITLE", all[rowIdx + 1].TITLE);
                		grid.setValue(rowIdx, "DIRECTORY", all[rowIdx + 1].DIRECTORY);
                		grid.setValue(rowIdx, "PAGE_CNT", all[rowIdx + 1].PAGE_CNT);
                		grid.setValue(rowIdx, "PREVIEW_PAGE", all[rowIdx + 1].PREVIEW_PAGE);
                		grid.setValue(rowIdx, "WEEK_TIME", all[rowIdx + 1].WEEK_TIME);
                		grid.setValue(rowIdx, "NEW_FLAG", all[rowIdx + 1].NEW_FLAG);

                		grid.setValue(rowIdx + 1, "TITLE", row[0].TITLE);
                		grid.setValue(rowIdx + 1, "DIRECTORY", row[0].DIRECTORY);
                		grid.setValue(rowIdx + 1, "PAGE_CNT", row[0].PAGE_CNT);
                		grid.setValue(rowIdx + 1, "PREVIEW_PAGE", row[0].PREVIEW_PAGE);
                		grid.setValue(rowIdx + 1, "WEEK_TIME", row[0].WEEK_TIME);
                		grid.setValue(rowIdx + 1, "NEW_FLAG", row[0].NEW_FLAG);
                		
                		grid.select(rowIdx + 1);
                		
                		fn_changeWeek();
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
                grid.exportExcel("과정 차시 관리.xls");
                break;
            case "import":
            	var urlParams = "page=/ax/common/axExcelUpload";
        		urlParams += "&SCREEN=CourseResource&COURSE_CODE=" + gfn_getUrlParams("COURSE_CODE");
        		
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
	
	gfn_callAjax("/course/axCourseResourceList.do", params, fn_callbackAjax, "search");
}

function fn_changeWeek() {
	var all = grid.getList();
	
	for ( var i = 0; i < all.length; i++ ) {
		grid.setValue(i, "WEEK", i + 1);
	} 
}

function fn_save() {
	var fieldParams = {
		TITLE : { mendatory : true, colName : "목차" },
		DIRECTORY : { mendatory : true, colName : "경로" },
   		PAGE_CNT : { mendatory : true, colName : "페이지", type : "number" },
   		PREVIEW_PAGE : { mendatory : true, colName : "미리보기 페이지", type : "number" },
   		WEEK_TIME : { mendatory : true, colName : "학습시간", type : "WEEK_TIME" }
   	};
   	if ( gfn_validationCheck(grid, fieldParams) ) {
       	mask.open();

       	//정렬
       	var allList = grid.getList();
       	for ( var i = 0; i < allList.length; i++ ) {
			grid.setValue(i, "WEEK", i + 1);
       	}
		
       	confirmDialog.confirm(
       		{
               	title: "Confirm",
               	msg: '저장하시겠습니까?'
           	}, 
           	function(){
             	if ( this.key == "ok" ) {
             		gfn_callAjax("/course/axCourseResourceSave.do", $.extend(gfn_getSaveData(grid, true), {COURSE_CODE : params.COURSE_CODE}), fn_callbackAjax, "save");
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
       				TITLE : data.list[i].TITLE, 
       				DIRECTORY : data.list[i].DIRECTORY, 
       				PAGE_CNT : data.list[i].PAGE_CNT,
       				WEEK_TIME : data.list[i].WEEK_TIME,
       				PREVIEW_PAGE : data.list[i].PREVIEW_PAGE
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

<h2>과정 차시 관리</h2>
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

