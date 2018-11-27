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
	
	gfn_callAjax("/course/axCourseMasterImageList.do", params, fn_callbackAjax, "search");
}


function fn_callbackAjax(data, id) {
	//console.log("fn_callbackAjax : " + id);
	if ( id == "search" ) {
		if ( data.list[0].SWF == "Y" ) {
			$('#swfImg').attr("src", "/cImage/swf.jpg");
		}
		if ( data.list[0].B_IMG == "Y" ) {
			$('#bImg').attr("src", "/cImage/contents/" + params.COURSE_CODE + "/bImg.jpg" + "?timestamp=" + gfn_timestamp());
		}
		if ( data.list[0].C_IMG == "Y" ) {
			$('#cImg').attr("src", "/cImage/contents/" + params.COURSE_CODE + "/cImg.jpg" + "?timestamp=" + gfn_timestamp());
		}
		if ( data.list[0].M_IMG1 == "Y" ) {
			$('#mImg1').attr("src", "/cImage/contents/" + params.COURSE_CODE + "/mImg1.jpg" + "?timestamp=" + gfn_timestamp());
		}
		if ( data.list[0].M_IMG2 == "Y" ) {
			$('#mImg2').attr("src", "/cImage/contents/" + params.COURSE_CODE + "/mImg2.jpg" + "?timestamp=" + gfn_timestamp());
		}
		if ( data.list[0].M_IMG3 == "Y" ) {
			$('#mImg3').attr("src", "/cImage/contents/" + params.COURSE_CODE + "/mImg3.jpg" + "?timestamp=" + gfn_timestamp());
		}
		if ( data.list[0].S_IMG1 == "Y" ) {
			$('#sImg1').attr("src", "/cImage/contents/" + params.COURSE_CODE + "/sImg1.jpg" + "?timestamp=" + gfn_timestamp());
		}
		if ( data.list[0].S_IMG2 == "Y" ) {
			$('#sImg2').attr("src", "/cImage/contents/" + params.COURSE_CODE + "/sImg2.jpg" + "?timestamp=" + gfn_timestamp());
		}
		if ( data.list[0].S_IMG3 == "Y" ) {
			$('#sImg3').attr("src", "/cImage/contents/" + params.COURSE_CODE + "/sImg3.jpg" + "?timestamp=" + gfn_timestamp());
		}
		//mask.close();
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
	if ( pParam.kind == "SWF" && isExtention($("#swfFile").val(),"swf") == false ) {
		mask.open();
		dialog.alert( { msg : "플래시 파일을 선택해주세요." }, function () { mask.close();	} );
		return false;
	} else if ( pParam.kind == "B_IMG" && isExtention($("#bImgFile").val(),"jpg") == false ) {
		mask.open();
		dialog.alert( { msg : "JPG 파일을 선택해주세요." }, function () { mask.close();	} );
		return false;
	} else if ( pParam.kind == "C_IMG" && isExtention($("#cImgFile").val(),"jpg") == false ) {
		mask.open();
		dialog.alert( { msg : "JPG 파일을 선택해주세요." }, function () { mask.close();	} );
		return false;
	} else if ( pParam.kind == "M_IMG1" && isExtention($("#mImg1File").val(),"jpg") == false ) {
		mask.open();
		dialog.alert( { msg : "JPG 파일을 선택해주세요." }, function () { mask.close();	} );
		return false;
	} else if ( pParam.kind == "M_IMG2" && isExtention($("#mImg2File").val(),"jpg") == false ) {
		mask.open();
		dialog.alert( { msg : "JPG 파일을 선택해주세요." }, function () { mask.close();	} );
		return false;
	} else if ( pParam.kind == "M_IMG3" && isExtention($("#mImg3File").val(),"jpg") == false ) {
		mask.open();
		dialog.alert( { msg : "JPG 파일을 선택해주세요." }, function () { mask.close();	} );
		return false;
	} else if ( pParam.kind == "S_IMG1" && isExtention($("#sImg1File").val(),"jpg") == false ) {
		mask.open();
		dialog.alert( { msg : "JPG 파일을 선택해주세요." }, function () { mask.close();	} );
		return false;
	} else if ( pParam.kind == "S_IMG2" && isExtention($("#sImg2File").val(),"jpg") == false ) {
		mask.open();
		dialog.alert( { msg : "JPG 파일을 선택해주세요." }, function () { mask.close();	} );
		return false;
	} else if ( pParam.kind == "S_IMG3" && isExtention($("#sImg3File").val(),"jpg") == false ) {
		mask.open();
		dialog.alert( { msg : "JPG 파일을 선택해주세요." }, function () { mask.close();	} );
		return false;
	}
	
	$("#kind").val(pParam.kind);

	document.frm.action = context + "/course/axCourseMasterImageUpload.do";
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
    <div data-tab-panel='{label: "메인 플레시", "active": "true"}' style="background: #eee;">
        <div style="padding: 10px;">
            <div class="img_box"><img id="swfImg" src="/cImage/blank.jpg" style="width:650px;height:425px;"/></div>
            <div class="file_btn_group">
		      <a class="grayBtn file_button">swf.swf(1300*850) 파일</a> 
		      <input type="file" name="swfFile" id="swfFile" class="hidden_inputfile" title="" onChange="fn_upload({kind:'SWF'}); return false;">
		    </div>
        </div>
    </div>
    <div data-tab-panel='{label: "메인 배경 이미지", "active": "false"}' style="background: #ccc;">
        <div style="padding: 10px;">
            <div class="img_box"><img id="bImg" src="/cImage/blank.jpg" style="width:650px;height:425px;"/></div>
            <div class="file_btn_group">
		      <a class="grayBtn file_button">bImg.jpg(1300*850) 파일</a> 
		      <input type="file" name="bImgFile" id="bImgFile" class="hidden_inputfile" title="" onChange="fn_upload({kind:'B_IMG'}); return false;">
		    </div>
        </div>
    </div>
    <div data-tab-panel='{label: "과정 상세 이미지", "active": "false"}' style="background: #ccc;">
        <div style="padding: 10px;">
            <div class="img_box"><img id="cImg" src="/cImage/blank.jpg" style="width:356px;height:237px;"/></div>
            <div class="file_btn_group">
		      <a class="grayBtn file_button">cImg.jpg(356*237) 파일</a> 
		      <input type="file" name="cImgFile" id="cImgFile" class="hidden_inputfile" title="" onChange="fn_upload({kind:'C_IMG'}); return false;">
		    </div>
        </div>
    </div>
    <div data-tab-panel='{label: "과정 미리보기 이미지", "active": "false"}' style="background: #ccc;">
        <div style="padding: 10px;">
            <div class="img_box">
           		<img id="mImg1" src="/cImage/blank.jpg" style="width:249px;height:156px;"/>
           		<img id="mImg2" src="/cImage/blank.jpg" style="width:249px;height:156px;"/>
           		<img id="mImg3" src="/cImage/blank.jpg" style="width:249px;height:156px;"/>
            </div>
            <div class="file_btn_group">
		      <a class="grayBtn file_button">mImg1.jpg(374*235) 파일</a> 
		      <input type="file" name="mImg1File" id="mImg1File" class="hidden_inputfile" title="" onChange="fn_upload({kind:'M_IMG1'}); return false;">
		    </div>
            <div class="file_btn_group">
		      <a class="grayBtn file_button">mImg2.jpg(374*235) 파일</a> 
		      <input type="file" name="mImg2File" id="mImg2File" class="hidden_inputfile" title="" onChange="fn_upload({kind:'M_IMG2'}); return false;">
		    </div>
            <div class="file_btn_group">
		      <a class="grayBtn file_button">mImg3.jpg(374*235) 파일</a> 
		      <input type="file" name="mImg3File" id="mImg3File" class="hidden_inputfile" title="" onChange="fn_upload({kind:'M_IMG3'}); return false;">
		    </div>
        </div>
    </div>
    <div data-tab-panel='{label: "과정 썸네일 이미지", "active": "false"}' style="background: #ccc;">
        <div style="padding: 10px;">
            <div class="img_box">
           		<img id="sImg1" src="/cImage/blank.jpg" style="width:249px;height:156px;"/>
           		<img id="sImg2" src="/cImage/blank.jpg" style="width:249px;height:156px;"/>
           		<img id="sImg3" src="/cImage/blank.jpg" style="width:249px;height:156px;"/>
            </div>
            <div class="file_btn_group">
		      <a class="grayBtn file_button">sImg1.jpg(120*75) 파일</a> 
		      <input type="file" name="sImg1File" id="sImg1File" class="hidden_inputfile" title="" onChange="fn_upload({kind:'S_IMG1'}); return false;">
		    </div>
            <div class="file_btn_group">
		      <a class="grayBtn file_button">sImg2.jpg(120*75) 파일</a> 
		      <input type="file" name="sImg2File" id="sImg2File" class="hidden_inputfile" title="" onChange="fn_upload({kind:'S_IMG2'}); return false;">
		    </div>
            <div class="file_btn_group">
		      <a class="grayBtn file_button">sImg3.jpg(120*75) 파일</a> 
		      <input type="file" name="sImg3File" id="sImg3File" class="hidden_inputfile" title="" onChange="fn_upload({kind:'S_IMG3'}); return false;">
		    </div>
        </div>
    </div>
</div>

</form>
	
<iframe id="tranFrameS" name="tranFrameS" style="display:none;"></iframe>

</body>
</html>

