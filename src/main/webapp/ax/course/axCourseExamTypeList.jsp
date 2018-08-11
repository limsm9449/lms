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

var dd = {};

$(document.body).ready(function () {
	$( window ).resize( function() {
		gfn_gridResize("grid-parent", grid);
	} );
	
    confirmDialog.setConfig({
        theme: "danger"
    });

    gfn_callAjax("/common/axDd.do", { DD_KIND : "CategoryLevel1,Tutor" }, fn_callbackAjax, "dd", { async : false });
    
    $('[data-grid-control]').click(function () {
        switch (this.getAttribute("data-grid-control")) {
	        case "search":
	            fn_search();
	            break;
            case "add":
		    	gfn_cbRemove("INS_CB_COURSE_CODE");
		    	gfn_cbRemove("INS_CB_LEVEL3");
		    	gfn_cbRemove("INS_CB_LEVEL2");
		    	$("#INS_CB_LEVEL1").val("");
		    	
		    	gfn_showPopupDiv("insDiv");

		    	break;
            case "delete":
            	var row = grid.getList("selected");
            	if ( row.length == 0 ) {
            		mask.open();
            		dialog.alert( { msg : "과정을 선택하셔야 합니다." }, function () { mask.close();	} );
            		return;
            	}
            	if ( row[0]["STANDARD_CNT"] > 0 ) {
            		mask.open();
            		dialog.alert( { msg : "유형 기준을 먼저 삭제하셔야 합니다." }, function () { mask.close();	} );
            		return;
            	}
            	
               	grid.deleteRow("selected");
            	
                break;
            case "reset":
            	fn_search();
                break;
            case "save" :
            	fn_save();
                break;
            case "export":
                grid.exportExcel("과정시험유형관리.xls");
                break;
            case "editDetail":
            	var row = grid.getList("selected");
            	if ( row.length == 0 ) {
            		mask.open();
            		dialog.alert( { msg : "과정을 선택하셔야 합니다." }, function () { mask.close();	} );
            	} else if ( row[0]["NEW_FLAG"] == "N" ) {
            		var urlParams = "page=/ax/course/axCourseExamTypeStandardPopupList";
            		urlParams += "&EXAM_TYPE_SEQ=" + row[0]["SEQ"] + "&WEEK_CNT=" + row[0]["WEEK_CNT"] + "&QUESTION_CNT=" + row[0]["QUESTION_CNT"];
            		
            		f_popup('/common/openPage', {displayName:'courseExamTypeStandard',option:'width=900,height=500', urlParams:urlParams});
            	} else {
            		mask.open();
            		dialog.alert( { msg : "신규로 추가한 경우는 저장후에 유형 기준을 편집하셔야 합니다." }, function () { mask.close();	} );
            	}
            		
                break;
        }
    });
});

