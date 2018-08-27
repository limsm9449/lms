/* 게시판 내용의 사이즈 */
var board_contents_length = 50000;
/* 과정 목표,내용등 */
var course_contents_length = 10000;
/* 타이틀 사이즈 */
var board_title_length = 200;

$(document).ready(function() {
	//자동 submit 방지
	var forms = document.forms;
	for ( i = 0; i < forms.length; i++ ) {
		forms[i].onsubmit = function() {return false;} 
	}
	
	$.datepicker.regional['ko'] = {
			closeText : '닫기',
			prevText : '이전달',
			nextText : '다음달',
			currentText : '오늘',
			monthNames : ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'],
			monthNamesShort : ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'],
			dayNames : ['일요일','월요일','화요일','수요일','목요일','금요일','토요일'],
			dayNamesShort : ['일','월','화','수','목','금','토'],
			dayNamesMin : ['일','월','화','수','목','금','토'],
			weekHeader : 'Wk',
			dateFormat : 'yy-mm-dd',
			firstDay : 0,
			isRTL : false,
			showMonthAfterYear : true,
			yearSuffix : '년',
			changeMonth : true,
		    changeYear : true,
		    yearRange : "c-50:c+10"
		};
	$.datepicker.setDefaults($.datepicker.regional['ko']);
});

/** 
 * Enter시 자동 검색
 */
function lfn_enter() {
	if ( event.keyCode == 13 ) {
		lfn_btn('search');
	}
}
 
/** 
 * 화면 리사이즈
 */
function gfn_resize() {
	/*
  	var bHeight = 95;

  	var cHeight = 0;
  	
  	if ( $('#left').contents().find("[id='side']").length > 0 ) {
  		lHeight = $('#left').contents().find("[id='side']")[0].scrollHeight;
  	} else {
  		lHeight = 600;
  	}
  	if ( $('#content').contents().find("[id='contents']").length > 0 ) {
  		cHeight = $('#content').contents().find("[id='contents']")[0].scrollHeight;
  	} else {
  		cHeight = 600;
  	}
  	
  	$('#content').height(cHeight);

  	var lc = (cHeight > lHeight ? cHeight : lHeight);

	console.log("left : " + lHeight + ", content : " + cHeight + ", lc : " + lc + ", window : " + $(window).height());

  	if ( lc + bHeight < $(window).height() ) {
  		$('.bottom').css('top', ($(window).height() - bHeight) +'px');
  	  	$('#left').height($(window).height() - bHeight);
  	} else  {
  		$('.bottom').css('top', (lc + 10) +'px');
  		$('#left').height(lc + 10);
	}
	*/
  	$('#left').height($(window).height());
  	$('#content').height($(window).height());
	
  	//$('html, body').scrollTop(0);
}

/**
 * 백스페이스 방지
 */
/*
$(document).bind("keydown",function(e){
	console.log(event.ctrlKey + " : " + event.keyCode);
    if( (event.ctrlKey == true && (event.keyCode == 78 || event.keyCode == 82)) || (event.keyCode == 116) || (e.keyCode == 8) ){
    	return false;
    }
});
*/

/**
 * 페이지 관련 함수 모음
 */
var page = {
	/**
	 * HomePage로 이동
	 */
	goHome : function() {
		top.location = "/";
	},
	
	goUserHome : function() {
		location = "/home/userHome.do";
	},

	goTutorHome : function() {
		top.location = "/home/tutorHome.do";
	},

	goTeacherHome : function() {
		top.location = "/home/teacherHome.do";
	},

	goCompManagerHome : function() {
		top.location = "/home/compManagerHome.do";
	},

	goAdminHome : function() {
		top.location = "/home/adminHome.do";
	},

	goPage : function(urlPage, urlParam) {
		window.location = urlPage + ".do" + (urlParam != undefined ? "?" + urlParam : "");
	},

	goJsp : function(jspPage) {
		window.location = "/goJsp.do?jspPage=" + jspPage;
	},

	goNsJsp : function(jspPage) {
		window.location = "/ns/goNsJsp.do?jspPage=" + jspPage;
	},
	
	refresh : function() {
		window.location = window.location;
	}

}

