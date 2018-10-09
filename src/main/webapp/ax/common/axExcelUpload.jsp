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
var screen = gfn_getUrlParams("SCREEN");

$(document.body).ready(function () {
    $('[data-grid-control]').click(function () {
        switch (this.getAttribute("data-grid-control")) {
            case "close" :
            	window.close();
                break;
        }
    });

	if ( screen == "Quest" ) {
		$("#columns").val("TYPE,QUESTION,QA1,QA2,QA3,QA4,USE_YN");
	} else if ( screen == "Exam" ) {
		$("#columns").val("TYPE,QUESTION,QA1,QA2,QA3,QA4,ANSWER,ANSWER_DESC,WEEK,LEVEL,USE_YN");
	} else if ( screen == "CourseResource" ) {
		$("#columns").val("WEEK,TITLE,DIRECTORY,PAGE_CNT,PREVIEW_PAGE,WEEK_TIME");
	} else if ( screen == "CompanyUser" ) {
		$("#columns").val("USER_ID,USER_NAME,EMAIL,SEX,BIRTH_DAY,HOME_ZIPCODE,HOME_ADDR,HOME_TEL,MOBILE,PWD");
	}
});


function lfn_btn(pKind, pParam) {
	if ( pKind == "excelUpload" ) {
		document.frm.action = context + "/common/axExcelUpload.do";
		document.frm.target = "tranFrameS";
		document.frm.method = "POST";	
		document.frm.submit();
	}
}

function lfn_tran(data) {
	if ( data.RtnMode && data.RtnMode != "OK" ) {
		$("#validArea").text("업로드시 문제가 발생했습니다.");
	} else {
		var isNotValid = false;
		var msg = "";
		if ( screen == "Quest" ) {
			for ( var i = 0; i < data.list.length; i++ ) {
				var rowMsg = "";
				if ( !gfn_isExistStringInString(data.list[i].TYPE, "객관식,주관식,복수형") ) {
					isNotValid = true;
					rowMsg += "타입 오류[객관식/주관식/복수형] -> " + data.list[i].TYPE;
				} 
				if ( !gfn_isExistStringInString(data.list[i].USE_YN, "Y,N") ) {
					isNotValid = true;
					rowMsg += " , 사용여부 오류[Y/N] -> " + data.list[i].USE_YN;
				} 
				
				if ( rowMsg != "" ) {
					msg += (i + 1) + " 라인 : " + rowMsg + "\n";
				}
				
				//코드 데이타 변환
				if ( data.list[i].TYPE == "객관식" ) {
					data.list[i].TYPE = "G";
				} else if ( data.list[i].TYPE == "주관식" ) {
					data.list[i].TYPE = "J";
				} else if ( data.list[i].TYPE == "복수형" ) {
					data.list[i].TYPE = "M";
				}
				
				//기타 데이타 입력
				data.list[i].QG_ID = gfn_getUrlParams("QG_ID");
			}
			if ( isNotValid ) {
				$("#validArea").text(msg);
				fn_fileInit();
				return;
			}
		} else if ( screen == "Exam" ) {
			var weekCnt = parseInt(gfn_getUrlParams("WEEK_CNT"));
			
			for ( var i = 0; i < data.list.length; i++ ) {
				var rowMsg = "";
				if ( !gfn_isExistStringInString(data.list[i].TYPE, "객관식,주관식") ) {
					isNotValid = true;
					rowMsg += "타입 오류[객관식/주관식] -> " + data.list[i].TYPE;
				} 
				if ( data.list[i].TYPE == "객관식" && !gfn_isExistStringInString(data.list[i].ANSWER, "1,2,3,4") ) {
					isNotValid = true;
					rowMsg += " , 정답 오류[1/2/3/4] -> " + data.list[i].ANSWER;
				} 
				if ( !gfn_isExistStringInString(data.list[i].LEVEL, "상,중,하") ) {
					isNotValid = true;
					rowMsg += " , 난이도 오류[상/중/하] -> " + data.list[i].LEVEL;
				} 
				if ( parseInt(data.list[i].WEEK.replace("주차", "").replace(" ", "")) >= weekCnt ) {
					isNotValid = true;
					rowMsg += " , 주차 오류[1 ~ " + weekCnt + "] -> " + data.list[i].WEEK;
				}
				if ( !gfn_isExistStringInString(data.list[i].USE_YN, "Y,N") ) {
					isNotValid = true;
					rowMsg += " , 사용여부 오류[Y/N] -> " + data.list[i].USE_YN;
				} 
				
				if ( rowMsg != "" ) {
					msg += (i + 1) + " 라인 : " + rowMsg + "\n";
				}
				
				//코드 데이타 변환
				if ( data.list[i].TYPE == "객관식" ) {
					data.list[i].TYPE = "G";
				} else if ( data.list[i].TYPE == "주관식" ) {
					data.list[i].TYPE = "J";
				}
				if ( data.list[i].LEVEL == "상" ) {
					data.list[i].LEVEL = "1";
				} else if ( data.list[i].LEVEL == "중" ) {
					data.list[i].LEVEL = "2";
				} else if ( data.list[i].LEVEL == "하" ) {
					data.list[i].LEVEL = "3";
				}
				data.list[i].WEEK = data.list[i].WEEK.replace("주차", "").replace(" ", "");
				
				//기타 데이타 입력
				data.list[i].COURSE_CODE = gfn_getUrlParams("COURSE_CODE");
			}
			if ( isNotValid ) {
				$("#validArea").text(msg);
				fn_fileInit();
				return;
			}
		} else if ( screen == "CourseResource" ) {
			for ( var i = 0; i < data.list.length; i++ ) {
				var rowMsg = "";
				if ( data.list[i].PAGE_CNT == "" || isNaN(data.list[i].PAGE_CNT) ) {
					isNotValid = true;
					rowMsg += "페이지 오류[정수타입] -> " + data.list[i].PAGE_CNT;
				} 
				if ( data.list[i].PREVIEW_PAGE == "" || isNaN(data.list[i].PREVIEW_PAGE) ) {
					isNotValid = true;
					rowMsg += "미리보기 페이지 오류[정수타입] -> " + data.list[i].PREVIEW_PAGE;
				}
				if ( data.list[i].WEEK_TIME == "" || isNaN(data.list[i].WEEK_TIME) ) {
					isNotValid = true;
					rowMsg += "학습시간 오류[정수타입] -> " + data.list[i].WEEK_TIME;
				}
								
				if ( rowMsg != "" ) {
					msg += (i + 1) + " 라인 : " + rowMsg + "\n";
				}
			}
			if ( isNotValid ) {
				$("#validArea").text(msg);
				fn_fileInit();
				return;
			}
		} else if ( screen == "CompanyUser" ) {
			for ( var i = 0; i < data.list.length; i++ ) {
				var rowMsg = "";
				if ( !gfn_isExistStringInString(data.list[i].SEX, "남,여") ) {
					isNotValid = true;
					rowMsg += "성별 오류[남/여] -> " + data.list[i].SEX;
				} 
				/*
				if ( !isEmail(data.list[i].BIRTH_DAY) ) {
					isNotValid = true;
					rowMsg += " , 생일 포맷 오류 -> " + data.list[i].BIRTH_DAY;
				} 
				*/
				if ( !isEmail(data.list[i].EMAIL) ) {
					isNotValid = true;
					rowMsg += " , 이메일 오류 -> " + data.list[i].isEmail;
				} 
				if ( data.list[i].PWD == ""  ) {
					isNotValid = true;
					rowMsg += " , 패스워드 오류(필수) ->" + data.list[i].PWD;
				} 
				
				if ( rowMsg != "" ) {
					msg += (i + 1) + " 라인 : " + rowMsg + "\n";
				}
				
				//코드 데이타 변환
				if ( data.list[i].SEX == "남" ) {
					data.list[i].SEX = "M";
				} else if ( data.list[i].SEX == "여" ) {
					data.list[i].SEX = "F";
				}
			}
			if ( isNotValid ) {
				$("#validArea").text(msg);
				fn_fileInit();
				return;
			}
		}

		opener.fn_callbackAjax(data, "excelUploadList");
		self.close();
	}
}

