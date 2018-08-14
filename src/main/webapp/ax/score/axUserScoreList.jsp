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
	var openParams = parent.document.getElementById("left").contentWindow.pageParam["axUserScoreList"]; 	
	$("#screenTitle").text(openParams.COURSE_NAME + " 성적 관리");
	params.COURSE_ID = openParams.COURSE_ID;
	
	$( window ).resize( function() {
		gfn_gridResize("grid-parent", grid);
	} );
	
    confirmDialog.setConfig({
        theme: "danger"
    });

    fn_makeGrid();
    
    $('[data-grid-control]').click(function () {
        switch (this.getAttribute("data-grid-control")) {
	        case "search":
	            fn_search();
	            break;
            case "save" :
            	fn_save();
                break;
            case "export":
                grid.exportExcel(openParams.COURSE_NAME + "성적관리.xls");
                break;
            case "viewWeek":
            	var row = grid.getList("selected");
            	if ( row.length == 0 ) {
            		mask.open();
            		dialog.alert( { msg : "과정을 선택하셔야 합니다." }, function () { mask.close();	} );
            	} else {
            		var urlParams = "page=/ax/score/axUserScoreWeekPopup";
            		urlParams += "&COURSE_ID=" + row[0]["COURSE_ID"] + "&USER_ID=" + row[0]["USER_ID"];
            		
            		f_popup('/common/axOpenPage', {displayName:'userScoreWeekPopup',option:'width=900,height=600', urlParams:urlParams});
            	}
            		
                break;
        }
    });
    
    fn_search();
});

function fn_makeGrid() {
	grid = gfn_makeAx5Grid("first-grid",
		[ 	{
	            key : "USER_ID",
	            label : "수강생 ID",
	            width : 80,
	            align : "left"
	        },{
	            key : "USER_NAME",
	            label : "수강생명",
	            width : 80,
	            align : "left"
	        },{
              	key : undefined, 
              	label: "점수", 
              	columns: [	        
			        {
			            key : "REPORT",
			            label : "레포트",
			            width : 70,
			            align : "right", 
			        	editor : { 
			        		type : "number", 
			            	disabled : function () {
		                        return ( this.item.C_REPORT_YN == "Y" ?  false : true );
		                    } 
			        	},
						styleClass: function () {
		                    return ( this.item.C_REPORT_YN == "Y" ? "grid-cell-edit": "" );
		                }
			        },{
			            key : "REPORT_RATE",
			            label : "%",
			            width : 50,
			            align : "right",
			            formatter : function () {
			                return this.item.REPORT_RATE + " %";
			           	} 
			        },{
			            key : "EXAM",
			            label : "시험",
			            width : 60,
			            align : "right"
			        },{
			            key : "EXAM_RATE",
			            label : "%",
			            width : 50,
			            align : "right",
			            formatter : function () {
			                return this.item.EXAM_RATE + " %";
			           	} 
			        },{
			            key : "DISCUSSION",
			            label : "토론",
			            width : 60,
			            align : "right", 
			        	editor : { 
			        		type : "number", 
			            	disabled : function () {
		                        return ( this.item.C_DISCUSSION_YN == "Y" ?  false : true );
		                    } 
			        	},
						styleClass: function () {
		                    return ( this.item.C_DISCUSSION_YN == "Y" ? "grid-cell-edit": "" );
		                }
			        },{
			            key : "DISCUSSION_RATE",
			            label : "%",
			            width : 50,
			            align : "right",
			            formatter : function () {
			                return this.item.DISCUSSION_RATE + " %";
			           	} 
			        },{
			            key : "PROGRESS",
			            label : "강의진도",
			            width : 80,
			            align : "right"
			        },{
			            key : "PROGRESS_RATE",
			            label : "%",
			            width : 50,
			            align : "right",
			            formatter : function () {
			                return this.item.PROGRESS_RATE + " %";
			           	} 
			        },{
			            key : "TOTAL",
			            label : "합계",
			            width : 50,
			            align : "right"
			        }
		        ]
	        },{
	            key : "REPORT_YN",
	            label : "레포트 제출 여부",
	            width : 130,
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
              	label: "주차 학습", 
              	columns: [	        
			        {
			            key : "LAST_WEEK",
			            label : "최종 학습 주차",
			            width : 120,
			            align : "right"
			        },{
			            key : "LAST_PAGE",
			            label : "최종 학습 페이지",
			            width : 120,
			            align : "right"
			        }
		        ]
	        },{
              	key : undefined, 
              	label: "시험", 
              	columns: [	        
			        {
			            key : "E_FROM_DATE",
			            label : "시작시간",
			            width : 110,
			            align : "center"
			        },{
			            key : "E_TO_DATE",
			            label : "종료시간",
			            width : 110,
			            align : "center"
			        }
		        ]
	        },{
	            key : "QUEST_YN",
	            label : "설문지 작성 여부",
	            width : 130,
	            align : "center", 
	        	editor : { 
	        		type : "checkbox", 
	        		config : {height: 17, trueValue: "Y", falseValue: "N"},
	            	disabled : function () {
                        return true;
                    } 
	        	}
	        },{
	            key : "COMPLETE_YN",
	            label : "완료 여부",
	            width : 100,
	            align : "center", 
	        	editor : { 
	        		type : "checkbox", 
	        		config : {height: 17, trueValue: "Y", falseValue: "N"},
	            	disabled : function () {
                        return true;
                    } 
	        	},
				styleClass: function () {
                    return "grid-cell-edit";
                }	        }	], 
	  	null,
	  	{
	  		showRowSelector : false
	  	}
	);
	
	$(window).trigger("resize");
}

function fn_params() {
	params.SEARCH_USER = $("#SEARCH_USER").val();
}

function fn_search() {
	//mask.open();
	
	fn_params();
	
	gfn_callAjax("/score/axUserScoreList.do", params, fn_callbackAjax, "search");
}

function fn_save() {
	var fieldParams = {
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
             		gfn_callAjax("/score/axUserScoreSave.do", gfn_getSaveData(grid), fn_callbackAjax, "save");
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

		mask.open();
		dialog.alert( { msg : "저장 되었습니다." }, function () { mask.close();	fn_search(); } );
	}
}

function fn_gridEvent(event, obj) {
	if ( event == "Click" ) {
		obj.self.select(obj.dindex);
	} else if ( event == "DBLClick" ) {
	} else if ( event == "DataChanged" ) {
	}
}


</script>

<body style="padding : 10px">

<form id="frm" name="frm" method="post">

<h2 id="screenTitle">수강생별 성적 관리</h2>
<div style="height:10px"></div>

<div>
	수강생
	<input type="text" class="search_input" id="SEARCH_USER" name="SEARCH_USER" value="" />
</div>

<div style="height:10px"></div>

<div>
    <button class="btn btn-default" data-grid-control="search">검색</button>
    <button class="btn btn-default" data-grid-control="save">저장</button>
    <button class="btn btn-default" data-grid-control="export">엑셀</button>
    <button class="btn btn-default" data-grid-control="viewWeek">주차 학습 진행율</button>
    <button class="btn btn-default" data-grid-control="viewUserScore">제출 레포트</button>
    <button class="btn btn-default" data-grid-control="viewExam">시험</button>
    <button class="btn btn-default" data-grid-control="viewQuest">설문지</button>
    <button class="btn btn-default" data-grid-control="viewPostscript">수강후기</button>
</div>

<div style="height:10px"></div>


<div style="position: relative;height:400px;" id="grid-parent">
    <div data-ax5grid="first-grid" style="height: 100%;"></div>
</div>

</form>

<div class="mask"></div>


</body>
</html>