var gfn_ajax = {
	/**
	 * logout 
	 */
	logout : function () {
		$.ajax({
			type :"POST",
			url : context +"/logout.do",
			dataType :"json",
			success : function(json){
				if ( json.rtnMode == "OK") {
					page.goHome();
				}
			},
			error : function(e) {
				page.goHome();
			}
		})
	}
}

/**
 * 페이지 이동
 * @param pDoUrl
 * @param pParam
 * @returns
 */
function gfn_goPage(pDoUrl,pParam) {
	if ( pParam != undefined ) {
		/* 한글이 있을 경우를 대비해서 Form으로 전송을 한다. */
		$form = $("<form/>").attr({id:"goPageForm", name:"goPageForm", method:'POST', action:context + pDoUrl + ".do"});
		$(document.body).append($form);

		/* 정보 세팅 */
		var paramArr = decodeURIComponent(pParam).split("&");
		for ( i = 0; i < paramArr.length; i++ ) {
			var tempArr = paramArr[i].split("=");
			$("<input></input>").attr({type:"hidden", name:tempArr[0], value:$.trim(tempArr[1])}).appendTo($form);
		}
		
		document.goPageForm.submit();
	} else {
		this.location = context + pDoUrl + ".do";
	}
}

/**
 * 팝업 오픈
 * @param pDoUrl
 * @param pParam
 * @param pWIdth
 * @param pHeight
 */
function gfn_popup(pDoUrl,pParam,pWIdth, pHeight) {
	if ( pParam != undefined )
		Popup.showPopup(context + pDoUrl + ".do?" + pParam,pWIdth,pHeight);
	else
		Popup.showPopup(context + pDoUrl + ".do",pWIdth,pHeight);
}

/**
 * 중복방지 기능
 */
var evt = {}; 
function btnUnbind(pBtn) {
	evt[pBtn] = document.getElementById(pBtn).onclick;
	document.getElementById(pBtn).onclick = null; 
}
function btnBind(pBtn) {
	document.getElementById(pBtn).onclick = evt[pBtn];
}

/**
 * 체크박스 기능
 */
function gfn_allChk(pAllChk, pChk) {
    $("input[id='" + pChk + "']").each(function(i) {
    	if ( $(this).prop("disabled") == false ) {
	        if ( $("#" + pAllChk).is(":checked") )
	            $(this).prop("checked", "checked");
	        else
	            $(this).prop("checked", "");
    	}
    });
}
function gfn_chk(pAllChk, pChk) {
	var isAllCheck = true;
    $("input[id='" + pChk + "']").each(function(i) {
    	if ( $(this).prop("disabled") == false ) {
	    	if ( $(this).is(":checked") == false )
	    		isAllCheck = false;
    	}
    });
    
    if ( isAllCheck == false )
    	$("#" + pAllChk).prop("checked", "");
    else
    	$("#" + pAllChk).prop("checked", "checked");
}
//선택된 체크박스의 Values를 가져온다.
function gfn_cbCheckedValues(pId, pDelimiter) {
	var delimiter = ( pDelimiter == null || pDelimiter == "" ? "," : pDelimiter);
	var values = "";
    $("input[id='" + pId + "']").each(function(i) {
    	if ( $(this).prop("disabled") == false ) {
	    	if ( $(this).is(":checked") )
	    		values += $(this).val() + delimiter;
    	}
    });
    
    return values.substring(0,values.length - 1);
}

/**
 * Input에 있는 값들을 한 문자로 가져온다.
 */
function gfn_inputValues(pId, pDelimiter) {
	var delimiter = ( pDelimiter == null || pDelimiter == "" ? "," : pDelimiter);
	var values = "";
    $("input[id='" + pId + "']").each(function(i) {
   		values += $(this).val() + delimiter;
    });
    
    return values.substring(0,values.length - 1);
}

/*
 * .do호출을 위한 공통 합수
 * 선행처리가 필요할 경우 f_preSubmit에 정의를 해주면 된다.
 * 
 * pParam : 나중에 필요시 정의
 */
