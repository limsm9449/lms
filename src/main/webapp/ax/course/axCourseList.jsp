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
    
    gfn_callAjax("/common/axDd.do", { DD_KIND : "CategoryLevel1,Tutor,Company,OpenKind,Year" }, fn_callbackAjax, "dd", { async : false });
    
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
            case "copy":
            	var row = grid.getList("selected");
            	if ( row.length == 0 ) {
            		mask.open();
            		dialog.alert( { msg : "과정을 선택하셔야 합니다." }, function () { mask.close();	} );
            		return;
            	}
            	
            	$('#MCB_COMPANY').multiselect('deselectAll', false);
            	$('#MCB_COMPANY').multiselect('rebuild');
            	
		    	gfn_showPopupDiv("companyDiv");

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
            case "tutor":
            	var row = grid.getList("selected");
            	if ( row.length == 0 ) {
            		mask.open();
            		dialog.alert( { msg : "과정을 선택하셔야 합니다." }, function () { mask.close();	} );
            	} else {
            		var urlParams = "page=/ax/course/axCourseTutorPopup";
            		urlParams += "&COURSE_ID=" + row[0]["COURSE_ID"];
            		
            		f_popup('/common/axOpenPage', {displayName:'courseTutorPopup',option:'width=500,height=350', urlParams:urlParams});
            	}
            		
                break;
            case "userTutor":
            	var row = grid.getList("selected");
            	if ( row.length == 0 ) {
            		mask.open();
            		dialog.alert( { msg : "과정을 선택하셔야 합니다." }, function () { mask.close();	} );
            	} else { 
            		var urlParams = "page=/ax/course/axCourseUserTutorPopup";
            		urlParams += "&COURSE_ID=" + row[0]["COURSE_ID"];
            		
            		f_popup('/common/axOpenPage', {displayName:'courseTutorPopup',option:'width=400,height=700', urlParams:urlParams});
            	}
            		
                break;
            case "viewContent":
            	var row = grid.getList("selected");
            	if ( row.length == 0 ) {
            		mask.open();
            		dialog.alert( { msg : "과정을 선택하셔야 합니다." }, function () { mask.close();	} );
            	} else {
            		var urlParams = "page=/ax/course/axCourseContentsPopup";
            		urlParams += "&COURSE_ID=" + row[0]["COURSE_ID"];
            		
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
	            key : "USER_CNT",
	            label : "수강생",
	            width : 70,
	            align : "right"
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
                    }
	        	},
	            formatter : function () {
	                return gfn_getValueInList(dd.Company, "value",  this.item.COMP_CD, "text");
	           	},
				styleClass: function () {
                    return "grid-cell-edit";
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
	            key : "TUTOR_CNT",
	            label : "복수 튜터",
	            width : 80,
	            align : "right"
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
                },
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
			                return ax5.util.number(this.item.REPORT_RATE) + ax5.util.number(this.item.EXAM_RATE) + ax5.util.number(this.item.DISCUSSION_RATE) + ax5.util.number(this.item.PROGRESS_RATE);
			           	},
						styleClass: function () {
		                    return "";
		                }
			        }
		        ]
	        },{
	        	key : "COURSE_EXAM_TYPE_NAME", 
	        	label : "시험 유형", 
	            width : 150,
	        	align : "left", 
				styleClass: function () {
                    return "grid-cell-edit2";
                } 
	        },{
              	key : undefined, 
              	label: "과락 기준 (100점 기준)", 
              	columns: [	        
			        {
			            key : "REPORT_FAIL",
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
			            key : "EXAM_FAIL",
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
			            key : "DISCUSSION_FAIL",
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
			            key : "PROGRESS_FAIL",
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
			            key : "TOTAL_FAIL",
			            label : "총점",
			            width : 90,
			            align : "right",
			            editor : { 
			            	type : "number"
						},
						styleClass: function () {
		                    return "grid-cell-edit"; 
		                }
			        }
		        ]
	        },{
              	key : undefined, 
              	label: "기간", 
              	columns: [	        
              		{
        	        	key : "TERM_YN", 
        	        	label : "가입기간 여부", 
        	            width : 110,
        	        	align : "center", 
        	        	editor : { type : "checkbox", config : {height: 17, trueValue: "Y", falseValue: "N"} } ,
        				styleClass: function () {
                            return "grid-cell-edit";
                        } 
        	        },{
			            key : "TERM_PERIOD_FROM",
			            label : "가입 시작일",
			            width : 110,
			            align : "center",
			            editor : { 
			            	type : "date"
						},
						styleClass: function () {
		                    return "grid-cell-edit";
		                }
			        },{
			            key : "TERM_PERIOD_TO",
			            label : "가입 종료일",
			            width : 110,
			            align : "center",
			            editor : { 
			            	type : "date"
						},
						styleClass: function () {
		                    return "grid-cell-edit";
		                }
			        },{
			            key : "STUDY_PERIOD_FROM",
			            label : "학습 시작일",
			            width : 110,
			            align : "center",
			            editor : { 
			            	type : "date"
						},
						styleClass: function () {
		                    return "grid-cell-edit";
		                }
			        },{
			            key : "STUDY_PERIOD_TO",
			            label : "학습 종료일",
			            width : 110,
			            align : "center",
			            editor : { 
			            	type : "date"
						},
						styleClass: function () {
		                    return "grid-cell-edit";
		                }
			        },{
			            key : "C_PERIOD",
			            label : "교육일수",
			            width : 80,
			            align : "right",
			            editor : { 
			            	type : "number"
						},
						styleClass: function () {
		                    return "grid-cell-edit";
		                },
			            formatter : function () {
			                return this.item.C_PERIOD + " 일";
			           	}
			        }
		        ]
	        },{
	        	key : "MOBILE_YN", 
	        	label : "모바일", 
	            width : 60,
	        	align : "center", 
	        	editor : { type : "checkbox", config : {height: 17, trueValue: "Y", falseValue: "N"} } ,
				styleClass: function () {
                    return "grid-cell-edit";
                } 
	        },{
	        	key : "OPEN_YN", 
	        	label : "오픈", 
	            width : 90,
	        	align : "center", 
	        	editor : { type : "checkbox", config : {height: 17, trueValue: "Y", falseValue: "N"} } ,
				styleClass: function () {
                    return "grid-cell-edit";
                } 
	        },{
	        	key : "POPULAR_YN", 
	        	label : "인기 과정", 
	            width : 80,
	        	align : "center", 
	        	editor : { type : "checkbox", config : {height: 17, trueValue: "Y", falseValue: "N"} } ,
				styleClass: function () {
                    return "grid-cell-edit";
                } 
	        },{
	        	key : "RECOMMEND_COURSE_YN", 
	        	label : "추천과정", 
	            width : 80,
	        	align : "center", 
	        	editor : { type : "checkbox", config : {height: 17, trueValue: "Y", falseValue: "N"} } ,
				styleClass: function () {
                    return "grid-cell-edit";
                } 
	        },{
	        	key : "NEW_COURSE_YN", 
	        	label : "신규과정", 
	            width : 80,
	        	align : "center", 
	        	editor : { type : "checkbox", config : {height: 17, trueValue: "Y", falseValue: "N"} } ,
				styleClass: function () {
                    return "grid-cell-edit";
                } 
	        },{
	        	key : "CATEGORY_MAIN_YN", 
	        	label : "카테고리별 메인 과정", 
	            width : 150,
	        	align : "center", 
	        	editor : { type : "checkbox", config : {height: 17, trueValue: "Y", falseValue: "N"} } ,
				styleClass: function () {
                    return "grid-cell-edit";
                } 
	        },{
	        	key : "CLOSE_YN", 
	        	label : "강의 종료", 
	            width : 80,
	        	align : "center", 
	        	editor : { type : "checkbox", config : {height: 17, trueValue: "Y", falseValue: "N"} } ,
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
	  		showRowSelector : false,
	  		frozenColumnIndex : 5
	  	}
	);
	
	$(window).trigger("resize");
}

