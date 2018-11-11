<%@ page contentType="text/html;charset=utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<head>
    <meta charset='utf-8'>
    <meta name='viewport' content='width=device-width, initial-scale=1, minimum-scale=1, maximum-scale=1'>
    <meta http-equiv='X-UA-Compatible' content='ie=edge'>
    <title>Q learning - 관리자 - 과정관리 - 과정코드관리</title>

	<%@ include file="../../common/commMainInclude.jsp" %>
	
	<link rel="stylesheet" type="text/css" href="/resources/ax5ui/dist/ax5mask.css"/>
	<link rel="stylesheet" type="text/css" href="/resources/ax5ui/dist/ax5calendar.css"/>
	<link rel="stylesheet" type="text/css" href="/resources/ax5ui/dist/ax5picker.css"/>
	<link rel="stylesheet" type="text/css" href="/resources/ax5ui/dist/ax5select.css"/>
	<link rel="stylesheet" type="text/css" href="/resources/ax5ui/dist/ax5grid.css"/>
	<link rel="stylesheet" type="text/css" href="/resources/ax5ui/dist/ax5dialog.css"/>
	<link rel="stylesheet" type="text/css" href="/resources/ax5ui/dist/ax5toast.css"/>
	<link rel="stylesheet" type="text/css" href="/resources/ax5ui/dist/ax5combobox.css"/>
	<link rel="stylesheet" type="text/css" href="/resources/ax5ui/dist/ax5layout.css"/>
	<script src="/resources/ax5ui/dist/ax5core.js"></script>
	<script src="/resources/ax5ui/dist/ax5mask.js"></script>
	<script src="/resources/ax5ui/dist/ax5formatter.min.js"></script>
	<script src="/resources/ax5ui/dist/ax5calendar.min.js"></script>
	<script src="/resources/ax5ui/dist/ax5picker.min.js"></script>
	<script src="/resources/ax5ui/dist/ax5select.js"></script>
	<script src="/resources/ax5ui/dist/ax5grid.js"></script>
	<script src="/resources/ax5ui/dist/ax5dialog.js"></script>
	<script src="/resources/ax5ui/dist/ax5toast.js"></script>
	<script src="/resources/ax5ui/dist/ax5combobox.js"></script>
	<script src="/resources/ax5ui/dist/ax5layout.js"></script>


    <link href='https://fonts.googleapis.com/css?family=Nanum+Gothic' rel='stylesheet'>
    <link rel='stylesheet' href='/resources/homepage/css/initialization.css'>
    <link rel='stylesheet' href='/resources/homepage/css/etc/admin.css'>
    
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>
	<script type="text/javascript" src="/resources/multiselect/js/bootstrap-multiselect.js"></script>
    
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
		//gfn_gridResize("grid-parent", grid);
		$("#" + "grid-parent").height($(window).height() - $("#" + "grid-parent").position().top - 20);
		grid.setHeight($(window).height() - $("#" + "grid-parent").position().top - 20);
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
            	
		    	gfn_cbRemove("INS_CB_LEVEL3");
		    	gfn_cbRemove("INS_CB_LEVEL2");
		    	$("#INS_CB_LEVEL1").val("");
		    	
		    	gfn_showPopupDiv("categoryDiv");

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

