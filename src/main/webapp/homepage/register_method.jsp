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
    <title>Q learning - 교육안내 - 학습방법</title>

    <%@ include file="../common/commMainInclude.jsp" %>

    <link href='https://fonts.googleapis.com/css?family=Nanum+Gothic' rel='stylesheet'>
    <link rel='stylesheet' href='/resources/homepage/css/initialization.css'>
    <link rel='stylesheet' href='/resources/homepage/css/guidance/register_method.css'>
</head>

<body>
<frameset rows='*'>
    <div class='wrap'>
        <!-- PC HEADER -->
        <%@ include file="../common/mainTop.jsp" %>
        <!-- HEAD END -->

        <!-- CONTENTS -->
        <div class='contents_wrap process' onmouseover='sub_hide()'>
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
                            <p>교육안내</p>
                            <span>
                                <img src='/resources/homepage/img/course/arr_right.jpg' alt=' '>
                            </span>
                            <p>학습방법</p>
                        </div>
                    </div>
                    <h1>
                        교육<span>안내</span>
                    </h1>
                </div>
                <!-- Top END -->

                <div class='classroom_subtitle'>
                    <p class='subtitle'>학습방법</p>
                    <p>학습자, 강사, 운영자 모듈로 구성되어 있으며, 고객사에 맞는 교육관리시스템을 제공합니다.</p>
                </div>
                <div class='register_method_tab clear_fix'>
                    <button onclick='guide_change("pc", this)' class='on'>PC 러닝 학습가이드</button>
                    <button onclick='guide_change("mobile", this)'>모바일 러닝 학습가이드</button>
                </div>
                <div class='register_method_pc'>
                    <img src='/resources/homepage/img/guidance/pc.jpg' alt=' '>
                    <ol>
                        <li>
                            <div class='step_name'>
                                <p class='num'></p>
                                <p></p>
                            </div>
                            <span><img src='' alt=''></span>
                            <div class='step_note'>
                                <p class='name'></p>
                                <p></p>
                            </div>
                        </li>
                        <li>
                            <div class='step_name'>
                                <p class='num'></p>
                                <p></p>
                            </div>
                            <span><img src='' alt=''></span>
                            <div class='step_note'>
                                <p class='name'></p>
                                <p></p>
                            </div>
                        </li>
                        <li>
                            <div class='step_name'>
                                <p class='num'></p>
                                <p></p>
                            </div>
                            <span><img src='' alt=''></span>
                            <div class='step_note'>
                                <p class='name'></p>
                                <p></p>
                            </div>
                        </li>
                    </ol>
                </div>
                <div class='register_method_mobile'>
                    <img src='/resources/homepage/img/guidance/mobile.jpg' alt=' '>
                    <ol>
                        <li>
                            <div class='step_name'>
                                <p class='num'></p>
                                <p></p>
                            </div>
                            <span><img src='' alt=''></span>
                            <div class='step_note'>
                                <p class='name'></p>
                                <p></p>
                            </div>
                        </li>
                        <li>
                            <div class='step_name'>
                                <p class='num'></p>
                                <p></p>
                            </div>
                            <span><img src='' alt=''></span>
                            <div class='step_note'>
                                <p class='name'></p>
                                <p></p>
                            </div>
                        </li>
                    </ol>
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