<%@ page contentType="text/html;charset=utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<!DOCTYPE html>
<html lang='ko'>

<head>
    <meta charset='utf-8'>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>온라인 평가</title>

	<%@ include file="../common/commMainInclude.jsp" %>
	
    <link href="https://fonts.googleapis.com/css?family=Nanum+Gothic" rel="stylesheet">

    <link rel='stylesheet' href='/resources/homepage/css/initialization.css'>
    <link rel='stylesheet' href='/resources/homepage/css/popup/popup_common.css'>
</head>

<script type="text/javascript">
$(document).ready(function() {
	if ( $("[id=types]").length == 0 ) {
		alert("등록된 설문이 없습니다.");
		window.close();
	}
});

function lfn_btn(pKind, pParam) {
	if ( pKind =="save" ) {
		if ( lfn_validate() == false )
			return false;
		
		if ( confirm("한번만 저장하실 수 있습니다.\n저장하시겠습니까?") == true ) {
			$.ajax({
				type :"POST",
				url : context +"/quest/userQuestIns.do",
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
		} else if ( types[i].value == "M") {
			var checkValues = ( $("input[name=answers_" + (i + 1) + "_1]").is(":checked") ? "Y" : "N" ) + "," +
								( $("input[name=answers_" + (i + 1) + "_2]").is(":checked") ? "Y" : "N" ) + "," + 
								( $("input[name=answers_" + (i + 1) + "_3]").is(":checked") ? "Y" : "N" ) + "," +
								( $("input[name=answers_" + (i + 1) + "_4]").is(":checked") ? "Y" : "N" ); 
			
			if ( checkValues == "N,N,N,N" ) {
				alert((i + 1) + " 문항의 답을 선택하세요.");
				return false;
			}

			answers[i].value = checkValues;
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
	 
    <!-- 설문 POPUP -->
    <div id='popup_survey' class='popup'>
        <div class='popup_fix'>
            <p class='popup_title'>
                설문 제목
            </p>
            <div class='popup_info_box'>
                <div class='popup_info'>
                   ${set.questName}
                </div>
                <ul class='popup_info_list'>
                    <li>
                        설문자:
                        <span>${session.userName}</span>
                    </li>
                </ul>
            </div>
        </div>
        <ul class='popup_question survey'>
<c:forEach var="row" items="${set.list}" varStatus="idx">
	<input type='hidden' name='types' id='types' value='${row.type}'>     
	<input type="hidden" id="qgIds" name="qgIds" value="${row.qgId}"/> 
	<input type='hidden' name='seqs' id='seqs' value='${row.seq}'>     
	<input type='hidden' name='answers' id='answers'>   	
   	
	<c:if test="${row.type eq 'G'}">
            <li class='question_list_box'>
                <div>
                    <div class='question_num'>
                        Q.
                        <span>${idx.index + 1}</span>
                    </div>
                    <div class='question_answer'>
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
	<c:if test="${row.type eq 'M'}">
			<li class='question_list_box'>
                <div>
                    <div class='question_num'>
                        Q.
                        <span>${idx.index + 1}</span>
                    </div>
                    <div class='question_answer'>
                        <p>${row.question}</p>
                        <ul class='answer_box'>
                            <li class='clear_fix'>
                                <input type='checkbox' name='answers_${idx.index + 1}_1' id='answers_${idx.index + 1}_1' value='1'>
                                <p>
                                    ${row.qa1}
                                </p>
                            </li>
                            <li class='clear_fix'>
                                <input type='checkbox' name='answers_${idx.index + 1}_2' id='answers_${idx.index + 1}_2' value='2'>
                                <p>
                                   ${row.qa2}
                                </p>
                            </li>
                            <li class='clear_fix'>
                                <input type='checkbox' name='answers_${idx.index + 1}_3' id='answers_${idx.index + 1}_3' value='3'>
                                <p>
                                   ${row.qa3}
                                </p>
                            </li>
                            <li class='clear_fix last_bottom'>
                                <input type='checkbox' name='answers_${idx.index + 1}_4' id='answers_${idx.index + 1}_4' value='4'>
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
                        <input type='text' name='jAnswers_${idx.index + 1}' id='jAnswers_${idx.index + 1}'>
                    </div>
                </div>
            </li>	
	</c:if>
	<c:if test="${row.type eq 'R'}">
            <li class='question_list_box'>
                <div>
                    <div class='question_num'>
                        Q.
                        <span>${idx.index + 1}</span>
                    </div>
                    <div class='question_answer'>
                        <p>${row.question}</p>
                        <textarea name='jAnswers_${idx.index + 1}' id='jAnswers_${idx.index + 1}'></textarea>
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
    <!-- 설문 POPUP END-->

</form>
    
</body>

</html>