function fn_hidePopupDiv(popupDivId, mode) {
	if ( popupDivId == "insDiv" ) {
		if ( $("#INS_CB_LEVEL1 option:selected").val() == "" || $("#INS_CB_LEVEL2 option:selected").val() == "" || $("#INS_CB_LEVEL3 option:selected").val() == "" ) {
			gfn_hidePopupDiv(popupDivId);
			
			mask.open();
			dialog.alert( { msg : "대/중/소분류를 선택하셔야 합니다." }, function () { mask.close(); gfn_showPopupDiv(popupDivId); } );
			return;
		} 
	
		if ( $("#INS_CB_COURSE_CODE option:selected").val() == "" ) {
			gfn_hidePopupDiv(popupDivId);

			mask.open();
			dialog.alert( { msg : "과정을 선택하셔야 합니다." }, function () { mask.close(); gfn_showPopupDiv(popupDivId); } );
			return;
		} 
	
		grid.addRow( 
			{
				NEW_FLAG : "Y", 
				CATEGORY_NAME : $("#INS_CB_LEVEL1 option:selected").text() + " > " + $("#INS_CB_LEVEL2 option:selected").text() + " > " + $("#INS_CB_LEVEL3 option:selected").text(), 
				CODE : $("#INS_CB_LEVEL3 option:selected").val(), 
				COURSE_CODE : $("#INS_CB_COURSE_CODE option:selected").val(), 
				COURSE_NAME : $("#INS_CB_COURSE_CODE option:selected").text(),
				COMP_CD : 'B2C',
				TUTOR_ID : gfn_findValueInList(dd.CourseCode, "value", $("#INS_CB_COURSE_CODE option:selected").val(), "TUTOR_ID"),
				TUTOR_CNT : 0,
				COURSE_COST : gfn_findValueInList(dd.CourseCode, "value", $("#INS_CB_COURSE_CODE option:selected").val(), "COURSE_COST"),
				REPORT_RATE : gfn_findValueInList(dd.CourseCode, "value", $("#INS_CB_COURSE_CODE option:selected").val(), "REPORT_RATE"),
				EXAM_RATE : gfn_findValueInList(dd.CourseCode, "value", $("#INS_CB_COURSE_CODE option:selected").val(), "EXAM_RATE"),
				DISCUSSION_RATE : gfn_findValueInList(dd.CourseCode, "value", $("#INS_CB_COURSE_CODE option:selected").val(), "DISCUSSION_RATE"),
				PROGRESS_RATE : gfn_findValueInList(dd.CourseCode, "value", $("#INS_CB_COURSE_CODE option:selected").val(), "PROGRESS_RATE"),
				COURSE_EXAM_TYPE_NAME : "",
				REPORT_FAIL : 0,
				EXAM_FAIL : 0,
				DISCUSSION_FAIL : 0,
				PROGRESS_FAIL : 0,
				TOTAL_FAIL : 0,
				OPEN_YN : "N",
				TERM_YN : "N",
				TERM_PERIOD_FROM : "",
				TERM_PERIOD_TO : "",
				STUDY_PERIOD_FROM : "",
				STUDY_PERIOD_TO : "",
				C_PERIOD : 30,
				POPULAR_YN : "N",
				CLOSE_YN : "N",
				MOBILE_YN : gfn_findValueInList(dd.CourseCode, "value", $("#INS_CB_COURSE_CODE option:selected").val(), "MOBILE_YN"),
				RECOMMEND_COURSE_YN : "N",
				NEW_COURSE_YN : "N",
				CATEGORY_MAIN_YN : "N"
			}, "last", {focus: "END"});
	} else if ( popupDivId == "examTypeDiv" ) {
		if ( mode == "delete" ) {
			var row = grid.getList("selected");
			grid.setValue(row[0].__index, "COURSE_EXAM_TYPE_ID", '');
			grid.setValue(row[0].__index, "COURSE_EXAM_TYPE_NAME", '');
		} else {
			if ( $("#CB_EXAM_TYPE option:selected").val() == "" ) {
				gfn_hidePopupDiv(popupDivId);
				
				mask.open();
				dialog.alert( { msg : "시험 유형을 선택하셔야 합니다." }, function () { mask.close(); gfn_showPopupDiv(popupDivId); } );
				return;
			} 
	
			var row = grid.getList("selected");
			grid.setValue(row[0].__index, "COURSE_EXAM_TYPE_ID", $("#CB_EXAM_TYPE option:selected").val());
			grid.setValue(row[0].__index, "COURSE_EXAM_TYPE_NAME", $("#CB_EXAM_TYPE option:selected").text());
		}
	} else if ( popupDivId == "companyDiv" ) {
		var companys = $("#MCB_COMPANY").val();
		if ( companys.length == 0 ) {
			gfn_hidePopupDiv(popupDivId);
			
			mask.open();
			dialog.alert( { msg : " 회사를 선택하셔야 합니다." }, function () { mask.close(); gfn_showPopupDiv(popupDivId); } );
			return;
		} 

		var row = grid.getList("selected");
		for ( var i = 0; i < companys.length; i++ ) {
			grid.addRow( 
				{
					NEW_FLAG : "Y", 
					CATEGORY_NAME : row[0].CATEGORY_NAME, 
					CODE : row[0].CODE, 
					COURSE_CODE : row[0].COURSE_CODE, 
					COURSE_NAME : row[0].COURSE_NAME, 
					COMP_CD : companys[i],
					TUTOR_ID : row[0].TUTOR_ID,
					COURSE_COST : row[0].COURSE_COST,
					REPORT_RATE : row[0].REPORT_RATE,
					EXAM_RATE : row[0].EXAM_RATE,
					DISCUSSION_RATE : row[0].DISCUSSION_RATE,
					PROGRESS_RATE : row[0].PROGRESS_RATE,
					REPORT_FAIL : row[0].REPORT_FAIL,
					EXAM_FAIL : row[0].EXAM_FAIL,
					COURSE_EXAM_TYPE_NAME : row[0].COURSE_EXAM_TYPE_NAME,
					DISCUSSION_FAIL : row[0].DISCUSSION_FAIL,
					PROGRESS_FAIL : row[0].PROGRESS_FAIL,
					TOTAL_FAIL : row[0].TOTAL_FAIL,
					TERM_YN : row[0].TERM_YN,
					TERM_PERIOD_FROM : row[0].TERM_PERIOD_FROM,
					TERM_PERIOD_TO : row[0].TERM_PERIOD_TO,
					STUDY_PERIOD_FROM : row[0].STUDY_PERIOD_FROM,
					STUDY_PERIOD_TO : row[0].STUDY_PERIOD_TO,
					C_PERIOD : row[0].C_PERIOD,
					POPULAR_YN : "N",
					CLOSE_YN : "N",
					MOBILE_YN : row[0].MOBILE_YN,
					RECOMMEND_COURSE_YN : "N",
					NEW_COURSE_YN : "N",
					CATEGORY_MAIN_YN : "N"
				}, "last", {focus: "END"});
			
			grid.repaint();
		}
	}

	gfn_hidePopupDiv(popupDivId);
}

