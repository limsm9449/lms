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

<style>
  .file_btn_group { position:relative; left: 0px; width: 170px; height: 23px; overflow: hidden; margin-bottom: 5px; }
  .file_button { position: absolute; top:0px; }
  .hidden_inputfile { cursor:pointer; font-size: 45px; position: absolute; right: 0px; top: 0px; opacity: 0; filter: alpha(opacity=0); -ms-filter: "alpha(opacity=0)"; -khtml-opacity: 0; -moz-opacity: 0; }
</style>

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
    
    jQuery('[data-ax5layout="ax1"]').ax5layout({
        onResize: function () {
            //console.log(this.$target);

            //console.log(this);
        },
        onOpenTab: function () {
            //console.log(this);
        }
    });

    $('[data-grid-control]').click(function () {
        switch (this.getAttribute("data-grid-control")) {
            case "close" :
            	if ( isSave ) {
            		opener.fn_search();
            	}
            	
            	window.close();
                break;
        }
    });
    
    $("#USER_ID").val(gfn_getUrlParams("USER_ID"));

    fn_search();
    
    if ( gfn_getUrlParams("IS_VIEW") == "Y" ) {
    	$("div.file_btn_group").hide();
	}
});

function fn_params() {
	params.USER_ID = gfn_getUrlParams("USER_ID");	
}

function fn_search() {
	fn_params();
	
	gfn_callAjax("/account/axAccountImageList.do", params, fn_callbackAjax, "search");
}

function fn_callbackAjax(data, id) {
	//console.log("fn_callbackAjax : " + id);
	if ( id == "search" ) {
		if ( data.row.USER_IMG == "Y" ) {
			$('#userImg').attr("src", "/cImage/user/" + data.row.USER_ID + ".jpg" + "?timestamp=" + gfn_timestamp());
		}
		if ( data.row.TALK_IMAGE_YN == "Y" ) {
			$('#userTalkImg').attr("src", "/cImage/user/" + data.row.USER_ID + "_talk.jpg" + "?timestamp=" + gfn_timestamp());
		}
		//mask.close();
	} else if ( id == "save" ){
		mask.close();

		if ( data.RtnMode && data.RtnMode != "OK" ) {
			mask.open();
			dialog.alert( { msg : "업로드시 문제가 발생했습니다. (" + data.RtnMode + ")" }, function () { mask.close(); } );
		} else {
			mask.open();
			dialog.alert( { msg : "업로드 되었습니다. 등록된 이미지를 다른 이미지로 변경시 바로 바뀌지 않습니다. f5를 눌러 주시면 업로드 이미지를 볼 수 있습니다." }, function () { mask.close();	fn_search(); } );
		}
		
		isSave = true;
	}
}

function fn_upload(pParam) {
	if ( pParam.kind == "USER" && isExtention($("#userImgFile").val(),"jpg") == false ) {
		mask.open();
		dialog.alert( { msg : "JPG 파일을 선택해주세요." }, function () { mask.close();	} );
		return false;
	}
	if ( pParam.kind == "USER_TALK" && isExtention($("#userTalkImgFile").val(),"jpg") == false ) {
		mask.open();
		dialog.alert( { msg : "JPG 파일을 선택해주세요." }, function () { mask.close();	} );
		return false;
	}
	
	$("#kind").val(pParam.kind);

	document.frm.action = context + "/account/axAccountImageUpload.do";
	document.frm.target = "tranFrameS";
	document.frm.method = "POST";	
	document.frm.submit();
}

function isExtention(fileName, compExt) {
	var ext = fileName.substring(fileName.lastIndexOf(".") + 1,  fileName.length);
	if ( ext.toLowerCase() == compExt.toLowerCase() )
		return true;
	else 
		return false;
	
}

</script>

<body style="padding : 10px">

<form id="frm" name="frm" action="" method="post" enctype="multipart/form-data">
<input id="kind" name="kind" type="hidden" value=""/>
<input id="USER_ID" name="USER_ID" type="hidden" value=""/>

<h2>이미지 관리</h2>
<div style="height:10px"></div>

<div>
    <button class="btn btn-default" data-grid-control="close">닫기</button>
</div>

<div style="height:10px"></div>

<div data-ax5layout="ax1" data-config='{layout:"tab-panel"}' style="height:515px;">
    <div data-tab-panel='{label: "사용자 이미지", "active": "true"}' style="background: #eee;">
        <div style="padding: 10px;">
            <div class="img_box"><img id="userImg" src="/cImage/blank.jpg" style="width:150px;height:150px;"/></div>
            <div class="file_btn_group">
		      <a class="grayBtn file_button">userId.jpg(150 * 150) 파일</a> 
		      <input type="file" name="userImgFile" id="userImgFile" class="hidden_inputfile" title="" onChange="fn_upload({kind:'USER'}); return false;">
		    </div>
        </div>
    </div>
    <div data-tab-panel='{label: "Talk 이미지", "active": "false"}' style="background: #eee;">
        <div style="padding: 10px;">
            <div class="img_box"><img id="userTalkImg" src="/cImage/blank.jpg" style="width:75px;height:75px;"/></div>
            <div class="file_btn_group">
		      <a class="grayBtn file_button">userId_talk.jpg(75 * 75) 파일</a> 
		      <input type="file" name="userTalkImgFile" id="userTalkImgFile" class="hidden_inputfile" title="" onChange="fn_upload({kind:'USER_TALK'}); return false;">
		    </div>
        </div>
    </div>
</div>

</form>
	
<iframe id="tranFrameS" name="tranFrameS" style="display:none;"></iframe>

</body>
</html>