function f_submit(pDoUrl,pParam,pForm) {
	//submit 전에 처리할 기능이 있으면 호출해준다.
	if ( window.f_preSubmit ) {
		if ( f_preSubmit(pDoUrl,pParam) != true )
			return false;
	}

	//파라미터 처리
	var params = "";
	if ( pParam != undefined && pParam.urlParams != undefined )
		params = "?" + escape(encodeURIComponent(pParam.urlParams));

	//submit할 iframe을 구한다.
	var iframe = "";
	if ( pParam != undefined && pParam.iframe != undefined )
		if ( pParam.iframe == "self")
			iframe = "_self";
		else if ( pParam.iframe == "tran")
			iframe = "tranFrame";
		else 
			iframe = pParam.iframe;
	
	//공백제거
	$("input").each(function(index){
		$(this).val($.trim($(this).val()));
	});
	
	if ( pForm == undefined ) {
		document.frm.action = context + pDoUrl + ".do" + params;
		document.frm.target = iframe;
		document.frm.method = "POST";	
		document.frm.submit();
	} else {
		pForm.action = context + pDoUrl + ".do" + params;
		pForm.target = iframe;
		pForm.method = "POST";	
		pForm.submit();
	}
} 

function f_submitSelf(pDoUrl,pParam,pForm) {
	if ( pParam == undefined )
		pParam = {iframe:'self'};
	else
		pParam.iframe = "self";
	
	f_submit(pDoUrl,pParam,pForm);
}

function f_submitTran(pDoUrl,pParam,pForm) {
	if ( pParam == undefined )
		pParam = {iframe:'tran'};
	else
		pParam.iframe = "tran";
	
	f_submit(pDoUrl,pParam,pForm);
}



/*
 * 전체 콤보박스의 선택여부를 개별 콤보박스에 반영
 */
function f_commAllCheckbox(allChk,chk) {
	$("#" + allChk).click(function() {    
		if($(this).is(':checked')) {        
			$("input[name=" + chk +"]").prop("checked", true);    
		} else {        
			$("input[name=" + chk +"]").prop("checked", false);    
		}
	});
}

/*
 * 개별 콤보박스가 다 선택되면 전체 콤보박스가 선택이 되도록 함.
 */
function f_commCheckbox(allChk,chk) {
	var isAllCheck = true;
	
	$("input[name=" + chk +"]").each(function() {
		if ( $(this).is(':checked') ) {        
		} else {        
			isAllCheck = false;
		}
	});
	
	if ( isAllCheck == true )
		$("#" + allChk).prop("checked", true);
	else
		$("#" + allChk).prop("checked", false);
}

/*
 * 자기자신으로 처리를 위한 공통 함수
 * 선행처리가 필요할 경우 f_preMenuContent에 정의를 해주면 된다.
 * 
 * pParam : 나중에 필요시 정의
 */ 
function f_menuContent(pDoUrl,pParam) {
	//submit 전에 처리할 기능이 있으면 호출해준다.
	if ( window.f_preMenuContent ) {
		if ( f_preMenuContent(pDoUrl,pParam) != true ) 
			return false;
	}

	var params = "";
	if ( pParam != undefined && pParam.urlParams != undefined )
		params = "?" + pParam.urlParams + "&timestamp=" + (new Date()).getMilliseconds();

	document.frm.action = context + pDoUrl + ".do" + params;	
	document.frm.target = "content";
	document.frm.method = "POST";	
	document.frm.submit();
}



/*
 * 팝업을 위한 공통 함수
 * 
 * 선행처리가 필요할 경우 f_prePopup에 정의를 해주면 된다.
 * 
 * pParam : 나중에 필요시 정의
 */
function f_popup(pDoUrl,pParam) {
	//submit 전에 처리할 기능이 있으면 호출해준다.
	if ( window.f_prePopup ) {
		if ( f_prePopup(pDoUrl,pParam) != true ) 
			return;
	}

	var params = "";
	var displayName = "";
	var option = "";
	if ( pParam != undefined && pParam.urlParams != undefined )
		params = "?" + pParam.urlParams + "&timestamp=" + timestamp;
	if ( pParam != undefined && pParam.displayName != undefined )
		displayName = pParam.displayName;
	if ( pParam != undefined && pParam.option != undefined )
		option = pParam.option;

	option += ",resizable=0";
	
	//POST로 넘긴다.
	window.open("",displayName,option);
	document.frm.action = context + pDoUrl + ".do" + params;	
	document.frm.target = displayName;
	document.frm.method = "POST";	
	document.frm.submit();
}

