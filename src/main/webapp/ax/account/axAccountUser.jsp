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
    
    fn_search();
    
    $('[data-grid-control]').click(function () {
        switch (this.getAttribute("data-grid-control")) {
	        case "search":
	            fn_search();
	            break;
            case "save" :
            	fn_save();
                break;
            case "passwordChange" :
		    	gfn_showPopupDiv("commPopupDiv");
                break;
            case "zipcodeUrl":
           		window.open(dd.ZipcodeUrl[0].text, "zipcode","width=900,height=650");
                break;
            case "editImage":
           		var urlParams = "page=/ax/account/axAccountImagePopup";
           		urlParams += "&USER_ID=" + userData.USER_ID;
           		
           		f_popup('/common/axOpenPage', {displayName:'accountImagePopup',option:'width=900,height=650', urlParams:urlParams});
            		
                break; 
            case "career":
           		var urlParams = "page=/ax/account/axAccountUserCareerPopup";
           		urlParams += "&USER_ID=" + userData.USER_ID;
           		
           		f_popup('/common/axOpenPage', {displayName:'accountUserCareerPopup',option:'width=600,height=450', urlParams:urlParams});
            		
                break; 
            case "commPopupDivOk":
            	fn_hidePopupDiv('commPopupDiv')
                break;
            case "commPopupDivClose":
            	gfn_hidePopupDiv('commPopupDiv');
                break;
        } 
    });
});

function fn_params() {
}

function fn_search() {
	fn_params();
	
	gfn_callAjax("/account/axAccountUserOne.do", params, fn_callbackAjax, "search");
}

function fn_save() {
    
   	mask.open();
   	confirmDialog.confirm(
   		{
           	title: "Confirm",
           	msg: '저장하시겠습니까?'
       	}, 
       	function(){
         	if ( this.key == "ok" ) {
         		gfn_callAjax("/account/axAccountUserSave.do", gfn_getFormToJson("frm"), fn_callbackAjax, "save");
           	} else {
           		mask.close();
           	}
       	}
   	);
}

var userData;
function fn_callbackAjax(data, id) {
	if ( data.RtnMode == "ERROR" ) {
		mask.open();
		dialog.alert( { msg : "처리시 오류가 발생했습니다. 관리자에게 문의하세요." }, function () { mask.close();	fn_search(); } );
		return;
	}
	
	if ( id == "search" ) {
		$("#USER_NAME").val(data.row.USER_NAME);
		$("#SEX").val(data.row.SEX);
		$("#BIRTH_DAY").val(data.row.BIRTH_DAY);
		$("#EMAIL").val(data.row.EMAIL);
		$("#MOBILE").val(data.row.MOBILE);
		$("#HOME_TEL").val(data.row.HOME_TEL);
		$("#HOME_ZIPCODE").val(data.row.HOME_ZIPCODE);
		$("#HOME_ADDR").val(data.row.HOME_ADDR);
		$("#BANK").val(data.row.BANK);
		$("#ACC_NUM").val(data.row.ACC_NUM);

	    $('#BIRTH_DAY').datepicker({format:"yyyy-mm-dd"}).datepicker("setDate", data.row.BIRTH_DAY );
	    
	    if ( data.row.TEACHER_YN != "Y") {
	    	$('#career').hide()
	    }
	    
	    userData = data.row;
	} else if ( id == "dd" ){
		dd = $.extend({}, data);
	} else if ( id == "save" ){
		mask.close();

		mask.open();
		dialog.alert( { msg : "저장 되었습니다." }, function () { mask.close();	fn_search(); } );
	} else if ( id == "passwordChange" ){
		mask.close();

		mask.open();
		dialog.alert( { msg : "패스워드가 변경 되었습니다." }, function () { mask.close();	fn_search(); } );
	}
}

function fn_hidePopupDiv(popupDivId, mode) {
	if ( popupDivId == "commPopupDiv" ) {
		if ( $("#pwd1").val() == "" || $("#pwd1").val() != $("#pwd2").val() ) {
			gfn_hidePopupDiv(popupDivId);
			
			mask.open();
			dialog.alert( { msg : "변경할 패스워드를 확인하세요." }, function () { mask.close(); gfn_showPopupDiv(popupDivId); } );
			return;
		} 
	
		confirmDialog.confirm(
	       	{  	title: "Confirm", msg: '패스워드를 변경 하시겠습니까?' }, 
	           	function(){
	             	if ( this.key == "ok" ) {
	             		var saveParam = {
	             			USER_ID : userData.USER_ID,
	             			USER_PASSWORD : $("#pwd1").val()
	             		}
	             		gfn_callAjax("/account/axPasswordChange.do", saveParam, fn_callbackAjax, "passwordChange");
	               	} else {
	               		mask.close();
	               	}
	           	}
	       	);
	}

	gfn_hidePopupDiv(popupDivId);
}

