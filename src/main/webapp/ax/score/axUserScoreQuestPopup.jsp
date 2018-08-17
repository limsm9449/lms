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
	        	key : "TYPE", 
	        	label : "타입", 
	            width : 70,
	        	align : "center", 
	        	editor: {
	                type : "select", 
	                config : {
	                    columnKeys: { optionValue: "CD", optionText: "NM" },
	                    options: [
	                        {CD: "G", NM: "객관식"},
	                        {CD: "M", NM: "복수형"},
	                        {CD: "J", NM: "주관식"}
	                    ]
	                },
	            	disabled : function () {
                        return true;
                    }
	        	},
	            formatter : function () {
	            	if ( this.item.TYPE == "G" )
	            		return "객관식";
	            	else if ( this.item.TYPE == "M" )
	            		return "복수형";
	            	else 
	                	return "주관식";
	           	}
	        },{
	            key : "QUESTION",
	            label : "질문",
	            width : 300,
	            align : "left"
	        },{
              	key : undefined, 
              	label: "질문 답", 
              	columns: [	
              		{
			            key : "QA1",
			            label : "1번",
			            width : 80,
			            align : "left"
			        },{
			            key : "QA2",
			            label : "2번",
			            width : 80,
			            align : "left"
			        },{
			            key : "QA3",
			            label : "3번",
			            width : 80,
			            align : "left"
			        },{
			            key : "QA4",
			            label : "4번",
			            width : 80,
			            align : "left"
			        }
			   	]
	        },{
	            key : "ANSWER",
	            label : "수강생 답",
	            width : 80,
	            align : "left"
	        },{
	        	key : "CREATE_DATE",
	            label : "생성일자",
	            width : 110,
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
	
	gfn_callAjax("/score/axUserScoreQuestList.do", params, fn_callbackAjax, "search");
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

<h2>설문지</h2>
<div style="height:10px"></div>

<div>
    <button class="btn btn-default" data-grid-control="close">닫기</button>
</div>

<div style="height:10px"></div>


<div style="position: relative;height:560px;" id="grid-parent">
    <div data-ax5grid="first-grid" style="height: 100%;"></div>
   
</div>


</form>
	

</body>
</html>

