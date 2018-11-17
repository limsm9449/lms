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
    <meta name='viewport' content='width=device-width, initial-scale=1, minimum-scale=1, maximum-scale=1'>
    <meta http-equiv='X-UA-Compatible' content='ie=edge'>
    <title>Q learning - 교육 안내 - 찾아오시는길</title>

	<%@ include file="../common/commMainInclude.jsp" %>

    <link href='https://fonts.googleapis.com/css?family=Nanum+Gothic' rel='stylesheet'>
    <link rel='stylesheet' href='/resources/homepage/css/initialization.css'>
    <link rel='stylesheet' href='/resources/homepage/css/support/map.css'>
</head>

<body>
    <frameset rows='*'>
        <div class='wrap'>
            <!-- PC HEADER -->
            <%@ include file="../common/mainTop.jsp" %>
            <!-- HEAD END -->

            <!-- CONTENTS -->
            <div class='contents_wrap tutorial' >
                <div class='contents_wrap_box'>
                    <!-- QUICK MENU -->
                    <%@ include file="../common/mainQuickMenu.jsp" %>

                    <!-- Top -->
                    <div class='top_area'>
                        <div class='clear_fix'>
                            <div class='process_history_box clear_fix'>
                                <span>
                                    <img src='/resources/homepage/img/course/ic_home.jpg' alt=' '>
                                </span>
                                <p>HOME</p>
                                <span>
                                    <img src='/resources/homepage/img/course/arr_right.jpg' alt=' '>
                                </span>
                                <p>수강신청</p>
                                <span>
                                    <img src='/resources/homepage/img/course/arr_right.jpg' alt=' '>
                                </span>
                                <p>교육과정</p>
                            </div>
                        </div>
                        <h1>
                            찾아오시는<span>길</span>
                        </h1>
                    </div>
                    <!-- Top END -->

                    <div id="contact">
                        <!--
                                * Daum 지도 - 약도서비스
                                * 한 페이지 내에 약도를 2개 이상 넣을 경우에는
                                * 약도의 수 만큼 소스를 새로 생성, 삽입해야 합니다.
                            -->
                        <!-- 1. 약도 노드 -->
                        <div id="daumRoughmapContainer1489041316885" class="root_daum_roughmap root_daum_roughmap_landing" style='width:1122px; margin:80px auto'></div>

                        <!-- 2. 설치 스크립트 -->
                        <script charset="UTF-8" class="daum_roughmap_loader_script" src="http://dmaps.daum.net/map_js_init/roughmapLoader.js"></script>

                        <!-- 3. 실행 스크립트 -->
                        <script charset="UTF-8">
                            new daum.roughmap.Lander({
                                "timestamp": "1489041316885",
                                "key": "gfxu",
                                "mapWidth": "1122",
                                "mapHeight": "500"
                            }).render();
                        </script>
                    </div>

                </div>
            </div>
            <!-- CONTENTS END -->

            <!-- FOOTER -->
            <%@ include file="../common/mainBottom.jsp" %>
            <!-- FOOTER END -->
        </div>
    </frameset>
    <script src='/resources/homepage/js/dev_sub.js'></script>

</body>

</html>