</script>

<body style="padding : 10px">

<h2>사용자 정보</h2>
<div style="height:10px"></div>
 
<form id="frm" name="frm" class="form-horizontal">
  	<div class="form-group">
    	<label for="USER_NAME" class="col-sm-2 control-label">이름</label>
    	<div class="col-sm-10">
      		<input type="text" class="form-control" id="USER_NAME" name="USER_NAME" placeholder="">
    	</div>
  	</div>
  	<div class="form-group">
    	<label for="SEX" class="col-sm-2 control-label">성별</label>
    	<div class="col-sm-10">
    		<select id="SEX" name="SEX" class="form-control" style="width:100px">
				<option value="M">남성</option>
				<option value="F">여성</option>
			</select>
    	</div>
  	</div>
  	<div class="form-group">
    	<label for="BIRTH_DAY" class="col-sm-2 control-label">생년월일</label>
    	<div class="col-sm-10">
			<input type="text" class="form-control" id="BIRTH_DAY" name="BIRTH_DAY" style="width:100px">
    	</div>
  	</div>
  	<div class="form-group">
    	<label for="EMAIL" class="col-sm-2 control-label">이메일</label>
    	<div class="col-sm-10">
      		<input type="text" class="form-control" id="EMAIL" name="EMAIL" placeholder="">
    	</div>
  	</div>
  	<div class="form-group">
    	<label for="MOBILE" class="col-sm-2 control-label">핸드폰번호</label>
    	<div class="col-sm-10">
      		<input type="text" class="form-control" id="MOBILE" name="MOBILE" placeholder="">
    	</div>
  	</div>
  	<div class="form-group">
    	<label for="HOME_TEL" class="col-sm-2 control-label">전화번호</label>
    	<div class="col-sm-10">
      		<input type="text" class="form-control" id="HOME_TEL" name="HOME_TEL" placeholder="">
    	</div>
  	</div>
  	<div class="form-group">
    	<label for="HOME_ZIPCODE" class="col-sm-2 control-label">우편번호</label>
    	<div class="col-sm-10">
      		<input type="text" class="form-control" id="HOME_ZIPCODE" name="HOME_ZIPCODE" placeholder="">
    	</div>
  	</div>
  	<div class="form-group">
    	<label for="HOME_ADDR" class="col-sm-2 control-label">집주소</label>
    	<div class="col-sm-10">
      		<input type="text" class="form-control" id="HOME_ADDR" name="HOME_ADDR" placeholder="">
    	</div>
  	</div>
  	<div class="form-group">
    	<label for="BANK" class="col-sm-2 control-label">환불은행</label>
    	<div class="col-sm-10">
      		<input type="text" class="form-control" id="BANK" name="BANK" placeholder="">
    	</div>
  	</div>
  	<div class="form-group">
    	<label for="ACC_NUM" class="col-sm-2 control-label">환불계좌번호</label>
    	<div class="col-sm-10">
      		<input type="text" class="form-control" id="ACC_NUM" name="ACC_NUM" placeholder="">
    	</div>
  	</div>

  	<div class="form-group">
    	<div class="col-sm-offset-6 col-sm-6">
		    <button class="btn btn-default" data-grid-control="save">저장</button>
		    <button class="btn btn-default" data-grid-control="passwordChange">패스워드 변경</button>
		    <button class="btn btn-default" data-grid-control="editImage">이미지 관리</button>
		    <button class="btn btn-default" data-grid-control="zipcodeUrl">주소검색</button>
		    <button class="btn btn-default" data-grid-control="career" id="career">경력</button>
    	</div>
  	</div>
</form>

<div class="mask"></div>
<div class="popupDiv form-horizontal" id="commPopupDiv" style="width:400px;height:200px;padding:10px">
	<div style="height:30px"></div>
	<div class="form-group">
    	<label for="pwd1" class="col-sm-3 control-label">패스워드 1</label>
    	<div class="col-sm-9">
      		<input type="text" class="form-control" id="pwd1" name="pwd1" placeholder="">
    	</div>
  	</div>
  	<div class="form-group">
    	<label for="pwd2" class="col-sm-3 control-label">패스워드 2</label>
    	<div class="col-sm-9">
      		<input type="text" class="form-control" id="pwd2" name="pwd2" placeholder=""> 
    	</div>
  	</div>
  	<div class="form-group">
    	<div class="col-sm-offset-7 col-sm-5">
	  		<button class="btn btn-default" data-grid-control="commPopupDivOk">확인</button>
	  		<button class="btn btn-default" data-grid-control="commPopupDivClose">닫기</button>
	  	</div>
  	</div>
</div>

</body>
</html>

