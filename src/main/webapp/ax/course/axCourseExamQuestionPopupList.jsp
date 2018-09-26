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
	        	key : "TYPE", 
	        	label : "타입", 
	            width : 100,
	        	align : "center", 
	        	editor: {
                    type : "select", 
                    config : {
                        columnKeys: { optionValue: "CD", optionText: "NM" },
                        options: [
                            {CD: "G", NM: "객관식"},
                            {CD: "M", NM: "복수형"},
                            {CD: "J", NM: "주관식"}
                        ]
                    } 
	        	},
	            formatter : function () {
	            	if ( this.item.TYPE == "G" )
	            		return "객관식";
	            	else if ( this.item.TYPE == "M" )
	            		return "복수형";
	            	else 
	                	return "주관식";
	           	},
				styleClass: function () {
                    return "grid-cell-edit";
                }
	        },{
	            key : "QUESTION",
	            label : "질문",
	            width : 300,
	            align : "left",
	            editor : { 
	            	type : "text"
				},
				styleClass: function () {
                    return "grid-cell-edit";
                }
	        },{
	        	key : "QA1", 
	        	label : "1번 답", 
	            width : 80,
	        	align : "left", 
	        	editor : { 
	        		type : "text",
		        	disabled : function () {
	                    return ( this.item.TYPE == "J" ? true : false);
	                } 
	        	},
				styleClass: function () {
                    return "grid-cell-edit";
                }
	        },{
	        	key : "QA2", 
	        	label : "2번 답", 
	            width : 80,
	        	align : "left", 
	        	editor : { 
	        		type : "text",
		        	disabled : function () {
	                    return ( this.item.TYPE == "J" ? true : false);
	                } 
	        	},
				styleClass: function () {
                    return "grid-cell-edit";
                }
	        },{
	        	key : "QA3", 
	        	label : "3번 답", 
	            width : 80,
	        	align : "left", 
	        	editor : { 
	        		type : "text",
		        	disabled : function () {
	                    return ( this.item.TYPE == "J" ? true : false);
	                } 
	        	},
				styleClass: function () {
                    return "grid-cell-edit";
                }
	        },{
	        	key : "QA4", 
	        	label : "4번 답", 
	            width : 80,
	        	align : "left", 
	        	editor : { 
	        		type : "text",
		        	disabled : function () {
	                    return ( this.item.TYPE == "J" ? true : false);
	                } 
	        	},
				styleClass: function () {
                    return "grid-cell-edit";
                }
	        },{
	        	key : "ANSWER", 
	        	label : "정답", 
	            width : 80,
	        	align : "left", 
	        	editor : { 
	        		type : "text"
	        	},
				styleClass: function () {
                    return "grid-cell-edit";
                }
	        },{
	        	key : "ANSWER_DESC", 
	        	label : "정답 설명", 
	            width : 150,
	        	align : "left", 
	        	editor : { 
	        		type : "text"
	        	},
				styleClass: function () {
                    return "grid-cell-edit";
                }
	        },{
	        	key : "WEEK", 
	        	label : "주차", 
	            width : 80,
	        	align : "center", 
	        	editor: {
                    type : "select", 
                    config : {
                        columnKeys: { optionValue: "CD", optionText: "NM" },
                        options: ddWeek
                    } 
	        	},
	            formatter : function () {
	            	return ( this.item.WEEK == undefined ? 1 : this.item.WEEK ) + " 주차";
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
	            	else 
	                	return "하";
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
               	var allList = grid.getList();
               	var maxSeq = 0;
               	for ( var i = 0; i < allList.length; i++ ) {
        			if ( parseInt(allList[i].SEQ) > maxSeq ) {
        				maxSeq = parseInt(allList[i].SEQ);
        			}
               	}
               	
            	grid.addRow(
            			{
            				NEW_FLAG : "Y", 
            				COURSE_CODE : params.COURSE_CODE, 
            				SEQ : maxSeq + 1, 
            				TYPE : "G", 
            				QUESTION : "질문을 입력하세요.", 
            				QA1 : "", 
            				QA2 : "", 
            				QA3 : "", 
            				QA4 : "", 
            				ANSWER : "", 
            				ANSWER_DESC : "",
            				WEEK : 1, 
            				LEVEL : 3,
            				USE_YN : "Y" 
            			}, "last", {focus: "END"});
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
                		grid.setValue(rowIdx, "TYPE", all[rowIdx - 1].TYPE);
                		grid.setValue(rowIdx, "QUESTION", all[rowIdx - 1].QUESTION);
                		grid.setValue(rowIdx, "QA1", all[rowIdx - 1].QA1);
                		grid.setValue(rowIdx, "QA2", all[rowIdx - 1].QA2);
                		grid.setValue(rowIdx, "QA3", all[rowIdx - 1].QA3);
                		grid.setValue(rowIdx, "QA4", all[rowIdx - 1].QA4);
                		grid.setValue(rowIdx, "ANSWER", all[rowIdx - 1].ANSWER);
                		grid.setValue(rowIdx, "ANSWER_DESC", all[rowIdx - 1].ANSWER_DESC);
                		grid.setValue(rowIdx, "WEEK", all[rowIdx - 1].WEEK);
                		grid.setValue(rowIdx, "LEVEL", all[rowIdx - 1].LEVEL);
                		grid.setValue(rowIdx, "USE_YN", all[rowIdx - 1].USE_YN);
                		grid.setValue(rowIdx, "LAST_UPDATE_USER", all[rowIdx - 1].LAST_UPDATE_USER);
                		grid.setValue(rowIdx, "LAST_UPDATE_DATE", all[rowIdx - 1].LAST_UPDATE_DATE);
                		grid.setValue(rowIdx, "SEQ", all[rowIdx - 1].SEQ);
                		grid.setValue(rowIdx, "NEW_FLAG", all[rowIdx - 1].NEW_FLAG);

                		grid.setValue(rowIdx - 1, "TYPE", row[0].TYPE);
                		grid.setValue(rowIdx - 1, "QUESTION", row[0].QUESTION);
                		grid.setValue(rowIdx - 1, "QA1", row[0].QA1);
                		grid.setValue(rowIdx - 1, "QA2", row[0].QA2);
                		grid.setValue(rowIdx - 1, "QA3", row[0].QA3);
                		grid.setValue(rowIdx - 1, "QA4", row[0].QA4);
                		grid.setValue(rowIdx - 1, "ANSWER", row[0].ANSWER);
                		grid.setValue(rowIdx - 1, "ANSWER_DESC", row[0].ANSWER_DESC);
                		grid.setValue(rowIdx - 1, "WEEK", row[0].WEEK);
                		grid.setValue(rowIdx - 1, "LEVEL", row[0].LEVEL);
                		grid.setValue(rowIdx - 1, "USE_YN", row[0].USE_YN);
                		grid.setValue(rowIdx - 1, "LAST_UPDATE_USER", row[0].LAST_UPDATE_USER);
                		grid.setValue(rowIdx - 1, "LAST_UPDATE_DATE", row[0].LAST_UPDATE_DATE);
                		grid.setValue(rowIdx - 1, "SEQ", row[0].SEQ);
                		grid.setValue(rowIdx - 1, "NEW_FLAG", row[0].NEW_FLAG);
                		
                		grid.select(rowIdx - 1);
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
                		grid.setValue(rowIdx, "TYPE", all[rowIdx + 1].TYPE);
                		grid.setValue(rowIdx, "QUESTION", all[rowIdx + 1].QUESTION);
                		grid.setValue(rowIdx, "QA1", all[rowIdx + 1].QA1);
                		grid.setValue(rowIdx, "QA2", all[rowIdx + 1].QA2);
                		grid.setValue(rowIdx, "QA3", all[rowIdx + 1].QA3);
                		grid.setValue(rowIdx, "QA4", all[rowIdx + 1].QA4);
                		grid.setValue(rowIdx, "ANSWER", all[rowIdx + 1].ANSWER);
                		grid.setValue(rowIdx, "ANSWER_DESC", all[rowIdx + 1].ANSWER_DESC);
                		grid.setValue(rowIdx, "WEEK", all[rowIdx + 1].WEEK);
                		grid.setValue(rowIdx, "LEVEL", all[rowIdx + 1].LEVEL);
                		grid.setValue(rowIdx, "USE_YN", all[rowIdx + 1].USE_YN);
                		grid.setValue(rowIdx, "LAST_UPDATE_USER", all[rowIdx + 1].LAST_UPDATE_USER);
                		grid.setValue(rowIdx, "LAST_UPDATE_DATE", all[rowIdx + 1].LAST_UPDATE_DATE);
                		grid.setValue(rowIdx, "SEQ", all[rowIdx + 1].SEQ);
                		grid.setValue(rowIdx, "NEW_FLAG", all[rowIdx + 1].NEW_FLAG);

                		grid.setValue(rowIdx + 1, "TYPE", row[0].TYPE);
                		grid.setValue(rowIdx + 1, "QUESTION", row[0].QUESTION);
                		grid.setValue(rowIdx + 1, "QA1", row[0].QA1);
                		grid.setValue(rowIdx + 1, "QA2", row[0].QA2);
                		grid.setValue(rowIdx + 1, "QA3", row[0].QA3);
                		grid.setValue(rowIdx + 1, "QA4", row[0].QA4);
                		grid.setValue(rowIdx + 1, "ANSWER", row[0].ANSWER);
                		grid.setValue(rowIdx + 1, "ANSWER_DESC", row[0].ANSWER_DESC);
                		grid.setValue(rowIdx + 1, "WEEK", row[0].WEEK);
                		grid.setValue(rowIdx + 1, "LEVEL", row[0].LEVEL);
                		grid.setValue(rowIdx + 1, "USE_YN", row[0].USE_YN);
                		grid.setValue(rowIdx + 1, "LAST_UPDATE_USER", row[0].LAST_UPDATE_USER);
                		grid.setValue(rowIdx + 1, "LAST_UPDATE_DATE", row[0].LAST_UPDATE_DATE);
                		grid.setValue(rowIdx + 1, "SEQ", row[0].SEQ);
                		grid.setValue(rowIdx + 1, "NEW_FLAG", row[0].NEW_FLAG);
                		
                		grid.select(rowIdx + 1);
                	}
            	}

            	break;
            case "export":
                grid.exportExcel("시험 과정 문항 관리.xls");
                break;
            case "import":
            	var urlParams = "page=/ax/common/axExcelUpload";
        		urlParams += "&SCREEN=Exam&COURSE_CODE=" + gfn_getUrlParams("COURSE_CODE") + "&WEEK_CNT=" + gfn_getUrlParams("WEEK_CNT");
        		
        		f_popup('/common/axOpenPage', {displayName:'excelUploadPopup',option:'width=600,height=500', urlParams:urlParams});
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
	params.COURSE_CODE = gfn_getUrlParams("COURSE_CODE");	
}

