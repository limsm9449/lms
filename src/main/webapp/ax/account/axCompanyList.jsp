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

    gfn_callAjax("/common/axDd.do", { DD_KIND : "ZipcodeUrl" }, fn_callbackAjax, "dd", { async : false });
    
    $('[data-grid-control]').click(function () {
        switch (this.getAttribute("data-grid-control")) {
	        case "search":
	            fn_search();
	            break;
            case "add":
            	grid.addRow({NEW_FLAG : "Y", COMP_CD : "******", COMP_NAME : "회사명을 입력하세요.", C2C_YN : "N", USE_YN : "Y"}, "last", {focus: "END"});

		    	break;
            case "delete":
            	var row = grid.getList("selected");
            	if ( row.length == 0 ) {
            		mask.open();
            		dialog.alert( { msg : "회사를 선택하셔야 합니다." }, function () { mask.close();	} );
            		return;
            	}
            	if ( parseInt(row[0]["EMPLOYEE_CNT"]) > 0 ) {
            		mask.open();
            		dialog.alert( { msg : "등록된 직원이 있습니다." }, function () { mask.close();	} );
            		return;
            	}
            	
               	grid.deleteRow("selected");
            	
                break;
            case "reset":
            	fn_search();
                break;
            case "save" :
            	fn_save();
                break;
            case "export":
                grid.exportExcel("회사관리.xls");
                break;
            case "editImage":
            	var row = grid.getList("selected");
            	if ( row.length == 0 ) {
            		mask.open();
            		dialog.alert( { msg : "회사를 선택하셔야 합니다." }, function () { mask.close();	} );
            	} else if ( row[0]["NEW_FLAG"] == "Y" ) {
            		mask.open();
            		dialog.alert( { msg : "신규로 추가한 경우는 저장후에 이미지를 편집하셔야 합니다." }, function () { mask.close();	} );
            	} else {
            		var urlParams = "page=/ax/account/axCompanyImagePopup";
            		urlParams += "&COMP_CD=" + row[0]["COMP_CD"];
            		
            		f_popup('/common/axOpenPage', {displayName:'companyImagePopup',option:'width=900,height=650', urlParams:urlParams});
            	}
            		
                break;
            case "zipcodeUrl":
           		window.open(dd.ZipcodeUrl[0].text, "zipcode","width=900,height=650");
                break;
            case "employee":
            	var row = grid.getList("selected");
            	if ( row.length == 0 ) {
            		mask.open();
            		dialog.alert( { msg : "회사를 선택하셔야 합니다." }, function () { mask.close();	} );
            	} else {
	        		parent.document.getElementById("left").contentWindow.gfn_openMenu("axAccountList", { 
	        				COMP_CD : row[0].COMP_CD,
	        				CB_USERKIND : "B2C"
		    			}
		    		);
            	}
        		
                break;
            case "auth":
            	var row = grid.getList("selected");
            	if ( row.length == 0 ) {
            		mask.open();
            		dialog.alert( { msg : "회사를 선택하셔야 합니다." }, function () { mask.close();	} );
            	} else if ( row[0]["NEW_FLAG"] == "N" ) {
            		var urlParams = "page=/ax/account/axCompanyAuthPopupList";
            		urlParams += "&COMP_CD=" + row[0]["COMP_CD"];
            		
            		f_popup('/common/axOpenPage', {displayName:'companyAuthPopup',option:'width=850,height=820', urlParams:urlParams});
            	} else {
            		mask.open();
            		dialog.alert( { msg : "신규로 추가한 경우는 저장후에 인증키 등록을 하셔야 합니다." }, function () { mask.close();	} );
            	}
            		
                break;
                
        }
    });
});

