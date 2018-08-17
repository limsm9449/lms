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

var isSave = false;

$(document.body).ready(function () {
    confirmDialog.setConfig({
        theme: "danger"
    });
    
    grid = gfn_makeAx5Grid("first-grid",
   		[ 	{
   	            key : "TITLE",
   	            label : "제목",
   	            width : 500,
   	            align : "left"
   	        },{
   	            key : "USER_NAME",
   	            label : "작성자",
   	            width : 120,
   	            align : "center"
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
	
    $('[data-grid-control]').click(function () {
        switch (this.getAttribute("data-grid-control")) {
	        case "search":
	            fn_search();
	            break;
            case "close" :
            	if ( isSave ) {
            		opener.fn_search();
            	}
            	
            	window.close();
                break;
        }
    });
    
    $("#SEARCH_STR").val(gfn_getUrlParams("USER_ID"));
    fn_search();
});

function fn_params() {
	params.COURSE_ID = gfn_getUrlParams("COURSE_ID");
}

function fn_search() {
	//mask.open();
	
	fn_params();
	
	gfn_callAjax("/score/axUserScoreReportList.do", params, fn_callbackAjax, "search");
}


function fn_callbackAjax(data, id) {
	//console.log("fn_callbackAjax : " + id);
	if ( id == "search" ) {
		grid.setData(data.list);
		//mask.close();
	}
}

function fn_gridEvent(event, obj) {
	if ( event == "Click" ) {
		obj.self.select(obj.dindex);
	} else if ( event == "DBLClick" ) {
   		var urlParams = "page=/ax/board/axBoardReportPopup";
   		urlParams += "&MODE=&SEQ=" + obj.item["SEQ"] + "&COURSE_ID=" + params.COURSE_ID + "&KIND=B_REPORT";
   		
   		f_popup('/common/axOpenPage', {displayName:'boardReportPopup',option:'width=900,height=700', urlParams:urlParams});
	} else if ( event == "DataChanged" ) {
	}
}

</script>

<body style="padding : 10px">

<form id="frm" name="frm" method="post">

<h2>제출 레포트</h2>
<div style="height:10px"></div>

<div class="form-inline">
	<div class="form-group">
	  	<label for="SEARCH_STR">통합검색</label>
   		<input type="text" class="form-control" id="SEARCH_STR" placeholder="">
	</div>
</div>	
<div style="height:10px"></div> 
<div class="form-horizontal">
	<div class="form-group">
		<div class="col-sm-offset-9 col-sm-3">
		    <button class="btn btn-default" data-grid-control="search">검색</button>
		    <button class="btn btn-default" data-grid-control="close">닫기</button>
		</div>
	</div>
</div>

<div style="position: relative;height:500px;" id="grid-parent"> 
    <div data-ax5grid="first-grid" style="height: 100%;"></div>
   
</div>

</form>
	

</body>
</html>

