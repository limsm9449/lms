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

    gfn_callAjax("/common/axDd.do", { DD_KIND : "Job,Sex,ZipcodeUrl" }, fn_callbackAjax, "dd", { async : false });
    
    $('[data-grid-control]').click(function () {
        switch (this.getAttribute("data-grid-control")) {
	        case "search":
	            fn_search();
	            break;
            case "add":
            	grid.addRow(
            		{
            			NEW_FLAG : "Y", 
            			USER_ID : "******", 
            			USER_NAME : "사용자명을 입력하세요.", 
		            	COMP_CD : "${compCd}"
            		}, "last", {focus: "END"});

		    	break;
            case "delete":
            	var row = grid.getList("selected");
            	if ( row.length == 0 ) {
            		mask.open();
            		dialog.alert( { msg : "사용자를 선택하셔야 합니다." }, function () { mask.close();	} );
            		return;
            	}
            	if ( parseInt(row[0]["COURSE_CNT"]) > 0 ) {
            		mask.open();
            		dialog.alert( { msg : "등록된 강의가 있어서 삭제할 수 없습니다." }, function () { mask.close();	} );
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
                grid.exportExcel("직원관리.xls");
                break;
            case "passwordReset" :
            	var row = grid.getList("selected");
            	if ( row.length == 0 ) {
            		mask.open();
            		dialog.alert( { msg : "사용자를 선택하셔야 합니다." }, function () { mask.close();	} );
            		return;
            	} else {
            		confirmDialog.confirm(
            	       		{  	title: "Confirm", msg: '패스워드를 초기화 하시겠습니까?' }, 
            	           	function(){
            	             	if ( this.key == "ok" ) {
            	             		var saveParam = {
            	             			USER_ID : row[0].USER_ID,
            	             			EMAIL : row[0].EMAIL
            	             		}
            	             		gfn_callAjax("/account/axPasswordReset.do", saveParam, fn_callbackAjax, "passwordReset");
            	               	} else {
            	               		mask.close();
            	               	}
            	           	}
            	       	);
            	}
                break;
            case "zipcodeUrl":
           		window.open(dd.ZipcodeUrl[0].text, "zipcode","width=900,height=650");
                break;
            case "import":
            	var urlParams = "page=/ax/common/axExcelUpload";
        		urlParams += "&SCREEN=CompanyUser";
        		
        		f_popup('/common/axOpenPage', {displayName:'excelUploadPopup',option:'width=600,height=500', urlParams:urlParams});
                break;
        }
    });
});

