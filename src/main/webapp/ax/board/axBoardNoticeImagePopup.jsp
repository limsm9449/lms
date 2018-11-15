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
    
    $("#seq").val(gfn_getUrlParams("SEQ"));
    
    fn_search();
});

function fn_params() {
	params.SEQ = gfn_getUrlParams("SEQ");	
}

function fn_search() {
	fn_params();
	
	gfn_callAjax("/board/axBoardNoticeImageList.do", params, fn_callbackAjax, "search");
}

function fn_callbackAjax(data, id) {
	if ( id == "search" ) {
		if ( data.list[0].IMG1 == "Y" ) {
			$('#img1').attr("src", "/cImage/notice/" + params.SEQ + "_img1.jpg" + "?timestamp=" + gfn_timestamp());
		}
		if ( data.list[0].IMG2 == "Y" ) {
			$('#img2').attr("src", "/cImage/notice/" + params.SEQ + "_img2.jpg" + "?timestamp=" + gfn_timestamp());
		}
	} else if ( id == "save" ){
		mask.close();

		if ( data.RtnMode && data.RtnMode != "OK" ) {
			mask.open();
			dialog.alert( { msg : "업로드시 문제가 발생했습니다. (" + data.RtnMode + ")" }, function () { mask.close(); } );
		} else {
			mask.open();
			dialog.alert( { msg : "업로드 되었습니다." }, function () { mask.close();	fn_search(); } );
		}
		
		isSave = true;
	}
}

function fn_upload(pParam) {
	if ( pParam.kind == "img1" && isExtention($("#img1File").val(),"jpg") == false ) {
		mask.open();
		dialog.alert( { msg : "JPG 파일을 선택해주세요." }, function () { mask.close();	} );
		return false;
	} else if ( pParam.kind == "img2" && isExtention($("#img2File").val(),"jpg") == false ) {
		mask.open();
		dialog.alert( { msg : "JPG 파일을 선택해주세요." }, function () { mask.close();	} );
		return false;
	}
	
	$("#kind").val(pParam.kind);

	document.frm.action = context + "/board/axBoardNoticeImageUpload.do";
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
<input id="seq" name="seq" type="hidden" value=""/>

<h2>이미지 관리</h2>
<div style="height:10px"></div>

<div>
    <button class="btn btn-default" data-grid-control="close">닫기</button>
</div>

<div style="height:10px"></div>

<div data-ax5layout="ax1" data-config='{layout:"tab-panel"}' style="height:515px;">
    <div data-tab-panel='{label: "공지 이미지", "active": "true"}' style="background: #ccc;">
        <div style="padding: 10px;">
            <div class="img_box">
           		<img id="img1" src="/cImage/blank.jpg" style="width:249px;height:156px;"/>
           		<img id="img2" src="/cImage/blank.jpg" style="width:249px;height:156px;"/>
            </div>
            <div class="file_btn_group">
		      <a class="grayBtn file_button">img1.jpg(1125*353) 파일</a> 
		      <input type="file" name="img1File" id="img1File" class="hidden_inputfile" title="" onChange="fn_upload({kind:'img1'}); return false;">
		    </div>
            <div class="file_btn_group">
		      <a class="grayBtn file_button">img2.jpg(360*496) 파일</a> 
		      <input type="file" name="img2File" id="img2File" class="hidden_inputfile" title="" onChange="fn_upload({kind:'img2'}); return false;">
		    </div>
        </div>
    </div>
</div>

</form>
	
<iframe id="tranFrameS" name="tranFrameS" style="display:none;"></iframe>

</body>
</html>