function fn_makeGrid() {
	grid = gfn_makeAx5Grid("first-grid",
		[ 	{
	            key : "NEW_FLAG",
	            width : 0
	        },{
	            key : "SEQ",
	            width : 0
	        },{
	            key : "CATEGORY_NAME",
	            label : "카테고리",
	            width : 150,
	            align : "left"
	        },{
	            key : "COURSE_CODE",
	            label : "과정코드",
	            width : 90,
	            align : "left"
	        },{
	            key : "COURSE_NAME",
	            label : "과정명",
	            width : 150,
	            align : "left"
	        },{
	            key : "WEEK_CNT",
	            label : "과정 주차",
	            width : 90,
	            align : "right"
	        },{
	        	key : "QUESTION_ALL_CNT", 
	        	label : "과정 문항수", 
	            width : 100,
	        	align : "right"
	        },{
	        	key : "TYPE_NAME", 
	        	label : "유형명", 
	            width : 200,
	        	align : "left", 
	        	editor: {
                    type : "text"
	        	},
				styleClass: function () {
                    return "grid-cell-edit";
                }
	        },{
	        	key : "QUESTION_CNT", 
	        	label : "유형 문항수", 
	            width : 100,
	        	align : "right", 
	        	editor: {
                    type : "number"
	        	},
				styleClass: function () {
                    return "grid-cell-edit";
                }
	        },{
              	key : undefined, 
              	label: "전체시험", 
              	columns: [	
              		{
			        	key : "STANDARD_CNT1", 
			        	label : "기준 갯수", 
			            width : 80,
			        	align : "right"
			        },{
			        	key : "STANDARD_QUESTION_CNT_G1", 
			        	label : "객간식 문항수", 
			            width : 100,
			        	align : "right"
			        },{
			        	key : "STANDARD_QUESTION_CNT_J1", 
			        	label : "주간식 문항수", 
			            width : 100,
			        	align : "right"
			        },{
			        	key : "TOTAL_RATIO", 
			        	label : "비율", 
			            width : 70,
			        	align : "right", 
			        	editor: {
		                    type : "number"
			        	},
						styleClass: function () {
		                    return "grid-cell-edit";
		                }
			        }
			   	]
	        },{
              	key : undefined, 
              	label: "주별시험", 
              	columns: [	
			       	{
			        	key : "STANDARD_CNT2", 
			        	label : "기준 갯수", 
			            width : 80,
			        	align : "right"
			        },{
			        	key : "STANDARD_QUESTION_CNT_G2", 
			        	label : "객간식 문항수", 
			            width : 100,
			        	align : "right"
			        },{
			        	key : "STANDARD_QUESTION_CNT_J2", 
			        	label : "주간식 문항수", 
			            width : 100,
			        	align : "right"
			        },{
			        	key : "WEEK_RATIO", 
			        	label : "비율", 
			            width : 70,
			        	align : "right", 
			        	editor: {
		                    type : "number"
			        	},
						styleClass: function () {
		                    return "grid-cell-edit";
		                }
			        }
	        	]
	        },{
	        	key : "USE_YN", 
	        	label : "사용여부", 
	            width : 80, 
	        	align : "center", 
	        	editor : { type : "checkbox", config : {height: 17, trueValue: "Y", falseValue: "N"} },
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
	
	$(window).trigger("resize");
}

function fn_hidePopupDiv(popupDivId) {
	gfn_hidePopupDiv(popupDivId);
	
	if ( $("#INS_CB_LEVEL1 option:selected").val() == "" || $("#INS_CB_LEVEL2 option:selected").val() == "" || $("#INS_CB_LEVEL3 option:selected").val() == "" ) {
		mask.open();
		dialog.alert( { msg : "대/중/소분류를 선택하셔야 합니다." }, function () { mask.close(); } );
		return;
	} 

	if ( $("#INS_CB_COURSE_CODE option:selected").val() == "" ) {
		mask.open();
		dialog.alert( { msg : "과정을 선택하셔야 합니다." }, function () { mask.close(); } );
		return;
	} 

	grid.addRow( 
		{
			NEW_FLAG : "Y", 
			CATEGORY_NAME : $("#INS_CB_LEVEL1 option:selected").text() + " > " + $("#INS_CB_LEVEL2 option:selected").text() + " > " + $("#INS_CB_LEVEL3 option:selected").text(), 
			COURSE_CODE : $("#INS_CB_COURSE_CODE option:selected").val(), 
			COURSE_NAME : $("#INS_CB_COURSE_CODE option:selected").text(),
			QUESTION_ALL_CNT : gfn_getValueInList(dd.ExamCourseCode, "value",  $("#INS_CB_COURSE_CODE option:selected").val(), "QUESTION_CNT"),
			TYPE_NAME : $("#INS_CB_COURSE_CODE option:selected").text() + " 유형", 
			QUESTION_CNT : 0,
			STANDARD_CNT : 0,
			STANDARD_QUESTION_CNT : 0,
			USE_YN : "Y",
			WEEK_RATIO : 0,
			TOTAL_RATIO : 100
		}, "last", {focus: "END"});
}

function fn_params() {
	params.LEVEL1_CODE = $("#CB_LEVEL1 option:selected").val();	
	params.LEVEL2_CODE = $("#CB_LEVEL2 option:selected").val();	
	params.LEVEL3_CODE = $("#CB_LEVEL3 option:selected").val();	
	params.courseName = $("#courseName").val();	
}

function fn_search() {
	//mask.open();
	
	fn_params();
	
	gfn_callAjax("/course/axCourseExamTypeList.do", params, fn_callbackAjax, "search");
}

function fn_save() {
	var fieldParams = {
		TYPE_NAME : { mendatory : true, colName : "유형명" }
   	};
   	if ( gfn_validationCheck(grid, fieldParams) ) {
       	var allList = grid.getList();
       	for ( var i = 0; i < allList.length; i++ ) {
       		if ( parseInt(allList[i].QUESTION_ALL_CNT) < parseInt(allList[i].QUESTION_CNT) ) {
    			mask.open();
    			dialog.alert( { msg : (i + 1) + "라인의 유형 문항수는 " + allList[i].QUESTION_ALL_CNT + "보다 작아야 합니다." }, function () { mask.close(); } );
    			return false;
           	}
       	}
       	
       	mask.open();
       	confirmDialog.confirm(
       		{
               	title: "Confirm",
               	msg: '저장하시겠습니까?'
           	}, 
           	function(){
             	if ( this.key == "ok" ) {
             		gfn_callAjax("/course/axCourseExamTypeSave.do", gfn_getSaveData(grid), fn_callbackAjax, "save");
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
		dd = $.extend({}, data);
		
		gfn_cbRefresh("CB_LEVEL1", data.CategoryLevel1, true);
		gfn_cbRefresh("INS_CB_LEVEL1", data.CategoryLevel1, true);
		
		fn_makeGrid();
		fn_search();
	} else if ( id == "CB_LEVEL1" ){
		gfn_cbRefresh("CB_LEVEL2", data.CategoryLevel2, true);
	} else if ( id == "CB_LEVEL2" ){
		gfn_cbRefresh("CB_LEVEL3", data.CategoryLevel3, true);
	} else if ( id == "INS_CB_LEVEL1" ){
		gfn_cbRefresh("INS_CB_LEVEL2", data.CategoryLevel2, true);
	} else if ( id == "INS_CB_LEVEL2" ){
		gfn_cbRefresh("INS_CB_LEVEL3", data.CategoryLevel3, true);
	} else if ( id == "INS_CB_COURSE_CODE" ){
		gfn_cbRefresh("INS_CB_COURSE_CODE", data.ExamCourseCode, true);
		
		dd.ExamCourseCode = data.ExamCourseCode;
	} else if ( id == "save" ){
		mask.close();

		mask.open();
		dialog.alert( { msg : "저장 되었습니다." }, function () { mask.close();	fn_search(); } );
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
	} else  if ( id == "INS_CB_LEVEL1" ) {
	    gfn_callAjax("/common/axDd.do", { DD_KIND : "CategoryLevel2", LEVEL1_CODE : $("#INS_CB_LEVEL1 option:selected").val()}, fn_callbackAjax, "INS_CB_LEVEL1", { async : false });
	} else  if ( id == "INS_CB_LEVEL2" ) {
	    gfn_callAjax("/common/axDd.do", { DD_KIND : "CategoryLevel3", LEVEL2_CODE : $("#INS_CB_LEVEL2 option:selected").val()}, fn_callbackAjax, "INS_CB_LEVEL2", { async : false });
	} else  if ( id == "INS_CB_LEVEL3" ) {
	    gfn_callAjax("/common/axDd.do", { DD_KIND : "ExamCourseCode", LEVEL3_CODE : $("#INS_CB_LEVEL3 option:selected").val()}, fn_callbackAjax, "INS_CB_COURSE_CODE", { async : false });
	}
}


</script>

<body style="padding : 10px">

<form id="frm" name="frm" method="post">

<h2>과정 시험 유형 관리</h2>
<div style="height:10px"></div>

<div>
	대분류
	<select id="CB_LEVEL1" onchange="fn_cbChange('CB_LEVEL1')">
		<option value="">전체</option>
	</select>
	중분류
	<select id="CB_LEVEL2" onchange="fn_cbChange('CB_LEVEL2')">
		<option value="">전체</option>
	</select>
	소분류
	<select id="CB_LEVEL3">
		<option value="">전체</option>
	</select>
	과정명
	<input type="text" class="search_input" id="courseName" name="courseName" value="" />
</div>

<div style="height:10px"></div>

<div>
    <button class="btn btn-default" data-grid-control="search">검색</button>
    <button class="btn btn-default" data-grid-control="add">추가</button>
    <button class="btn btn-default" data-grid-control="delete">삭제</button>
    <button class="btn btn-default" data-grid-control="reset">초기화</button>
    <button class="btn btn-default" data-grid-control="save">저장</button>
    <button class="btn btn-default" data-grid-control="export">엑셀</button>
    <button class="btn btn-default" data-grid-control="editDetail">유형 기준 편집</button>
</div>

<div style="height:10px"></div>


<div style="position: relative;height:400px;" id="grid-parent">
    <div data-ax5grid="first-grid" style="height: 100%;"></div>
</div>

</form>

<div class="mask"></div>
<div class="popupDiv" id="insDiv" style="width:300px; height:200px;">
	대분류
	<select id="INS_CB_LEVEL1" onchange="fn_cbChange('INS_CB_LEVEL1')">
	</select>
	<br></br>
	중분류
	<select id="INS_CB_LEVEL2" onchange="fn_cbChange('INS_CB_LEVEL2')">
	</select>
	<br></br>
	소분류
	<select id="INS_CB_LEVEL3" onchange="fn_cbChange('INS_CB_LEVEL3')">
	</select>
	<br></br>
	과정명
	<select id="INS_CB_COURSE_CODE">
	</select>
	
	<div style="height:30px"></div>
	<input type="button" href="#" value="확인" onclick="fn_hidePopupDiv('insDiv')"/>
    <input type="button" href="#" value="닫기" onclick="gfn_hidePopupDiv('insDiv');"/>
</div>
	

</body>
</html>