function fn_search() {
	//mask.open();
	
	fn_params();
	
	gfn_callAjax("/course/axCourseExamQuestionList.do", params, fn_callbackAjax, "search");
}

function fn_save() {
	var fieldParams = {
		QUESTION : { mendatory : true, colName : "질문" },
   		QA1 : { mendatory : true, colName : "1번 답", except : { field : "TYPE", value : "J"} },
   		QA2 : { mendatory : true, colName : "2번 답", except : { field : "TYPE", value : "J"} },
   		QA3 : { mendatory : true, colName : "3번 답", except : { field : "TYPE", value : "J"} },
   		QA4 : { mendatory : true, colName : "4번 답", except : { field : "TYPE", value : "J"} }
   	};
   	if ( gfn_validationCheck(grid, fieldParams) ) {
       	mask.open();

       	//정렬
       	var allList = grid.getList();
       	for ( var i = 0; i < allList.length; i++ ) {
			grid.setValue(i, "ORD", i + 1);
       	}
		
       	confirmDialog.confirm(
       		{
               	title: "Confirm",
               	msg: '저장하시겠습니까?'
           	}, 
           	function(){
             	if ( this.key == "ok" ) {
             		gfn_callAjax("/course/axCourseExamQuestionSave.do", gfn_getSaveData(grid), fn_callbackAjax, "save");
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
		console.log(data.list);
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
      				SEQ : maxSeq + i + 1, 
      				TYPE : data.list[i].TYPE, 
      				QUESTION : data.list[i].QUESTION, 
      				QA1 : data.list[i].QA1, 
      				QA2 : data.list[i].QA2, 
      				QA3 : data.list[i].QA3, 
      				QA4 : data.list[i].QA4, 
      				ANSWER : data.list[i].ANSWER, 
      				ANSWER_DESC : data.list[i].ANSWER_DESC, 
      				WEEK : data.list[i].WEEK, 
      				LEVEL : data.list[i].LEVEL, 
      				USE_YN : data.list[i].USE_YN
      			}, "last", {focus: "END"});
		}
	}
}

function fn_gridEvent(event, obj) {
	if ( event == "Click" ) {
		obj.self.select(obj.dindex);
	} else if ( event == "DataChanged" ) {
		if ( obj.item["TYPE"] == "J" ) {
			grid.setValue(obj.item["__index"], "QA1", "");
			grid.setValue(obj.item["__index"], "QA2", "");
			grid.setValue(obj.item["__index"], "QA3", "");
			grid.setValue(obj.item["__index"], "QA4", "");
		}
	}
}

</script>

<body style="padding : 10px">

<form id="frm" name="frm" method="post">

<h2>과정 시험 문항 관리</h2>
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

