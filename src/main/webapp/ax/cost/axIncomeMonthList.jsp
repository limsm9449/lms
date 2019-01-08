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
            case "export":
                grid.exportExcel("월별수입관리.xls");
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
	            label : "전체", 
              	columns : fn_monthColumn("T") 	        	
	        },{
	            key : undefined,
	            label : "01 월", 
              	columns : fn_monthColumn("01") 	        	
	        },{
	            key : undefined,
	            label : "02 월", 
              	columns : fn_monthColumn("02") 	        	
	        },{
	            key : undefined,
	            label : "03 월", 
              	columns : fn_monthColumn("03") 	        	
	        },{
	            key : undefined,
	            label : "04 월", 
              	columns : fn_monthColumn("04") 	        	
	        },{
	            key : undefined,
	            label : "05 월", 
              	columns : fn_monthColumn("05") 	        	
	        },{
	            key : undefined,
	            label : "06 월", 
              	columns : fn_monthColumn("06") 	        	
	        },{
	            key : undefined,
	            label : "07 월", 
              	columns : fn_monthColumn("07") 	        	
	        },{
	            key : undefined,
	            label : "08 월", 
              	columns : fn_monthColumn("08") 	        	
	        },{
	            key : undefined,
	            label : "09 월", 
              	columns : fn_monthColumn("09") 	        	
	        },{
	            key : undefined,
	            label : "10 월", 
              	columns : fn_monthColumn("10") 	        	
	        },{
	            key : undefined,
	            label : "11 월", 
              	columns : fn_monthColumn("11") 	        	
	        },{
	            key : undefined,
	            label : "12 월", 
              	columns : fn_monthColumn("12") 	        	
	        }	
	   	], 
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
	params.SEARCH_YEAR = $("#CB_SEARCH_YEAR option:selected").val();	
}

function fn_monthColumn(month) {
	return 	[	        
		  		{
		        	key : "USER_CNT_" + month,
		            label : "인원",
		            width : 60,
		            align : "right",
		            formatter : function () {
		                return checkThousand(this.item["USER_CNT_" + month]);
		           	}
		        },{
		        	key : "TOTAL_COST_" + month,
		            label : "전체",
		            width : 60,
		            align : "right",
		            formatter : function () {
		            	return checkThousand(this.item["TOTAL_COST_" + month]);
		           	}
		        },{
		        	key : "TUTOR_COST_" + month,
		            label : "튜터",
		            width : 60,
		            align : "right",
		            formatter : function () {
		            	return checkThousand(this.item["TUTOR_COST_" + month]);
		           	}
		        },{
		        	key : "TEACHER_COST_" + month,
		            label : "강사",
		            width : 60,
		            align : "right",
		            formatter : function () {
		            	return checkThousand(this.item["TEACHER_COST_" + month]);
		           	}
		        },{
		        	key : "CP_COST_" + month,
		            label : "CP",
		            width : 60,
		            align : "right",
		            formatter : function () {
		            	return checkThousand(this.item["CP_COST_" + month]);
		           	}
		        },{
		        	key : "COMPANY_COST_" + month,
		            label : "회사",
		            width : 60,
		            align : "right",
		            formatter : function () {
		            	return checkThousand(this.item["COMPANY_COST_" + month]);
		           	}
		        }
		  	];	
}

function fn_search() {
	//mask.open();
	
	fn_params();
	
	gfn_callAjax("/cost/axIncomeMonthList.do", params, fn_callbackAjax, "search");
}

function fn_callbackAjax(data, id) {
	//console.log("fn_callbackAjax : " + id);
	if ( id == "search" ) {
		list = data.list;
		grid.setData(data.list);
		
		//mask.close();
	} else if ( id == "dd" ){
		dd = $.extend({}, data);

		gfn_cbRefresh("CB_COMPANY", data.CompanyKind, true);
		gfn_cbRefresh("CB_LEVEL1", data.CategoryLevel1, true);

		gfn_cbRefresh("CB_YEAR", data.Year, true);

		gfn_cbRefresh("CB_SEARCH_YEAR", data.Year, true);
		$("#CB_SEARCH_YEAR").val(new Date().getFullYear());		

		fn_makeGrid();
		//fn_search();
	} else if ( id == "CB_LEVEL1" ){
		gfn_cbRefresh("CB_LEVEL2", data.CategoryLevel2, true);
	} else if ( id == "CB_LEVEL2" ){
		gfn_cbRefresh("CB_LEVEL3", data.CategoryLevel3, true);
	}
}

function fn_gridEvent(event, obj) {
	if ( event == "Click" ) {
		//obj.self.select(obj.dindex);
	}
}

function fn_cbChange(id) {
	if ( id == "CB_LEVEL1" ) {
	    gfn_callAjax("/common/axDd.do", { DD_KIND : "CategoryLevel2", LEVEL1_CODE : $("#CB_LEVEL1 option:selected").val()}, fn_callbackAjax, "CB_LEVEL1", { async : false });
	} else  if ( id == "CB_LEVEL2" ) {
	    gfn_callAjax("/common/axDd.do", { DD_KIND : "CategoryLevel3", LEVEL2_CODE : $("#CB_LEVEL2 option:selected").val()}, fn_callbackAjax, "CB_LEVEL2", { async : false });
	}else  if ( id == "CB_COMPANY" ) {
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

<h2>월별 수입 관리</h2>
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
  	<div class="form-group">
    	<label for="CB_SEARCH_YEAR">&nbsp;검색 년도</label>
		<select class="form-control" id="CB_SEARCH_YEAR">
			<option value="">전체</option>
		</select>
  	</div>
</div>

<div style="height:10px"></div>

<div>
    <button class="btn btn-default" data-grid-control="search">검색</button>
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