formValid = {
		check : function(objId,param,idx) {
			if ( idx == undefined )
				idx = 0;
			
			str = $($("[name=" + objId + "]")[idx]).val();
			if ( param != undefined ) {
				if ( param.isNecess != undefined && param.isNecess == true ) {
					if ( str == "" ) {
						if ( param.msg != undefined )
							alert(param.msg);
						else
							alert("필수 입력입니다.");
						
						$($("[name=" + objId + "]")[idx]).focus();
						return false;
					}
				}
				if ( param.isNum != undefined && param.isNum == true ) {
					if ( isNum(str) == false ) {
						alert("숫자만 입력 가능합니다.");
						$($("[name=" + objId + "]")[idx]).select();
						return false;
					}
				}
				if ( param.isAccountNum != undefined && param.isAccountNum == true ) {
					if ( isAccountNum(str) == false ) {
						alert("숫자,-만 입력 가능합니다.");
						$($("[name=" + objId + "]")[idx]).select();
						return false;
					}
				}
				if ( param.minLeng != undefined ) {
					if ( checkByte(str) < param.minLeng ) {
						alert("최소 " + param.minLeng + " 자릿수 이상을 넣으셔야 합니다.");
						$($("[name=" + objId + "]")[idx]).select();
						return false;
					}
				}
				if ( param.maxLeng != undefined ) {
					if ( checkByte(str) > param.maxLeng ) {
						alert("입력 가능한 자릿수를 넘었습니다.(" + param.maxLeng + ")");
						$($("[name=" + objId + "]")[idx]).select();
						return false;
					}
				}
				if ( param.leng != undefined ) {
					if ( checkByte(str) != param.leng ) {
						alert(param.leng + "자리를 입력하셔야 합니다.");
						$($("[name=" + objId + "]")[idx]).select();
						return false;
					}
				}
				if ( param.isEmail != undefined && param.isEmail == true ) {
					if ( isEmail(str) == false ) {
						alert("잘못된 email 입니다.")
						$($("[name=" + objId + "]")[idx]).select();
						return false;
					}
				}
			}
		},
		
		isEmail : function(email) {
			alert("A");
		}
		
};

/***********************************************************************
 * 숫자 체크
 ***********************************************************************/
function isNum(input) {
	var chars = "0123456789";
	return isAllHaveContain(input,chars);
}

function isAccountNum(input) {
	var chars = "0123456789-";
	return isAllHaveContain(input,chars);
}

/***********************************************************************
 * 숫자/문자 존재여부 체크
 ***********************************************************************/
function isExistNum(input) {
	var chars = "0123456789";
	return isExistChar(input,chars);
}

function isExistAlpha(input) {
	var chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz";
	return isExistChar(input,chars);
}
function isExistNumAlpha(input) {
	var isExist1 = isExistNum(input);
	var isExist2 = isExistAlpha(input);
	
	if ( isExist1 == true && isExist2 == true )
		return true;
	else
		return false;
}

function isUserId(input) {
	var rtn = true;

	var chars = "0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz";
	
	for ( var i = 0 ; i < input.length ; i++ ) {
		if ( chars.indexOf(input.charAt(i)) < 0 ) {
			rtn = false;
			break;
		}
	}
	
	return rtn;

}

/***********************************************************************
 * 체크로직
 * input이 chars에 속한 문자열로만 이루어졌는지 체크
 ***********************************************************************/
function isAllHaveContain(input,chars) {
	var res=1;
	for(var i=0 ; i<input.length ; i++){
		if(chars.indexOf(input.charAt(i))==-1)res=-1;
	}
	if(res==-1)return false;
	return true;
}

