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

var dd;
var ddWeekCost = [
	{value : "Y", text : "차시별"},
    {value : "N", text : "과정별"}
];


$(document.body).ready(function () {
    confirmDialog.setConfig({
        theme: "danger"
    });

    gfn_callAjax("/common/getDd.do", { DD_KIND : "CategoryLevel1,Tutor" }, fn_callbackAjax, "dd", { async : false });
    
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
            	if ( row[0]["NEXT_CREATE_FLAG"] == "Y" ) {
            		mask.open();
            		dialog.alert( { msg : "과정 시험을 먼저 삭제하셔야 합니다." }, function () { mask.close();	} );
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
                grid.exportExcel("과정Master관리.xls");
                break;
            case "editContent":
            	var row = grid.getList("selected");
            	if ( row.length == 0 ) {
            		mask.open();
            		dialog.alert( { msg : "과정을 선택하셔야 합니다." }, function () { mask.close();	} );
            	} else if ( row[0]["NEW_FLAG"] == "N" ) {
            		var urlParams = "page=/ax/course/axCourseMasterContentsPopup";
            		urlParams += "&COURSE_CODE=" + row[0]["COURSE_CODE"];
            		
            		f_popup('/common/openPage', {displayName:'courseMasterContentsPopup',option:'width=900,height=600', urlParams:urlParams});
            	} else {
            		mask.open();
            		dialog.alert( { msg : "신규로 추가한 경우는 저장후에 학습내용을 편집하셔야 합니다." }, function () { mask.close();	} );
            	}
            		
                break;
            case "editImage":
            	var row = grid.getList("selected");
            	if ( row.length == 0 ) {
            		mask.open();
            		dialog.alert( { msg : "과정을 선택하셔야 합니다." }, function () { mask.close();	} );
            	} else if ( row[0]["NEW_FLAG"] == "N" ) {
            		var urlParams = "page=/ax/course/axCourseMasterImagePopup";
            		urlParams += "&COURSE_CODE=" + row[0]["COURSE_CODE"];
            		
            		f_popup('/common/openPage', {displayName:'courseMasterImagePopup',option:'width=900,height=650', urlParams:urlParams});
            	} else {
            		mask.open();
            		dialog.alert( { msg : "신규로 추가한 경우는 저장후에 이미지를 편집하셔야 합니다." }, function () { mask.close();	} );
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
	        	key : "WEEK_COST_YN", 
	        	label : "과정비용", 
	            width : 90,
	        	align : "center", 
	        	editor: {
                    type : "select", 
                    config : {
                        columnKeys: { optionValue: "value", optionText: "text" },
                        options: ddWeekCost
                    },
	            	disabled : function () {
                        return ( this.item.NEW_FLAG != "Y" ? true : false );
                    },
	        	},
	            formatter : function () {
	            	return gfn_getValueInList(ddWeekCost, "value",  this.item.WEEK_COST_YN, "text");
	           	},
				styleClass: function () {
                    return ( this.item.NEW_FLAG == "Y" ? "grid-cell-edit" : "" );
                }
	        },{
	        	key : "TUTOR_ID", 
	        	label : "튜터", 
	            width : 100,
	        	align : "center", 
	        	editor: {
                    type : "select", 
                    config : {
                        columnKeys: { optionValue: "value", optionText: "text" },
                        options: dd.Tutor
                    } 
	        	},
	            formatter : function () {
	                return gfn_getValueInList(dd.Tutor, "value",  this.item.TUTOR_ID, "text");
	           	},
				styleClass: function () {
                    return "grid-cell-edit";
                }
	        },{
	        	key : "PROMOTION_VIDEO_YN", 
	        	label : "홍보영상", 
	            width : 80, 
	        	align : "center", 
	        	editor : { type : "checkbox", config : {height: 17, trueValue: "Y", falseValue: "N"} },
				styleClass: function () {
                    return "grid-cell-edit";
                }
	        },{
	            key : "COURSE_COST",
	            label : "과정비용",
	            width : 90,
	            align : "right",
	            editor : { 
	            	type : "number"
				},
				styleClass: function () {
                    return "grid-cell-edit";
                }
	        },{
              	key : undefined, 
              	label: "학습내용", 
              	columns: [	        
			        {
			            key : "LEARING_GOAL_YN",
			            label : "학습목표",
			            width : 80,
			            align : "center"
			        },{
			            key : "LEARING_CONTENT_YN",
			            label : "학습내용",
			            width : 80,
			            align : "center"
			        },{
			            key : "EVAL_METHOD_YN",
			            label : "평가방법",
			            width : 80,
			            align : "center"
			        },{
			            key : "LEARING_TARGET_YN",
			            label : "학습대상",
			            width : 80,
			            align : "center"
			        },{
			            key : "LEARING_COST_YN",
			            label : "학습비용",
			            width : 80,
			            align : "center"
			        }
		        ]
	        },{
              	key : undefined, 
              	label: "점수 비율", 
              	columns: [	        
			        {
			            key : "REPORT_RATE",
			            label : "레포트",
			            width : 80,
			            align : "right",
			            editor : { 
			            	type : "number"
						},
						styleClass: function () {
		                    return "grid-cell-edit";
		                }
			        },{
			            key : "EXAM_RATE",
			            label : "시험",
			            width : 70,
			            align : "right",
			            editor : { 
			            	type : "number"
						},
						styleClass: function () {
		                    return "grid-cell-edit";
		                }
			        },{
			            key : "DISCUSSION_RATE",
			            label : "토론",
			            width : 70,
			            align : "right",
			            editor : { 
			            	type : "number"
						},
						styleClass: function () {
		                    return "grid-cell-edit";
		                }
			        },{
			            key : "PROGRESS_RATE",
			            label : "강의진도",
			            width : 90,
			            align : "right",
			            editor : { 
			            	type : "number"
						},
						styleClass: function () {
		                    return "grid-cell-edit";
		                }
			        },{
			            key : "TOTAL",
			            label : "합계",
			            width : 90,
			            align : "right",
			            formatter : function () {
			                return this.item.REPORT_RATE + this.item.EXAM_RATE + this.item.DISCUSSION_RATE + this.item.PROGRESS_RATE;
			           	}
			        }
		        ]
	        },{
              	key : undefined, 
              	label: "이미지", 
              	columns: [	        
			        {
			            key : "SWF",
			            label : "메인 플레시",
			            width : 100,
			            align : "center"
			        },{
			            key : "B_IMG",
			            label : "메인 배경",
			            width : 80,
			            align : "center"
			        },{
			            key : "C_IMG",
			            label : "과정 상세",
			            width : 80,
			            align : "center"
			        },{
			            key : "M_IMG1",
			            label : "미리보기1",
			            width : 80,
			            align : "center"
			        },{
			            key : "M_IMG2",
			            label : "미리보기2",
			            width : 80,
			            align : "center"
			        },{
			            key : "M_IMG3",
			            label : "미리보기3",
			            width : 80,
			            align : "center"
			        },{
			            key : "S_IMG1",
			            label : "썸네일1",
			            width : 70,
			            align : "center"
			        },{
			            key : "S_IMG2",
			            label : "썸네일2",
			            width : 70,
			            align : "center"
			        },{
			            key : "S_IMG3",
			            label : "썸네일3",
			            width : 70,
			            align : "center"
			        }
		        ]
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
	            label : "과정 시험 여부",
	            width : 130,
	            align : "center"
	        }	], 
	  	null,
	  	{
	  		showRowSelector : false
	  	}
	);
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
			CODE : $("#INS_CB_LEVEL3 option:selected").val(), 
			COURSE_CODE : $("#INS_CB_COURSE_CODE option:selected").val(), 
			COURSE_NAME : $("#INS_CB_COURSE_CODE option:selected").text(),
			WEEK_COST_YN : "N", 
			PROMOTION_VIDEO_YN : "N",
			COURSE_COST : 0,
			REPORT_RATE : 0,
			EXAM_RATE : 0,
			DISCUSSION_RATE : 0,
			PROGRESS_RATE : 100
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
	
	gfn_callAjax("/course/axCourseMasterList.do", params, fn_callbackAjax, "search");
}

