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
        	if ( this.activePanelIndex == 0 ) {
        		$("#learingContent").cleditor()[0].refresh();
        	} else if ( this.activePanelIndex == 1 ) {
        		$("#learingGoal").cleditor()[0].refresh();
        	} else if ( this.activePanelIndex == 2 ) {
        		$("#learingTarget").cleditor()[0].refresh();
        	} else if ( this.activePanelIndex == 3 ) {
        		$("#evalMethod").cleditor()[0].refresh();
        	} else if ( this.activePanelIndex == 4 ) {
        		$("#learingCost").cleditor()[0].refresh();
        	} else if ( this.activePanelIndex == 5 ) {
        		$("#offlineDesc").cleditor()[0].refresh();
        	} 
        }
    });

	$("#learingGoal").cleditor({height:405});
	$("#learingContent").cleditor({height:405});
	$("#evalMethod").cleditor({height:405});
	$("#learingTarget").cleditor({height:405});
	$("#learingCost").cleditor({height:405});
	$("#offlineDesc").cleditor({height:405});

	if ( gfn_getUrlParams("IS_VIEW") == "Y" ) {
		$("button[data-grid-control='save'").hide();
		$("#learingGoal").cleditor()[0].disable(true).refresh();
		$("#learingContent").cleditor()[0].disable(true).refresh();
		$("#evalMethod").cleditor()[0].disable(true).refresh();
		$("#learingTarget").cleditor()[0].disable(true).refresh();
		$("#learingCost").cleditor()[0].disable(true).refresh();
		$("#offlineDesc").cleditor()[0].disable(true).refresh();
	}

    $('[data-grid-control]').click(function () {
        switch (this.getAttribute("data-grid-control")) {
            case "save" :
            	fn_save();
                break;
            case "close" :
            	if ( isSave ) {
            		opener.fn_search();
            	}
            	
            	window.close();
                break;
        }
    });
    
    fn_search();
});

function fn_params() {
	params.COURSE_CODE = gfn_getUrlParams("COURSE_CODE");	
}

function fn_search() {
	//mask.open();
	
	fn_params();
	
	gfn_callAjax("/course/axCourseMasterContentsList.do", params, fn_callbackAjax, "search");
}

function fn_save() {
	if ( checkByte($('learingContent').val()) > course_contents_length ) {
		mask.open();
		dialog.alert( { msg : "입력 가능한 자릿수를 넘었습니다." }, function () { layout$.ax5layout("tabOpen", 0); mask.close();	} );
		return false;
	}
	if ( checkByte($('learingGoal').val()) > course_contents_length ) {
		mask.open();
		dialog.alert( { msg : "입력 가능한 자릿수를 넘었습니다." }, function () { layout$.ax5layout("tabOpen", 1); mask.close();	} );
		return false;
	}
	if ( checkByte($('learingTarget').val()) > course_contents_length ) {
		mask.open();
		dialog.alert( { msg : "입력 가능한 자릿수를 넘었습니다." }, function () { layout$.ax5layout("tabOpen", 2); mask.close();	} );
		return false;
	}
	if ( checkByte($('evalMethod').val()) > course_contents_length ) {
		mask.open();
		dialog.alert( { msg : "입력 가능한 자릿수를 넘었습니다." }, function () { layout$.ax5layout("tabOpen", 3); mask.close();	} );
		return false;
	}
	if ( checkByte($('learingCost').val()) > course_contents_length ) {
		mask.open();
		dialog.alert( { msg : "입력 가능한 자릿수를 넘었습니다." }, function () { layout$.ax5layout("tabOpen", 4); mask.close();	} );
		return false;
	}
	if ( checkByte($('offlineDesc').val()) > course_contents_length ) {
		mask.open();
		dialog.alert( { msg : "입력 가능한 자릿수를 넘었습니다." }, function () { layout$.ax5layout("tabOpen", 5); mask.close();	} );
		return false;
	}

   	mask.open();
   	confirmDialog.confirm(
   		{
           	title: "Confirm",
           	msg: '저장하시겠습니까?'
       	}, 
       	function(){
         	if ( this.key == "ok" ) {
         		var saveParams = {
         				LEARING_GOAL : $('#learingGoal').val(),
         				LEARING_CONTENT : $('#learingContent').val(),
         				EVAL_METHOD : $('#evalMethod').val(),
         				LEARING_TARGET : $('#learingTarget').val(),
         				LEARING_COST : $('#learingCost').val(),
         				OFFLINE_DESC : $('#offlineDesc').val(),
         				COURSE_CODE : params.COURSE_CODE
         		};
         		gfn_callAjax("/course/axCourseMasterContentsSave.do", saveParams, fn_callbackAjax, "save");
           	} else {
           		mask.close();
           	}
       	}
   	);
}

