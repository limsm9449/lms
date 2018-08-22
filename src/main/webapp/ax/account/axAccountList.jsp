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

    gfn_callAjax("/common/axDd.do", { DD_KIND : "Company,Job,Sex,ZipcodeUrl" }, fn_callbackAjax, "dd", { async : false });
    
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
		            	ADMIN_YN : "N",
		            	SITE_MANAGER_YN : "N",
		            	CONTENTS_MANAGER_YN : "N",
		            	TUTOR_YN : "N",
		            	TEACHER_YN : "N"
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
                grid.exportExcel("사용자관리.xls");
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
            case "reSendCertification" :
            	var row = grid.getList("selected");
            	if ( row.length == 0 ) {
            		mask.open();
            		dialog.alert( { msg : "사용자를 선택하셔야 합니다." }, function () { mask.close();	} );
            		return;
            	} else {
            		if ( row[0].CERTIFICATION_YN == "Y" ) {
            			mask.open();
                		dialog.alert( { msg : "인증 처리된 사용자입니다." }, function () { mask.close();	} );
            			return;
            		}
            		confirmDialog.confirm(
            	       		{  	title: "Confirm", msg: '인증메일 재발송을 하시겠습니까?' }, 
            	           	function(){
            	             	if ( this.key == "ok" ) {
            	             		var saveParam = {
            	             			USER_ID : row[0].USER_ID,
            	             			USER_NAME : row[0].USER_NAME,
            	             			EMAIL : row[0].EMAIL	
            	             		}
            	             		gfn_callAjax("/account/axReSendCertification.do", saveParam, fn_callbackAjax, "reSendCertification");
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
            case "editImage":
            	var row = grid.getList("selected");
            	if ( row.length == 0 ) {
            		mask.open();
            		dialog.alert( { msg : "사용자를 선택하셔야 합니다." }, function () { mask.close();	} );
            	} else if ( row[0]["NEW_FLAG"] == "Y" ) {
            		mask.open();
            		dialog.alert( { msg : "신규로 추가한 경우는 저장후에 이미지를 편집하셔야 합니다." }, function () { mask.close();	} );
            	} else {
            		var urlParams = "page=/ax/account/axAccountImagePopup";
            		urlParams += "&USER_ID=" + row[0]["USER_ID"];
            		
            		f_popup('/common/axOpenPage', {displayName:'accountImagePopup',option:'width=900,height=650', urlParams:urlParams});
            	}
            		
                break;
        }
    });
});

