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
var grid2 = null;
var params = {}

var isSave = false;

$(document.body).ready(function () {
    confirmDialog.setConfig({
        theme: "danger"
    });
    
    $('[data-grid-control]').click(function () {
        switch (this.getAttribute("data-grid-control")) {
	        case "search":
	            fn_search();
	            break;
            case "add" :
            	var rows = grid.getList("selected");
            	for ( var i = 0; i < rows.length; i++ ) {
            		grid2.addRow( 
           				{
           					NEW_FLAG : "Y", 
           					COURSE_ID : params.COURSE_ID,
           					USER_ID : rows[i].USER_ID, 
           					USER_NAME : rows[i].USER_NAME
           				}, "last", {focus: "END"});
            	}

            	grid.deleteRow("selected"); 
            	
            	fn_save();
            	
            	break;
            case "delete" :
            	var rows = grid2.getList("selected");
            	for ( var i = 0; i < rows.length; i++ ) {
            		grid.addRow( 
           				{
           					NEW_FLAG : "Y", 
           					USER_ID : rows[i].USER_ID, 
           					USER_NAME : rows[i].USER_NAME
           				}, "last", {focus: "END"});
            	}

            	grid2.deleteRow("selected");

            	fn_save();
            	
                break;
            case "save" :
            	fn_save();
                break;
            case "application" :
            	var rows = grid2.getList("");
            	if ( rows.length == 0 ) {
            		mask.open();
            		dialog.alert( { msg : "신청할 사용자가 없습니다." }, function () { mask.close();	} );
            	} else {
            		document.frm.action = context + "/pg/axApplication.do?COURSE_ID=" + params.COURSE_ID + "&KIND=TYPE1";	
            		document.frm.target = "";
            		document.frm.method = "POST";	
            		document.frm.submit();
            	}
            	
                break;
            case "close" :
            	if ( isSave ) {
            		opener.fn_search();
            	}
            	
            	window.close();
                break;
        }
    });
    
    fn_makeGrid();
    fn_search();
});

function fn_makeGrid() {
	grid = gfn_makeAx5Grid("first-grid1",
		[ 	{
	            key : "USER_ID",
	            label : "수강생 ID",
	            width : 80,
	            align : "left"
	        },{
	            key : "USER_NAME",
	            label : "수강생명",
	            width : 80,
	            align : "left"
	        }	], 
	  	null,
	  	{
	  		showRowSelector : true,
	  		multipleSelect: true
	  	}
	);
	grid2 = gfn_makeAx5Grid("first-grid2",
			[ 	{
		            key : "USER_ID",
		            label : "수강생 ID",
		            width : 80,
		            align : "left"
		        },{
		            key : "USER_NAME",
		            label : "수강생명",
		            width : 80,
		            align : "left"
		        }	], 
		  	null,
		  	{
		  		showRowSelector : true,
		  		multipleSelect: true
		  	}
		);
}

function fn_params() {
	params.COURSE_ID = gfn_getUrlParams("COURSE_ID");
}

function fn_search() {
	//mask.open();
	
	fn_params();
	
	gfn_callAjax("/siteManager/axSiteManagerCourseUserList.do", params, fn_callbackAjax, "search");
}

function fn_save() {
	var saveParams = {
	};
	
	gfn_callAjax("/siteManager/axSiteManagerCourseUserSave.do", $.extend(saveParams, gfn_getSaveData(grid2)), fn_callbackAjax, "save");
}

function fn_callbackAjax(data, id) {
	//console.log("fn_callbackAjax : " + id);
	if ( id == "search" ) {
		grid.setData(data.list1);
		grid2.setData(data.list2);
	} else if ( id == "save" ){
		mask.close();

		if ( data.RtnMode && data.RtnMode != "OK" ) {
			mask.open();
			dialog.alert( { msg : "저장시 문제가 발생했습니다. (" + data.RtnMode + ")" }, function () { mask.close(); } );
		} else {
			mask.open();
			dialog.alert( { msg : "저장 되었습니다." }, function () { mask.close();	fn_search(); } );
		}
		
		isSave = true;
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

<h2>수강 신청</h2>
<div style="height:10px"></div>

<div>
    <button class="btn btn-default" data-grid-control="application">수강신청</button>
    <button class="btn btn-default" data-grid-control="close">닫기</button>
</div>

<div style="height:10px"></div>

<table style="width:100%;">
	<tr>
		<td>
			<div style="position: relative;height:460px;width" id="grid-parent"> 
			    <div data-ax5grid="first-grid1" style="height: 100%;"></div>
			</div>
		</td>
		<td style="width:5px"></td> 
		<td style="width:80px"> 
		    <button class="btn btn-default" data-grid-control="add">추가</button><br><br><br><br><br>
    		<button class="btn btn-default" data-grid-control="delete">삭제</button>
		</td>
		<td style="width:5px"></td> 
		<td> 
			<div style="position: relative;height:460px;width" id="grid-parent">
			    <div data-ax5grid="first-grid2" style="height: 100%;"></div>
			</div>
		</td>
	</tr>
</table>


</form>

<div class="mask"></div>

</body>
</html>