function isExistChar(input,chars) {
	var isExist = false;
	
	for ( var i = 0 ; i < input.length ; i++ ) {
		if ( chars.indexOf(input.charAt(i)) > -1 ) {
			isExist = true;
			break;
		}
	}
	
	return isExist;
}

/**
 * 한글을 2바이트 씩 계산하여 입력받은 문자열이 DB에 저장될 때 총 몇바이트를 차지하는지 계산한다.
 * 엔터(\r\n)는 2바이트를 차지한다.
 * @param val : 입력받은 문자열
 */
function checkByte(val)
{
	// 입력받은 문자열을 escape() 를 이용하여 변환한다.
	// 변환한 문자열 중 유니코드(한글 등)는 공통적으로 %uxxxx로 변환된다.
	var temp_estr = escape(val);
	var s_index   = 0;
	var e_index   = 0;
	var temp_str  = "";
	var cnt       = 0;

	// 문자열 중에서 유니코드를 찾아 제거하면서 갯수를 센다.
	while ((e_index = temp_estr.indexOf("%u", s_index)) >= 0)  // 제거할 문자열이 존재한다면
	{
		temp_str += temp_estr.substring(s_index, e_index);
		s_index = e_index + 6;
		cnt ++;
	}

	temp_str += temp_estr.substring(s_index);

	temp_str = unescape(temp_str);  // 원래 문자열로 바꾼다.

	// 유니코드는 2바이트 씩 계산하고 나머지는 1바이트씩 계산한다.
	return ((cnt * 2) + temp_str.length) + "";
}

/***********************************************************************
 * email 체크
 ***********************************************************************/
function isEmail (email) {
	var regex=/^([\w-]+(?:\.[\w-]+)*)@((?:[\w-]+\.)*\w[\w-]{0,66})\.([a-z]{2,6}(?:\.[a-z]{2})?)$/;   
	  
	if(regex.test(email) === false) {  
	    return false;  
	} else {  
	    return true;  
	}  
}

/***********************************************************************
 * 주민등록번호체크
 ***********************************************************************/
function isResidentNO(str_f_num,str_l_num){  
	var i3=0
	for (var i=0;i<str_f_num.length;i++){
		var ch1 = str_f_num.substring(i,i+1);
		if (ch1<'0' || ch1>'9') i3=i3+1;
	}
	if ((str_f_num == '') || ( i3 != 0 )) return false;
	var i4=0;
	for (var i=0;i<str_l_num.length;i++){
		var ch1 = str_l_num.substring(i,i+1);
		if (ch1<'0' || ch1>'9') i4=i4+1; 
	}
	if ((str_l_num == '') || ( i4 != 0 )) return false;
	if(str_f_num.substring(0,1) < 4) return false;
	if(str_l_num.substring(0,1) > 2) return false;
	if((str_f_num.length > 7) || (str_l_num.length > 8)) return false;
	if ((str_f_num == '72') || ( str_l_num == '18'))return false;
      
	var f1=str_f_num.substring(0,1)
	var f2=str_f_num.substring(1,2)
	var f3=str_f_num.substring(2,3)
	var f4=str_f_num.substring(3,4)
	var f5=str_f_num.substring(4,5)
	var f6=str_f_num.substring(5,6)
	var hap=f1*2+f2*3+f3*4+f4*5+f5*6+f6*7
	var l1=str_l_num.substring(0,1)
	var l2=str_l_num.substring(1,2)
	var l3=str_l_num.substring(2,3)
	var l4=str_l_num.substring(3,4)
	var l5=str_l_num.substring(4,5)
	var l6=str_l_num.substring(5,6)
	var l7=str_l_num.substring(6,7)
	hap=hap+l1*8+l2*9+l3*2+l4*3+l5*4+l6*5
	hap=hap%11
	hap=11-hap
	hap=hap%10
	if (hap != l7) return false;
	return true; 
}

function checkThousand(num) {
	num = num + "";	//문자로 변환
	num=num.replace(/,/g,'');    //콤마 제거
	var commaValue = "";
	var i;
  
	for(i=1; i<=num.length; i++) {
       if(i>1 && (i%3)==1) 
           commaValue = num.charAt(num.length-i) + "," + commaValue;
       else 
           commaValue = num.charAt(num.length-i) + commaValue;    
	}
    return commaValue;
}








