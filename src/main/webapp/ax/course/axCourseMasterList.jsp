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
var ddWeekCost = [
	{value : "Y", text : "차시별"},
    {value : "N", text : "과정별"}
];

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
            	var allList = grid.getList();
            	if ( gfn_getValueInList(allList, "NEW_FLAG",  "Y", "NEW_FLAG") == "Y" ) {
            		mask.open();
            		dialog.alert( { msg : "추가된 데이타가 있습니다. 저장후에 다시 추가를 해주세요." }, function () { mask.close();	} );
            		return;
            	}
            	
            	Popup.showCourseCode({ ddKind : "UnregisteredCourseCode" });

		    	break;
            case "delete":
            	var row = grid.getList("selected");
            	if ( row.length == 0 ) {
            		mask.open();
            		dialog.alert( { msg : "과정을 선택하셔야 합니다." }, function () { mask.close();	} );
            		return;
            	} else if ( row[0]["NEW_FLAG"] == "Y" ) {
            		mask.open();
            		dialog.alert( { msg : "신규로 추가한 경우는 저장후에 작업을 하셔야 합니다." }, function () { mask.close();	} );
            	}
            	if ( row[0]["NEXT_CREATE_FLAG"] == "Y" ) {
            		mask.open();
            		dialog.alert( { msg : "과정 평가을 먼저 삭제하셔야 합니다." }, function () { mask.close();	} );
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
            	} else if ( row[0]["NEW_FLAG"] == "Y" ) {
            		mask.open();
            		dialog.alert( { msg : "신규로 추가한 경우는 저장후에 작업을 하셔야 합니다." }, function () { mask.close();	} );
            	} else {
            		var urlParams = "page=/ax/course/axCourseMasterContentsPopup";
            		urlParams += "&COURSE_CODE=" + row[0]["COURSE_CODE"];
            		
            		f_popup('/common/axOpenPage', {displayName:'courseMasterContentsPopup',option:'width=900,height=600', urlParams:urlParams});
            	}
            		
                break;
            case "editImage":
            	var row = grid.getList("selected");
            	if ( row.length == 0 ) {
            		mask.open();
            		dialog.alert( { msg : "과정을 선택하셔야 합니다." }, function () { mask.close();	} );
            	} else if ( row[0]["NEW_FLAG"] == "Y" ) {
            		mask.open();
            		dialog.alert( { msg : "신규로 추가한 경우는 저장후에 작업을 하셔야 합니다." }, function () { mask.close();	} );
            	} else {
            		var urlParams = "page=/ax/course/axCourseMasterImagePopup";
            		urlParams += "&COURSE_CODE=" + row[0]["COURSE_CODE"];
            		
            		f_popup('/common/axOpenPage', {displayName:'courseMasterImagePopup',option:'width=900,height=650', urlParams:urlParams});
            	}
            		
                break;
            case "editWeekCost":
            	var row = grid.getList("selected");
            	if ( row.length == 0 ) {
            		mask.open();
            		dialog.alert( { msg : "과정을 선택하셔야 합니다." }, function () { mask.close();	} );
            	} else if ( row[0]["NEW_FLAG"] == "Y" ) {
            		mask.open();
            		dialog.alert( { msg : "신규로 추가한 경우는 저장후에 작업을 하셔야 합니다." }, function () { mask.close();	} );
            	} else if ( row[0]["WEEK_COST_YN"] == "N" ) {
            		mask.open();
            		dialog.alert( { msg : "차시별 과정비용 과정이 아닙니다." }, function () { mask.close();	} );
            	} else {
            		var urlParams = "page=/ax/course/axCourseMasterWeekCostPopup";
            		urlParams += "&COURSE_CODE=" + row[0]["COURSE_CODE"] + "&COURSE_COST=" + row[0]["COURSE_COST"];
            		
            		f_popup('/common/axOpenPage', {displayName:'courseMasterWeekCostPopup',option:'width=800,height=820', urlParams:urlParams});
            	}
            		
                break;
            case "contentsView":
            	var row = grid.getList("selected");
            	if ( row.length == 0 ) {
            		mask.open();
            		dialog.alert( { msg : "과정을 선택하셔야 합니다." }, function () { mask.close();	} );
            	} else if ( row[0]["NEW_FLAG"] == "Y" ) {
            		mask.open();
            		dialog.alert( { msg : "신규로 추가한 경우는 저장후에 작업을 하셔야 합니다." }, function () { mask.close();	} );
            	} else {
	            	var row = grid.getList("selected");
	            	Popup.showViewContents(row[0]["COURSE_CODE"], "", row[0]["H_PX"], row[0]["V_PX"]);
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
	            align : "left"
	        },{
	        	key : "WEEK_COST_YN", 
	        	label : "결제 유형", 
	            width : 90,
	        	align : "center", 
	        	editor: {
                    type : "select", 
                    config : {
                        columnKeys: { optionValue: "value", optionText: "text" },
                        options: ddWeekCost
                    }
	        	},
	            formatter : function () {
	            	return gfn_getValueInList(ddWeekCost, "value",  this.item.WEEK_COST_YN, "text");
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
	            key : "STUDY_MAX_WEEK",
	            label : "학습 차시 제한",
	            width : 120, 
	            align : "right",
	            editor : { 
	            	type : "number"
				},
				styleClass: function () {
                    return "grid-cell-edit";
                }
	        },{
              	key : undefined, 
              	label: "콘텐츠 유형", 
              	columns: [	        
			        {
			        	key : "RESPONSIVE_CONTENTS_YN", 
			        	label : "모바일 병행", 
			            width : 110, 
			        	align : "center", 
			        	editor : { type : "checkbox", config : {height: 17, trueValue: "Y", falseValue: "N"} },
						styleClass: function () {
		                    return "grid-cell-edit";
		                } 
			        },{
			        	key : "MOBILE_YN", 
			        	label : "모바일 변환",  
			            width : 110, 
			        	align : "center", 
			        	editor : { type : "checkbox", config : {height: 17, trueValue: "Y", falseValue: "N"} },
						styleClass: function () {
		                    return "grid-cell-edit";
						}
			        },{
			        	key : "SMART_LEARNING_YN", 
			        	label : "스마트러닝", 
			            width : 110, 
			        	align : "center", 
			        	editor : { type : "checkbox", config : {height: 17, trueValue: "Y", falseValue: "N"} },
						styleClass: function () {
		                    return "grid-cell-edit";
						}
		        	}
			   	]
	        },{
              	key : undefined, 
              	label: "추가 제공 서비스 유형", 
              	columns: [	        
			        {
			        	key : "BOOK_YN", 
			        	label : "교재", 
			            width : 80, 
			        	align : "center", 
			        	editor : { type : "checkbox", config : {height: 17, trueValue: "Y", falseValue: "N"} },
						styleClass: function () {
		                    return "grid-cell-edit";
		                } 
			        },{
			        	key : "OFFLINE_YN", 
			        	label : "오프라인", 
			            width : 80, 
			        	align : "center", 
			        	editor : { type : "checkbox", config : {height: 17, trueValue: "Y", falseValue: "N"} },
						styleClass: function () {
		                    return "grid-cell-edit";
						}
		        	}
			   	]
	        },{
              	key : undefined, 
              	label: "교육비지원", 
              	columns: [	        
			        {
			            key : "WORKER_CARD_YN",
			            label : "근로자카드",
			            width : 90,
			            align : "center", 
			        	editor : { type : "checkbox", config : {height: 17, trueValue: "Y", falseValue: "N"} },
						styleClass: function () {
		                    return "grid-cell-edit";
		                }
			        },{
			            key : "SUPPORT_EMPLOYER_YN",
			            label : "사업주지원", 
			            width : 90,
			            align : "center", 
			        	editor : { type : "checkbox", config : {height: 17, trueValue: "Y", falseValue: "N"} },
						styleClass: function () {
		                    return "grid-cell-edit";
		                }
			        },{
			            key : "NORMAL_COURSE_YN",
			            label : "일반과정",
			            width : 70,
			            align : "center", 
			        	editor : { type : "checkbox", config : {height: 17, trueValue: "Y", falseValue: "N"} },
						styleClass: function () {
		                    return "grid-cell-edit";
		                }
			        }
		        ]
	        },{
              	key : undefined, 
              	label: "학습내용", 
              	columns: [	        
			        {
			            key : "LEARING_CONTENT_YN",
			            label : "강의소개",
			            width : 80,
			            align : "center"
			        },{
			            key : "LEARING_GOAL_YN",
			            label : "학습목표",
			            width : 80,
			            align : "center"
			        },{
			            key : "LEARING_TARGET_YN",
			            label : "교육대상",
			            width : 80,
			            align : "center"
			        },{
			            key : "EVAL_METHOD_YN",
			            label : "평가방법",
			            width : 80,
			            align : "center"
			        },{
			            key : "LEARING_COST_YN",
			            label : "학습비용",
			            width : 80,
			            align : "center"
			        },{
			            key : "OFFLINE_DESC_YN",
			            label : "오프라인",
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
			            label : "평가",
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
			           	}
			        }
		        ]
	        },{
              	key : undefined, 
              	label: "이미지", 
              	columns: [	        
			        {
			            key : "B_IMG",
			            label : "리스트",
			            width : 80,
			            align : "center"
			        },{
			            key : "C_IMG",
			            label : "수강후기",
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
              	key : undefined, 
              	label: "정산 비용", 
              	columns: [	        
			        {
			        	key : "CP_COST_RATE",
			            label : "CP 비용 비율(%)",
			            width : 130,
			            align : "right",
			            editor : { 
			            	type : "number",
			            	disabled : function () {
		                        return ( this.item.CP_YN != "Y" ? true : false );
		                    }
						},
						styleClass: function () {
		                    return (this.item.CP_YN == "Y" ? "grid-cell-edit" : "");
		                }
			        },{
			            key : "TEACHER_COST_RATE",
			            label : "강사 비용 비율(%)",
			            width : 130,
			            align : "right",
			            editor : { 
			            	type : "number",
			            	disabled : function () {
			            		return ( this.item.OFFLINE_YN == "Y" ? true : false );
		                    }
						},
						styleClass: function () {
							return ( this.item.OFFLINE_YN == "Y" ? "" : "grid-cell-edit");
		                }
			        },{
			            key : "REPORT_COST",
			            label : "레포트 비용",
			            width : 100,
			            align : "right",
			            editor : { 
			            	type : "number",
			            	disabled : function () {
		                        return ( this.item.OFFLINE_YN == "Y" ? true : false );
		                    }
						},
						styleClass: function () {
		                    return ( this.item.OFFLINE_YN == "Y" ? "" : "grid-cell-edit");
		                },
			            formatter : function () {
			                return checkThousand(this.item.REPORT_COST);
			           	}
			        },{
			            key : "EVAL_COST",
			            label : "평가비용",
			            width : 80,
			            align : "right",
			            editor : { 
			            	type : "number",
			            	disabled : function () {
		                        return ( this.item.OFFLINE_YN == "Y" ? true : false );
		                    }
						},
						styleClass: function () {
		                    return ( this.item.OFFLINE_YN == "Y" ? "" : "grid-cell-edit");
		                },
			            formatter : function () {
			                return checkThousand(this.item.EVAL_COST);
			           	}
			        },{
			            key : "DATA_COST",
			            label : "자료실 건당 비용",
			            width : 120,
			            align : "right",
			            editor : { 
			            	type : "number",
			            	disabled : function () {
		                        return ( this.item.OFFLINE_YN == "Y" ? true : false );
		                    }
						},
						styleClass: function () {
		                    return ( this.item.OFFLINE_YN == "Y" ? "" : "grid-cell-edit");
		                },
			            formatter : function () {
			                return checkThousand(this.item.DATA_COST);
			           	}
			        },{
			            key : "ANSWER_COST",
			            label : "답변 건당 비용",
			            width :100,
			            align : "right",
			            editor : { 
			            	type : "number",
			            	disabled : function () {
		                        return ( this.item.OFFLINE_YN == "Y" ? true : false );
		                    }
						},
						styleClass: function () {
		                    return ( this.item.OFFLINE_YN == "Y" ? "" : "grid-cell-edit");
		                },
			            formatter : function () {
			                return checkThousand(this.item.ANSWER_COST);
			           	}
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
	            label : "과정 평가 여부",
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

function fn_courseCodeSelect(data) {
	grid.addRow( 
		{
			NEW_FLAG : "Y", 
			CATEGORY_NAME : data.CB_LEVEL1_NAME + " > " + data.CB_LEVEL2_NAME + " > " + data.CB_LEVEL3_NAME, 
			CODE : data.CB_LEVEL3_CODE, 
			COURSE_CODE : data.CB_COURSE_CODE, 
			COURSE_NAME : data.CB_COURSE_NAME,
			WEEK_COST_YN : "N", 
			PROMOTION_VIDEO_YN : "N",
			COURSE_COST : 0,
			REPORT_RATE : 0,
			EXAM_RATE : 0,
			DISCUSSION_RATE : 0,
			PROGRESS_RATE : 100,
			MOBILE_YN : "N",
			CP_COST_RATE : 0,
			TEACHER_COST_RATE : 0,
			REPORT_COST : 0,
			EVAL_COST : 0,
			DATA_COST : 0,
			ANSWER_COST : 0,
			STUDY_MAX_WEEK : 0,
			WORKER_CARD_YN : 'N',
			SUPPORT_EMPLOYER_YN : 'N',
			NORMAL_COURSE_YN : 'Y',
			OFFLINE_YN : "N"
		}, "last", {focus: "END"}
	);
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
		EXAM_RATE : { mendatory : true, colName : "평가", type : "number" },
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
       		if ( allList[i].RESPONSIVE_CONTENTS_YN == "Y" && allList[i].MOBILE_YN == "Y" ) {
    			mask.open();
    			dialog.alert( { msg : "콘텐츠 유형은 동시에 HTML5 이고 모바일을 수 없습니다." }, function () { mask.close(); } );
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
		
		fn_makeGrid();
		//fn_search();
	} else if ( id == "CB_LEVEL1" ){
		gfn_cbRefresh("CB_LEVEL2", data.CategoryLevel2, true);
	} else if ( id == "CB_LEVEL2" ){
		gfn_cbRefresh("CB_LEVEL3", data.CategoryLevel3, true);
	} else if ( id == "save" ){
		mask.close();

		mask.open();
		dialog.alert( { msg : "저장 되었습니다." }, function () { mask.close();	fn_search(); } );
	}
}

function fn_gridEvent(event, obj) {
	if ( event == "Click" ) {
		obj.self.select(obj.dindex);
	} else if ( event == "DataChanged" ) {
		if ( obj.key == "OFFLINE_YN" ||
				obj.key == "REPORT_RATE" ||
				obj.key == "EXAM_RATE" ||
				obj.key == "DISCUSSION_RATE" ||
				obj.key == "PROGRESS_RATE" ) {
			
			if ( obj.key == "OFFLINE_YN" && obj.item["OFFLINE_YN"] == "Y" ) {
				grid.setValue(obj.item["__index"], "CP_COST_RATE", "0");
				grid.setValue(obj.item["__index"], "TEACHER_COST_RATE", "0");
				grid.setValue(obj.item["__index"], "REPORT_COST", "0");
				grid.setValue(obj.item["__index"], "EVAL_COST", "0");
				grid.setValue(obj.item["__index"], "DATA_COST", "0");
				grid.setValue(obj.item["__index"], "ANSWER_COST", "0");
			}
					
			grid.repaint();
		}
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

<h2>과정 Master 관리</h2>
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
</form>
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
    <button class="btn btn-default" data-grid-control="editWeekCost">차시별 비용</button>
    <button class="btn btn-default" data-grid-control="contentsView">콘텐츠 미리보기</button>
</div>

<div style="height:10px"></div>


<div style="position: relative;height:400px;" id="grid-parent">
    <div data-ax5grid="first-grid" style="height: 100%;"></div>
</div>

<div class="mask"></div>

</body>
</html>

