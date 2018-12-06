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

var dd; 

$(document.body).ready(function () {
	$( window ).resize( function() {
		gfn_gridResize("grid-parent", grid);
	} );
	
    confirmDialog.setConfig({
        theme: "danger"
    }); 

    gfn_callAjax("/common/axDd.do", { DD_KIND : "CategoryLevel1,Teacher,QuestGroup,ContentsManager" }, fn_callbackAjax, "dd", { async : false });
    
    $('[data-grid-control]').click(function () {
        switch (this.getAttribute("data-grid-control")) {
	        case "search":
	            fn_search();
	            break;
            case "add":
            	var allList = grid.getList();
            	if ( gfn_getValueInList(allList, "NEW_FLAG",  "Y", "NEW_FLAG") == "Y" ) {
            		mask.open();
            		dialog.alert( { msg : "신규로 추가된 과정코드가 잇습니다. 저장후에 다시 추가를 해주세요." }, function () { mask.close();	} );
            		return;
            	}

		    	Popup.showCategory();
		    	
		    	break;
            case "delete":
            	var row = grid.getList("selected");
            	if ( row.length == 0 ) {
            		mask.open();
            		dialog.alert( { msg : "과정을 선택하셔야 합니다." }, function () { mask.close();	} );
            		return;
            	}
            	if ( row[0]["NEXT_CREATE_FLAG"] == "Y" ) {
            		mask.open();
            		dialog.alert( { msg : "과정 Master를 먼저 삭제하셔야 합니다." }, function () { mask.close();	} );
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
                grid.exportExcel("과정코드관리.xls");
                break;
            case "editDetail":
            	var row = grid.getList("selected");
            	if ( row.length == 0 ) {
            		mask.open();
            		dialog.alert( { msg : "과정을 선택하셔야 합니다." }, function () { mask.close();	} );
            	} else if ( row[0]["NEW_FLAG"] == "N" ) {
            		var urlParams = "page=/ax/course/axCourseResourcePopupList";
            		urlParams += "&COURSE_CODE=" + row[0]["COURSE_CODE"];
            		
            		f_popup('/common/axOpenPage', {displayName:'courseResourcePopup',option:'width=1100,height=820', urlParams:urlParams});
            	} else {
            		mask.open();
            		dialog.alert( { msg : "신규로 추가한 경우는 저장후에 주차를 편집하셔야 합니다." }, function () { mask.close();	} );
            	}
            		
                break;
        }
    });
});

function fn_makeGrid() {
	grid = gfn_makeAx5Grid("first-grid",
		[ 	{
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
	            align : "left",
	            editor : { 
	            	type : "text"
				},
				styleClass: function () {
                    return "grid-cell-edit";
                }
	        },{
	        	key : "TEACHER_ID", 
	        	label : "강사", 
	            width : 140,
	        	align : "left", 
	        	editor: {
                    type : "select", 
                    config : {
                        columnKeys: { optionValue: "value", optionText: "text" },
                        options: dd.Teacher
                    } 
	        	},
	            formatter : function () {
	                return gfn_getValueInList(dd.Teacher, "value",  this.item.TEACHER_ID, "text");
	           	},
				styleClass: function () {
                    return "grid-cell-edit";
                }
	        },{
	        	key : "CONTENTS_MANAGER_ID", 
	        	label : "컨텐츠 관리자", 
	            width : 140,
	        	align : "left", 
	        	editor: {
                    type : "select", 
                    config : {
                        columnKeys: { optionValue: "value", optionText: "text" },
                        options: dd.ContentsManager
                    } 
	        	},
	            formatter : function () {
	                return gfn_getValueInList(dd.ContentsManager, "value",  this.item.CONTENTS_MANAGER_ID, "text");
	           	},
				styleClass: function () {
                    return "grid-cell-edit";
                }
	        },{
	            key : "WEEK_CNT",
	            label : "주차 갯수",
	            width : 80,
	            align : "right"
	        },{
	            key : "H_PX",
	            label : "가로 길이",
	            width : 90,
	            align : "right",
	            editor : { 
	            	type : "number"
				},
				styleClass: function () {
                    return "grid-cell-edit";
                }
	        },{
	            key : "V_PX",
	            label : "세로 길이",
	            width : 90,
	            align : "right",
	            editor : { 
	            	type : "number"
				},
				styleClass: function () {
                    return "grid-cell-edit";
                }
	        },{
	            key : "DIRECTORY",
	            label : "디렉토리",
	            width : 90,
	            align : "left",
	            editor : { 
	            	type : "text"
				},
				styleClass: function () {
                    return "grid-cell-edit";
                }
	        },{
	            key : "POINT",
	            label : "포인트",
	            width : 90,
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
	        	editor : { type : "checkbox", config : {height: 17, trueValue: "Y", falseValue: "N"} },
				styleClass: function () {
                    return "grid-cell-edit";
                }
	        },{
	        	key : "QG_ID", 
	        	label : "설문지", 
	            width : 160,
	        	align : "left", 
	        	editor: {
                    type : "select", 
                    config : {
                        columnKeys: { optionValue: "value", optionText: "text" },
                        options: dd.QuestGroup
                    } 
	        	},
	            formatter : function () {
	                return gfn_getValueInList(dd.QuestGroup, "value",  this.item.QG_ID, "text");
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
	        },{
	            key : "NEXT_CREATE_FLAG",
	            label : "과정 Master 여부",
	            width : 130,
	            align : "center"
	        }	], 
	  	null,
	  	{
	  		showRowSelector : false
	  	}
	);
	
	$(window).trigger("resize");
}

function fn_params() {
	params.LEVEL1_CODE = $("#CB_LEVEL1 option:selected").val();	
	params.LEVEL2_CODE = $("#CB_LEVEL2 option:selected").val();	
	params.LEVEL3_CODE = $("#CB_LEVEL3 option:selected").val();	
	params.courseName = $("#courseName").val();	
	params.useYn = $("#useYn").val();
}

function fn_search() {
	//mask.open();
	
	fn_params();
	
	gfn_callAjax("/course/axCourseCodeList.do", params, fn_callbackAjax, "search");
}

function fn_save() {
	var fieldParams = {
		COURSE_NAME : { mendatory : true, colName : "과정명" },
		TEACHER_ID : { mendatory : true, colName : "강사" },
		DIRECTORY : { mendatory : true, colName : "디렉토리" }
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
             		gfn_callAjax("/course/axCourseCodeSave.do", gfn_getSaveData(grid), fn_callbackAjax, "save");
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
		
		dd.ContentsManager = [{value : "", text : ""}].concat(dd.ContentsManager);
		
		gfn_cbRefresh("CB_LEVEL1", data.CategoryLevel1, true);
		gfn_cbRefresh("INS_CB_LEVEL1", data.CategoryLevel1, true);
		
		fn_makeGrid();
	} else if ( id == "CB_LEVEL1" ){
		gfn_cbRefresh("CB_LEVEL2", data.CategoryLevel2, true);
	} else if ( id == "CB_LEVEL2" ){
		gfn_cbRefresh("CB_LEVEL3", data.CategoryLevel3, true);
	} else if ( id == "INS_CB_LEVEL1" ){
		gfn_cbRefresh("INS_CB_LEVEL2", data.CategoryLevel2, true);
	} else if ( id == "INS_CB_LEVEL2" ){
		gfn_cbRefresh("INS_CB_LEVEL3", data.CategoryLevel3, true);
	} else if ( id == "save" ){
		mask.close();

		mask.open();
		dialog.alert( { msg : "저장 되었습니다." }, function () { mask.close();	fn_search(); } );
	}
}

function fn_categorySelect(data) {
	$.ajax({
		url : context + "/common/axMaxCourseCode.do",
		type : "POST",
		async : false,
		dataType :"json",
		contentType : "application/json; charset=UTF-8",
		data : JSON.stringify(params || {}),
		success : function(jData){
			var maxSeq = jData.list[0].YYYYMMDD;
			if ( jData.list[0].MAX_SEQ < 10 ) {
				maxSeq += "00" + ( jData.list[0].MAX_SEQ + 1 );
			} else if ( jData.list[0].MAX_SEQ < 100 ) {
				maxSeq += "0" + ( jData.list[0].MAX_SEQ + 1 );
			} else {
				maxSeq += ( jData.list[0].MAX_SEQ + 1 );
			}
			grid.addRow( 
				{
					NEW_FLAG : "Y", 
					CATEGORY_NAME : data.CB_LEVEL1_NAME + " > " + data.CB_LEVEL2_NAME + " > " + data.CB_LEVEL3_NAME, 
					CODE : data.CB_LEVEL3_CODE, 
					COURSE_CODE : maxSeq, 
					COURSE_NAME : "과정명을 입력하세요",
					H_PX : 1000, 
					V_PX : 900,
					DIRECTORY : maxSeq,
					POINT : 0,
					USE_YN : "Y", 
				}, "last", {focus: "END"});
		},
		error : function(e) {
			alert(resource.msg.systemError);
		}
	});
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
	}
}


</script>

<body style="padding : 10px">


<h2>과정 코드 관리</h2>
<div style="height:10px"></div>

<form id="frm" name="frm" method="post" class="form-inline">
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
    	<label for="courseName">&nbsp;과정명</label>
    	<input type="text" class="form-control" id="courseName" name="courseName">
  	</div>
  	<div class="form-group">
    	<label for="useYn">&nbsp;사용여부</label>
    	<select class="form-control" id="useYn">
			<option value="">전체</option>
			<option value="Y">Y</option>
			<option value="N">N</option>
		</select>
  	</div>
</form>
<div style="height:10px"></div>

<div>
    <button class="btn btn-default" data-grid-control="search">검색</button>
    <button class="btn btn-default" data-grid-control="add">추가</button>
    <button class="btn btn-default" data-grid-control="delete">삭제</button>
    <button class="btn btn-default" data-grid-control="reset">초기화</button>
    <button class="btn btn-default" data-grid-control="save">저장</button>
    <button class="btn btn-default" data-grid-control="export">엑셀</button>
    <button class="btn btn-default" data-grid-control="editDetail">주차 편집</button>
</div>
<div style="height:10px"></div>


<div style="position: relative;height:400px;" id="grid-parent">
    <div data-ax5grid="first-grid" style="height: 100%;"></div>
</div>


<div class="mask"></div>

</body>
</html>

