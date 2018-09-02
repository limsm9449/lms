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

var ddWeek = [];
var isSave = false;

$(document.body).ready(function () {
    confirmDialog.setConfig({
        theme: "danger"
    });
    
    var weekCnt = gfn_getUrlParams("WEEK_CNT");
    for ( var i = 0; i < weekCnt; i++ ) {
    	ddWeek.push({	CD : i + 1, NM : (i + 1) + " 주차"	});
    }
    
	grid = gfn_makeAx5Grid("first-grid",
		[ 	{
	            key : "EXAM_KIND",
	            label : "시험 종류",
	            width : 100,
	            align : "center", 
	            editor: {
                    type : "select", 
                    config : {
                        columnKeys: { optionValue: "CD", optionText: "NM" },
                        options: [
                            {CD: "TOTAL", NM: "전체 시험"},
                            {CD: "WEEK", NM: "주별 시험"}
                        ]
                    } 
	        	},
	            formatter : function () {
	            	if ( this.item.EXAM_KIND == "WEEK" )
	            		return "주별 시험";
	            	else if ( this.item.EXAM_KIND == "TOTAL" )
	                	return "전체 시험";
	            	else 
	                	return "-";
	           	},
				styleClass: function () {
                    return "grid-cell-edit";
                }
	        },{
	            key : "WEEK_FROM",
	            label : "주차 From",
	            width : 100,
	            align : "center", 
	        	editor: {
                    type : "select", 
                    config : {
                        columnKeys: { optionValue: "CD", optionText: "NM" },
                        options: ddWeek
                    } 
	        	},
	            formatter : function () {
	            	return ( this.item.WEEK_FROM == undefined ? 1 : this.item.WEEK_FROM ) + " 주차";
	           	},
				styleClass: function () {
                    return "grid-cell-edit";
                }
	        },{
	        	key : "WEEK_TO", 
	        	label : "주차 To", 
	            width : 100,
	        	align : "center", 
	        	editor: {
                    type : "select", 
                    config : {
                        columnKeys: { optionValue: "CD", optionText: "NM" },
                        options: ddWeek
                    } 
	        	},
	            formatter : function () {
	            	return ( this.item.WEEK_TO == undefined ? 1 : this.item.WEEK_TO ) + " 주차";
	           	},
				styleClass: function () {
					return "grid-cell-edit";
                }
	        },{
	        	key : "TYPE", 
	        	label : "문제타입", 
	            width : 90,
	        	align : "center",
	        	editor: {
                    type : "select", 
                    config : {
                        columnKeys: { optionValue: "CD", optionText: "NM" },
                        options: [
                            {CD: "G", NM: "객관식"},
                            {CD: "J", NM: "주관식"}
                        ]
                    } 
	        	},
	            formatter : function () {
	            	if ( this.item.TYPE == "G" )
	            		return "객관식";
	            	else if ( this.item.TYPE == "J" )
	            		return "주관식";
	            	else 
	                	return "-";
	           	},
				styleClass: function () {
                    return "grid-cell-edit";
                }
	        },{
	        	key : "LEVEL", 
	        	label : "난이도", 
	            width : 80,
	        	align : "center",
	        	editor: {
                    type : "select", 
                    config : {
                        columnKeys: { optionValue: "CD", optionText: "NM" },
                        options: [
                            {CD: "1", NM: "상"},
                            {CD: "2", NM: "중"},
                            {CD: "3", NM: "하"}
                        ]
                    } 
	        	},
	            formatter : function () {
	            	if ( this.item.LEVEL == "1" )
	            		return "상";
	            	else if ( this.item.LEVEL == "2" )
	            		return "중";
	            	else if ( this.item.LEVEL == "3" )
	            		return "하";
	            	else 
	                	return "-";
	           	},
				styleClass: function () {
                    return "grid-cell-edit";
                }
	        },{
	        	key : "QUESTION_CNT", 
	        	label : "문항수", 
	            width : 80,
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
	  		showRowSelector : false
	  	}
	);
	
    $('[data-grid-control]').click(function () {
        switch (this.getAttribute("data-grid-control")) {
	        case "search":
	            fn_search();
	            break;
            case "add":
            	grid.addRow({NEW_FLAG : "Y", EXAM_TYPE_SEQ : params.EXAM_TYPE_SEQ, EXAM_KIND : "TOTAL", WEEK_FROM : 1, WEEK_TO : 1, LEVEL : 3, QUESTION_CNT : 0, USE_YN : "Y"}, "last", {focus: "END"});
                break;
            case "delete":
                grid.deleteRow("selected");
                break;
            case "save" :
            	fn_save();
                break;
            case "close" :
            	if ( isSave ) {
            		opener.fn_search();
            	}
            	
            	window.close();
                break;
        }
    });
    
    fn_search();
});

function fn_params() {
	params.EXAM_TYPE_SEQ = gfn_getUrlParams("EXAM_TYPE_SEQ");
	params.QUESTION_CNT = gfn_getUrlParams("QUESTION_CNT");
}

function fn_search() {
	//mask.open();
	
	fn_params();
	
	gfn_callAjax("/course/axCourseExamTypeStandardList.do", params, fn_callbackAjax, "search");
}

function fn_save() {
	var fieldParams = {
		QUESTION_CNT : { mendatory : true, colName : "문항수", type : "number" }
   	};
   	if ( gfn_validationCheck(grid, fieldParams) ) {
       	mask.open();

		var questionCnt = 0;
       	var allList = grid.getList();
       	for ( var i = 0; i < allList.length; i++ ) {
       		if ( allList[i].USE_YN == "Y" ) {
       			questionCnt = allList[i].QUESTION_CNT;
       		}
       	}
       	if ( parseInt(questionCnt) > parseInt(params.QUESTION_CNT) ) {
			mask.open();
			dialog.alert( { msg : "전체 문항수는 " + params.QUESTION_CNT + "입니다." }, function () { mask.close(); } );
			return false;
       	}

       	confirmDialog.confirm(
       		{
               	title: "Confirm",
               	msg: '저장하시겠습니까?'
           	}, 
           	function(){
             	if ( this.key == "ok" ) {
             		gfn_callAjax("/course/axCourseExamTypeStandardSave.do", gfn_getSaveData(grid), fn_callbackAjax, "save");
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
	}
}

function fn_gridEvent(event, obj) {
	if ( event == "Click" ) {
		obj.self.select(obj.dindex);
	} else if ( event == "DBLClick" ) {
	} else if ( event == "DataChanged" ) {
		/*
		if ( obj.item.EXAM_KIND == "WEEK" ) {
			if ( obj.key == "EXAM_KIND" || obj.key == "WEEK_FROM" ) {
				grid.setValue(obj.item.__index, "WEEK_TO", obj.item.WEEK_FROM);
			}
		}
		*/
	}
}

</script>

<body style="padding : 10px">

<form id="frm" name="frm" method="post">

<h2>과정 시험 유형 기준 관리</h2>
<div style="height:10px"></div>

<div>
    <button class="btn btn-default" data-grid-control="add">추가</button>
    <button class="btn btn-default" data-grid-control="delete">삭제</button>
    <button class="btn btn-default" data-grid-control="save">저장</button>
    <button class="btn btn-default" data-grid-control="close">닫기</button>
</div>

<div style="height:10px"></div>


<div style="position: relative;height:360px;" id="grid-parent">
    <div data-ax5grid="first-grid" style="height: 100%;"></div>
</div>


</form>
	

</body>
</html>

