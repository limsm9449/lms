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
	var splitter = $('#splitter').height($(window).height() - $("#splitter").position().top - 20).split({
	    orientation: 'horizontal',
	    limit: 10,
	    position: '50%',
	    onDrag: function(event) {
	        if ( grid1 ) { 
	        	grid1.setHeight($("#topPane").height());
	        	grid2.setHeight($("#bottomPane").height());
	        }
	    }
	});
	
	$( window ).resize( function() {
		$("#splitter").height($(window).height() - $("#splitter").position().top - 20);
    	$("#top-grid-parent").height($("#topPane").height());
    	$("#bottom-grid-parent").height($("#bottomPane").height());
	} );
	
    confirmDialog.setConfig({
        theme: "danger"
    });

    gfn_callAjax("/common/axDd.do", { DD_KIND : "FrameKind" }, fn_callbackAjax, "dd", { async : false });
    
    $('[data-grid-control]').click(function () {
        switch (this.getAttribute("data-grid-control")) {
	        case "search":
	            fn_search();
	            break; 
        }
    });
    
    $(window).trigger("resize");
    
    //fn_search();
});

function fn_makeGrid() {
	grid1 = gfn_makeAx5Grid("top-first-grid",
		[ 	{
	            key : "CHANNEL_KIND",
	            label : "채널 종류",
	            width : 80,
	            align : "center", 
	        	editor: {
                    type : "select", 
                    config : {
                        columnKeys: { optionValue: "value", optionText: "text" },
                        options: dd.ChannelKind
                    }
	        	},
	            formatter : function () {
	                return gfn_getValueInList(dd.ChannelKind, "value",  this.item.CHANNEL_KIND, "text");
	           	},
				styleClass: function () {
                    return "grid-cell-edit";
                }
	        },{
	            key : "FRAME_KIND",
	            label : "프레임 종류",
	            width : 90,
	            align : "center", 
	        	editor: {
                    type : "select", 
                    config : {
                        columnKeys: { optionValue: "value", optionText: "text" },
                        options: dd.FrameKind
                    }
	        	},
	            formatter : function () {
	                return gfn_getValueInList(dd.FrameKind, "value",  this.item.FRAME_KIND, "text");
	           	},
				styleClass: function () {
                    return "grid-cell-edit";
                }
	        },{
	        	key : "FRAME_NAME", 
	        	label : "프레임 이름", 
	            width : 200,
	        	align : "left", 
	        	editor : { 
	        		type : "text"
	        	},
				styleClass: function () {
                    return "grid-cell-edit";
                } 
	        },{
              	key : undefined, 
              	label: "운영", 
              	columns: [	        
			        {
			            key : "BK_COLOR",
			            label : "배경색",
			            width : 70,			            
			            align : "left",
			        	editor : { 
			        		type : "text"
			        	},
						styleClass: function () {
		                    return "grid-cell-edit";
		                }  

			        },{
			            key : "BK_IMAGE_URL",
			            label : "배경 Url",
			            width : 170,			            
			            align : "left",
			        	editor : { 
			        		type : "text"
			        	},
						styleClass: function () {
		                    return "grid-cell-edit";
		                }  

			        },{
			            key : "ORD",
			            label : "순번",
			            width : 70,
			            align : "right",
			        	editor : { 
			        		type : "number"
			        	},
						styleClass: function () {
		                    return "grid-cell-edit";
		                } 
			        },{
			            key : "USE_YN",
			            label : "사용여부",
			            width : 90,
			        	align : "center", 
			        	editor : { type : "checkbox", config : {height: 17, trueValue: "Y", falseValue: "N"} },
						styleClass: function () {
		                    return "grid-cell-edit";
		                } 
			        }
		        ]	        	
	        },{
              	key : undefined, 
              	label: "테스트", 
              	columns: [	        
			        {
			            key : "T_BK_COLOR",
			            label : "배경색",
			            width : 70,
			            align : "left",
			        	editor : { 
			        		type : "text"
			        	},
						styleClass: function () {
		                    return "grid-cell-edit";
		                }  
			        },{
			            key : "T_BK_IMAGE_URL",
			            label : "배경 Url",
			            width : 170,
			            align : "left",
			        	editor : { 
			        		type : "text"
			        	},
						styleClass: function () {
		                    return "grid-cell-edit";
		                }  
			        },{
			            key : "T_ORD",
			            label : "순번",
			            width : 70,
			            align : "right",
			        	editor : { 
			        		type : "number"
			        	},
						styleClass: function () {
		                    return "grid-cell-edit";
		                } 
			        },{
			            key : "T_USE_YN",
			            label : "사용여부",
			            width : 90,
			        	align : "center", 
			        	editor : { type : "checkbox", config : {height: 17, trueValue: "Y", falseValue: "N"} },
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
	
	grid2 = gfn_makeAx5Grid("bottom-first-grid",
		[ 	{
              	key : undefined, 
              	label: "운영", 
              	columns: [	        
			        {
			            key : "CONTENTS_URL",
			            label : "이미지 URL",
			            width : 70,			            
			            align : "left",
			        	editor : { 
			        		type : "text"
			        	},
						styleClass: function () {
		                    return "grid-cell-edit";
		                }  

			        },{
			            key : "LINK_URL",
			            label : "연결할 URL",
			            width : 170,			            
			            align : "left",
			        	editor : { 
			        		type : "text"
			        	},
						styleClass: function () {
		                    return "grid-cell-edit";
		                }  
			        },{
			            key : "MP4_YN",
			            label : "동영상 여부",
			            width : 90,
			        	align : "center", 
			        	editor : { type : "checkbox", config : {height: 17, trueValue: "Y", falseValue: "N"} },
						styleClass: function () {
		                    return "grid-cell-edit";
		                } 
			        },{
			            key : "ORD",
			            label : "순번",
			            width : 70,
			            align : "right",
			        	editor : { 
			        		type : "number"
			        	},
						styleClass: function () {
		                    return "grid-cell-edit";
		                } 
			        },{
			            key : "USE_YN",
			            label : "사용 여부",
			            width : 90,
			        	align : "center", 
			        	editor : { type : "checkbox", config : {height: 17, trueValue: "Y", falseValue: "N"} },
						styleClass: function () {
		                    return "grid-cell-edit";
		                } 
			        }
		        ]	        	
	        },{
              	key : undefined, 
              	label: "테스트", 
              	columns: [	        
              		{
			            key : "T_CONTENTS_URL",
			            label : "이미지 URL",
			            width : 70,			            
			            align : "left",
			        	editor : { 
			        		type : "text"
			        	},
						styleClass: function () {
		                    return "grid-cell-edit";
		                }  

			        },{
			            key : "T_LINK_URL",
			            label : "연결할 URL",
			            width : 170,			            
			            align : "left",
			        	editor : { 
			        		type : "text"
			        	},
						styleClass: function () {
		                    return "grid-cell-edit";
		                }  
			        },{
			            key : "T_MP4_YN",
			            label : "동영상 여부",
			            width : 90,
			        	align : "center", 
			        	editor : { type : "checkbox", config : {height: 17, trueValue: "Y", falseValue: "N"} },
						styleClass: function () {
		                    return "grid-cell-edit";
		                } 
			        },{
			            key : "T_ORD",
			            label : "순번",
			            width : 70,
			            align : "right",
			        	editor : { 
			        		type : "number"
			        	},
						styleClass: function () {
		                    return "grid-cell-edit";
		                } 
			        },{
			            key : "T_USE_YN",
			            label : "사용 여부",
			            width : 90,
			        	align : "center", 
			        	editor : { type : "checkbox", config : {height: 17, trueValue: "Y", falseValue: "N"} },
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
}

function fn_params() {
	params.SEARCH_STR = $("#SEARCH_STR").val();	
}

function fn_search() {
	//mask.open();
	
	fn_params();
	
	gfn_callAjax("/setting/axMainFrameList.do", params, fn_callbackAjax, "search");
}

function fn_callbackAjax(data, id) {
	//console.log("fn_callbackAjax : " + id);
	if ( id == "search" ) {
		grid1.setData(data.list);
	} else if ( id == "searchDetail" ) {
		grid2.setData(data.list);
	} else if ( id == "dd" ){
		dd = $.extend({}, data);

		fn_makeGrid();
	}
}

function fn_gridEvent(event, obj) {
	if ( event == "Click" ) {
		obj.self.select(obj.dindex);
	} else if ( event == "DBLClick" ) {
		params.USER_ID = obj.item.USER_ID;	
		
		gfn_callAjax("/setting/axMainFrameList.do", params, fn_callbackAjax, "searchDetail");
	} else if ( event == "DataChanged" ) {
	}
}


</script>

<body style="padding : 10px">

<form id="frm" name="frm" method="post">

<h2>메인 프레임 관리</h2>
<div style="height:10px"></div>

<div class="form-inline">
  	<div class="form-group">
    	<label for="CHANNEL_KIND">채널 종류</label>
		<select class="form-control" id="CHANNEL_KIND">
			<option value="">전체</option>
			<option value="Q_CHANNEL">Q.채널</option>
			<option value="P_CHANNEL">P.채널</option>
		</select>
  	</div>
</div>
<div style="height:10px"></div>

<div>
    <button class="btn btn-default" data-grid-control="search">검색</button>
    <button class="btn btn-default" data-grid-control="saveMaster">Master 저장</button>
    <button class="btn btn-default" data-grid-control="saveDetail">Detail 저장</button>
    <button class="btn btn-default" data-grid-control="saveApply">운영 적용</button>
</div> 

<div style="height:10px"></div>

<div id="splitter">
    <div id="topPane">
	    <div id="top-grid-parent">
		    <div data-ax5grid="top-first-grid" style="height: 100%; width:100%;"></div>
		</div>
    </div>
    <div id="bottomPane">
	    <div id="bottom-grid-parent">
		    <div data-ax5grid="bottom-first-grid" style="height: 100%; width:100%;"></div>
		</div>
    </div>
</div>


</form>

<div class="mask"></div>

</body>
</html>

