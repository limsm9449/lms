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

<link rel="stylesheet" type="text/css" href="/resources/jquery_splitter/css/jquery.splitter.css"/>
<script src="/resources/jquery_splitter/js/jquery.splitter.js"></script>

</head>

<script type="text/javascript">
var mask = new ax5.ui.mask();
var confirmDialog = new ax5.ui.dialog();
var dialog = new ax5.ui.dialog( { title: '<i class="axi axi-ion-alert"></i> Alert' } );
var grid1 = null;
var grid2 = null;

var params = {};
var dd = {};

$(document.body).ready(function () {
	var splitter = $('#splitter').height(200).split({
	    orientation: 'vertical',
	    limit: 10,
	    position: '30%',
	    onDrag: function(event) {
	        //console.log(splitter.position());
	        if ( grid1 ) { 
	        	gfn_gridResize2("splitter", grid1, grid2);
	        }
	    }
	});
	
	$( window ).resize( function() {
        if ( grid1 ) { 
			gfn_gridResize2("splitter", grid1, grid2);
        }
	} );
	
	$("#FROM_DATE").val(gfn_addDay(gfn_currentDay(), -5, "-"));		
	gfn_initDatepicker("FROM_DATE");

	$("#TO_DATE").val(gfn_currentDay(null, "-"));		
	gfn_initDatepicker("TO_DATE");

    confirmDialog.setConfig({
        theme: "danger"
    });

    $('[data-grid-control]').click(function () {
        switch (this.getAttribute("data-grid-control")) {
	        case "search":
	            fn_search();
	            break; 
	        case "delete":
	        	mask.open();
	           	confirmDialog.confirm(
	           		{
	                   	title: "Confirm",
	                   	msg: '30일 이전의 메일 로그를 삭제하시겠습니까?'
	               	}, 
	               	function(){
	                 	if ( this.key == "ok" ) {
	                 		var saveParams = {
	                 		};
	                 		
	                 		gfn_callAjax("/log/axMailLogDelete.do", { }, fn_callbackAjax, "delete");
	                   	} else {
	                   		mask.close();
	                   	}
	               	}
	           	);
	           	
	            break; 
        }
    });

	fn_makeGrid();
});

function fn_makeGrid() {
	grid1 = gfn_makeAx5Grid("left-first-grid",
		[ 	{
	            key : "MAIL_DATE",
	            label : "발송일자",
	            width : 100,
	            align : "center"
	        },{
	            key : "MAIL_SERVER",
	            label : "SMTP 서버",
	            width : 180,
	            align : "left"
	        },{
	            key : "MAIL_CNT",
	            label : "발송건수",
	            width : 80,
	            align : "right"
	        },{
	            key : "BLOCK_YN",
	            label : "BLOCK",
	            width : 80,
	            align : "center"
	        }	], 
	  	null,
	  	{
	  		showRowSelector : false
	  	}
	);
	
	grid2 = gfn_makeAx5Grid("right-first-grid",
		[ 	{
	            key : "CREATE_DATE",
	            label : "생성일자",
	            width : 140,
	            align : "center"
	        },{
	            key : "USER_ID",
	            label : "사용자 ID",
	            width : 100,
	            align : "center"
	        },{
	            key : "USER_NAME",
	            label : "사용자명",
	            width : 90,
	            align : "center"
	        },{
	            key : "EMAIL",
	            label : "이메일",
	            width : 170,
	            align : "left"
	        },{
	            key : "TITLE",
	            label : "제목",
	            width : 400,
	            align : "left"
	        },{
	            key : "SEND_DATE",
	            label : "발송일자",
	            width : 140,
	            align : "center"
	        }	], 
	  	null,
	  	{
	  		showRowSelector : false
	  	}
	);

	$(window).trigger("resize");
}

function fn_params() {
	params.FROM_DATE = $("#FROM_DATE").val();
	params.TO_DATE = $("#TO_DATE").val();
	params.SEARCH_STR = $("#SEARCH_STR").val();	
}

function fn_search() {
	fn_params();
	
	gfn_callAjax("/log/axMailLogList.do", params, fn_callbackAjax, "search");
}

function fn_callbackAjax(data, id) {
	if ( data.RtnMode == "ERROR" ) {
		mask.open();
		dialog.alert( { msg : "처리시 오류가 발생했습니다. 관리자에게 문의하세요." }, function () { mask.close();	fn_search(); } );
		return;
	}

	if ( id == "search" ) {
		grid1.setData(data.list1);
		grid2.setData(data.list2);
	} else if ( id == "delete" ){
		mask.close();

		mask.open();
		dialog.alert( { msg : "삭제 되었습니다." }, function () { mask.close();	fn_search(); } );
	}
}

function fn_gridEvent(event, obj) {
	if ( event == "Click" ) {
		obj.self.select(obj.dindex);

		//params.USER_ID = obj.item.USER_ID;	
		//gfn_callAjax("/point/axPointDetailList.do", params, fn_callbackAjax, "searchDetail");
	} else if ( event == "DBLClick" ) {
		if ( obj.item["TITLE"] != undefined ) {
	   		var urlParams = "page=/ax/log/axMailLogPopup";
	   		urlParams += "&SEQ=" + obj.item["SEQ"];
	   		
	   		f_popup('/common/axOpenPage', {displayName:'mailLogPopup',option:'width=900,height=620', urlParams:urlParams});
		}
	} else if ( event == "DataChanged" ) {
	}
}


</script>

<body style="padding : 10px">

<form id="frm" name="frm" method="post">

<h2>메일 로그 관리</h2>
<div style="height:10px"></div>

<div class="form-inline">
  	<div class="form-group">
    	<label for="courseName">이벤트 일자</label>
	   	<input id="FROM_DATE" name="FROM_DATE" maxlength="10" size="10" class="form-control datePicker" value="" readonly/> ~
	   	<input id="TO_DATE" name="TO_DATE" maxlength="10" size="10" class="form-control datePicker" value="" readonly/>
  	</div>
  	<div class="form-group">
    	<label for="CB_SEARCHKIND">메일 제목</label>
		<input class="form-control" type="text" class="search_input" id="SEARCH_STR" name="SEARCH_STR" value="" />
  	</div>
</div>
<div style="height:10px"></div>

<div>
    <button class="btn btn-default" data-grid-control="search">검색</button>
    <button class="btn btn-default" data-grid-control="delete">메일 로그 삭제</button>
</div> 

<div style="height:10px"></div>

<div id="splitter">
    <div id="leftPane">
	    <div style="height:500px;" id="left-grid-parent">
		    <div data-ax5grid="left-first-grid" style="height: 100%; width:100%;"></div>
		</div>
    </div>
    <div id="rightPane">
	    <div style="height:500px;" id="right-grid-parent">
		    <div data-ax5grid="right-first-grid" style="height: 100%; width:100%;"></div>
		</div>
    </div>
</div>


</form>

<div class="mask"></div>

</body>
</html>