function fn_callbackAjax(data, id) {
	//console.log("fn_callbackAjax : " + id);
	if ( id == "search" ) {
		$('#learingGoal').text(data.list[0].LEARING_GOAL);
		$('#learingContent').text(data.list[0].LEARING_CONTENT);
		$('#evalMethod').text(data.list[0].EVAL_METHOD);
		$('#learingTarget').text(data.list[0].LEARING_TARGET);
		$('#learingCost').text(data.list[0].LEARING_COST);
		$('#offlineDesc').text(data.list[0].OFFLINE_DESC);
		
		$("#learingGoal").cleditor()[0].refresh();
		$("#learingContent").cleditor()[0].refresh();
		$("#evalMethod").cleditor()[0].refresh();
		$("#learingTarget").cleditor()[0].refresh();
		$("#learingCost").cleditor()[0].refresh();
		$("#offlineDesc").cleditor()[0].refresh();
		
		//mask.close();
	} else if ( id == "save" ){
		mask.close();

		if ( data.RtnMode && data.RtnMode != "OK" ) {
			mask.open();
			dialog.alert( { msg : "저장시 문제가 발생했습니다. (" + data.RtnMode + ")" }, function () { mask.close(); } );
		} else {
			mask.open();
			dialog.alert( { msg : "저장 되었습니다." }, function () { mask.close();	fn_search(); } );
		}
		
		isSave = true;
	}
}

</script>

<body style="padding : 10px">

<form id="frm" name="frm" method="post">

<h2>학습내용 관리</h2>
<div style="height:10px"></div>

<div>
    <button class="btn btn-default" data-grid-control="save">저장</button>
    <button class="btn btn-default" data-grid-control="close">닫기</button>
</div>

<div style="height:10px"></div>

<div data-ax5layout="ax1" data-config='{layout:"tab-panel"}' style="height:460px;">
    <div data-tab-panel='{label: "강의소개", "active": "true"}' style="background: #ccc;">
        <div style="padding: 10px;">
            <textarea id="learingContent" name="learingContent"></textarea>
        </div>
    </div>
    <div data-tab-panel='{label: "학습목표", "active": "false"}' style="background: #eee;">
        <div style="padding: 10px;">
            <textarea id="learingGoal" name="learingGoal"></textarea>
        </div>
    </div>
    <div data-tab-panel='{label: "교육대상", "active": "false"}' style="background: #ccc;">
        <div style="padding: 10px;">
            <textarea id="learingTarget" name="learingTarget"></textarea>
        </div>
    </div>
    <div data-tab-panel='{label: "평가방법", "active": "false"}' style="background: #ccc;">
        <div style="padding: 10px;">
            <textarea id="evalMethod" name="evalMethod"></textarea>
        </div>
    </div>
    <div data-tab-panel='{label: "학습비용", "active": "false"}' style="background: #ccc;">
        <div style="padding: 10px;">
            <textarea id="learingCost" name="learingCost"></textarea>
        </div>
    </div>
    <div data-tab-panel='{label: "오프라인", "active": "false"}' style="background: #ccc;">
        <div style="padding: 10px;">
            <textarea id="offlineDesc" name="learingCost"></textarea>
        </div>
    </div>
</div>

</form>
	

</body>
</html>

