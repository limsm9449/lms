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
    <title>과정학습 - 학습가이드</title>

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
                학습 가이드
                <span>학습 가이드입니다.</span>
            </p>
            <div class='popup_info_box'>
                <p>
                    온라인 학습에서는 무엇보다도 철저한 자기관리가 가장 중요합니다. <span></span>수강신청 후 학습하는 것을 잊어버리거나 한꺼번에 몰아서 학습하는 경우, 또는 강의실에 입장한 상태 에서 다른 일을 병행하는 경우에는 최대한의 학습효과를 기대할 수 없습니다.
                </p>
            </div>
        </div>
        <div class='popup_content guide'>
            <div>
                <ol class='box'>
                    <li><span>1) 내 눈높이에 맞는 과정을 선택하라.</span></li>
                    <li><span>2) 하루 30분씩 꼭 학습, 나만의 학습시간을 만들어라.</span></li>
                    <li><span>3) 언제든지 반복이 가능한 온라인 학습, 반복하고 또 반복하라.</span></li>
                    <li><span>4) 수시로 취득 점수를 체크하라.</span></li>
                </ol>
            </div>
        </div>
    </div>
    <!-- 설문 POPUP END-->
</body>

</html>