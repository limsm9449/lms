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

    $('#MCB_COMPANY').multiselect(multiselectOptions);
    
    gfn_callAjax("/common/axDd.do", { DD_KIND : "CategoryLevel1,Tutor,OpenKind,Year" }, fn_callbackAjax, "dd", { async : false });
    
    $('[data-grid-control]').click(function () {
        switch (this.getAttribute("data-grid-control")) {
	        case "search":
	            fn_search();
	            break;
            case "export":
                grid.exportExcel("과정Master관리.xls");
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
            case "viewImage":
            	var row = grid.getList("selected");
            	if ( row.length == 0 ) {
            		mask.open();
            		dialog.alert( { msg : "과정을 선택하셔야 합니다." }, function () { mask.close();	} );
            	} else {
            		var urlParams = "page=/ax/course/axCourseMasterImagePopup";
            		urlParams += "&COURSE_CODE=" + row[0]["COURSE_CODE"] + "&IS_VIEW=Y";
            		
            		f_popup('/common/axOpenPage', {displayName:'courseImagePopup',option:'width=900,height=650', urlParams:urlParams});
            	}
            		
                break;
            case "courseRegister":
            	var row = grid.getList("selected");
            	if ( row.length == 0 ) {
            		mask.open();
            		dialog.alert( { msg : "과정을 선택하셔야 합니다." }, function () { mask.close();	} );
            	} else if ( row[0]["OPEN_YN"] != "Y" || row[0]["CLOSE_YN"] == "Y" ) {
            		mask.open();
            		dialog.alert( { msg : "오픈 중이 아니가, 종료된 강의는 수강신청을 할 수 없습니다." }, function () { mask.close();	} );
            	} else {
            		var urlParams = "page=/ax/siteManager/axCourseRegisterPopup";
            		urlParams += "&COURSE_ID=" + row[0]["COURSE_ID"];
            		
            		f_popup('/common/axOpenPage', {displayName:'courseRegisterPopup',option:'width=900,height=700', urlParams:urlParams});
            	}
            		
                break;
            case "courseNotApprovalRegister":
            	var row = grid.getList("selected");
            	if ( row.length == 0 ) {
            		mask.open();
            		dialog.alert( { msg : "과정을 선택하셔야 합니다." }, function () { mask.close();	} );
            	} else if ( row[0]["W_USER_CNT"] == 0 ) {
            		mask.open();
            		dialog.alert( { msg : "미결재 수강생이 없습니다." }, function () { mask.close();	} );
            	} else {
            		window.open("","courseNotApprovalRegister", "width=900,height=700");
            		document.frm.action = context + "/paymentGateway/axApplication.do?COURSE_ID=" + row[0]["COURSE_ID"] + "&KIND=TYPE2";	
            		document.frm.target = "courseNotApprovalRegister";
            		document.frm.method = "POST";	
            		document.frm.submit();
            	}
            		
                break;
        }
    });
});

