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
var dd = {};

$(document.body).ready(function () {
    confirmDialog.setConfig({
        theme: "danger"
    });

	$("#FROM_DT").val(gfn_addDay(gfn_currentDay(), -5, "-"));		
	$("#TO_DT").val(gfn_currentDay(null, "-"));		
	gfn_initDatepicker("FROM_DT");
	gfn_initDatepicker("TO_DT");

    $('[data-grid-control]').click(function () {
        switch (this.getAttribute("data-grid-control")) {
	        case "search":
	            fn_search();
	            break;
            case "export":
                grid.exportExcel("기업교육 튜터지원 문의.xls");
                break;
            case "save" :
            	fn_save();
                break;
        }
    });
    
    gfn_callAjax("/common/axDd.do", { DD_KIND : "InquiryCategory" }, fn_callbackAjax, "dd", { async : false });
});

function fn_save() {
	var fieldParams = {};
   	if ( gfn_validationCheck(grid, fieldParams) ) {
       	mask.open();
       	confirmDialog.confirm(
       		{
               	title: "Confirm",
               	msg: '저장하시겠습니까?'
           	}, 
           	function(){
             	if ( this.key == "ok" ) {
             		gfn_callAjax("/counsel/axInquirySave.do", gfn_getSaveData(grid), fn_callbackAjax, "save");
               	} else {
               		mask.close();
               	}
           	}
       	);
   	}
}

function fn_ddAfter() {
	grid = gfn_makeAx5Grid("first-grid",
		[ 	{
	            key : "KIND",
	            label : "카테고리",
	            width : 120,
	            align : "left", 
	        	editor: {
                    type : "select", 
                    config : {
                        columnKeys: { optionValue: "value", optionText: "text" },
                        options: dd.InquiryCategory
                    },
	            	disabled : function () {
                        return true;
                    }
	        	},
	            formatter : function () {
	                return gfn_getValueInList(dd.InquiryCategory, "value",  this.item.KIND, "text");
	           	}
	        },{
	            key : "USER_NAME",
	            label : "사용자명",
	            width : 90,
	            align : "left"
	        },{
	            key : "MOBILE",
	            label : "핸드폰",
	            width : 120,
	            align : "left"
	        },{
	            key : "TEL",
	            label : "전화번호",
	            width : 120,
	            align : "left"
	        },{
	            key : "EMAIL",
	            label : "이메일",
	            width : 120,
	            align : "left"
	        },{
	            key : "COMPANY_NAME",
	            label : "회사명",
	            width : 120,
	            align : "left"
	        },{
	            key : "CREATE_DATE_STR",
	            label : "등록일자",
	            width : 120,
	            align : "center"
	        },{
	        	key : "COMPLETE_YN", 
	        	label : "완료 여부", 
	            width : 80,
	        	align : "center", 
	        	editor : { type : "checkbox", config : {height: 17, trueValue: "Y", falseValue: "N"} } ,
				styleClass: function () {
                    return "grid-cell-edit";
                } 
	        },{
	        	key : "MEMO", 
	        	label : "메모", 
	            width : 300,
	        	align : "left", 
	        	editor : { type : "text" },
				styleClass: function () {
                    return "grid-cell-edit";
                } 
	        },{
	            key : "UPDATE_DATE_STR",
	            label : "처리일자",
	            width : 120,
	            align : "center"
	        }	], 
	  	null,
	  	{
	  		showRowSelector : false
	  	}
	);

	$( window ).resize( function() {
		gfn_gridResize("grid-parent", grid); 
	} ).resize();
}

function fn_params() {
	params.FROM_DT = $("#FROM_DT").val();	
	params.TO_DT = $("#TO_DT").val();	
	params.SEARCH_STR = $("#SEARCH_STR").val();
}

function fn_search() {
	fn_params();
	
	gfn_callAjax("/counsel/axInquiryList.do", params, fn_callbackAjax, "search");
}

function fn_callbackAjax(data, id) {
	if ( data.RtnMode == "ERROR" ) {
		mask.open();
		dialog.alert( { msg : "처리시 오류가 발생했습니다. 관리자에게 문의하세요." }, function () { mask.close();	fn_search(); } );
		return;
	}
	
	if ( id == "search" ) {
		grid.setData(data.list);
	} else if ( id == "dd" ){
		dd = $.extend({}, data);
		
		gfn_cbRefresh("CB_KIND", data.InquiryCategory, true);
		
		fn_ddAfter();
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
		if ( obj.item["KIND"] == "COMPANY" ) {
	   		var urlParams = "page=/ax/counsel/axInquiryPopup1";
	   		urlParams += "&SEQ=" + obj.item["SEQ"]; 
	   		
	   		f_popup('/common/axOpenPage', {displayName:'inquiryPopup',option:'width=900,height=800', urlParams:urlParams});
		} else {
			var urlParams = "page=/ax/counsel/axInquiryPopup2";
	   		urlParams += "&SEQ=" + obj.item["SEQ"];
	   		
	   		f_popup('/common/axOpenPage', {displayName:'inquiryPopup',option:'width=900,height=800', urlParams:urlParams});
		}
	} else if ( event == "DataChanged" ) {
	}
}

</script>

<body style="padding : 10px">

<form id="frm" name="frm" method="post">

<h2>기업교육/튜터지원 문의</h2>
<div style="height:10px"></div>

<div class="form-inline">
  	<div class="form-group">
    	<label for="CB_KIND">카테고리</label>
		<select class="form-control" id="CB_KIND">
			<option value="">전체</option>
		</select>
  	</div>
	<div class="form-group">
    	<label for="FROM_DT">&nbsp;일자</label>
	   	<input id="FROM_DT" name="FROM_DT" maxlength="10" size="10" class="form-control datePicker" value="" readonly/> ~ 
		<input id="TO_DT" name="TO_DT" maxlength="10" size="10" class="form-control datePicker" value="" readonly/>
  	</div>
  	<div class="form-group">
    	<label for="CB_SEARCHKIND">통합검색</label>
		<input class="form-control" type="text" class="search_input" id="SEARCH_STR" name="SEARCH_STR" value="" />
  	</div>
</div>
<div style="height:10px"></div>
 
<div>
    <button class="btn btn-default" data-grid-control="search">검색</button>
    <button class="btn btn-default" data-grid-control="export">엑셀</button>
    <button class="btn btn-default" data-grid-control="save">저장</button>
</div>

<div style="height:10px"></div>


<div style="position: relative;height:400px;" id="grid-parent">
    <div data-ax5grid="first-grid" style="height: 100%;"></div>
</div>

</form>


<div class="mask"></div>

</body>
</html>

