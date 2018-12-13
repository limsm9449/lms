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
    <title>과정학습 - 환경 설정</title>

    <%@ include file="../common/commMainInclude.jsp" %> 

    <link href='https://fonts.googleapis.com/css?family=Nanum+Gothic' rel='stylesheet'>

    <link rel='stylesheet' href='/resources/homepage/css/initialization.css?timestamp=<%=timestamp%>'>
    <link rel='stylesheet' href='/resources/homepage/css/popup/popup_common.css?timestamp=<%=timestamp%>'>
</head>

<body>
    <!-- 환경설정 POPUP -->
    <div id='popup_standard' class='popup'>
        <div class='popup_fix'>
            <p class='popup_title'>
                환경 설정
                <span>환경 설정 안내입니다.</span>
            </p>
            <div class='popup_info_box'>
                <p>
                    Internet Explorer 브라우저 최적화 안내입니다
                </p>
            </div>
        </div>
        <div class='preference_tab'>
            <button class='on' onclick='browser_set(this, "9")'>IE9</button>
            <button onclick='browser_set(this, "10")'>IE10</button>
            <button onclick='browser_set(this, "11")'>IE11</button>
        </div>
        <div class='popup_content preference normal'>
            <p>
                <span>1</span> Internet Explorer 상단의 [도구] -> [인터넷 옵션]을 클릭합니다. (단축키 Alt + T + O)
            </p>
            <img class='small' src='/resources/homepage/img/etc/preference_1.JPG' alt=' '>
            <p>
                <span>2</span> [일반]탭 검색기록 항목의 [삭제] 클릭, <br> 팝업된 [검색기록 삭제] 창의 모든 항목을 체크한 후 [삭제] 버튼을 클릭합니다.
            </p>
            <img src='/resources/homepage/img/etc/preference_2.JPG' alt=' '>
            <p>
                <span>3</span> [설정] 버튼을 클릭하고 '페이지를 열 때마다' 체크 후 [파일보기] 버튼을 클릭합니다.
            </p>
            <img src='/resources/homepage/img/etc/preference_3.JPG' alt=' '>
            <p>
                <span>4</span> 임시인터넷파일 폴더에 남아있는 파일이 있는 경우 [Ctrl + A]를 눌러 모든 파일을 선택하고 Delete 키를 눌러 모두 삭제합니다. (일부 파일은 삭제되지 않을 수도 있습니다.)
            </p>
            <img class='small' src='/resources/homepage/img/etc/preference_4.JPG' alt=' '>
            <p>
                <span>5</span> [보안] 탭의 '신뢰할 수 있는 사이트' 클릭 후 [사이트]를 클릭합니다.<br> ('이 영역에 있는 모든 사이트에 대해 서버 확인 필요'의 체크 표시 없앰)<br> '영역에 웹 사이트 추가' 부분에 *.qlearning.co.kr 입력 후 [추가]한 후 [닫기] 버튼을 클릭합니다.
            </p>
            <img src='/resources/homepage/img/etc/preference_5.JPG' alt=' '>
            <p>
                <span>6</span> [개인정보] -> [고급]을 클릭하여 '자동으로 쿠키 처리 안함'에 체크하고, '현재 사이트의 쿠키', '링크된 사이트의 쿠키' 모두 [허용] 체크, '항상 세션에 쿠키 허용'에 체크한 후, [확인]을 클릭합니다.
            </p>
            <img src='/resources/homepage/img/etc/preference_6.JPG' alt=' '>
            <p>
                <span>7</span> [팝업차단 사용]의 체크를 해제합니다.
            </p>
            <img class='small' src='/resources/homepage/img/etc/preference_7.JPG' alt=' '>
            <p>
                <span>8</span> [고급] 탭을 클릭하여 'GPU 렌더링 대신 소프트웨어 렌더링 사용' 항목에 체크합니다.<br> 스크롤바를 내리면 [국제] 항목이 확인됩니다. 국제 항목의 'URL 경로를 UTF-8 URL 보내기' 체크 해제 후 [확인] 버튼을 클릭하여 인터넷 옵션 창을 닫아주십시오.
            </p>
            <img src='/resources/homepage/img/etc/preference_8.JPG' alt=' '>
            <p>
                <span>9</span> Internet Explorer 상단의 [도구] -> [호환성 보기 설정]을 클릭합니다. (단축키 Alt + T + B)<br> '이 웹사이트 추가' 항목에 [qlearning.co.kr] 입력 후 [추가] 버튼을 클릭합니다.<br> 하단의 '호환성 보기에서 모든 웹 사이트 표시' 항목 체크 후 [닫기] 버튼을 클릭합니다.
            </p>
            <img src='/resources/homepage/img/etc/preference_9.JPG' alt=' '>
        </div>
        <div class='popup_content preference privacy_more'>
            <p>
                <span>1</span> Internet Explorer 상단의 [도구] -> [인터넷 옵션]을 클릭합니다. (단축키 Alt + T + O)
            </p>
            <img class='small' src='/resources/homepage/img/etc/preference_1.JPG' alt=' '>
            <p>
                <span>2</span> [일반]탭 검색기록 항목의 [삭제] 클릭, <br> 팝업된 [검색기록 삭제] 창의 모든 항목을 체크한 후 [삭제] 버튼을 클릭합니다.
            </p>
            <img src='/resources/homepage/img/etc/preference_2.JPG' alt=' '>
            <p>
                <span>3</span> [설정] 버튼을 클릭하고 '페이지를 열 때마다' 체크 후 [파일보기] 버튼을 클릭합니다.
            </p>
            <img src='/resources/homepage/img/etc/preference_3.JPG' alt=' '>
            <p>
                <span>4</span> 임시인터넷파일 폴더에 남아있는 파일이 있는 경우 [Ctrl + A]를 눌러 모든 파일을 선택하고 Delete 키를 눌러 모두 삭제합니다. (일부 파일은 삭제되지 않을 수도 있습니다.)
            </p>
            <img class='small' src='/resources/homepage/img/etc/preference_4.JPG' alt=' '>
            <p>
                <span>5</span> [보안] 탭의 '신뢰할 수 있는 사이트' 클릭 후 [사이트]를 클릭합니다.<br> ('이 영역에 있는 모든 사이트에 대해 서버 확인 필요'의 체크 표시 없앰)<br> '영역에 웹 사이트 추가' 부분에 *.qlearning.co.kr 입력 후 [추가]한 후 [닫기] 버튼을 클릭합니다.
            </p>
            <img src='/resources/homepage/img/etc/preference_5.JPG' alt=' '>
            <p>
                <span>6</span> [보안] 탭의 '신뢰할 수 있는 사이트' 클릭 후 [사용자 지정 수준]을 클릭합니다.<br> 보안 설정 화면에서 아래와 같이 'ActiveX' 설정을 순차적으로 진행하여 주십시오.
            </p>
            <img src='/resources/homepage/img/etc/preference_5_1.JPG' alt=' '>
            <img src='/resources/homepage/img/etc/preference_5_2.JPG' alt=' '>
            <p>
                <span>7</span> 보안 설정 화면에서, '다른 도메인 사이에서 창과 프레임 탐색', '도메인 간의 데이터 소스 엑세스'를 [사용]으로 체크합니다.
            </p>
            <img class='small' src='/resources/homepage/img/etc/preference_5_3.JPG' alt=' '>
            <p>
                <span>8</span> [개인정보] -> [고급]을 클릭하여 '자동으로 쿠키 처리 안함'에 체크하고, '현재 사이트의 쿠키', '링크된 사이트의 쿠키' 모두 [허용] 체크, '항상 세션에 쿠키 허용'에 체크한 후, [확인]을 클릭합니다.
            </p>
            <img src='/resources/homepage/img/etc/preference_6.JPG' alt=' '>
            <p>
                <span>9</span> [팝업차단 사용]의 체크를 해제합니다.
            </p>
            <img class='small' src='/resources/homepage/img/etc/preference_7.JPG' alt=' '>
            <p>
                <span>10</span> [고급] 탭을 클릭하여 스크롤바를 내리면 [국제] 항목이 확인됩니다.<br>국제 항목의 'URL 경로를 UTF-8 URL 보내기' 체크 해제 후 [확인] 버튼을 클릭하여 인터넷 옵션 창을 닫아주십시오.
            </p>
            <img class='small' src='/resources/homepage/img/etc/preference_8_1.JPG' alt=' '>
            <p>
                <span>11</span> Internet Explorer 상단의 [도구] -> [호환성 보기 설정]을 클릭합니다. (단축키 Alt + T + B)<br> ([도구] 메뉴가 보이지 않을 경우 키보드의 [Alt] 키를 클리하여 주십시오.)<br>'이 웹사이트 추가' 항목에 [qlearning.co.kr] 입력 후 [추가] 버튼을 클릭합니다.<br> 하단의 '호환성 보기에서 모든 웹 사이트 표시' 항목 체크 후 [닫기] 버튼을 클릭합니다.
            </p>
            <img src='/resources/homepage/img/etc/preference_9.JPG' alt=' '>
        </div>
    </div>
    <!-- 설문 POPUP END-->

    <script src='/resources/homepage/js/sub.js'></script>
</body>

</html>