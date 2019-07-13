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
    
	grid = gfn_makeAx5Grid("first-grid",
		[ 	{
				key : "COMP_NAME",
	            label : "채널",
	            width : 120,
	            align : "center"
	        },{
				key : "USER_NAME",
	            label : "담당자",
	            width : 120,
	            align : "center"
	        },{
  	            key : "TALK_NOTICE",
  	            label : "공지 내용",
  	            width : 700,
  	            align : "left",
	            editor : { 
	            	type : "text"
				},
				styleClass: function () {
                    return "grid-cell-edit";
                }
	        }	], 
	  	null,
	  	{
	  		showRowSelector : false
	  	}
	);
	
	$(window).trigger("resize");
	
    $('[data-grid-control]').click(function () {
        switch (this.getAttribute("data-grid-control")) {
		    case "save":
		       	mask.open();
		       	confirmDialog.confirm(
		       		{
		               	title: "Confirm",
		               	msg: '저장하시겠습니까?'
		           	}, 
		           	function(){
		             	if ( this.key == "ok" ) {
		             		gfn_callAjax("/board/axTalkNoticeSave.do", gfn_getSaveData(grid), fn_callbackAjax, "save");
		               	} else {
		               		mask.close();
		               	}
		           	}
		       	);
		    	
		    	break;
        }
    });
    
    fn_search();
});

function fn_params() {
	params.COMP_CD = "${session.compCd}";	
}

function fn_search() {
	fn_params();
	
	gfn_callAjax("/board/axTalkNoticeList.do", params, fn_callbackAjax, "search");
}

function fn_callbackAjax(data, id) {
	if ( data.RtnMode == "ERROR" ) {
		mask.open();
		dialog.alert( { msg : "처리시 오류가 발생했습니다. 관리자에게 문의하세요." }, function () { mask.close();	fn_search(); } );
		return;
	}
	
	if ( id == "search" ) {
		grid.setData(data.list);
	} else if ( id == "save" ) {
		mask.close();

		mask.open();
		dialog.alert( { msg : "저장 되었습니다." }, function () { mask.close();	fn_search(); } );
	} else if ( id == "dd" ){
		dd = $.extend({}, data);

		gfn_cbRefresh("CB_COMPANY", data.Company2, true);
	}
}

function fn_gridEvent(event, obj) {
	if ( event == "Click" ) {
		obj.self.select(obj.dindex);
	}
}

</script>

<body style="padding : 10px">

<form id="frm" name="frm" method="post">

<h2>큐톡 공지 관리</h2>
<div style="height:10px"></div>

<div>
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

