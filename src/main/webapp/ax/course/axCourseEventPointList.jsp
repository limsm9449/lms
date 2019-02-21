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
    
    gfn_callAjax("/common/axDd.do", { DD_KIND : "CategoryLevel1,Tutor,CompanyKind,Company,Company1,Company2,OpenKind,Year,QuestProgressRatio,AgainStudyDay" }, fn_callbackAjax, "dd", { async : false });
    
    $('[data-grid-control]').click(function () {
        switch (this.getAttribute("data-grid-control")) {
	        case "search":
	            fn_search();
	            break;
            case "save" :
            	fn_save();
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
                    },
	            	disabled : function () {
                        return true;
                    }
	        	},
	            formatter : function () {
	                return gfn_getValueInList(dd.Company, "value",  this.item.COMP_CD, "text");
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
                    },
	            	disabled : function () {
                        return true;
                    }
	        	},
	            formatter : function () {
	                return gfn_getValueInList(dd.Tutor, "value",  this.item.TUTOR_ID, "text");
	           	}
	        },{
	            key : "COURSE_COST",
	            label : "과정비용",
	            width : 90,
	            align : "right",
	            formatter : function () {
	                return checkThousand(this.item.COURSE_COST);
	           	}
	        },{
	            key : "OFFLINE_YN",
	            label : "오프라인",
	            width : 80,
	            align : "center"
	        },{
              	key : undefined, 
              	label: "포인트", 
              	columns: [	        
              		{
			            key : "EVENT_POINT_FROM",
			            label : "이벤트 시작일",
			            width : 110,
			            align : "center",
			            editor : { 
			            	type : "date"
						},
						styleClass: function () {
		                    return "grid-cell-edit";
		                }
			        },{
			            key : "EVENT_POINT_TO",
			            label : "이벤트 종료일",
			            width : 110,
			            align : "center",
			            editor : { 
			            	type : "date"
						},
						styleClass: function () {
		                    return "grid-cell-edit";
		                }
			        },{
			            key : "EVENT_POINT",
			            label : "포인트",
			            width : 80,
			            align : "right",
			            editor : { 
			            	type : "number"
						},
						styleClass: function () {
		                    return "grid-cell-edit";
		                },
			            formatter : function () {
			                return checkThousand(this.item.EVENT_POINT);
			           	} 
			        },{
			            key : "EVENT_POINT_MONTH",
			            label : "유효 개월수",
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
              	label: "오픈/종료", 
              	columns: [	        
			        {
			        	key : "OPEN_YN", 
			        	label : "오픈", 
			            width : 70,
			        	align : "center", 
			        	editor : { 
			        		type : "checkbox", 
			        		config : {height: 17, trueValue: "Y", falseValue: "N"},
			            	disabled : function () {
		                        return true;
		                    } 
			        	} 
			        },{
			        	key : "OPEN_CLOSE_YN", 
			        	label : "오픈 종료", 
			            width : 80,
			        	align : "center", 
			        	editor : { 
			        		type : "checkbox", 
			        		config : {height: 17, trueValue: "Y", falseValue: "N"},
			            	disabled : function () {
		                        return true;
		                    } 
			        	} 
			        },{
			        	key : "CLOSE_YN", 
			        	label : "강의 종료", 
			            width : 80,
			        	align : "center", 
			        	editor : { 
			        		type : "checkbox", 
			        		config : {height: 17, trueValue: "Y", falseValue: "N"},
			            	disabled : function () {
		                        return true;
		                    } 
			        	} 
			        }
			   	]
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
	params.COMPANY = $("#CB_COMPANY option:selected").val();	
	params.COMPANY2 = $("#CB_COMPANY2 option:selected").val();	
	params.OPEN_KIND = $("#CB_OPEN_KIND option:selected").val();	
	params.MONTH = $("#CB_MONTH option:selected").val();	
	params.YEAR = $("#CB_YEAR option:selected").val();	
	params.MONTH = $("#CB_MONTH option:selected").val();	
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
	
	gfn_callAjax("/course/axCourseEventPointList.do", params, fn_callbackAjax, "search");
}

function fn_save() {
	var fieldParams = {
   	};
   	if ( gfn_validationCheck(grid, fieldParams) ) {
   		var allList = grid.getList();
       	for ( var i = 0; i < allList.length; i++ ) {
       		if ( (gfn_getString(allList[i].EVENT_POINT_FROM) != "" && gfn_getString(allList[i].EVENT_POINT_TO) == "") ||
       				(gfn_getString(allList[i].EVENT_POINT_FROM) == "" && gfn_getString(allList[i].EVENT_POINT_TO) != "") ||
       				(gfn_getString(allList[i].EVENT_POINT_FROM) != "" && parseInt(allList[i].EVENT_POINT) == 0) ||
       				(gfn_getString(allList[i].EVENT_POINT_FROM) != "" && parseInt(allList[i].EVENT_POINT_MONTH) == 0) ) {
    			mask.open();
    			dialog.alert( { msg : (allList[i].__index + 1) + "라인의" + " 포인트 정보를 다 입력하셔야 합니다." }, function () { mask.close(); } );
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
             		gfn_callAjax("/course/axCourseEventPointSave.do", gfn_getSaveData(grid), fn_callbackAjax, "save");
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
		
		gfn_cbRefresh("CB_COMPANY", data.CompanyKind, true);
		gfn_cbRefresh("CB_LEVEL1", data.CategoryLevel1, true);

		gfn_cbRefresh("CB_OPEN_KIND", data.OpenKind, true);
		$("#CB_OPEN_KIND").val("NOT_CLOSE");

		gfn_cbRefresh("CB_YEAR", data.Year, true);
		//$("#CB_YEAR").val(new Date().getFullYear());
		
		fn_makeGrid();
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
	} else if ( event == "DBLClick" ) {
	} else if ( event == "DataChanged" ) {
		if ( obj.key == "EVENT_POINT" && obj.item.EVENT_POINT == "" ) {
			obj.item.EVENT_POINT = "0";
		}
		if ( obj.key == "EVENT_POINT_MONTH" && obj.item.EVENT_POINT_MONTH == "" ) {
			obj.item.EVENT_POINT_MONTH = "0";
		}
	}
}

function fn_cbChange(id) {
	if ( id == "CB_LEVEL1" ) {
	    gfn_callAjax("/common/axDd.do", { DD_KIND : "CategoryLevel2", LEVEL1_CODE : $("#CB_LEVEL1 option:selected").val()}, fn_callbackAjax, "CB_LEVEL1", { async : false });
	} else  if ( id == "CB_LEVEL2" ) {
	    gfn_callAjax("/common/axDd.do", { DD_KIND : "CategoryLevel3", LEVEL2_CODE : $("#CB_LEVEL2 option:selected").val()}, fn_callbackAjax, "CB_LEVEL2", { async : false });
	} else  if ( id == "CB_COMPANY" ) {
		if ( $("#CB_COMPANY").val() == "B2B" ) {
			gfn_cbRefresh("CB_COMPANY2", dd.Company1, true);
		} else if ( $("#CB_COMPANY").val() == "C2C" ) {
			gfn_cbRefresh("CB_COMPANY2", dd.Company2, true);
		} else {
			gfn_cbRefresh("CB_COMPANY2", null, true);
		}
	}
}


</script>

<body style="padding : 10px">

<h2>강의 이벤트 관리</h2>
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
	    	<input type="text" class="form-control" id="courseName" name="courseName" style="width:120px;">
	  	</div>
	  	<div class="form-group">
	    	<label for="CB_YEAR">&nbsp;년도</label>
			<select class="form-control" id="CB_YEAR">
				<option value="">전체</option>
			</select>
	  	</div>
	  	<div class="form-group">
	    	<label for="CB_MONTH">&nbsp;월</label>
			<select class="form-control" id="CB_MONTH">
				<option value="">전체</option>
<c:forEach var="i" begin="1" end="12" step="1" varStatus ="status">
	<c:if test="${i < 10}">
                <option value="0${i}">${i}</option>
	</c:if>     
	<c:if test="${i >= 10}">
                <option value="${i}">${i}</option>
	</c:if>     
</c:forEach>    
			</select>
	  	</div>
	  	<div class="form-group">
	    	<label for="chasu">&nbsp;차수</label>
	    	<input type="text" class="form-control" id="chasu" name="chasu" style="width:60px;"> 
	  	</div>
	</div>
	<div style="height:10px"></div>
	<div class="form-inline">
	  	<div class="form-group">
	    	<label for="CB_COMPANY">&nbsp;회사 구분</label>
			<select class="form-control" id="CB_COMPANY" onchange="fn_cbChange('CB_COMPANY')">
				<option value="">전체</option>
			</select>
			<select class="form-control" id="CB_COMPANY2">
				<option value="">전체</option>
			</select>
	  	</div>
	  	<div class="form-group">
	    	<label for="CB_OPEN_KIND">&nbsp;오픈구분</label>
			<select class="form-control" id="CB_OPEN_KIND">
				<option value="">전체</option>
			</select>
	  	</div>
	</div>
</form>

<div style="height:10px"></div>

<div>
    <button class="btn btn-default" data-grid-control="search">검색</button>
    <button class="btn btn-default" data-grid-control="save">저장</button>
</div>

<div style="height:10px"></div>


<div style="position: relative;height:400px;" id="grid-parent">
    <div data-ax5grid="first-grid" style="height: 100%;"></div>
</div>

<div class="mask"></div>


</body>
</html>

