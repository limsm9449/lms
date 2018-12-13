<%@ page contentType="text/html;charset=utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!DOCTYPE html>
<html lang='ko'>

<head>
    <meta charset='utf-8'>
    <meta name='viewport' content='width=device-width, initial-scale=1.0'>
    <meta http-equiv='X-UA-Compatible' content='ie=edge'>
    <title>과정학습 - 학습/수료기준</title>

    <%@ include file="../common/commMainInclude.jsp" %> 

    <link href='https://fonts.googleapis.com/css?family=Nanum+Gothic' rel='stylesheet'>

    <link rel='stylesheet' href='/resources/homepage/css/initialization.css?timestamp=<%=timestamp%>'>
    <link rel='stylesheet' href='/resources/homepage/css/popup/popup_common.css?timestamp=<%=timestamp%>'>
</head>

<body>
    <!-- 설문 POPUP -->
    <div id='popup_standard' class='popup'>
        <div class='popup_fix'>
            <p class='popup_title'>
                학습/수료 기준 안내
                <span>학습/수료 기준 안내입니다.</span>
            </p>
            <div class='popup_info_box'>
                <div class='popup_info'>
                    학습/수료 기준 안내
                </div>
                <p>
                    수강하시는 과정의 진도체크 방법 및 수료기준 입니다. <span></span>학습진행 시 착오 없도록 숙지 바랍니다.
                </p>
            </div>
        </div>
        <div class='popup_content'>
            <div>
                <p class='note_title'>진도 체크 방법</p>
                <p>학습화면 오른쪽 하단에 있는 [NEXT 또는 다음] 버튼을 누르셔서 마지막 페이지 까지 학습합니다.</p>
            </div>
            <div>
                <p class='note_title'>평가항목 및 수료 기준</p>
                <ul class='box'>
                    <li>진도율 : <span>80% 이상 진행</span></li>
                    <li>평가 : <span>시험/과제 제출 (시험유무는 과정별로 상이함)</span></li>
                    <li>수료기준 : <span>총점 60점 이상 (100점 만점 기준)</span></li>
                </ul>
            </div>
        </div>
    </div>
    <!-- 설문 POPUP END-->
</body>

</html>