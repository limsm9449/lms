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
    
    $("#courseCode").val(gfn_getUrlParams("COURSE_CODE"));

    fn_search();
    
    if ( gfn_getUrlParams("IS_VIEW") == "Y" ) {
    	$("div.file_btn_group").hide();
	}
});

function fn_params() {
	params.COURSE_CODE = gfn_getUrlParams("COURSE_CODE");	
}

function fn_search() {
	//mask.open();
	
	fn_params();
	
	gfn_callAjax("/mainPage/axMainPageImageList.do", params, fn_callbackAjax, "search");
}

function fn_callbackAjax(data, id) {
	if ( id == "search" ) {
		if ( data.list[0].POPULAR_IMG1 == "Y" ) {
			$('#popular1').attr("src", "/cImage/contents/" + params.COURSE_CODE + "/popular1.jpg");
		}
		if ( data.list[0].POPULAR_IMG2 == "Y" ) {
			$('#popular2').attr("src", "/cImage/contents/" + params.COURSE_CODE + "/popular2.jpg");
		}
		if ( data.list[0].NEW_IMG1 == "Y" ) {
			$('#new1').attr("src", "/cImage/contents/" + params.COURSE_CODE + "/new1.jpg");
		}
		if ( data.list[0].NEW_IMG2 == "Y" ) {
			$('#new2').attr("src", "/cImage/contents/" + params.COURSE_CODE + "/new2.jpg");
		}
		if ( data.list[0].RECOMMEND_IMG1 == "Y" ) {
			$('#recommend1').attr("src", "/cImage/contents/" + params.COURSE_CODE + "/recommend1.jpg");
		}
		if ( data.list[0].RECOMMEND_IMG2 == "Y" ) {
			$('#recommend2').attr("src", "/cImage/contents/" + params.COURSE_CODE + "/recommend2.jpg");
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
	if ( pParam.kind == "popular1" && isExtention($("#popular1File").val(),"jpg") == false ) {
		mask.open();
		dialog.alert( { msg : "JPG 파일을 선택해주세요." }, function () { mask.close();	} );
		return false;
	} else if ( pParam.kind == "popular2" && isExtention($("#popular2File").val(),"jpg") == false ) {
		mask.open();
		dialog.alert( { msg : "JPG 파일을 선택해주세요." }, function () { mask.close();	} );
		return false;
	} else if ( pParam.kind == "new1" && isExtention($("#new1File").val(),"jpg") == false ) {
		mask.open();
		dialog.alert( { msg : "JPG 파일을 선택해주세요." }, function () { mask.close();	} );
		return false;
	} else if ( pParam.kind == "new2" && isExtention($("#new2File").val(),"jpg") == false ) {
		mask.open();
		dialog.alert( { msg : "JPG 파일을 선택해주세요." }, function () { mask.close();	} );
		return false;
	} else if ( pParam.kind == "recommend1" && isExtention($("#recommend1File").val(),"jpg") == false ) {
		mask.open();
		dialog.alert( { msg : "JPG 파일을 선택해주세요." }, function () { mask.close();	} );
		return false;
	} else if ( pParam.kind == "recommend2" && isExtention($("#recommend2File").val(),"jpg") == false ) {
		mask.open();
		dialog.alert( { msg : "JPG 파일을 선택해주세요." }, function () { mask.close();	} );
		return false;
	}
	
	$("#kind").val(pParam.kind);

	document.frm.action = context + "/mainPage/axMainPageImageUpload.do";
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
<input id="courseCode" name="courseCode" type="hidden" value=""/>

<h2>이미지 관리</h2>
<div style="height:10px"></div>

<div>
    <button class="btn btn-default" data-grid-control="close">닫기</button>
</div>

<div style="height:10px"></div>

<div data-ax5layout="ax1" data-config='{layout:"tab-panel"}' style="height:515px;">
    <div data-tab-panel='{label: "인기과정 ", "active": "true"}' style="background: #ccc;">
        <div style="padding: 10px;">
            <div class="img_box">
           		<img id="popular1" src="/cImage/blank.jpg" style="width:249px;height:156px;"/>
           		<img id="popular2" src="/cImage/blank.jpg" style="width:249px;height:156px;"/>
            </div>
            <div class="file_btn_group">
		      <a class="grayBtn file_button">popular1.jpg(1125*353) 파일</a> 
		      <input type="file" name="popular1File" id="popular1File" class="hidden_inputfile" title="" onChange="fn_upload({kind:'popular1'}); return false;">
		    </div>
            <div class="file_btn_group">
		      <a class="grayBtn file_button">popular2.jpg(360*496) 파일</a> 
		      <input type="file" name="popular2File" id="popular2File" class="hidden_inputfile" title="" onChange="fn_upload({kind:'popular2'}); return false;">
		    </div>
        </div>
    </div>
    <div data-tab-panel='{label: "추천과정 ", "active": "true"}' style="background: #ccc;">
        <div style="padding: 10px;">
            <div class="img_box">
           		<img id="recommend1" src="/cImage/blank.jpg" style="width:249px;height:156px;"/>
           		<img id="recommend2" src="/cImage/blank.jpg" style="width:249px;height:156px;"/>
            </div>
            <div class="file_btn_group">
		      <a class="grayBtn file_button">recommend1.jpg(336*450) 파일</a> 
		      <input type="file" name="recommend1File" id="recommend1File" class="hidden_inputfile" title="" onChange="fn_upload({kind:'recommend1'}); return false;">
		    </div>
            <div class="file_btn_group">
		      <a class="grayBtn file_button">recommend2.jpg(336*450) 파일</a> 
		      <input type="file" name="recommend2File" id="recommend2File" class="hidden_inputfile" title="" onChange="fn_upload({kind:'recommend2'}); return false;">
		    </div>
        </div>
    </div>
    <div data-tab-panel='{label: "신규과정 ", "active": "true"}' style="background: #ccc;">
        <div style="padding: 10px;">
            <div class="img_box">
           		<img id="new1" src="/cImage/blank.jpg" style="width:249px;height:156px;"/>
           		<img id="new2" src="/cImage/blank.jpg" style="width:249px;height:156px;"/>
            </div>
            <div class="file_btn_group">
		      <a class="grayBtn file_button">new1.jpg(1125*240) 파일</a> 
		      <input type="file" name="new1File" id="new1File" class="hidden_inputfile" title="" onChange="fn_upload({kind:'new1'}); return false;">
		    </div>
            <div class="file_btn_group">
		      <a class="grayBtn file_button">new2.jpg(360*252) 파일</a> 
		      <input type="file" name="new2File" id="new2File" class="hidden_inputfile" title="" onChange="fn_upload({kind:'new2'}); return false;">
		    </div>
        </div>
    </div>
</div>

</form>
	
<iframe id="tranFrameS" name="tranFrameS" style="display:none;"></iframe>

</body>
</html>

