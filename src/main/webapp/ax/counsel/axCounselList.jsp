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
    
    $("#CONTENTS").cleditor({height:305});
	
    $('[data-grid-control]').click(function () {
        switch (this.getAttribute("data-grid-control")) {
	        case "search":
	            fn_search();
	            break;
            case "export":
                grid.exportExcel("상담내역.xls");
                break;
        }
    });
    
    gfn_callAjax("/common/axDd.do", { DD_KIND : "FaqCategory" }, fn_callbackAjax, "dd", { async : false });

    fn_search();
});

function fn_ddAfter() {
	grid = gfn_makeAx5Grid("first-grid",
		[ 	{
	            key : "CATEGORY",
	            label : "카테고리",
	            width : 120,
	            align : "left", 
	        	editor: {
                    type : "select", 
                    config : {
                        columnKeys: { optionValue: "value", optionText: "text" },
                        options: dd.FaqCategory
                    },
	            	disabled : function () {
                        return true;
                    }
	        	},
	            formatter : function () {
	                return gfn_getValueInList(dd.FaqCategory, "value",  this.item.CATEGORY, "text");
	           	}
	        },{
	            key : "TITLE",
	            label : "제목",
	            width : 700,
	            align : "left"
	        },{
	            key : "CREATE_DATE",
	            label : "등록일자",
	            width : 120,
	            align : "center"
	        },{
	        	key : "ANSWER_YN", 
	        	label : "답변상태", 
	            width : 70,
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
	params.CATEGORY = $("#CB_CATEGORY option:selected").val();	
	params.SEARCH_STR = $("#SEARCH_STR").val();
}

function fn_search() {
	fn_params();
	
	gfn_callAjax("/counsel/axCounselList.do", params, fn_callbackAjax, "search");
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
		
		gfn_cbRefresh("CB_CATEGORY", data.FaqCategory, true);
		
		fn_ddAfter();
	}
} 

function fn_gridEvent(event, obj) {
	if ( event == "Click" ) {
		obj.self.select(obj.dindex); 
	} else if ( event == "DBLClick" ) {
		var mode = "UPDATE";
		
   		var urlParams = "page=/ax/counsel/axCounselPopup";
   		urlParams += "&MODE=" + mode + "&SEQ=" + obj.item["SEQ"];
   		
   		f_popup('/common/axOpenPage', {displayName:'counselPopup',option:'width=900,height=800', urlParams:urlParams});
   		
	} else if ( event == "DataChanged" ) {
	}
}

</script>

<body style="padding : 10px">

<form id="frm" name="frm" method="post">

<h2>상담내역</h2>
<div style="height:10px"></div>

<div class="form-inline">
  	<div class="form-group">
    	<label for="CB_CATEGORY">카테고리</label>
		<select class="form-control" id="CB_CATEGORY">
			<option value="">전체</option>
		</select>
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
</div>

<div style="height:10px"></div>


<div style="position: relative;height:400px;" id="grid-parent">
    <div data-ax5grid="first-grid" style="height: 100%;"></div>
</div>

</form>


<div class="mask"></div>

</body>
</html>