function gfn_validationCheck( gridObj, fieldParams ) {
	var modified = gridObj.getList("modified");
	var deleted = gridObj.getList("deleted");
	//console.log(modified);
	for ( var i = 0; i < modified.length; i++ ) {
		for (var field in fieldParams) {
			if ( field == "DUP_FIELDS" ) {
				continue;
			}
				
			var fieldInfo = fieldParams[field];
			var fieldValue = gfn_string(modified[i][field]);
			
			if ( fieldInfo.mendatory ) {
				if ( fieldInfo.except ) {
					if ( modified[i][fieldInfo.except.field] == fieldInfo.except.value ) {
						continue;
					}
				}
				
				if ( fieldValue == "" ) {
					mask.open();
					dialog.alert( { msg : (modified[i].__index + 1) + "라인의 " + fieldInfo.colName + "은(는) " + "필수입력 입니다." }, function () { mask.close(); });

					return false;
				}
			} 
			if ( fieldInfo.length && fieldValue.length != fieldInfo.length ) {
				mask.open();
				dialog.alert( { msg : (modified[i].__index + 1) + "라인의 " + fieldInfo.colName + "은(는) " + fieldInfo.length + "자리를 입력해야 합니다." }, function () { mask.close(); } );
				
				return false;
			}
			if ( fieldInfo.type == "number" ) {
				if ( !$.isNumeric(fieldValue) ) {
					mask.open();
					dialog.alert( { msg : (modified[i].__index + 1) + "라인의 " + fieldInfo.colName + "은(는) 정수를 입력해야 합니다." }, function () { mask.close(); } );
					
					return false;
				}
			}
		}
	}

	//중복체크
	if ( fieldParams.DUP_FIELDS != undefined ) {
		var dupfields = ( fieldParams.DUP_FIELDS || "" ).split(",");
		var allList = gridObj.getList();
		var isDup = false;
		var pk = {};
		for ( var i = 0; i < allList.length; i++ ) {
			var pkData = "";
			for ( var m = 0; m < dupfields.length; m++ ) {
				pkData += allList[i][dupfields[m]];
			}
			
			if ( pk[pkData] != undefined ) {
				mask.open();
				dialog.alert( { msg : (allList[i].__index + 1) + "라인의 데이타가 중복입니다." }, function () { mask.close(); } );
				
				return false;
			} else {
				pk[pkData] = pkData;
			}
		}
	}
	
	if ( modified.length == 0 && deleted.length == 0 ) {
		mask.open();
		dialog.alert( { msg : "수정된 데이타가 없습니다." }, function () { mask.close(); } );
		
		return false;
	}
	
	return true;
}

function gfn_string(val) {
	if ( val == undefined || val == null ) {
		return "";
	} else {
		return (val + "").trim();
	}
}

function gfn_getSaveData( gridObj, isAll ) {
	var saveData = {};
	
	if ( isAll ) {
		saveData.modified = gridObj.getList();
	} else {
		saveData.modified = gridObj.getList("modified");
		saveData.deleted = gridObj.getList("deleted");
	}
	
	return saveData;
}

