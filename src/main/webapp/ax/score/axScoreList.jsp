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

var dd = {};

$(document.body).ready(function () {
	$( window ).resize( function() {
		gfn_gridResize("grid-parent", grid);
	} );
	
    confirmDialog.setConfig({
        theme: "danger"
    });

    $('#MCB_COMPANY').multiselect();
    
    gfn_callAjax("/common/axDd.do", { DD_KIND : "CategoryLevel1,Tutor,Company" }, fn_callbackAjax, "dd", { async : false });
    
    $('[data-grid-control]').click(function () {
        switch (this.getAttribute("data-grid-control")) {
	        case "search":
	            fn_search();
	            break;
            case "export":
                grid.exportExcel("성적관리.xls");
                break;
            case "viewContent":
            	var row = grid.getList("selected");
            	if ( row.length == 0 ) {
            		mask.open();
            		dialog.alert( { msg : "과정을 선택하셔야 합니다." }, function () { mask.close();	} );
            	} else {
            		var urlParams = "page=/ax/course/axCourseContentsPopup";
            		urlParams += "&COURSE_ID=" + row[0]["COURSE_ID"] + "&IS_VIEW=Y";
            		
            		f_popup('/common/axOpenPage', {displayName:'courseContentsPopup',option:'width=900,height=600', urlParams:urlParams});
            	}
            		
                break;
            case "viewUserScore":
            	var row = grid.getList("selected");
            	if ( row.length == 0 ) {
            		mask.open();
            		dialog.alert( { msg : "과정을 선택하셔야 합니다." }, function () { mask.close();	} );
            	} else {
            		parent.document.getElementById("left").contentWindow.gfn_openMenu("axUserScoreList", { 
	            				COURSE_ID : row[0].COURSE_ID,
	            				COURSE_NAME : row[0].COURSE_NAME 
	            			}
	            		);
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
	            key : "COURSE_EXAM_TYPE_ID",
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
	            key : "YEAR",
	            label : "년",
	            width : 50,
	            align : "center"
	        },{
	            key : "MONTH",
	            label : "월",
	            width : 50,
	            align : "center"
	        },{
	            key : "CHASU",
	            label : "차수",
	            width : 50,
	            align : "center"
	        },{
	        	key : "COMP_CD", 
	        	label : "회사", 
	            width : 100,
	        	align : "center", 
	        	editor: {
                    type : "select", 
                    config : {
                        columnKeys: { optionValue: "value", optionText: "text" },
                        options: dd.Company
                    },
	            	disabled : function () {
                        return true;
                    }
	        	},
	            formatter : function () {
	                return gfn_getValueInList(dd.Company, "value",  this.item.COMP_CD, "text");
	           	}
	        },{
              	key : undefined, 
              	label: "진도", 
              	columns: [	        
			        {
			            key : "REPORT_CNT",
			            label : "레포트",
			            width : 80,
			            align : "right"
			        },{
			            key : "EXAM_CNT",
			            label : "시험",
			            width : 70,
			            align : "right"
			        },{
			            key : "DISCUSSION_CNT",
			            label : "토론",
			            width : 70,
			            align : "right"
			        },{
			            key : "PROGRESS_CNT",
			            label : "강의진도",
			            width : 90,
			            align : "right"
			        },{
			            key : "TOTAL_CNT",
			            label : "합계",
			            width : 90,
			            align : "right"
			        }
		        ]
	        },{
	        	key : "REPORT_SUBMIT_CNT", 
	        	label : "레포트 제출", 
	            width : 120,
	        	align : "right"
	        },{
	        	key : "QUEST_CNT", 
	        	label : "설문지 제출", 
	            width : 120,
	        	align : "right"
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
	params.SEARCH_COURSE = $("#SEARCH_COURSE").val();	
}

function fn_search() {
	//mask.open();
	
	fn_params();
	
	gfn_callAjax("/score/axScoreList.do", params, fn_callbackAjax, "search");
}

function fn_callbackAjax(data, id) {
	//console.log("fn_callbackAjax : " + id);
	if ( id == "search" ) {
		grid.setData(data.list);
		
		//mask.close();
	} else if ( id == "dd" ){
		dd = $.extend({}, data);
		
		gfn_cbRefresh("CB_LEVEL1", data.CategoryLevel1, true);
		
		fn_makeGrid();
		fn_search();
	} else if ( id == "CB_LEVEL1" ){
		gfn_cbRefresh("CB_LEVEL2", data.CategoryLevel2, true);
	} else if ( id == "CB_LEVEL2" ){
		gfn_cbRefresh("CB_LEVEL3", data.CategoryLevel3, true);
	}
}

function fn_gridEvent(event, obj) {
	if ( event == "Click" ) {
		obj.self.select(obj.dindex);
	} else if ( event == "DBLClick" ) {
	} else if ( event == "DataChanged" ) {
	}
}

function fn_cbChange(id) {
	if ( id == "CB_LEVEL1" ) {
	    gfn_callAjax("/common/axDd.do", { DD_KIND : "CategoryLevel2", LEVEL1_CODE : $("#CB_LEVEL1 option:selected").val()}, fn_callbackAjax, "CB_LEVEL1", { async : false });
	} else  if ( id == "CB_LEVEL2" ) {
	    gfn_callAjax("/common/axDd.do", { DD_KIND : "CategoryLevel3", LEVEL2_CODE : $("#CB_LEVEL2 option:selected").val()}, fn_callbackAjax, "CB_LEVEL2", { async : false });
	}
}


</script>

<body style="padding : 10px">

<form id="frm" name="frm" method="post">

<h2>성적 관리</h2>
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
	<input type="text" class="search_input" id="SEARCH_COURSE" name="SEARCH_COURSE" value="" />
</div>

<div style="height:10px"></div>

<div>
    <button class="btn btn-default" data-grid-control="search">검색</button>
    <button class="btn btn-default" data-grid-control="export">엑셀</button>
    <button class="btn btn-default" data-grid-control="viewContent">학습내용</button>
    <button class="btn btn-default" data-grid-control="viewUserScore">수강생별 성적</button>
</div>

<div style="height:10px"></div>


<div style="position: relative;height:400px;" id="grid-parent">
    <div data-ax5grid="first-grid" style="height: 100%;"></div>
</div>

</form>

<div class="mask"></div>


</body>
</html>

