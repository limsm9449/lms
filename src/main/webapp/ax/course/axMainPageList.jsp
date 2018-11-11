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

var dd;

$(document.body).ready(function () {
	$( window ).resize( function() {
		gfn_gridResize("grid-parent", grid);
	} );

    confirmDialog.setConfig({
        theme: "danger"
    });

    gfn_callAjax("/common/axDd.do", { DD_KIND : "MainpageKind" }, fn_callbackAjax, "dd", { async : false });
    
    $('[data-grid-control]').click(function () {
        switch (this.getAttribute("data-grid-control")) {
	        case "search":
	            fn_search();
	            break;
            case "save" :
            	fn_save();
                break;
            case "editImage":
            	var row = grid.getList("selected");
            	if ( row.length == 0 ) {
            		mask.open();
            		dialog.alert( { msg : "과정을 선택하셔야 합니다." }, function () { mask.close();	} );
            	} else {
            		var urlParams = "page=/ax/course/axMainPageImagePopup";
            		urlParams += "&COURSE_CODE=" + row[0]["COURSE_CODE"];
            		
            		f_popup('/common/axOpenPage', {displayName:'axMainPageImagePopup',option:'width=900,height=650', urlParams:urlParams});
            	}
            		
                break;
        }
    });
    
	fn_makeGrid();
});

function fn_makeGrid() {
	grid = gfn_makeAx5Grid("first-grid",
		[ 	{
	            key : "COURSE_ID",
	            label : "ID",
	            width : 40,
	            align : "right"
	        },{
	            key : "CATEGORY_NAME",
	            label : "카테고리",
	            width : 150,
	            align : "left"
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
              	key : undefined, 
              	label: "인기과정", 
              	columns: [	        
              		{
        	        	key : "POPULAR_YN", 
        	        	label : "인기과정", 
        	            width : 80,
        	        	align : "center", 
        	        	editor : { type : "checkbox", config : {height: 17, trueValue: "Y", falseValue: "N"} } ,
        				styleClass: function () {
                            return "grid-cell-edit";
                        } 
        	        },{
			            key : "POPULAR_IMG1",
			            label : "PC 이미지",
			            width : 100,
			            align : "center"
			        },{
			            key : "POPULAR_IMG2",
			            label : "모바일 이미지",
			            width : 120,
			            align : "center"
			        },{
			        	key : "POPULAR_COLOR", 
			        	label : "배경색", 
			            width : 80,
			        	align : "center", 
			        	editor : { type : "text" } ,
						styleClass: function () {
		                    return "grid-cell-edit";
		                } 
			        }
		        ]
	        },{
              	key : undefined, 
              	label: "추천과정", 
              	columns: [	        
              		{
        	        	key : "RECOMMEND_COURSE_YN", 
        	        	label : "추천과정", 
        	            width : 80,
        	        	align : "center", 
        	        	editor : { type : "checkbox", config : {height: 17, trueValue: "Y", falseValue: "N"} } ,
        				styleClass: function () {
                            return "grid-cell-edit";
                        } 
        	        },{
			            key : "RECOMMEND_IMG1",
			            label : "PC 이미지",
			            width : 100,
			            align : "center"
			        },{
			            key : "RECOMMEND_IMG2",
			            label : "모바일 이미지",
			            width : 120,
			            align : "center"
			        },{
			        	key : "RECOMMEND_COLOR", 
			        	label : "배경색", 
			            width : 80,
			        	align : "center", 
			        	editor : { type : "text" } ,
						styleClass: function () {
		                    return "grid-cell-edit";
		                } 
			        }
		        ]
	        },{
              	key : undefined, 
              	label: "신규과정", 
              	columns: [	        
              		{
        	        	key : "NEW_COURSE_YN", 
        	        	label : "신규과정", 
        	            width : 80,
        	        	align : "center", 
        	        	editor : { type : "checkbox", config : {height: 17, trueValue: "Y", falseValue: "N"} } ,
        				styleClass: function () {
                            return "grid-cell-edit";
                        } 
        	        },{
			            key : "NEW_IMG1",
			            label : "PC 이미지",
			            width : 100,
			            align : "center"
			        },{
			            key : "NEW_IMG2",
			            label : "모바일 이미지",
			            width : 120,
			            align : "center"
			        },{
			        	key : "NEW_COLOR", 
			        	label : "배경색", 
			            width : 80,
			        	align : "center", 
			        	editor : { type : "text" } ,
						styleClass: function () {
		                    return "grid-cell-edit";
		                } 
			        }
		        ]
	        }	], 
	  	null,
	  	{
	  		showRowSelector : false
	  	}
	);
	
	$(window).trigger("resize");
}

function fn_params() {
	params.CB_KIND = $("#CB_KIND option:selected").val();	
}

function fn_search() {
	//mask.open();
	
	fn_params();
	
	gfn_callAjax("/mainPage/axMainPageList.do", params, fn_callbackAjax, "search");
}

function fn_save() {
	var fieldParams = {
   	};
   	if ( gfn_validationCheck(grid, fieldParams) ) {
       	mask.open();
       	confirmDialog.confirm(
       		{
               	title: "Confirm",
               	msg: '저장하시겠습니까?'
           	}, 
           	function(){
             	if ( this.key == "ok" ) {
             		gfn_callAjax("/mainPage/axMainPageSave.do", gfn_getSaveData(grid), fn_callbackAjax, "save");
               	} else {
               		mask.close();
               	}
           	}
       	);
   	}
}

function fn_callbackAjax(data, id) {
	//console.log("fn_callbackAjax : " + id);
	if ( id == "search" ) {
		grid.setData(data.list);
		
		//mask.close();
	} else if ( id == "dd" ){
		dd = $.extend({}, data);
		
		gfn_cbRefresh("CB_KIND", data.MainpageKind, true);
	} else if ( id == "save" ){
		mask.close();

		mask.open();
		dialog.alert( { msg : "저장 되었습니다." }, function () { mask.close();	fn_search(); } );
	}
}

function fn_gridEvent(event, obj) {
	if ( event == "Click" ) {
		obj.self.select(obj.dindex);
	} else if ( event == "DataChanged" ) {
		if ( obj.key == "REPORT_RATE" ||
				obj.key == "EXAM_RATE" ||
				obj.key == "DISCUSSION_RATE" ||
				obj.key == "PROGRESS_RATE" ) {
			grid.repaint();
		}
	}
}

</script>

<body style="padding : 10px">

<h2>메인페이지 관리</h2>
<div style="height:10px"></div>

<form id="frm" name="frm" method="post" class="form-inline">
  	<div class="form-group">
    	<label for="CB_KIND">과정종류</label>
		<select class="form-control" id="CB_KIND">
			<option value="">전체</option>
		</select>
  	</div>
</form>
<div style="height:10px"></div>

<div>
    <button class="btn btn-default" data-grid-control="search">검색</button>
    <button class="btn btn-default" data-grid-control="save">저장</button>
    <button class="btn btn-default" data-grid-control="editImage">이미지 편집</button>
</div>

<div style="height:10px"></div>


<div style="position: relative;height:400px;" id="grid-parent">
    <div data-ax5grid="first-grid" style="height: 100%;"></div>
</div>

<div class="mask"></div>
	

</body>
</html>

