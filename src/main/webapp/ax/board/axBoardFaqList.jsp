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
		    case "add":
           		var urlParams = "page=/ax/board/axBoardFaqPopup";
           		urlParams += "&MODE=INSERT&SEQ=";
           		f_popup('/common/axOpenPage', {displayName:'boardFaqPopup',option:'width=900,height=620', urlParams:urlParams});

		    	break;
		    case "delete":
		    	var row = grid.getList("selected");
            	if ( row.length == 0 ) {
            		mask.open();
            		dialog.alert( { msg : "삭제할 글을 선택하셔야 합니다." }, function () { mask.close();	} );
            		return;
            	}

            	mask.open();
               	confirmDialog.confirm(
               		{
                       	title: "Confirm",
                       	msg: '삭제하시겠습니까?'
                   	}, 
                   	function(){
                     	if ( this.key == "ok" ) {
                     		var saveParams = {
                     			MODE : "DELETE",
                     			SEQ : row[0].SEQ,
                     			COURSE_ID : row[0].COURSE_ID
                     		};
                     		
                     		gfn_callAjax("/board/axBoardFaqSave.do", saveParams, fn_callbackAjax, "delete");
                       	} else {
                       		mask.close();
                       	}
                   	}
               	);
		    	break;
            case "export":
                grid.exportExcel("FAQ 게시판.xls");
                break;
        }
    });
    
    gfn_callAjax("/common/axDd.do", { DD_KIND : "CompanyKind,B2CFaqCategory,B2BFaqCategory,C2CFaqCategory,AllFaqCategory" }, fn_callbackAjax, "dd", { async : false });

    //fn_search();
});

function fn_ddAfter() {
	grid = gfn_makeAx5Grid("first-grid",
		[ 	{
	        	key : "COMP_KIND", 
	        	label : "회사 구분", 
	            width : 100,
	        	align : "center", 
	        	editor: {
	                type : "select", 
	                config : {
	                    columnKeys: { optionValue: "value", optionText: "text" },
	                    options: dd.CompanyKind
	                },
	            	disabled : function () {
	                    return true;
	                }
	        	},
	            formatter : function () {
	                return gfn_getValueInList(dd.CompanyKind, "value",  this.item.COMP_KIND, "text");
	           	}
	        },{
	            key : "CATEGORY",
	            label : "카테고리",
	            width : 120,
	            align : "left", 
	        	editor: {
                    type : "select", 
                    config : {
                        columnKeys: { optionValue: "value", optionText: "text" },
                        options: dd.AllFaqCategory
                    },
	            	disabled : function () {
                        return true;
                    }
	        	},
	            formatter : function () {
	                return gfn_getValueInList(dd.AllFaqCategory, "value",  this.item.CATEGORY, "text");
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
	        	key : "VIEW_CNT", 
	        	label : "조회수", 
	            width : 70,
	        	align : "right"
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
	params.CB_COMPANY = $("#CB_COMPANY option:selected").val();	
	params.CATEGORY = $("#CB_CATEGORY option:selected").val();	
	params.SEARCH_STR = $("#SEARCH_STR").val();
}

function fn_search() {
	fn_params();
	
	gfn_callAjax("/board/axBoardFaqList.do", params, fn_callbackAjax, "search");
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
		
		gfn_cbRefresh("CB_COMPANY", data.CompanyKind, true);
		
		fn_ddAfter();
	} else if ( id == "delete" ) {
		mask.close();

		mask.open();
		dialog.alert( { msg : "삭제 되었습니다." }, function () { mask.close();	fn_search(); } );
	}
} 

function fn_gridEvent(event, obj) {
	if ( event == "Click" ) {
		obj.self.select(obj.dindex); 
	} else if ( event == "DBLClick" ) {
		var mode = "UPDATE";
		
   		var urlParams = "page=/ax/board/axBoardFaqPopup";
   		urlParams += "&MODE=" + mode + "&SEQ=" + obj.item["SEQ"] + "&COMP_KIND=" + obj.item["COMP_KIND"];
   		
   		f_popup('/common/axOpenPage', {displayName:'boardFaqPopup',option:'width=900,height=620', urlParams:urlParams});
   		
	} else if ( event == "DataChanged" ) {
	}
}

function fn_cbChange(id) {
	if ( id == "CB_COMPANY" ) {
		if ( $("#CB_COMPANY").val() == "B2B" ) {
			gfn_cbRefresh("CB_CATEGORY", dd.B2BFaqCategory, true);
		} else if ( $("#CB_COMPANY").val() == "C2C" ) {
			gfn_cbRefresh("CB_CATEGORY", dd.C2CFaqCategory, true);
		} else if ( $("#CB_COMPANY").val() == "B2C" ) {
			gfn_cbRefresh("CB_CATEGORY", dd.B2CFaqCategory, true);
		} else {
			gfn_cbRefresh("CB_CATEGORY", null, true);
		}
	}
}

</script>

<body style="padding : 10px">

<form id="frm" name="frm" method="post">

<h2>FAQ</h2>
<div style="height:10px"></div>

<div class="form-inline">
  	<div class="form-group">
    	<label for="CB_COMPANY">&nbsp;회사 구분</label>
		<select class="form-control" id="CB_COMPANY" onchange="fn_cbChange('CB_COMPANY')">
			<option value="">전체</option>
		</select>
  	</div>
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
    <button class="btn btn-default" data-grid-control="add">추가</button>
    <button class="btn btn-default" data-grid-control="delete">삭제</button>
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

