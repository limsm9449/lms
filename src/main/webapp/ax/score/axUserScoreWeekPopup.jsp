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
	            key : "WEEK",
	            label : "차시",
	            width : 60,
	            align : "right"
	        },{
	            key : "TITLE",
	            label : "제목",
	            width : 420,
	            align : "left"
	        },{
	            key : "PROGRESS_RATE",
	            label : "진도율",
	            width : 80,
	            align : "right",
	            formatter : function () {
	                return this.item.PROGRESS_RATE + " %";
	           	}
	        },{
	            key : "STUDY_START",
	            label : "학습 시작일",
	            width : 130,
	            align : "center"
	        },{
	            key : "STUDY_END",
	            label : "학습 종료일",
	            width : 130,
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
	params.COURSE_ID = gfn_getUrlParams("COURSE_ID");
	params.USER_ID = gfn_getUrlParams("USER_ID");
}

function fn_search() {
	//mask.open();
	
	fn_params();
	
	gfn_callAjax("/score/axUserScoreWeekList.do", params, fn_callbackAjax, "search");
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
	} else if ( event == "DataChanged" ) {
	}
}

</script>

<body style="padding : 10px">

<form id="frm" name="frm" method="post">

<h2>차시별 진도</h2>
<div style="height:10px"></div>

<div>
    <button class="btn btn-default" data-grid-control="close">닫기</button>
</div>

<div style="height:10px"></div>


<div style="position: relative;height:460px;" id="grid-parent">
    <div data-ax5grid="first-grid" style="height: 100%;"></div>
   
</div>


</form>
	

</body>
</html>