function fn_makeGrid() {
	grid = gfn_makeAx5Grid("first-grid",
		[ 	{
	            key : "USER_ID",
	            label : "사용자 ID",
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
	            key : "USER_NAME",
	            label : "사용자명",
	            width : 90,
	            align : "left",
	            editor : { 
	            	type : "text"
				},
				styleClass: function () {
                    return "grid-cell-edit";
                }
	        },{
	            key : "EMAIL",
	            label : "E-mail",
	            width : 150,
	            align : "left",
	            editor : { 
	            	type : "text"
				},
				styleClass: function () {
                    return "grid-cell-edit";
                }
	        },{
	            key : "SEX",
	            label : "성별",
	            width : 80,
	            align : "center", 
	        	editor: {
                    type : "select", 
                    config : {
                        columnKeys: { optionValue: "value", optionText: "text" },
                        options: dd.Sex
                    }
	        	},
	            formatter : function () {
	                return gfn_getValueInList(dd.Sex, "value",  this.item.SEX, "text");
	           	},
				styleClass: function () {
                    return "grid-cell-edit";
                }
	        },{
	            key : "BIRTH_DAY",
	            label : "생일",
	            width : 80,
	            align : "center",
	            editor : { 
	            	type : "date"
				},
				styleClass: function () {
                    return "grid-cell-edit";
                }
	        },{
	            key : "HOME_ZIPCODE",
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
	            key : "HOME_ADDR",
	            label : "집주소",
	            width : 200,
	            align : "left",
	            editor : { 
	            	type : "text"
				},
				styleClass: function () {
                    return "grid-cell-edit";
                }
	        },{
	            key : "HOME_TEL",
	            label : "집 전화번호",
	            width : 100,
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
	            key : "PWD",
	            label : "패스워드",
	            width : 90,
	            align : "left",
	            editor : { 
	            	type : "text",
	            	disabled : function () {
                        return ( this.item.NEW_FLAG != "Y" ? true : false );
                    },
                    attributes : {
                        "maxlength" : 10,
                        "data-maxlength" : 10
                    }
				},
				styleClass: function () {
                    return (this.item.NEW_FLAG === "Y") ? "grid-cell-edit" : "";
                }
	        },{
	            key : "COURSE_CNT",
	            label : "등록 강의 갯수",
	            width : 120,
	            align : "center"
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
	  		showRowSelector : false,
	  		frozenColumnIndex : 3 
	  	}
	);
	
	$(window).trigger("resize");
}

function fn_params() {
	params.CB_SEARCHKIND = $("#CB_SEARCHKIND option:selected").val();	
	params.SEARCH_STR = $("#SEARCH_STR").val();	
}

function fn_search() {
	//mask.open();
	
	fn_params();
	
	gfn_callAjax("/account/axAccountList.do", params, fn_callbackAjax, "search");
}

function fn_save() {
	var fieldParams = {
		USER_ID : { mendatory : true, colName : "사용자 ID" },
		USER_NAME : { mendatory : true, colName : "사용자명" },
		EMAIL : { mendatory : true, colName : "E-mail" }
		/*,
		HOME_ZIPCODE : { mendatory : true, colName : "디렉토리" },
		HOME_ADDR : { mendatory : true, colName : "디렉토리" },
		MOBILE : { mendatory : true, colName : "디렉토리" },
		JOB : { mendatory : true, colName : "디렉토리" },
		SEX : { mendatory : true, colName : "디렉토리" },
		BIRTH_DAY : { mendatory : true, colName : "디렉토리" }*/
   	};
    
   	if ( gfn_validationCheck(grid, fieldParams) ) {
   		var dupIdx = gfn_gridDupCheck(grid, "USER_ID");
   		if ( dupIdx > -1 ) {
			mask.open();
			dialog.alert( { msg : (dupIdx + 1) + "라인의 사용자 ID는 이미 등록된 사용자ID 입니다." }, function () { mask.close(); } );
			return; 
   		}
   		
       	mask.open();
       	confirmDialog.confirm(
       		{
               	title: "Confirm",
               	msg: '저장하시겠습니까?'
           	}, 
           	function(){
             	if ( this.key == "ok" ) {
             		gfn_callAjax("/account/axAccountSave.do", gfn_getSaveData(grid), fn_callbackAjax, "save");
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
	} else if ( id == "save" ){
		mask.close();

		if ( data.RtnMode == "DUPLICATION" ) {
			mask.open();
			dialog.alert( { msg : "이미 등록된 사용자ID가 있습니다. (" + data.DupUserids + ")" }, function () { mask.close(); } );
		} else {
			mask.open();
			dialog.alert( { msg : "저장 되었습니다." }, function () { mask.close();	fn_search(); } );
		}
	} else if ( id == "passwordReset" ){
		mask.close();

		mask.open();
		dialog.alert( { msg : "패스워드가 초기화 되었습니다." }, function () { mask.close();	fn_search(); } );
	} else if ( id == "dd" ){
		dd = $.extend({}, data);

		fn_makeGrid();
		fn_search();
	} else if ( id == "excelUploadList" ){
      	var allList = grid.getList();
      	var maxSeq = 0;
      	for ( var i = 0; i < allList.length; i++ ) {
			if ( parseInt(allList[i].SEQ) > maxSeq ) {
				maxSeq = parseInt(allList[i].SEQ);
			}
      	}

      	for ( var i = 0; i < data.list.length; i++ ) {
       		grid.addRow( 
       			{
       				NEW_FLAG : "Y", 
       				USER_ID : data.list[i].USER_ID, 
       				USER_NAME : data.list[i].USER_NAME, 
       				EMAIL : data.list[i].EMAIL, 
       				SEX : data.list[i].SEX, 
       				BIRTH_DAY : data.list[i].BIRTH_DAY, 
       				HOME_ZIPCODE : data.list[i].HOME_ZIPCODE, 
       				HOME_ADDR : data.list[i].HOME_ADDR, 
       				HOME_TEL : data.list[i].HOME_TEL, 
       				MOBILE : data.list[i].MOBILE, 
       				PWD : data.list[i].PWD, 
	            	COMP_CD : "${compCd}"
       			}, "last", {focus: "END"});
		}
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

<h2>직원 관리</h2>
<div style="height:10px"></div>

<div class="form-inline">
  	<div class="form-group">
    	<label for="CB_SEARCHKIND">검색 유형</label>
		<select class="form-control" id="CB_SEARCHKIND" name="CB_SEARCHKIND">
	       	<option value="USER_ID" >사용자 ID</option>
	       	<option value="USER_NAME" >사용자명</option>
	       	<option value="EMAIL" >이메일</option>
	       	<option value="MOBILE" >핸드폰</option>
	       	<option value="COMPANY" >회사</option>
		</select>
		<input type="text" class="form-control search_input" id="SEARCH_STR" name="SEARCH_STR" value="" />
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
    <button class="btn btn-default" data-grid-control="passwordReset">패스워드 초기화</button>
    <button class="btn btn-default" data-grid-control="zipcodeUrl">주소검색</button>
    <button class="btn btn-default" data-grid-control="import">엑셀 업로드</button>
</div> 

<div style="height:10px"></div>


<div style="height:500px;" id="grid-parent">
    <div data-ax5grid="first-grid" style="height: 100%;"></div>
</div>

</form>

<div class="mask"></div>

</body>
</html>

