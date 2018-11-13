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
	
    <link href="https://fonts.googleapis.com/css?family=Nanum+Gothic" rel="stylesheet">

    <link rel='stylesheet' href='/resources/homepage/css/initialization.css'>
    <link rel='stylesheet' href='/resources/homepage/css/popup/popup_common.css'>
    
    
</head>

<script type="text/javascript">
$(document).ready(function() {
	CountDownTimer("${set.startTime}");
});

var timer;
var end;
function CountDownTimer(dt) {
	end = new Date(	parseInt(dt.substring(0,4)), 
			parseInt(dt.substring(4,6)) - 1, 
			parseInt(dt.substring(6,8)), 
			parseInt(dt.substring(8,10)) + 1, 
			parseInt(dt.substring(10,12)), 
			parseInt(dt.substring(12,14)) );
	
	timer = setInterval(showRemaining, 1000);
}

function showRemaining() {
	var _second = 1000;
	var _minute = _second * 60;
	var _hour = _minute * 60;
	var _day = _hour * 24;
	var timer;
	
	var now = new Date();
	var distance = end - now;
	if (distance < 0) {
		clearInterval(timer);
		document.getElementById("time").innerHTML = '시험종료';
		
		return;
	} else{
		var days = Math.floor(distance / _day);
		var hours = Math.floor((distance % _day) / _hour);
		var minutes = Math.floor((distance % _hour) / _minute);
		var seconds = Math.floor((distance % _minute) / _second);
		
		document.getElementById("time").innerHTML = minutes + '분 ' + seconds + '초'; 
	}
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
						opener.location.reload();
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
			if ( $("#jAnswers_" + (i + 1)).val() == "" ) {
				alert((i + 1) + " 문항의 답을 입력하세요.");
				return false;
			}

			answers[i].value = $("#jAnswers_" + (i + 1)).val();
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
<c:choose>
	<c:when test="${set.condiVO.week eq '0'}">
                <span>과정을 수료하기 위한 최종 과정평가입니다.</span>
	</c:when>
	<c:otherwise>
                <span>주차별 진행 학습평가입니다.</span>
	</c:otherwise>
</c:choose>                  
            </p>
            <div class='popup_info_box'>
                <div class='popup_info'>
<c:choose>
	<c:when test="${set.condiVO.week eq '0'}">
                    <span>최종 학습평가</span>
	</c:when>
	<c:otherwise>
                    <span>${set.condiVO.week}주 진행 학습평가</span>
	</c:otherwise>
</c:choose>                  
                    문제를 정확히 읽고 정답을 선택해주세요.
                </div>
                <ul class='popup_info_list'>
                    <li>
                        응시자 :
                        <span>${session.userName}</span>
                    </li>
                    <li <c:if test="${set.condiVO.week ne '0'}">style="display:none;"</c:if>>
                        남은시간 :
                        <span id="time">0분 0초</span>
                    </li>
                </ul>
            </div>
        </div>
        <ul class='popup_question'>
<c:forEach var="row" items="${set.list}" varStatus="idx">   
	<input type='hidden' name='types' id='types' value='${row.type}'>     
	<input type='hidden' name='examKinds' id='examKinds' value='${row.examKind}'>     
	<input type='hidden' name='weeks' id='weeks' value='${row.week}'>     
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
                    	<input type='hidden' name='jAnswers_${idx.index + 1}' id='jAnswers_${idx.index + 1}'>
                    	
                        <p>${row.question}</p>
                        <ul class='answer_box'>
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
                       	<input type='radio' name='answers_${idx.index + 1}' id='answers_${idx.index + 1}' style="display:none;">

                        <p>${row.question}</p>
                        <input type='text' name='jAnswers_${idx.index + 1}' id='jAnswers_${idx.index + 1}'>
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