function fn_makeGrid() {
	grid = gfn_makeAx5Grid("first-grid",
		[ 	{
	            key : "NEW_FLAG",
	            width : 0
	        },{
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
	        	key : "COMP_CD", 
	        	label : "회사", 
	            width : 140,
	        	align : "left", 
	        	editor: {
                    type : "select", 
                    config : {
                        columnKeys: { optionValue: "value", optionText: "text" },
                        options: dd.Company
                    } 
	        	},
	            formatter : function () {
	                return gfn_getValueInList(dd.Company, "value",  this.item.COMP_CD, "text", true);
	           	},
				styleClass: function () {
                    return "grid-cell-edit";
                }
	        },{
	            key : "JOB",
	            label : "직급",
	            width : 60,
	            align : "center", 
	        	editor: {
                    type : "select", 
                    config : {
                        columnKeys: { optionValue: "value", optionText: "text" },
                        options: dd.Job
                    } 
	        	},
	            formatter : function () {
	                return gfn_getValueInList(dd.Job, "value",  this.item.JOB, "text");
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
	        	key : "CERTIFICATION_YN", 
	        	label : "인증 여부", 
	            width : 90,
	        	align : "center"
			},{
	        	key : "USER_IMG", 
	        	label : "사용자 이미지", 
	            width : 110,
	        	align : "center"
	        },{
	            key : "BANK",
	            label : "환불은행",
	            width : 80,
	            align : "left",
	            editor : { 
	            	type : "text"
				},
				styleClass: function () {
                    return "grid-cell-edit";
                }
	        },{
	            key : "ACC_NUM",
	            label : "환불계좌번호",
	            width : 120,
	            align : "left",
	            editor : { 
	            	type : "text"
				},
				styleClass: function () {
                    return "grid-cell-edit";
                }
			},{
			  	key : undefined, 
			  	label: "관리자", 
			  	columns: [	        
			        {
			        	key : "ADMIN_YN", 
			        	label : "어드민", 
			            width : 70,
			        	align : "center", 
			        	editor : { type : "checkbox", config : {height: 17, trueValue: "Y", falseValue: "N"} },
						styleClass: function () {
		                    return "grid-cell-edit";
		                }
			        },{
			        	key : "SITE_MANAGER_YN", 
			        	label : "사이트 관리자", 
			            width : 120,
			        	align : "center", 
			        	editor : { type : "checkbox", config : {height: 17, trueValue: "Y", falseValue: "N"} },
						styleClass: function () {
		                    return "grid-cell-edit";
		                }
			        },{
			        	key : "CONTENTS_MANAGER_YN", 
			        	label : "컨텐츠 관리자", 
			            width : 120,
			        	align : "center", 
			        	editor : { type : "checkbox", config : {height: 17, trueValue: "Y", falseValue: "N"} },
						styleClass: function () {
		                    return "grid-cell-edit";
		                }
			        },{
			        	key : "TEACHER_YN", 
			        	label : "강사", 
			            width : 60,
			        	align : "center", 
			        	editor : { type : "checkbox", config : {height: 17, trueValue: "Y", falseValue: "N"} },
						styleClass: function () {
		                    return "grid-cell-edit";
		                }
			        },{
			        	key : "TUTOR_YN", 
			        	label : "튜터", 
			            width : 60,
			        	align : "center", 
			        	editor : { type : "checkbox", config : {height: 17, trueValue: "Y", falseValue: "N"} },
						styleClass: function () {
		                    return "grid-cell-edit";
		                }
			        }
				]
			},{
	        	key : "RETIRED_YN", 
	        	label : "탈퇴 여부", 
	            width : 90,
	        	align : "center", 
	        	editor : { type : "checkbox", config : {height: 17, trueValue: "Y", falseValue: "N"} },
				styleClass: function () {
                    return "grid-cell-edit";
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
	params.CB_USERKIND = $("#CB_USERKIND option:selected").val();	
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
   		var allList = grid.getList();
       	for ( var i = 0; i < allList.length; i++ ) {
       		if ( allList[i].SITE_MANAGER_YN == "Y" && allList[i].COMP_CD == "") {
    			mask.open();
    			dialog.alert( { msg : (allList[i].__index + 1) + "라인의 " + "사이트 관리자일 경우 회사를 선택하셔야 합니다." }, function () { mask.close(); } );
    			return false;
       		}
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

		mask.open();
		dialog.alert( { msg : "저장 되었습니다." }, function () { mask.close();	fn_search(); } );
	} else if ( id == "passwordReset" ){
		mask.close();

		mask.open();
		dialog.alert( { msg : "패스워드가 초기화 되었습니다." }, function () { mask.close();	fn_search(); } );
	} else if ( id == "reSendCertification" ){
		mask.close();

		mask.open();
		dialog.alert( { msg : "인증메일을 재발송 하였습니다." }, function () { mask.close();	fn_search(); } );
	} else if ( id == "dd" ){
		dd = $.extend({}, data);

		dd.Company = [{value : "", text : ""}].concat(dd.Company);
		
		fn_makeGrid();
		fn_search();
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

<h2>사용자 관리</h2>
<div style="height:10px"></div>

<div>
	검색 유형
	<select id="CB_SEARCHKIND" name="CB_SEARCHKIND">
       	<option value="USER_ID" >사용자 ID</option>
       	<option value="USER_NAME" >사용자명</option>
       	<option value="EMAIL" >이메일</option>
       	<option value="MOBILE" >핸드폰</option>
       	<option value="COMPANY" >회사</option>
	</select>
	<input type="text" class="search_input" id="SEARCH_STR" name="SEARCH_STR" value="" />
	
	사용자 유형
	<select id="CB_USERKIND" name="CB_USERKIND">
		<option value="" selected>전체</option>
		<option value="ADMIN">Admin</option>
		<option value="SITE_MANAGER">사이트 관리자</option>
		<option value="CONTENTS_MANAGER">컨텐츠 관리자</option>
		<option value="TEACHER">강사</option>
		<option value="TUTOR">튜터</option>
		<option value="USER">사용자</option>
		<option value="B2C">일반사용자</option>
		<option value="COMPANY">회사사용자</option>
	</select>
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
    <button class="btn btn-default" data-grid-control="reSendCertification">인증메일 재발송</button>
    <button class="btn btn-default" data-grid-control="editImage">이미지 관리</button>
    <button class="btn btn-default" data-grid-control="zipcodeUrl">주소검색</button>
</div> 

<div style="height:10px"></div>


<div style="height:500px;" id="grid-parent">
    <div data-ax5grid="first-grid" style="height: 100%;"></div>
</div>

</form>

<div class="mask"></div>

</body>
</html>