function fn_save() {
	var fieldParams = {
		TUTOR_ID : { mendatory : true, colName : "튜터" },
		COURSE_COST : { mendatory : true, colName : "과정비용", type : "number" },
		REPORT_RATE : { mendatory : true, colName : "레포트", type : "number" },
		EXAM_RATE : { mendatory : true, colName : "시험", type : "number" },
		DISCUSSION_RATE : { mendatory : true, colName : "토론", type : "number" },
		PROGRESS_RATE : { mendatory : true, colName : "강의진도", type : "number" }
   	};
   	if ( gfn_validationCheck(grid, fieldParams) ) {
       	var allList = grid.getList();
       	for ( var i = 0; i < allList.length; i++ ) {
       		if ( parseInt(allList[i].REPORT_RATE) + parseInt(allList[i].EXAM_RATE) + parseInt(allList[i].DISCUSSION_RATE) + parseInt(allList[i].PROGRESS_RATE) != 100 ) {
    			mask.open();
    			dialog.alert( { msg : "점수 비율을 100이여야 합니다." }, function () { mask.close(); } );
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
             		gfn_callAjax("/course/axCourseMasterSave.do", gfn_getSaveData(grid), fn_callbackAjax, "save");
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
		gfn_cbRefresh("INS_CB_COURSE_CODE", data.CourseCode, true);
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
	    gfn_callAjax("/common/getDd.do", { DD_KIND : "CategoryLevel2", LEVEL1_CODE : $("#CB_LEVEL1 option:selected").val()}, fn_callbackAjax, "CB_LEVEL1", { async : false });
	} else  if ( id == "CB_LEVEL2" ) {
	    gfn_callAjax("/common/getDd.do", { DD_KIND : "CategoryLevel3", LEVEL2_CODE : $("#CB_LEVEL2 option:selected").val()}, fn_callbackAjax, "CB_LEVEL2", { async : false });
	} else  if ( id == "INS_CB_LEVEL1" ) {
	    gfn_callAjax("/common/getDd.do", { DD_KIND : "CategoryLevel2", LEVEL1_CODE : $("#INS_CB_LEVEL1 option:selected").val()}, fn_callbackAjax, "INS_CB_LEVEL1", { async : false });
	} else  if ( id == "INS_CB_LEVEL2" ) {
	    gfn_callAjax("/common/getDd.do", { DD_KIND : "CategoryLevel3", LEVEL2_CODE : $("#INS_CB_LEVEL2 option:selected").val()}, fn_callbackAjax, "INS_CB_LEVEL2", { async : false });
	} else  if ( id == "INS_CB_LEVEL3" ) {
	    gfn_callAjax("/common/getDd.do", { DD_KIND : "CourseCode", LEVEL3_CODE : $("#INS_CB_LEVEL3 option:selected").val()}, fn_callbackAjax, "INS_CB_COURSE_CODE", { async : false });
	}
}


</script>

<body style="padding : 10px">

<form id="frm" name="frm" method="post">

<h2>과정 Master 관리</h2>
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
    <button class="btn btn-default" data-grid-control="editContent">학습내용 편집</button>
    <button class="btn btn-default" data-grid-control="editImage">이미지 편집</button>
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

