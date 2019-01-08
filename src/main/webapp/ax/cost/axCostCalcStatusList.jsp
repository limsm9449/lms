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
var list = {};

$(document.body).ready(function () {
	$( window ).resize( function() {
		gfn_gridResize("grid-parent", grid);
	} );

    confirmDialog.setConfig({
        theme: "danger"
    });

    gfn_callAjax("/common/axDd.do", { DD_KIND : "CategoryLevel1,Year,CompanyKind,Company,Company1,Company2"}, fn_callbackAjax, "dd", { async : false });
    
    $('[data-grid-control]').click(function () {
        switch (this.getAttribute("data-grid-control")) {
	        case "search":
	            fn_search();
	            break;
	        case "save":
	        	var row = grid.getList("selected");
            	if ( row.length == 0 ) {
            		mask.open(); 
            		dialog.alert( { msg : "과정을 선택하셔야 합니다." }, function () { mask.close();	} );
            	} else {
                	fn_save();
            	}
	        	
	            break;
            case "export":
                grid.exportExcel("정산현황관리.xls");
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
	            label : "수강생", 
              	columns: [	        
			        {
			        	key : "USER_CNT",
			            label : "총 인원",
			            width : 80,
			            align : "right",
			            formatter : function () {
			                return checkThousand(this.item.USER_CNT);
			           	}
			        },{
			        	key : "COST_USER_CNT",
			            label : "정산",
			            width : 80,
			            align : "right",
			            formatter : function () {
			                return checkThousand(this.item.COST_USER_CNT);
			           	}
			        },{
			        	key : "NOT_COST_USER_CNT",
			            label : "미정산",
			            width : 80,
			            align : "right",
			            formatter : function () {
			                return checkThousand(this.item.NOT_COST_USER_CNT);
			           	}
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
		                        return ( parseInt(this.item.ORG_CP_COST_RATE) > 0 ? false : true ); 
		                    }
						},
						styleClass: function () {
		                    return ( parseInt(this.item.ORG_CP_COST_RATE) > 0 ? "grid-cell-edit" : "");
		                }
			        },{
			            key : "TEACHER_COST_RATE",
			            label : "강사 비용 비율(%)",
			            width : 130,
			            align : "right",
			            editor : { 
			            	type : "number",
			            	disabled : function () {
		                        return ( parseInt(this.item.ORG_TEACHER_COST_RATE) > 0 ? false : true );
		                    }
						},
						styleClass: function () {
		                    return ( parseInt(this.item.ORG_TEACHER_COST_RATE) > 0 ? "grid-cell-edit" : "");
		                }
			        },{
			            key : "REPORT_COST",
			            label : "레포트 비용",
			            width : 100,
			            align : "right",
			            editor : { 
			            	type : "number",
			            	disabled : function () {
		                        return ( parseInt(this.item.ORG_REPORT_COST) > 0 ? false : true );
		                    }
						},
						styleClass: function () {
		                    return ( parseInt(this.item.ORG_REPORT_COST) > 0 ? "grid-cell-edit" : "");
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
		                        return ( parseInt(this.item.ORG_EVAL_COST) > 0 ? false : true );
		                    }
						},
						styleClass: function () {
		                    return ( parseInt(this.item.ORG_EVAL_COST) > 0 ? "grid-cell-edit" : "");
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
		                        return ( parseInt(this.item.ORG_DATA_COST) > 0 ? false : true );
		                    }
						},
						styleClass: function () {
		                    return ( parseInt(this.item.ORG_DATA_COST) > 0 ? "grid-cell-edit" : "");
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
		                        return ( parseInt(this.item.ORG_ANSWER_COST) > 0 ? false : true );
		                    }
						},
						styleClass: function () {
		                    return ( parseInt(this.item.ORG_ANSWER_COST) > 0 ? "grid-cell-edit" : "");
		                },
			            formatter : function () {
			                return checkThousand(this.item.ANSWER_COST);
			           	}
			        }
		        ]
	        }	], 
	  	null,
	  	{
			showRowSelector : false,
	  		frozenColumnIndex : 6 
	  	}
	);
	
	$(window).trigger("resize"); 
} 

function fn_params() {
	params.LEVEL1_CODE = $("#CB_LEVEL1 option:selected").val();	
	params.LEVEL2_CODE = $("#CB_LEVEL2 option:selected").val();	
	params.LEVEL3_CODE = $("#CB_LEVEL3 option:selected").val();	
	params.YEAR = $("#CB_YEAR option:selected").val();	
	params.MONTH = $("#CB_MONTH option:selected").val();	
	params.chasu = $("#chasu").val();	
	params.courseName = $("#courseName").val();	
	params.COMPANY = $("#CB_COMPANY option:selected").val();	
	params.COMPANY2 = $("#CB_COMPANY2 option:selected").val();	
}

function fn_search() {
	//mask.open();
	
	fn_params();
	
	gfn_callAjax("/cost/axCostCalcStatusList.do", params, fn_callbackAjax, "search");
}

function fn_save() {
   	mask.open();
   	
   	var row = grid.getList("selected");
   	
   	confirmDialog.confirm(
   		{
           	title: "Confirm",
           	msg: '부분 정산을 하시겠습니까?'
       	}, 
       	function(){
         	if ( this.key == "ok" ) {
         		gfn_callAjax("/cost/axCostCalcStatusSave.do", row[0], fn_callbackAjax, "save");
           	} else {
           		mask.close();
           	}
       	}
   	);
}

function fn_callbackAjax(data, id) {
	if ( data.RtnMode == "ERROR" ) {
		mask.open();
		dialog.alert( { msg : "처리시 오류가 발생했습니다. 관리자에게 문의하세요." }, function () { mask.close();	fn_search(); } );
		return;
	}
	
	if ( id == "search" ) {
		list = data.list;
		grid.setData(data.list);
		
		//mask.close();
	} else if ( id == "dd" ){
		dd = $.extend({}, data);

		gfn_cbRefresh("CB_COMPANY", data.CompanyKind, true);
		gfn_cbRefresh("CB_LEVEL1", data.CategoryLevel1, true);

		gfn_cbRefresh("CB_YEAR", data.Year, true);
		//$("#CB_YEAR").val(new Date().getFullYear());		

		fn_makeGrid();
		//fn_search();
	} else if ( id == "CB_LEVEL1" ){
		gfn_cbRefresh("CB_LEVEL2", data.CategoryLevel2, true);
	} else if ( id == "CB_LEVEL2" ){
		gfn_cbRefresh("CB_LEVEL3", data.CategoryLevel3, true);
	} else if ( id == "save" ){
		mask.close();

		mask.open();
		dialog.alert( { msg : "정산 데이타가 생성 되었습니다." }, function () { mask.close();	fn_search(); } );
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

<form id="frm" name="frm" method="post">

<h2>정산 현황 관리</h2>
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
  	<div class="form-group">
    	<label for="courseName">&nbsp;과정명</label>
    	<input type="text" class="form-control" id="courseName" name="courseName">
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
</div>

<div style="height:10px"></div>

<div>
    <button class="btn btn-default" data-grid-control="search">검색</button>
    <button class="btn btn-default" data-grid-control="save">부분 정산</button>
    <button class="btn btn-default" data-grid-control="export">엑셀</button>
</div> 

<div style="height:10px"></div>


<div style="height:500px;" id="grid-parent">
    <div data-ax5grid="first-grid" style="height: 100%;"></div>
</div>

</form>

<div class="mask"></div>

</body>
</html>

