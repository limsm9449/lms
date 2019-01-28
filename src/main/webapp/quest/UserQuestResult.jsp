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
});

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
                        설문자 :
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
                                <input type='radio' name='answers_${idx.index + 1}' id='answers_${idx.index + 1}' value='1' <c:if test="${row.answer eq '1'}">checked='checked'</c:if>  disabled="disabled">
                                <p>
                                    ${row.qa1}
                                </p>
                            </li>
                            <li class='clear_fix'>
                                <input type='radio' name='answers_${idx.index + 1}' id='answers_${idx.index + 1}' value='2' <c:if test="${row.answer eq '2'}">checked='checked'</c:if>  disabled="disabled">
                                <p>
                                    ${row.qa2}
                                </p>
                            </li>
                            <li class='clear_fix'>
                                <input type='radio' name='answers_${idx.index + 1}' id='answers_${idx.index + 1}' value='3' <c:if test="${row.answer eq '3'}">checked='checked'</c:if>  disabled="disabled">
                                <p>
                                    ${row.qa3}
                                </p>
                            </li>
                            <li class='clear_fix last_bottom'>
                                <input type='radio' name='answers_${idx.index + 1}' id='answers_${idx.index + 1}' value='4' <c:if test="${row.answer eq '4'}">checked='checked'</c:if>  disabled="disabled">
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
                                <input type='checkbox' name='answers_${idx.index + 1}_1' id='answers_${idx.index + 1}_1' value='1' <c:if test="${row.answer1 eq 'Y'}">checked='checked'</c:if> disabled="disabled">
                                <p>
                                    ${row.qa1}
                                </p>
                            </li>
                            <li class='clear_fix'>
                                <input type='checkbox' name='answers_${idx.index + 1}_2' id='answers_${idx.index + 1}_2' value='2' <c:if test="${row.answer2 eq 'Y'}">checked='checked'</c:if> disabled="disabled">
                                <p>
                                   ${row.qa2}
                                </p>
                            </li>
                            <li class='clear_fix'>
                                <input type='checkbox' name='answers_${idx.index + 1}_3' id='answers_${idx.index + 1}_3' value='3' <c:if test="${row.answer3 eq 'Y'}">checked='checked'</c:if> disabled="disabled">
                                <p>
                                   ${row.qa3}
                                </p>
                            </li>
                            <li class='clear_fix last_bottom'>
                                <input type='checkbox' name='answers_${idx.index + 1}_4' id='answers_${idx.index + 1}_4' value='4' <c:if test="${row.answer4 eq 'Y'}">checked='checked'</c:if> disabled="disabled">
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
                        <input type='text' name='jAnswers_${idx.index + 1}' id='jAnswers_${idx.index + 1}' value="<c:out value="${row.answer}" escapeXml="" />" disabled="disabled">
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
                        <textarea name='jAnswers_${idx.index + 1}' id='jAnswers_${idx.index + 1}' disabled="disabled"><c:out value="${row.answer}" escapeXml="" /></textarea>
                    </div>
                </div>
            </li>	
	</c:if>
</c:forEach>   
        </ul>
        
        <div class='btn_submit'>
            <button onclick="javascript:window.close()">닫기</button>
        </div>
    </div>
    <!-- 설문 POPUP END-->

</form>
    
</body>

</html>