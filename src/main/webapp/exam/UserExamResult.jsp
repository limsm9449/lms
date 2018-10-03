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

<body>
    <!-- 시험 결과 POPUP -->
    <div id='popup_exam_result' class='popup'>
        <div class='popup_fix'>
            <p class='popup_title'>
                시험보기
                <span>과정을 수료하기 위한 최종 과정평가입니다.</span>
            </p>
            <div class='popup_score_box'>
                <div class='popup_score clear_fix'>
                    <p class='score_text'>최종평가<br>시험결과</p>
                    <p class='score_value'>점수 : <span>${set.eval.examTotal}</span>점 입니다.</p>
                </div>
                <ul class='popup_info_list score'>
                    <li>
                        응시자:
                        <span>${sess.userName}</span>
                    </li>
                </ul>
            </div>
        </div>
        <ul class='popup_question'>
<c:forEach var="row" items="${set.list}" varStatus="idx">           
	<c:if test="${row.type eq 'G'}">
            <li class='question_list_box'>
                <div>
    	<c:if test="${row.answerYn eq 'Y'}">
                    <div class='marking blue'>O</div>
		</c:if>                    
    	<c:if test="${row.answerYn eq 'N'}">
                    <div class='marking red'>X</div>
		</c:if>                    
                    <div class='question_num'>
                        Q.
                        <span>${idx.index + 1}</span>
                    </div>
                    <div class='question_answer explanation'>
                        <p>${row.question}</p>
                        <ul class='answer_box explanation'>
                            <li class='clear_fix'>
                                <input type='radio' name='answers_${idx.index + 1}' value='1' <c:if test="${row.answer eq '1'}">checked='checked'</c:if>>
                                <p>
                                    ${row.qa1}
                                </p>
                            </li>
                            <li class='clear_fix'>
                                <input type='radio' name='answers_${idx.index + 1}' value='2' <c:if test="${row.answer eq '2'}">checked='checked'</c:if>>
                                <p>
                                    ${row.qa2}
                                </p>
                            </li>
                            <li class='clear_fix'>
                                <input type='radio' name='answers_${idx.index + 1}' value='3' <c:if test="${row.answer eq '3'}">checked='checked'</c:if>>
                                <p>
                                   ${row.qa3}
                                </p>
                            </li>
                            <li class='clear_fix last_bottom'>
                                <input type='radio' name='answers_${idx.index + 1}' value='4' <c:if test="${row.answer eq '4'}">checked='checked'</c:if>>
                                <p>
                                    ${row.qa4}
                                </p>
                            </li>
                        </ul>
                    </div>
                </div>
                <div class='answer_paper'>
                    <div class='first_bottom'>
                        <p>정답</p>
                        <p id='answer_num'>${row.examAnswer}</p>
                    </div>
                    <div>
                        <p>해설</p>
                        <p id='answer_sheet'>${row.answerDesc}</p>
                    </div>
                </div>
            </li>
	</c:if>            
	<c:if test="${row.type eq 'J'}">
            <li class='question_list_box'>
                <div>
    	<c:if test="${row.answerYn eq 'Y'}">
                    <div class='marking blue'>O</div>
		</c:if>                    
    	<c:if test="${row.answerYn eq 'N'}">
                    <div class='marking red'>X</div>
		</c:if>  
                    <div class='question_num'>
                        Q.
                        <span>${idx.index + 1}</span>
                    </div>
                    <div class='question_answer explanation'>
                        <p>${row.question}</p>
                        <input type='text' value="<c:out value="${row.answer}" escapeXml="" />">
                    </div>
                </div>
                <div class='answer_paper'>
                    <div class='first_bottom'>
                        <p>정답</p>
                        <p id='answer_num'>${row.examAnswer}</p>
                    </div>
                    <div>
                        <p>해설</p>
                        <p id='answer_sheet'>${row.answerDesc}
                        </p>
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
    <!-- 시험 결과 POPUP END-->
</body>

</html>