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

	$("#FROM_DT").val(gfn_addDay(gfn_currentDay(), -10, "-"));		
	$("#TO_DT").val(gfn_currentDay(null, "-"));		
	gfn_initDatepicker("FROM_DT");
	gfn_initDatepicker("TO_DT");
	
    confirmDialog.setConfig({
        theme: "danger"
    });

    gfn_callAjax("/common/axDd.do", { DD_KIND : "ApprovalCardStatus,PaymentKind,CategoryLevel1,Year,CompanyKind,Company,Company1,Company2"}, fn_callbackAjax, "dd", { async : false });
    
    $('[data-grid-control]').click(function () {
        switch (this.getAttribute("data-grid-control")) {
	        case "search":
	            fn_search();
	            break;
	        case "refund":
	        	var rows = grid.getList("selected");
	        	if ( rows.length == 0 ) {
            		mask.open();
            		dialog.alert( { msg : "카드 입금 정보를 선택하셔야 합니다." }, function () { mask.close();	} );
            		return;
            	}
				if ( rows[0].STATUS != "A") {
            		mask.open();
            		dialog.alert( { msg : (rows[0].__index + 1) + " 라인 : 승인된 정보만 환불할 수 있습니다."	}, function () { mask.close();	} );
            		return;
				}		        			
		    	
				$("#approvalId").val(rows[0].APPROVAL_ID);
				$("#payApprovalId").val(rows[0].PAY_APPROVAL_ID);
				
				window.open("",	"xpay", "width=500,height=300,scrollbars=no,resizable=no,status=no,toolbar=no,menubar=no");
				document.frm.target = "xpay";
				document.frm.submit();

	            break;
            case "export":
                grid.exportExcel("카드입금관리.xls");
                break;
        }
    });
});

function fn_makeGrid() {
	grid = gfn_makeAx5Grid("first-grid",
		[ 	{
	            key : "APPROVAL_ID",
	            label : "결제ID",
	            width : 120,
	            align : "center"
	        },{
	            key : "REQUEST_DATE",
	            label : "신청일자",
	            width : 100,
	            align : "center"
	        },{
	            key : "USER_ID",
	            label : "신청자 ID",
	            width : 80,
	            align : "left"
	        },{
	            key : "USER_NAME",
	            label : "신청자명",
	            width : 80,
	            align : "left"
	        },{
	            key : "STATUS",
	            label : "신청상태", 
	            width : 80,
	            align : "center", 
	        	editor: {
                    type : "select",
	            	disabled : function () {
                        return true;
                    },
                    config : { 
                        columnKeys: { optionValue: "value", optionText: "text" },
                        options: dd.ApprovalCardStatus
                    } 
	        	}, 
	            formatter : function () {
	                return gfn_getValueInList(dd.ApprovalCardStatus, "value",  this.item.STATUS, "text");
	           	}
	        },{
	        	key : "REFUND_DATE",
	            label : "환불 일자",
	            width : 120,
	            align : "center"
	        },{
              	key : undefined, 
              	label: "결제", 
              	columns: [	
              		{
			            key : "TOTAL_COST",
			            label : "총금액",
			            width : 80,
			            align : "right",
			            formatter : function () {
			                return checkThousand(this.item.TOTAL_COST);
			           	}
			        },{
			            key : "PAYMENT_POINT",
			            label : "포인트 금액",
			            width : 100,
			            align : "right",
			            formatter : function () {
			                return checkThousand(this.item.PAYMENT_POINT);
			           	}
			        },{
			            key : "PAYMENT_COST",
			            label : "결제 금액",
			            width : 80,
			            align : "right",
			            formatter : function () {
			                return checkThousand(this.item.PAYMENT_COST);
			           	}
			        },{
			            key : "PAYMENT_KIND",
			            label : "결제 방법",
			            width : 80,
			            align : "center", 
			        	editor: {
		                    type : "select",
			            	disabled : function () {
		                        return true;
		                    },
		                    config : { 
		                        columnKeys: { optionValue: "value", optionText: "text" },
		                        options: dd.PaymentKind
		                    } 
			        	},
			            formatter : function () {
			                return gfn_getValueInList(dd.PaymentKind, "value",  this.item.PAYMENT_KIND, "text");
			           	}
			        },{
			            key : "PAYMENT_DATE",
			            label : "결제 일자",
			            width : 120,
			            align : "center"
			        }
			  	]
	        },{
	            key : "CATEGORY_NAME",
	            label : "카테고리",
	            width : 150,
	            align : "left"
	        },{
	            key : "COURSE_ID",
	            label : "ID",
	            width : 40,
	            align : "right"
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
	            key : "COURSE_COST",
	            label : "과정금액",
	            width : 80,
	            align : "right",
	            formatter : function () {
	                return checkThousand(this.item.COURSE_COST);
	           	}
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
	  		multipleSelect: false,
	  		frozenColumnIndex : 5,
	  		mergeCells : ["APPROVAL_ID","REQUEST_DATE","USER_ID","USER_NAME"]
	  	}
	);
	
	$(window).trigger("resize"); 
} 

function fn_params() {
	params.FROM_DT = $("#FROM_DT").val();	
	params.TO_DT = $("#TO_DT").val();	
	params.USER = $("#USER").val();
	params.CB_SEARCH_STATUS = $("#CB_SEARCH_STATUS option:selected").val();
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
	
	gfn_callAjax("/cost/axCardCostList.do", params, fn_callbackAjax, "search");
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
		gfn_cbRefresh("CB_SEARCH_STATUS", data.ApprovalCardStatus, true);
		gfn_cbRefresh("CB_LEVEL1", data.CategoryLevel1, true);

		gfn_cbRefresh("CB_YEAR", data.Year, true);
		//$("#CB_YEAR").val(new Date().getFullYear());		

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
		obj.self.select(obj.dindex);
	}
}

function fn_cbChange(id) {
	if ( id == "CB_LEVEL1" ) {
	    gfn_callAjax("/common/axDd.do", { DD_KIND : "CategoryLevel2", LEVEL1_CODE : $("#CB_LEVEL1 option:selected").val()}, fn_callbackAjax, "CB_LEVEL1", { async : false });
	} else  if ( id == "CB_LEVEL2" ) {
	    gfn_callAjax("/common/axDd.do", { DD_KIND : "CategoryLevel3", LEVEL2_CODE : $("#CB_LEVEL2 option:selected").val()}, fn_callbackAjax, "CB_LEVEL2", { async : false });
	} else if ( id == "CB_COMPANY" ) {
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

<form id="frm" name="frm" method="post" action="/paymentGateway/cancelInfo.do" >
	<input type="hidden" name="approvalId" id="approvalId" value=""/>
	<input type="hidden" name="payApprovalId" id="payApprovalId" value=""/>
	
<h2>카드  입금 관리</h2>
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
    	<label for="CB_SEARCH_STATUS">&nbsp;신청상태</label>
		<select class="form-control" id="CB_SEARCH_STATUS">
		</select>
  	</div>
  	<div class="form-group">
    	<label for="courseName">&nbsp;일자</label>
	   	<input id="FROM_DT" name="FROM_DT" maxlength="10" size="10" class="form-control datePicker" value="" readonly/> ~ 
		<input id="TO_DT" name="TO_DT" maxlength="10" size="10" class="form-control datePicker" value="" readonly/>
  	</div>
  	<div class="form-group">
    	<label for="courseName">&nbsp;신청자</label>
    	<input type="text" class="form-control" id="USER" name="USER" style="width:100px;">
  	</div>
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
    <button class="btn btn-default" data-grid-control="refund">환불</button>
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