function gfn_makeAx5Grid(gridId, columns, datas, options) {
	ax5.ui.grid.tmpl.page_status = function(){
        return '<span>{{dataRowCount}} 건</span>';
    };
    
    ax5.info.months = ["1월","2월","3월","4월","5월","6월","7월","8월","9월","10월","11월"];
    ax5.info.weekNames = [
             {label: "일"},
             {label: "월"},
             {label: "화"},
             {label: "수"},
             {label: "목"},
             {label: "금"},
             {label: "토"}
         ];
    
	tOptions = options || {};
	//gfn_log(tOptions);
	var gridObj = new ax5.ui.grid({
        target : $('[data-ax5grid="' + gridId + '"]'),
        frozenColumnIndex: gfn_defined(tOptions.frozenColumnIndex, 0),
        frozenRowIndex: gfn_defined(tOptions.frozenRowIndex, 0),
        showLineNumber : gfn_defined(tOptions.showLineNumber, true),
        showRowSelector : gfn_defined(tOptions.showRowSelector, true),
        multipleSelect : gfn_defined(tOptions.multipleSelect, false),
        lineNumberColumnWidth : gfn_defined(tOptions.lineNumberColumnWidth, 40),
        rowSelectorColumnWidth : gfn_defined(tOptions.rowSelectorColumnWidth, 28),
        virtualScrollY : gfn_defined(tOptions.virtualScrollY, true),
        virtualScrollX : gfn_defined(tOptions.virtualScrollX, false),
        sortable : gfn_defined(tOptions.sortable, true), 
        multiSort : gfn_defined(tOptions.multiSort, false),
        remoteSort : gfn_defined(tOptions.remoteSort, false), 
        header: {
            align : "center",
            columnHeight : 28
        },
        body: {
            align : "center",
            columnHeight : 28,
            onClick: function () {
            	if ( $.isFunction(fn_gridEvent) ) {
            		fn_gridEvent("Click", this);
    			}
            },
            onDBLClick: function () {
            	if ( $.isFunction(fn_gridEvent) ) {
            		fn_gridEvent("DBLClick", this);
    			}
            },
            onDataChanged: function () {
            	if ( $.isFunction(fn_gridEvent) ) {
            		fn_gridEvent("DataChanged", this);
    			}
            }
        },
        columns : columns
    });
	
	if ( datas ) {
		gridObj.setData(datas);
	}
	
	return gridObj;
}
	
function gfn_defined(def, initValue) {
	if ( def != undefined ) {
		return def;
	} else {
		return initValue;
	}
}

function gfn_callAjax(url, params, callback, id, options) {
	var tOptions = options || {};
	$.ajax({
		url : context + url,
		type : tOptions.type || "POST",
		async : tOptions.async || true,
		dataType :"json",
		contentType : "application/json; charset=UTF-8",
		data : JSON.stringify(params || {}),
		success : function(data){
			//gfn_log(data);
			if ( $.isFunction(callback) ) {
				callback(data, id);
			}
		},
		error : function(e) {
			alert(resource.msg.systemError);
		}
	})
}

function gfn_log(str) {
	console.log(arguments);
	console.log(str);
}

function gfn_showPopupDiv(popupDivId){
    // 화면의 높이와 너비를 변수로 만듭니다.
    var maskHeight = $(document).height();
    var maskWidth = $(window).width();

    // 마스크의 높이와 너비를 화면의 높이와 너비 변수로 설정합니다.
    $('.mask').css({'width':maskWidth,'height':maskHeight});

    // fade 애니메이션 : 1초 동안 검게 됐다가 80%의 불투명으로 변합니다.
    $('.mask').fadeTo("slow",0.2);

    // 레이어 팝업을 가운데로 띄우기 위해 화면의 높이와 너비의 가운데 값과 스크롤 값을 더하여 변수로 만듭니다.
    var left = ( $(window).scrollLeft() + ( $(window).width() - $('#' + popupDivId).width()) / 2 );
    var top = ( $(window).scrollTop() + ( $(window).height() - $('#' + popupDivId).height()) / 2 );

    // css 스타일을 변경합니다.
    $('#' + popupDivId).css({'left':left,'top':top, 'position':'absolute'});

    // 레이어 팝업을 띄웁니다.
    $('#' + popupDivId).show();
}

function gfn_hidePopupDiv(popupDivId) {
	$('.mask').hide();
    $('#' + popupDivId).hide();
}

function gfn_cbRefresh(id, options, isAll) {
	$("#" + id).find("option").remove();
	
	if ( isAll ) {
		$("#" + id).append("<option value=''>전체</option>")
	}
	for ( var i = 0; i < options.length; i++ ) {
		$("#" + id).append("<option value='" + options[i].value + "'>" + options[i].text + "</option>")
	}

	$("#" + id + "option:eq(0)").attr("selected", "selected");
}

