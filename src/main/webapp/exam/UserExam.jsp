<%@ page contentType="text/html;charset=utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<!DOCTYPE html>
<html lang='ko'>

<head>
    <meta charset='utf-8'>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>온라인 시험</title>

	<%@ include file="../common/commMainInclude.jsp" %>
	
    <!--[if IE]>
        <link rel='stylesheet' href='/resources/homepagePopup/css/main_ie.css'>
    <![endif]-->

    <link href="https://fonts.googleapis.com/css?family=Nanum+Gothic" rel="stylesheet">

    <link rel='stylesheet' href='/resources/homepagePopup/css/common/reset.css'>
    <link rel='stylesheet' href='/resources/homepagePopup/css/common/common.css'>
    <link rel='stylesheet' href='/resources/homepagePopup/css/popup/popup_common.css'>
</head>

<script type="text/javascript">
var gCondition = {
}

function lfn_btn(pKind, pParam) {
	if ( pKind =="save" ) {
		if ( lfn_validate() == false )
			return false;
		
		if ( confirm("시험은 한번만 저장하실 수 있습니다.\n저장하시겠습니까?") == true ) {
			$.ajax({
				type :"POST",
				url : context +"/exam/userExamIns.do",
				dataType :"json",
				data : $("#frm").serialize(),
				success : function(json){
					if ( json.rtnMode == "INSERT_OK") {
						alert("정상적으로 저장이 되었습니다.");
						opener.lfn_btn("refresh");
						window.close();
					}
				},
				error : function(e) {
					alert("<spring:message code="lms.msg.systemError" text="-" />");
				}
			})
		}
	}
}

function lfn_validate() {
	//Validation 검사
	types = $("[id=types]");
	answers = $("[id=answers]");
	for ( i = 0; i < types.length; i++ ) {
		if ( types[i].value == "G") {
			if ( $("input[name=answers_" + (i + 1) + "]:checked").length == 0 ) {
				alert((i + 1) + " 문항의 답을 선택하세요.");
				return false;
			}

			answers[i].value = $("input[name=answers_" + (i + 1) + "]:checked").val();
		} else {
			if ( $("#answers_" + (i + 1)).val() == "" ) {
				alert((i + 1) + " 문항의 답을 입력하세요.");
				return false;
			}

			answers[i].value = $("#answers_" + (i + 1)).val();
		}
	}
		
	return true;
}

</script>

<body>
<form id="frm" name="frm" action="" method="post">
	<input type="hidden" id="courseId" name="courseId" value="${set.condiVO.courseId}"/>
	 
    <!-- 시험 응시 POPUP -->
    <div id='popup_exam' class='popup'>
        <div class='popup_fix'>
            <!-- <div class='popup_head clear_fix'>
                <p>온라인 시험</p>
                <button type='button' onclick='close_popup("popup_exam")'>X</button>
            </div> -->
            <p class='popup_title'>
                시험보기
                <span>과정을 수료하기 위한 최종 과정평가입니다.</span>
            </p>
            <div class='popup_info_box'>
                <div class='popup_info'>
                    <span>최종평가</span>
                    문제를 정확히 읽고 정답을 선택해주세요.
                </div>
                <ul class='popup_info_list'>
                    <li>
                        응시자 :
                        <span>${sess.userName}</span>
                    </li>
                    <li>
                        남은시간 :
                        <span id="time">1:29:49</span>
                    </li>
                </ul>
            </div>
        </div>
        <ul class='popup_question'>
<c:forEach var="row" items="${set.list}" varStatus="idx">   
	<input type='hidden' name='types' id='types' value='${row.type}'>     
	<input type='hidden' name='seqs' id='seqs' value='${row.seq}'>     
	<input type='hidden' name='answers' id='answers' value=''>
	
	<c:if test="${row.type eq 'G'}">
            <li class='question_list_box'>
                <div>
                    <div class='question_num'>
                        Q.
                        <span>${idx.index + 1}</span>
                    </div>
                    <div class='question_answer'>
                        <p>${row.question}</p>
                        <ul class='answers_box'>
                            <li class='clear_fix'>
                                <input type='radio' name='answers_${idx.index + 1}' id='answers_${idx.index + 1}' value='1'>
                                <p>
            						${row.qa1}
                                </p>
                            </li>
                            <li class='clear_fix'>
                                <input type='radio' name='answers_${idx.index + 1}' id='answers_${idx.index + 1}' value='2'>
                                <p>
                                    ${row.qa2}
                                </p>
                            </li>
                            <li class='clear_fix'>
                                <input type='radio' name='answers_${idx.index + 1}' id='answers_${idx.index + 1}' value='3'>
                                <p>
                                    ${row.qa3}
                                </p>
                            </li>
                            <li class='clear_fix last_bottom'>
                                <input type='radio' name='answers_${idx.index + 1}' id='answers_${idx.index + 1}' value='4'>
                                <p>
                                    ${row.qa4}
                                </p>
                            </li>
                        </ul>
                    </div>
                </div>
            </li>
   	</c:if>
	<c:if test="${row.type eq 'J'}">
            <li class='question_list_box'>
                <div>
                    <div class='question_num'>
                        Q.
                        <span>${idx.index + 1}</span>
                    </div>
                    <div class='question_answer'>
                        <p>${row.question}</p>
                        <input type='text' name='answers_${idx.index + 1}' id='answers_${idx.index + 1}'>
                    </div>
                </div>
            </li>
   	</c:if>
</c:forEach>            
        </ul>
        <div class='btn_submit'>
            <button onclick="javascript:lfn_btn('save'); return false;">제출하기</button>
        </div>
    </div>
    <!-- 시험 응시 POPUP END-->

</form>
    
</body>

</html>