function fn_makeGrid() {
	grid = gfn_makeAx5Grid("first-grid",
		[ 	{
	            key : "COURSE_ID",
	            label : "ID",
	            width : 40,
	            align : "right"
	        },{
	            key : "CATEGORY_NAME",
	            label : "카테고리",
	            width : 150,
	            align : "left"
	        },{
	            key : "COURSE_NAME",
	            label : "과정명",
	            width : 150,
	            align : "left"
	        },{
	            key : "COURSE_CODE",
	            label : "과정코드",
	            width : 90,
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
	            align : "right"
	        },{
              	key : undefined, 
              	label: "수강생", 
              	columns: [
              		{
			            key : "USER_CNT",
			            label : "승인",
			            width : 70,
			            align : "right"
			        },{
			            key : "B_USER_CNT",
			            label : "입금확인",
			            width : 90,
			            align : "right"
			        },{
			            key : "Y_USER_CNT",
			            label : "미신청",
			            width : 70,
			            align : "right"
			        },{
			            key : "W_USER_CNT",
			            label : "미결재",
			            width : 70,
			            align : "right"
			        }
			  	]
	        },{
	            key : "COURSE_COST", 
	            label : "과정비용",
	            width : 90,
	            align : "right",
	            formatter : function () {
	                return checkThousand(this.item.COURSE_COST);
	           	}
	        },{
              	key : undefined, 
              	label: "점수 비율", 
              	columns: [	        
			        {
			            key : "REPORT_RATE",
			            label : "레포트",
			            width : 80,
			            align : "right"
			        },{
			            key : "EXAM_RATE",
			            label : "시험",
			            width : 70,
			            align : "right"
			        },{
			            key : "DISCUSSION_RATE",
			            label : "토론",
			            width : 70,
			            align : "right"
			        },{
			            key : "PROGRESS_RATE",
			            label : "강의진도",
			            width : 90,
			            align : "right"
			        },{
			            key : "TOTAL",
			            label : "합계",
			            width : 90,
			            align : "right",
			            formatter : function () {
			                return ax5.util.number(this.item.REPORT_RATE) + ax5.util.number(this.item.EXAM_RATE) + ax5.util.number(this.item.DISCUSSION_RATE) + ax5.util.number(this.item.PROGRESS_RATE);
			           	}
			        }
		        ]
	        },{
	        	key : "COURSE_EXAM_TYPE_NAME", 
	        	label : "시험 유형", 
	            width : 150,
	        	align : "left"
	        },{
              	key : undefined, 
              	label: "과락 기준 (100점 기준)", 
              	columns: [	        
			        {
			            key : "REPORT_FAIL",
			            label : "레포트",
			            width : 80,
			            align : "right"
			        },{
			            key : "EXAM_FAIL",
			            label : "시험",
			            width : 70,
			            align : "right"
			        },{
			            key : "DISCUSSION_FAIL",
			            label : "토론",
			            width : 70,
			            align : "right"
			        },{
			            key : "PROGRESS_FAIL",
			            label : "강의진도",
			            width : 90,
			            align : "right"
			        },{
			            key : "TOTAL_FAIL",
			            label : "총점",
			            width : 90,
			            align : "right"
			        }
		        ]
	        },{
	        	key : "OPEN_YN", 
	        	label : "오픈 여부", 
	            width : 90,
	        	align : "center", 
	        	editor : { 
	        		type : "checkbox", 
	        		config : {height: 17, trueValue: "Y", falseValue: "N"},
	            	disabled : function () {
                        return true;
                    } 
	        	}
	        },{
              	key : undefined, 
              	label: "기간", 
              	columns: [	        
              		{
        	        	key : "TERM_YN", 
        	        	label : "가입기간 여부", 
        	            width : 110,
        	        	align : "center", 
        	        	editor : { 
        	        		type : "checkbox", 
        	        		config : {height: 17, trueValue: "Y", falseValue: "N"},
        	            	disabled : function () {
                                return true;
                            }
        	        	} 
        	        },{
			            key : "TERM_PERIOD_FROM",
			            label : "가입 시작일",
			            width : 110,
			            align : "center"
			        },{
			            key : "TERM_PERIOD_TO",
			            label : "가입 종료일",
			            width : 110,
			            align : "center"
			        },{
			            key : "STUDY_PERIOD_FROM",
			            label : "학습 시작일",
			            width : 110,
			            align : "center"
			        },{
			            key : "STUDY_PERIOD_TO",
			            label : "학습 종료일",
			            width : 110,
			            align : "center"
			        },{
			            key : "C_PERIOD",
			            label : "교육일수",
			            width : 80,
			            align : "right"
			        }
		        ]
	        },{
	        	key : "CLOSE_YN", 
	        	label : "강의 종료 여부", 
	            width : 110,
	        	align : "center", 
	        	editor : { 
	        		type : "checkbox", 
	        		config : {height: 17, trueValue: "Y", falseValue: "N"},
	            	disabled : function () {
                        return true;
                    } 
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
	  		showRowSelector : false,
	  		frozenColumnIndex : 5
	  	}
	);
	
	$(window).trigger("resize");
}

function fn_params() {
	params.LEVEL1_CODE = $("#CB_LEVEL1 option:selected").val();	
	params.LEVEL2_CODE = $("#CB_LEVEL2 option:selected").val();	
	params.LEVEL3_CODE = $("#CB_LEVEL3 option:selected").val();	
	params.OPEN_KIND = $("#CB_OPEN_KIND option:selected").val();	
	params.YEAR = $("#CB_YEAR option:selected").val();	
	params.chasu = $("#chasu").val();	
	params.courseName = $("#courseName").val();	
}

function fn_search() {
	//mask.open();
	fn_params();
	
	if ( params.chasu != "" && isNaN(params.chasu) ) {
		mask.open();
		dialog.alert( { msg : "차수는 정수를 입력하셔야 합니다." }, function () { mask.close(); } );
		return false;
	}
	
	gfn_callAjax("/course/axCourseList.do", params, fn_callbackAjax, "search");
}


function fn_callbackAjax(data, id) {
	//console.log("fn_callbackAjax : " + id);
	if ( id == "search" ) {
		grid.setData(data.list);
		
		//mask.close();
	} else if ( id == "dd" ){
		dd = $.extend({}, data);
		
		gfn_cbRefresh("CB_LEVEL1", data.CategoryLevel1, true);

		gfn_cbRefresh("CB_OPEN_KIND", data.OpenKind, true);
		gfn_cbRefresh("CB_YEAR", data.Year, true);

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

<h2>강의 관리</h2>
<div style="height:10px"></div>

<div class="form-inline">
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
</div>
<div style="height:10px"></div>
<div class="form-inline">
  	<div class="form-group">
    	<label for="CB_OPEN_KIND">&nbsp;오픈구분</label>
		<select class="form-control" id="CB_OPEN_KIND">
			<option value="">전체</option>
		</select>
  	</div>
  	<div class="form-group">
    	<label for="CB_YEAR">&nbsp;년도</label>
		<select class="form-control" id="CB_YEAR">
			<option value="">전체</option>
		</select>
  	</div>
  	<div class="form-group">
    	<label for="chasu">&nbsp;차수</label>
    	<input type="text" class="form-control" id="chasu" name="chasu">
  	</div>
</div>
<div style="height:10px"></div>

<div>
    <button class="btn btn-default" data-grid-control="search">검색</button>
    <button class="btn btn-default" data-grid-control="export">엑셀</button>
    <button class="btn btn-default" data-grid-control="viewContent">학습내용</button>
    <button class="btn btn-default" data-grid-control="viewImage">강의 이미지</button>
    <button class="btn btn-default" data-grid-control="courseRegister">수강신청</button>
    <button class="btn btn-default" data-grid-control="courseNotApprovalRegister">미결재 수강신청</button>
</div>

<div style="height:10px"></div>


<div style="position: relative;height:400px;" id="grid-parent">
    <div data-ax5grid="first-grid" style="height: 100%;"></div>
</div>

</form>

<div class="mask"></div>


</body>
</html>

