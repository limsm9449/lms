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
	    	$("#top-grid-parent").height($("#topPane").height());
	    	$("#bottom-grid-parent").height($("#bottomPane").height());
	        
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

    gfn_callAjax("/common/axDd.do", { DD_KIND : "FrameKind,ChannelKind" }, fn_callbackAjax, "dd", { async : false });
    
    $('[data-grid-control]').click(function () {
        switch (this.getAttribute("data-grid-control")) {
	        case "search":
	            fn_search();
	            break; 
            case "addMaster":
            	grid1.addRow( {
            		NEW_FLAG : "Y"
					,CHANNEL_KIND : "Q_CHANNEL"
					,FRAME_KIND : "SLIDE"
					,FRAME_NAME : ""
					,ORD : 1
					,USE_YN : "N"
					,T_ORD : 1
					,T_USE_YN : "Y"
            	}, "last", {focus: "END"});
                break;
            case "deleteMaster":
            	var row = grid1.getList("selected");
            	if ( row.length == 0 ) {
            		mask.open();
            		dialog.alert( { msg : "데이타를 선택하셔야 합니다." }, function () { mask.close();	} );
            	} else {
                	grid1.deleteRow("selected");
            	}
            	
                break;
            case "saveMaster" :
            	fn_saveMaster();
                break;
            case "addDetail":
            	var row = grid1.getList("selected");
            	if ( row.length == 0 ) {
            		mask.open();
            		dialog.alert( { msg : "데이타를 선택하셔야 합니다." }, function () { mask.close();	} );
            	} else if ( row[0].NEW_FLAG == "Y" ) {
            		mask.open();
            		dialog.alert( { msg : "저장후에 추가를 하셔야 합니다." }, function () { mask.close();	} );
            	} else {            	
	            	grid2.addRow( {
	            		NEW_FLAG : "Y"
	            		,MAIN_FRAME_SEQ : row[0]["SEQ"]
						,BK_COLOR : ""
						,BK_IMAGE_URL : ""
	            		,LINK_URL : ""
	            		,MP4_YN : ""
	            		,ORD : 1
	            		,USE_YN : "N"
    					,T_BK_COLOR : ""
   						,T_BK_IMAGE_URL : ""
	            		,T_LINK_URL : ""
	            		,T_MP4_YN : "N"
	            		,T_ORD : 1
	            		,T_USE_YN : "Y"
	            	}, "last", {focus: "END"});
            	}
            	
                break;
            case "deleteDetail":
            	var row = grid2.getList("selected");
            	if ( row.length == 0 ) {
            		mask.open();
            		dialog.alert( { msg : "데이타를 선택하셔야 합니다." }, function () { mask.close();	} );
            	} else {
                	grid2.deleteRow("selected");
            	}
            	
                break;
            case "saveDetail" :
            	fn_saveDetail();
                break;
            case "view" :
            	var urlParams = "mainViewMode=TEST";
        		f_popup('/main/content', {displayName:'courseTutorPopup',option:'width=1400,height=900', urlParams:urlParams});
        		
                break;
            case "saveApply" :
            	fn_saveApply();
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
	            width : 90,
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
	            width : 130,
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
              	key : undefined, 
              	label: "테스트", 
              	columns: [	        
              		{
        	        	key : "T_FRAME_NAME", 
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
        	        	key : "T_FRAME_DESC", 
        	        	label : "프레임 설명", 
        	            width : 400,
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
	        },{
              	key : undefined, 
              	label: "운영", 
              	columns: [	        
              		{
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
        	        	key : "FRAME_DESC", 
        	        	label : "프레임 설명", 
        	            width : 400,
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
	        }	], 
	  	null,
	  	{
	  		showRowSelector : false
	  	}
	);
	
	grid2 = gfn_makeAx5Grid("bottom-first-grid",
		[ 	{
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
			            width : 400,
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
			            width : 270,			            
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
			            width : 400,			            
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
			            width : 270,			            
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
	        }	], 
	  	null,
	  	{
	  		showRowSelector : false
	  	}
	);
}

function fn_params() {
	params.CHANNEL_KIND = $("#CHANNEL_KIND option:selected").val();	
}

function fn_search() {
	//mask.open();
	
	fn_params();
	
	gfn_callAjax("/setting/axMainFrameList.do", params, fn_callbackAjax, "search");
}

function fn_searchDetail() {
	var row = grid1.getList("selected");
	if ( row.length == 1 ) {
		params.SEQ = row[0].SEQ;
		
		if ( row[0].NEW_FLAG == "N" ) {
			gfn_callAjax("/setting/axMainFrameDetailList.do", params, fn_callbackAjax, "searchDetail");
		}
	}
}

function fn_callbackAjax(data, id) {
	//console.log("fn_callbackAjax : " + id); 
	if ( id == "search" ) {
		grid1.setData(data.list);
		
		grid1.select(0, {selected: true});
		fn_searchDetail();
	} else if ( id == "searchDetail" ) {
		grid2.setData(data.list);
	} else if ( id == "dd" ){
		dd = $.extend({}, data);
		
		gfn_cbRefresh("CHANNEL_KIND", data.ChannelKind, true);

		fn_makeGrid();
	} else if ( id == "saveMaster" ){
		mask.close();

		mask.open();
		dialog.alert( { msg : "저장 되었습니다." }, function () { mask.close();	fn_search(); } );
	} else if ( id == "saveDetail" ){
		mask.close();

		mask.open();
		dialog.alert( { msg : "저장 되었습니다." }, function () { mask.close();	fn_searchDetail(); } );
	} else if ( id == "saveApply" ){
		mask.close();

		mask.open();
		dialog.alert( { msg : "메인 화면에 반영되었습니다." }, function () { mask.close();	fn_search(); } );
	}
}

var currentIdx = -1;
function fn_gridEvent(event, obj) {
	if ( event == "Click" ) {
		obj.self.select(obj.dindex);

		if ( obj.item.CHANNEL_KIND != undefined && currentIdx != obj.dindex) {
			currentIdx = obj.dindex;
			
			fn_searchDetail();
		}
	} else if ( event == "DBLClick" ) {
	} else if ( event == "DataChanged" ) {
	}
}

function fn_saveMaster() {
	var fieldParams = {
   	};
   	if ( gfn_validationCheck(grid1, fieldParams) ) {
       	mask.open();
       	confirmDialog.confirm(
       		{
               	title: "Confirm",
               	msg: '저장하시겠습니까?'
           	}, 
           	function(){
             	if ( this.key == "ok" ) {
             		gfn_callAjax("/setting/axMainFrameSave.do", gfn_getSaveData(grid1), fn_callbackAjax, "saveMaster");
               	} else {
               		mask.close();
               	}
           	}
       	);
   	}
}

function fn_saveDetail() {
	var fieldParams = {
			T_BK_IMAGE_URL : { mendatory : true, colName : "배경 Url" }
			,T_LINK_URL : { mendatory : true, colName : "연결할 URL" }
   	};
   	if ( gfn_validationCheck(grid2, fieldParams) ) {
       	mask.open();
       	confirmDialog.confirm(
       		{
               	title: "Confirm",
               	msg: '저장하시겠습니까?'
           	}, 
           	function(){
             	if ( this.key == "ok" ) {
             		gfn_callAjax("/setting/axMainFrameDetailSave.do", gfn_getSaveData(grid2), fn_callbackAjax, "saveDetail");
               	} else {
               		mask.close();
               	}
           	}
       	);
   	}
}

function fn_saveApply() {
   	mask.open();
   	confirmDialog.confirm(
   		{
           	title: "Confirm",
           	msg: '현재 설정값을 메인화면에 반영하시겠습니까?'
       	}, 
       	function(){
         	if ( this.key == "ok" ) {
         		gfn_callAjax("/setting/axMainFrameApply.do", {}, fn_callbackAjax, "saveApply");
           	} else {
           		mask.close();
           	}
       	}
   	);
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
		</select>
  	</div>
</div>
<div style="height:10px"></div>

<div>
    <button class="btn btn-default" data-grid-control="search">검색</button>
    <button class="btn btn-default" data-grid-control="addMaster">Master 추가</button>
    <button class="btn btn-default" data-grid-control="deleteMaster">Master 삭제</button>
    <button class="btn btn-default" data-grid-control="saveMaster">Master 저장</button>
    <button class="btn btn-primary" data-grid-control="addDetail">Detail 추가</button>
    <button class="btn btn-primary" data-grid-control="deleteDetail">Detail 삭제</button>
    <button class="btn btn-primary" data-grid-control="saveDetail">Detail 저장</button>
    <button class="btn btn-info" data-grid-control="view">설정 스타일 보기</button>
    <button class="btn btn-danger" data-grid-control="saveApply">운영 적용</button>
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