function fn_hidePopupDiv(popupDivId) {
	gfn_hidePopupDiv(popupDivId);
	
	if ( $("#INS_CB_LEVEL1 option:selected").val() == "" || $("#INS_CB_LEVEL2 option:selected").val() == "" || $("#INS_CB_LEVEL3 option:selected").val() == "" ) {
		mask.open();
		dialog.alert( { msg : "대/중/소분류를 선택하셔야 합니다." }, function () { mask.close(); } );
	} else {
		$.ajax({
			url : context + "/common/axMaxCourseCode.do",
			type : "POST",
			async : false,
			dataType :"json",
			contentType : "application/json; charset=UTF-8",
			data : JSON.stringify(params || {}),
			success : function(data){
				var maxSeq = data.list[0].YYYYMMDD;
				if ( data.list[0].MAX_SEQ < 10 ) {
					maxSeq += "00" + ( data.list[0].MAX_SEQ + 1 );
				} else if ( data.list[0].MAX_SEQ < 100 ) {
					maxSeq += "0" + ( data.list[0].MAX_SEQ + 1 );
				} else {
					maxSeq += ( data.list[0].MAX_SEQ + 1 );
				}
				grid.addRow( 
					{
						NEW_FLAG : "Y", 
						CATEGORY_NAME : $("#INS_CB_LEVEL1 option:selected").text() + " > " + $("#INS_CB_LEVEL2 option:selected").text() + " > " + $("#INS_CB_LEVEL3 option:selected").text(), 
						CODE : $("#INS_CB_LEVEL3 option:selected").val(), 
						COURSE_CODE : maxSeq, 
						COURSE_NAME : "과정명을 입력하세요",
						H_PX : 1000, 
						V_PX : 900,
						DIRECTORY : maxSeq,
						POINT : 0,
						USE_YN : "Y", 
					}, "last", {focus: "END"});

				if ( $.isFunction(callback) ) {
					callback(data, id);
				}
			},
			error : function(e) {
				alert(resource.msg.systemError);
			}
		});
	}
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
		//fn_search();
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

<body style='background:#fff'>

<form id="frm" name="frm" method="post" class="form-inline">

<frameset rows='*'>
    <div class='wrap clear_fix'>
        <div class='contents_wrap'>
            <div class='content_top'>
                <h1>과정 코드 관리</h1>
                <div class='filter_box clear_fix'>
                    <div>
                        <p>카테고리</p>
                        <select name='CB_LEVEL1' id="CB_LEVEL1" onchange="fn_cbChange('CB_LEVEL1')">
                            <option value=''>전체</option>
                        </select>
                        <select name='CB_LEVEL2' id="CB_LEVEL2" onchange="fn_cbChange('CB_LEVEL2')">
                            <option value=''>전체</option>
                        </select>
                        <select name='CB_LEVEL3' id="CB_LEVEL3">
                            <option value=''>전체</option>
                        </select>
                    </div>
                    <div>
                        <p>과정명</p>
                        <input type='text' name='courseName' id='courseName'>
                    </div>
                    <div>
                        <p>사용여부</p>
                        <select name='useYn' id="useYn">
                            <option value=''>전체</option>
							<option value="Y">Y</option>
							<option value="N">N</option>
                        </select>
                    </div>
                </div>
            </div>
            <div class='content_btn_box clear_fix'>
			    <button class="btn btn-default" data-grid-control="search">검색</button>
			    <button class="btn btn-default" data-grid-control="add">추가</button>
			    <button class="btn btn-default" data-grid-control="delete">삭제</button>
			    <button class="btn btn-default" data-grid-control="reset">초기화</button>
			    <button class="btn btn-default" data-grid-control="save">저장</button>
			    <button class="btn btn-default" data-grid-control="export">엑셀</button>
			    <button class="btn btn-default" data-grid-control="editDetail">주차 편집</button>                
            </div>
            <div class='grid_area' style="overflow-x: hidden;" id="grid-parent">
			    <div data-ax5grid="first-grid" ></div>
			</div>
        </div>
    </div>
    
<div class="mask"></div>
<div class="popupDiv" id="categoryDiv" style="width:300px; height:200px;">
	대분류
	<select id="INS_CB_LEVEL1" onchange="fn_cbChange('INS_CB_LEVEL1')">
	</select>
	<br></br>
	중분류
	<select id="INS_CB_LEVEL2" onchange="fn_cbChange('INS_CB_LEVEL2')">
	</select>
	<br></br>
	소분류
	<select id="INS_CB_LEVEL3">
	</select>
	
	<div style="height:30px"></div>
	<input type="button" href="#" value="확인" onclick="fn_hidePopupDiv('categoryDiv')"/>
    <input type="button" href="#" value="닫기" onclick="gfn_hidePopupDiv('categoryDiv');"/>
</div>    
</frameset>

</form>

<script src='/resources/homepage/js/dev_sub.js'></script>
</body>
</html>