function fn_params() {
	params.LEVEL1_CODE = $("#CB_LEVEL1 option:selected").val();	
	params.LEVEL2_CODE = $("#CB_LEVEL2 option:selected").val();	
	params.LEVEL3_CODE = $("#CB_LEVEL3 option:selected").val();	
	params.COMPANY = $("#CB_COMPANY option:selected").val();	
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

function fn_save() {
	var fieldParams = {
		TUTOR_ID : { mendatory : true, colName : "튜터" },
		COURSE_COST : { mendatory : true, colName : "과정비용", type : "number" },
		REPORT_RATE : { mendatory : true, colName : "레포트", type : "number" },
		EXAM_RATE : { mendatory : true, colName : "시험", type : "number" },
		DISCUSSION_RATE : { mendatory : true, colName : "토론", type : "number" },
		PROGRESS_RATE : { mendatory : true, colName : "강의진도", type : "number" },
		C_PERIOD : { colName : "교육일수", type : "number" }
   	};
   	if ( gfn_validationCheck(grid, fieldParams) ) {
       	var allList = grid.getList();
       	for ( var i = 0; i < allList.length; i++ ) {
       		if ( parseInt(allList[i].REPORT_RATE) + parseInt(allList[i].EXAM_RATE) + parseInt(allList[i].DISCUSSION_RATE) + parseInt(allList[i].PROGRESS_RATE) != 100 ) {
    			mask.open();
    			dialog.alert( { msg : (allList[i].__index + 1) + "라인의" + "점수 비율을 100이여야 합니다." }, function () { mask.close(); } );
    			return false;
       		}
       		if ( gfn_getString(allList[i].TERM_YN) == "Y" && (gfn_getString(allList[i].TERM_PERIOD_FROM) == "" || gfn_getString(allList[i].TERM_PERIOD_TO) == "")) {
    			mask.open();
    			dialog.alert( { msg : (allList[i].__index + 1) + "라인의" + "가입 시작일/종료일을 입력하셔야 합니다." }, function () { mask.close(); } );
    			return false; 
       		}
       		if ( (gfn_getString(allList[i].STUDY_PERIOD_FROM) == "" && gfn_getString(allList[i].STUDY_PERIOD_TO) == "" && allList[i].C_PERIOD == 0) ||
       		     (gfn_getString(allList[i].STUDY_PERIOD_FROM) != "" && gfn_getString(allList[i].STUDY_PERIOD_TO) != "" && allList[i].C_PERIOD > 0) ) {
    			mask.open();
    			dialog.alert( { msg : (allList[i].__index + 1) + "라인의" + "학습 시작일/종료일과 교육일수 중 하나를 입력하셔야 합니다." }, function () { mask.close(); } );
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
             		gfn_callAjax("/course/axCourseSave.do", gfn_getSaveData(grid), fn_callbackAjax, "save");
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

		gfn_cbRefresh("CB_OPEN_KIND", data.OpenKind, true);
		$("#CB_OPEN_KIND").val("NOT_CLOSE");
		gfn_cbRefresh("CB_YEAR", data.Year, true);

		fn_makeGrid();
		//fn_search();
		
		gfn_mcbRefresh("MCB_COMPANY", data.Company, false);
		$('#MCB_COMPANY').multiselect('rebuild');
	} else if ( id == "CB_LEVEL1" ){
		gfn_cbRefresh("CB_LEVEL2", data.CategoryLevel2, true);
	} else if ( id == "CB_LEVEL2" ){
		gfn_cbRefresh("CB_LEVEL3", data.CategoryLevel3, true);
	} else if ( id == "INS_CB_LEVEL1" ){
		gfn_cbRefresh("INS_CB_LEVEL2", data.CategoryLevel2, true);
	} else if ( id == "INS_CB_LEVEL2" ){
		gfn_cbRefresh("INS_CB_LEVEL3", data.CategoryLevel3, true);
	} else if ( id == "INS_CB_COURSE_CODE" ){
		dd.CourseCode = data.CourseCode;
		gfn_cbRefresh("INS_CB_COURSE_CODE", data.CourseCode, true);
	} else if ( id == "ExamType" ){
		gfn_cbRefresh("CB_EXAM_TYPE", data.ExamType, true);
	} else if ( id == "save" ){
		mask.close();

		mask.open();
		dialog.alert( { msg : "저장 되었습니다." }, function () { mask.close();	fn_search(); } );
	}
}

function fn_gridEvent(event, obj) {
	if ( event == "Click" ) {
		obj.self.select(obj.dindex);
	} else if ( event == "DBLClick" ) {
		if ( obj.column.key == "COURSE_EXAM_TYPE_NAME" ) {
	    	gfn_showPopupDiv("examTypeDiv");
			
	    	gfn_callAjax("/common/axDd.do", { DD_KIND : "ExamType", COURSE_CODE : obj.item.COURSE_CODE }, fn_callbackAjax, "ExamType", { async : false });
		}
	} else if ( event == "DataChanged" ) {
		if ( obj.key == "COURSE_EXAM_TYPE_NAME" ||
				obj.key == "REPORT_RATE" ||
				obj.key == "EXAM_RATE" ||
				obj.key == "DISCUSSION_RATE" ||
				obj.key == "PROGRESS_RATE" ) {
			grid.repaint();
		}
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
	    gfn_callAjax("/common/axDd.do", { DD_KIND : "CourseCode", LEVEL3_CODE : $("#INS_CB_LEVEL3 option:selected").val()}, fn_callbackAjax, "INS_CB_COURSE_CODE", { async : false });
	}
}


</script>

<body style="padding : 10px">

<h2>강의 관리</h2>
<div style="height:10px"></div>

<form id="frm" name="frm" method="post">
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
	    	<label for="CB_COMPANY">&nbsp;회사 구분</label>
			<select class="form-control" id="CB_COMPANY">
				<option value="">전체</option>
				<option value="B2C">일반사용자</option>
				<option value="B2B">회사</option>
			</select>
	  	</div>
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
</form>

<div style="height:10px"></div>

<div>
    <button class="btn btn-default" data-grid-control="search">검색</button>
    <button class="btn btn-default" data-grid-control="add">추가</button>
    <button class="btn btn-default" data-grid-control="copy">강의 복사</button>
    <button class="btn btn-default" data-grid-control="delete">삭제</button>
    <button class="btn btn-default" data-grid-control="reset">초기화</button>
    <button class="btn btn-default" data-grid-control="save">저장</button>
    <button class="btn btn-default" data-grid-control="export">엑셀</button>
    <button class="btn btn-default" data-grid-control="tutor">복수튜터</button>
    <button class="btn btn-default" data-grid-control="userTutor">담당튜터</button>
    <button class="btn btn-default" data-grid-control="viewContent">학습내용 편집</button>
    <button class="btn btn-default" data-grid-control="viewImage">강의 이미지</button>
</div>

<div style="height:10px"></div>


<div style="position: relative;height:400px;" id="grid-parent">
    <div data-ax5grid="first-grid" style="height: 100%;"></div>
</div>

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
	
<div class="popupDiv" id="examTypeDiv" style="width:200px; height:100px;">
	시험 유형
	<select id="CB_EXAM_TYPE">
	</select>
	<div style="height:30px"></div>
	<input type="button" href="#" value="삭제" onclick="fn_hidePopupDiv('examTypeDiv', 'delete')"/>
	<input type="button" href="#" value="확인" onclick="fn_hidePopupDiv('examTypeDiv')"/>
    <input type="button" href="#" value="닫기" onclick="gfn_hidePopupDiv('examTypeDiv');"/>
</div>

<div class="popupDiv" id="companyDiv" style="width:300px; height:200px;">
	복사할 회사 선택
	<div class="btn-group">
	<select id="MCB_COMPANY" multiple="multiple">
		<option>a</option>
		<option>b</option>
		<option>c</option>
	</select>
	<div style="height:30px"></div>
	<input type="button" href="#" value="복사" onclick="fn_hidePopupDiv('companyDiv')"/>
    <input type="button" href="#" value="닫기" onclick="gfn_hidePopupDiv('companyDiv');"/>
</div>


</body>
</html>