function fn_makeGrid() {
	grid = gfn_makeAx5Grid("first-grid",
		[ 	{
	            key : "COMP_CD",
	            label : "회사코드",
	            width : 100,
	            align : "left",
	            editor : { 
	            	type : "text",
	            	disabled : function () {
                        return ( this.item.NEW_FLAG != "Y" ? true : false );
                    },
                    attributes : {
                        "maxlength" : 15,
                        "data-maxlength" : 15
                    }
				},
				styleClass: function () {
                    return (this.item.NEW_FLAG === "Y") ? "grid-cell-edit" : "";
                }
	        },{
	            key : "COMP_NAME",
	            label : "회사명",
	            width : 90,
	            align : "left",
	            editor : { 
	            	type : "text"
				},
				styleClass: function () {
                    return "grid-cell-edit";
                }
	        },{
	            key : "BUSINESS_NO",
	            label : "사업자등록번호",
	            width : 130,
	            align : "left",
	            editor : { 
	            	type : "text"
				},
				styleClass: function () {
                    return "grid-cell-edit";
                }
	        },{
	            key : "OWNER_NAME",
	            label : "대표자명",
	            width : 100,
	            align : "left",
	            editor : { 
	            	type : "text"
				},
				styleClass: function () {
                    return "grid-cell-edit";
                }
	        },{
	            key : "SUB_DOMAIN",
	            label : "도메인명",
	            width : 150,
	            align : "left",
	            editor : { 
	            	type : "text"
				},
				styleClass: function () {
                    return "grid-cell-edit";
                }
	        },{
	            key : "NAVER_CLIENT_ID",
	            label : "네이버 Client ID",
	            width : 160,
	            align : "center",
	            editor : { 
	            	type : "text"
	            	,disabled : function () {
                        return ( this.item.COMP_CD == "B2C" ? false : true );
                    }
				},
				styleClass: function () {
                    return ( this.item.COMP_CD == "B2C" ? "grid-cell-edit" : "" );
                }
	        },{
	            key : "NAVER_CLIENT_SECRET",
	            label : "네이버 Client Secret",
	            width : 140,
	            align : "center",
	            editor : { 
	            	type : "text"
	            	,disabled : function () {
                        return ( this.item.COMP_CD == "B2C" ? false : true );
                    }
				},
				styleClass: function () {
                    return ( this.item.COMP_CD == "B2C" ? "grid-cell-edit" : "" );
                }
	        },{
	            key : "AUTH_CNT",
	            label : "등록 인증키",
	            width : 100,
	            align : "right"
	        },{
	            key : "ZIPCODE",
	            label : "우편번호",
	            width : 80,
	            align : "left",
	            editor : { 
	            	type : "text"
				},
				styleClass: function () {
                    return "grid-cell-edit";
                }
	        },{
	            key : "ADDR",
	            label : "주소",
	            width : 200,
	            align : "left",
	            editor : { 
	            	type : "text"
				},
				styleClass: function () {
                    return "grid-cell-edit";
                }
	        },{
	            key : "MOBILE",
	            label : "핸드폰",
	            width : 100,
	            align : "left",
	            editor : { 
	            	type : "text"
				},
				styleClass: function () {
                    return "grid-cell-edit";
                }
	        },{
	            key : "COMP_TEL",
	            label : "사무실번호",
	            width : 100,
	            align : "left",
	            editor : { 
	            	type : "text"
				},
				styleClass: function () {
                    return "grid-cell-edit";
                }
	        },{
	            key : "FAX",
	            label : "팩스번호",
	            width : 100,
	            align : "left",
	            editor : { 
	            	type : "text"
				},
				styleClass: function () {
                    return "grid-cell-edit";
                }
	        },{
	        	key : "USE_YN", 
	        	label : "사용 여부", 
	            width : 80,
	        	align : "center", 
	        	editor : { type : "checkbox", config : {height: 17, trueValue: "Y", falseValue: "N"} },
				styleClass: function () {
                    return "grid-cell-edit";
                }
			},{
	        	key : "LOGIN_IMG", 
	        	label : "로그인화면 이미지", 
	            width : 140,
	        	align : "center"
			},{
	        	key : "GNB_IMG", 
	        	label : "타이틀 로고 이미지", 
	            width : 140,
	        	align : "center"
			},{
	        	key : "EMPLOYEE_CNT", 
	        	label : "직원수", 
	            width : 90,
	        	align : "right"
	        },{
	            key : "LAST_UPDATE_USER",
	            label : "수정자",
	            width : 80,
	            align : "center"
	        },{
	            key : "LAST_UPDATE_DATE",
	            label : "수정일자",
	            width : 110,
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
	params.SEARCH_STR = $("#SEARCH_STR").val();	
}

function fn_search() {
	//mask.open();
	
	fn_params();
	
	gfn_callAjax("/account/axCompanyList.do", params, fn_callbackAjax, "search");
}

function fn_save() {
	var fieldParams = {
		COMP_CD : { mendatory : true, colName : "회사코드" },
		COMP_NAME : { mendatory : true, colName : "회사명" },
		BUSINESS_NO : { mendatory : true, colName : "사업자등록번호" },
		OWNER_NAME : { mendatory : true, colName : "대표자명" },
		SUB_DOMAIN : { mendatory : true, colName : "도메인명" }
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
             		gfn_callAjax("/account/axCompanySave.do", gfn_getSaveData(grid), fn_callbackAjax, "save");
               	} else {
               		mask.close();
               	}
           	}
       	);
   	}
}

function fn_callbackAjax(data, id) {
	if ( data.RtnMode == "ERROR" ) {
		mask.open();
		dialog.alert( { msg : "처리시 오류가 발생했습니다. 관리자에게 문의하세요." }, function () { mask.close();	fn_search(); } );
		return;
	}
	
	if ( id == "search" ) {
		grid.setData(data.list);
		
		//mask.close();
	} else if ( id == "save" ){
		mask.close();

		mask.open();
		dialog.alert( { msg : "저장 되었습니다." }, function () { mask.close();	fn_search(); } );
	} else if ( id == "dd" ){
		dd = $.extend({}, data);

		fn_makeGrid();
		//fn_search();
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

<h2>회사 관리</h2>
<div style="height:10px"></div>

<div class="form-inline">
  	<div class="form-group">
    	<label for="CB_SEARCHKIND">검색어</label>
		<input class="form-control" type="text" class="search_input" id="SEARCH_STR" name="SEARCH_STR" value="" />
  	</div>
</div>
<div style="height:10px"></div>

<div>
    <button class="btn btn-default" data-grid-control="search">검색</button>
    <button class="btn btn-default" data-grid-control="add">추가</button>
    <button class="btn btn-default" data-grid-control="delete">삭제</button>
    <button class="btn btn-default" data-grid-control="reset">초기화</button>
    <button class="btn btn-default" data-grid-control="save">저장</button>
    <button class="btn btn-default" data-grid-control="export">엑셀</button>
    <button class="btn btn-default" data-grid-control="editImage">이미지 관리</button>
    <button class="btn btn-default" data-grid-control="zipcodeUrl">주소검색</button>
    <button class="btn btn-default" data-grid-control="employee">직원검색</button>
    <button class="btn btn-default" data-grid-control="auth">인증키 등록</button>
</div> 

<div style="height:10px"></div>


<div style="height:500px;" id="grid-parent">
    <div data-ax5grid="first-grid" style="height: 100%;"></div>
</div>

</form>

<div class="mask"></div>

</body>
</html>