function fn_fileInit() {
	var agent = navigator.userAgent.toLowerCase();
	if ( (navigator.appName == 'Netscape' && navigator.userAgent.search('Trident') != -1) || (agent.indexOf("msie") != -1) ){
	    // ie 일때 input[type=file] init.
	    $("#newFile").replaceWith( $("#newFile").clone(true) );
	} else {
	    //other browser 일때 input[type=file] init.
	    $("#newFile").val("");
	}
}
</script>

<body style="padding : 10px">

<form id="frm" name="frm" action="" method="post" enctype="multipart/form-data">
<input type="hidden" id="columns" name="columns" value=""></input>

<h2>엑셀 업로드</h2>
<div style="height:10px"></div>

<div>
    <button class="btn btn-default" data-grid-control="close">닫기</button>
</div>

<div style="height:10px"></div>

<div>
	<div class="file_btn_group">
		<a class="grayBtn file_button">파일찾기</a>
	  	<input type="file" name="newFile" id="newFile" class="hidden_inputfile" title="" onChange="javascript:lfn_btn('excelUpload'); return false;">
	</div>
</div>

<div style="height:10px"></div>

<textarea id="validArea" style="width:580px;height:315px;">
1. 엑셀 업로드를 오픈한 화면에서 엑셀을 다운로드 하세요.
2. 등록할 내용을 추가해주세요.
3. 셀서식은 텍스트로 변경해주세요.
4. 저장시 통합문서로 저장해주세요.
5. 파일을 선택해서 업로드 해주세요.
6. 엑셀 파일이 양식에 안맞을 경우 오류 메세지를 보고 엑셀을 수정해 주세요. 
</textarea>


</form>
	
<iframe id="tranFrameS" name="tranFrameS" style="display:none;"></iframe>

</body>
</html>