function gfn_mcbRefresh(id, options, isAll, _params) {
	var params = _params || {};
	
	$("#" + id).find("option").remove();
	
	if ( isAll ) {
		$("#" + id).append("<option value=''>전체</option>")
	}
	for ( var i = 0; i < options.length; i++ ) {
		if ( params.except == undefined || params.except == "" || ("," + params.except + ",").indexOf("," + options[i].value + ",") < 0 ) {
			$("#" + id).append("<option value='" + options[i].value + "'>" + options[i].text + "</option>")
		}
	}

	$("#" + id + "option:eq(0)").attr("selected", "selected");
	
	$('#' + id).multiselect('rebuild');
}

function gfn_cbRemove(id) {
	$("#" + id).find("option").remove();
}

function gfn_getUrlParams(key) {
	var rtn = {};
	var tmp1 = location.href.split("?");
	if ( tmp1.length == 2 ) {
		var tmp2 = tmp1[1].split("&");
		
		for ( var i = 0; i < tmp2.length; i++ ) {
			var tmp3 = tmp2[i].split("=");
			rtn[tmp3[0]] = tmp3[1];
		}
	}
	
	if ( key ) {
		return rtn[key];
	} else {
		return rtn;
	}
}

function gfn_getValueInList(list, keyField, value, valueField, isValue) {
	if ( list ) {
		for ( var i = 0; i < list.length; i++ ) {
			if ( list[i][keyField] == value ) {
				return list[i][valueField];
			}		
		}
	}
	
	if ( isValue && isValue == true ) {
		return value;
	} else {
		return "";
	}
}

function gfn_gridResize(gridParentId, gridObj, minusHeight) {
	if ( minusHeight != undefined ) {
		$("#" + gridParentId).height($(window).height() - minusHeight);
		gridObj.setHeight($(window).height() - minusHeight);
	} else {
		$("#" + gridParentId).height($(window).height() - 190);
		gridObj.setHeight($(window).height() - 190);
	}
}

function gfn_initDatepicker(objId) {
	$("#" + objId).datepicker({ 
		changeMonth: true,
		changeYear: true,
		showMonthAfterYear: true,
		autoSize: false,
		buttonImage: "/resources/datepicker/images/calendar.gif",
		buttonImageOnly: true,
		showOn: "button",
		beforeShow: function(input) {
		   	var i_offset= $(input).offset();
		   	setTimeout(function(){
		      	$('#ui-datepicker-div').css({'top':i_offset.top + 20 + document.body.scrollTop, 'bottom':'', 'left':i_offset.left});      //datepicker의 div의 포지션을 강제로 input 위치에 그리고 좌측은 모바일이여서 작기때문에 무조건 10px에 놓았다.
		   	})
		} 
	});
}

function gfn_currentDay(dt, delimiter) {
	delimiter = delimiter || "";
	
	var newDate = null;
	
	if ( dt ) {
		newDate = dt;
	} else {
		newDate = new Date();
	}
	var year = newDate.getFullYear();
	var month = newDate.getMonth() + 1;
	var day = newDate.getDate();
	
	return year + delimiter + (month < 10 ? "0" : "") + month + delimiter + (day < 10 ? "0" : "") + day;
}

function gfn_addDay(dt, addDay, delimiter) {
	var dt = new Date(dt.substring(0,4), parseInt(dt.substring(4,6)) - 1, parseInt(dt.substring(6,8)) + addDay);
	
	return gfn_currentDay(dt, delimiter);
}

function gfn_isExistStringInString(str, compStr) {
	if ( ("," + compStr + ",").indexOf("," + str + ",") > -1 ) {
		return true;
	} else {
		return false;
	}
}

var multiselectOptions = { 
    maxHeight: 200
}

function gfn_getString(val) {
	if ( val == undefined ) {
		return "";
	} else if ( typeof val == 'number'  ) {
		return val + "";
	} else if ( typeof val == 'string'  ) {
		return val.trim();
	} else {
		return val;
	}
}

function gfn_getFormToJson(id) {
	var formData = $("#" + id).serialize();
	var jsonObject = {};
	
	var tmp = formData.split("&");
	for ( var i = 0; i < tmp.length; i++ ) {
		var tmp2 = tmp[i].split("=");
		
		jsonObject[tmp2[0]] = decodeURIComponent(tmp2[1]);
	}
	
	return jsonObject;
}

