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

	<%@ include file="../../common/commMainInclude.jsp" %>
	
    <link href="https://fonts.googleapis.com/css?family=Nanum+Gothic" rel="stylesheet">

    <link rel='stylesheet' href='/resources/homepage/css/initialization.css'>
    <link rel='stylesheet' href='/resources/homepage/css/popup/popup_common.css'>
</head>

<body>
    <!-- 시험 결과 POPUP -->
    <div id='popup_exam_result' class='popup'>
        <div class='popup_fix'>
            <p class='popup_title'>
                시험
            </p>
        </div>
        <ul class='popup_question'>
<c:forEach var="row" items="${list}" varStatus="idx">           
	<c:if test="${row.TYPE eq 'G'}">
            <li class='question_list_box'>
                <div>
    	<c:if test="${row.ANSWER_YN eq 'Y'}">
                    <div class='marking blue'>O</div>
		</c:if>                    
    	<c:if test="${row.ANSWER_YN eq 'N'}">
                    <div class='marking red'>X</div>
		</c:if>                    
                    <div class='question_num'>
                        Q.
                        <span>${idx.index + 1}</span>
                    </div>
                    <div class='question_answer explanation'>
                        <p>${row.QUESTION}</p>
                        <ul class='answer_box explanation'>
                            <li class='clear_fix'>
                                <input type='radio' name='answers_${idx.index + 1}' value='1'>
                                <p>
                                    ${row.QA1}
                                </p>
                            </li>
                            <li class='clear_fix'>
                                <input type='radio' name='answers_${idx.index + 1}' value='2'>
                                <p>
                                    ${row.QA2}
                                </p>
                            </li>
                            <li class='clear_fix'>
                                <input type='radio' name='answers_${idx.index + 1}' value='3'>
                                <p>
                                   ${row.QA3}
                                </p>
                            </li>
                            <li class='clear_fix last_bottom'>
                                <input type='radio' name='answers_${idx.index + 1}' value='4'>
                                <p>
                                    ${row.QA4}
                                </p> 
                            </li>
                        </ul>
                    </div>
                </div>
            </li>
	</c:if>            
	<c:if test="${row.TYPE eq 'J'}">
            <li class='question_list_box'>
                <div>
    	<c:if test="${row.ANSWER_YN eq 'Y'}">
                    <div class='marking blue'>O</div>
		</c:if>                    
    	<c:if test="${row.ANSWER_YN eq 'N'}">
                    <div class='marking red'>X</div>
		</c:if>  
                    <div class='question_num'>
                        Q.
                        <span>${idx.index + 1}</span>
                    </div>
                    <div class='question_answer explanation'>
                        <p>${row.QUESTION}</p>
                        <input type='text' value="" >
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