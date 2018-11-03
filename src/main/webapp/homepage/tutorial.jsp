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
    <title>Q learning - 교육 안내</title>
    
    <%@ include file="../common/commMainInclude.jsp" %>

    <link href='https://fonts.googleapis.com/css?family=Nanum+Gothic' rel='stylesheet'>
    <link rel='stylesheet' href='/resources/homepage/css/initialization.css'>
    <link rel='stylesheet' href='/resources/homepage/css/guidance/tutorial.css'>
</head>

<script type="text/javascript">
$(document).ready(function() {
	<c:if test="${!empty set.condiVO.shap}">	      	
		window.scroll(0, $("#${set.condiVO.shap}").offset().top);
	</c:if>
});
</script>

 
 
<body>
    <frameset rows='*'>
        <div class='wrap'>
            <!-- PC HEADER -->
            <%@ include file="../common/mainTop.jsp" %>
            <!-- HEAD END -->

            <!-- CONTENTS -->
            <div class='contents_wrap tutorial' onmouseover='sub_hide()'>
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
                            </div>
                        </div>
                        <h1>
                            교육<span>안내</span>
                        </h1>
                    </div>
                    <!-- Top END -->

                    <!-- Tutorial Guide -->
                    <div class='tutorial_btn_wrap'>
                        <div class='tutorial_btn_box clear_fix'>
                            <p>처음 오셨나요? 이용가이드를 확인해주세요.</p>
                            <button class='tutorial_btn'>
                                <div><img src='/resources/homepage/img/guidance/ic_1.png' alt=' '></div>
                                <p class='tutorial_btn_title'>처음이신가요?</p>
                                <p>
                                    큐러닝 이용이 처음이신가요?<span></span>초심자도 쉽게 이해할 수 있는<span></span>이용 가이드 입니다.
                                </p>
                            </button>
                            <button class='tutorial_btn mobile_right'>
                                <div><img src='/resources/homepage/img/guidance/ic_2.png' alt=' '></div>
                                <p class='tutorial_btn_title'>수강신청</p>
                                <p>
                                    수강신청에 대해 쉽게 이해할<span></span>수 있는 신청 가이드입니다.
                                </p>
                            </button>
                            <button class='tutorial_btn'>
                                <div><img src='/resources/homepage/img/guidance/ic_3.png' alt=' '></div>
                                <p class='tutorial_btn_title'>학습안내</p>
                                <p>
                                    효과적인 학습을 위한 방법을<span></span>안내해 드립니다.
                                </p>
                            </button>
                            <button class='tutorial_btn last_right'>
                                <div><img src='/resources/homepage/img/guidance/ic_4.png' alt=' '></div>
                                <p class='tutorial_btn_title'>수료안내</p>
                                <p>
                                    학습 수료를 통해 수료증을<span></span>발급받을 수 있습니다.
                                </p>
                            </button>
                        </div>
                    </div>

                    <!-- Tutorial download -->
                    <div class='tutorial_download clear_fix' id='quick_to'>
                        <div>
                            <p class='tutorial_download_title'>
                                학습에 <span></span>도움이 되는 <span></span>프로그램
                            </p>
                            <p>
                                강의에 필요한 프로그램을<span></span>다운 받을 수 있습니다.
                            </p>
                        </div>
                        <ul class='tutorial_download_list clear_fix'>
                            <li>
                                <div class='tutorial_download_image'><img src='/resources/homepage/img/guidance/download_1.jpg' alt=''></div>
                                <div class='tutorial_download_text clear_fix'>
                                    <p class='tutorial_download_name'>Flash player</p>
                                    <p>
                                        플래시가 브라우저에서 실행되기 위한 <span></span>ActiveX Plug-in 입니다.
                                    </p>
                                    <a href='https://get.adobe.com/flashplayer/?loc=kr' target='_blank'>다운로드</a>
                                </div>
                            </li>
                            <li class='even'>
                                <div class='tutorial_download_image'><img src='/resources/homepage/img/guidance/download_2.jpg' alt=''></div>
                                <div class='tutorial_download_text clear_fix'>
                                    <p class='tutorial_download_name double_line'>윈도우즈 미디어 플레이어(v11-xp)</p>
                                    <p>
                                        샘플 강의 재생 시 <span></span>(OS가 정품일 경우 설치가능)
                                    </p>
                                    <a href='https://www.microsoft.com/ko-kr/download/windows-media-player-details.aspx' target='_blank'>다운로드</a>
                                </div>
                            </li>
                            <li>
                                <div class='tutorial_download_image'><img src='/resources/homepage/img/guidance/download_3.jpg' alt=''></div>
                                <div class='tutorial_download_text clear_fix'>
                                    <p class='tutorial_download_name'>익스플로러 8.0</p>
                                    <p>
                                        익스플로러 오류 날 때 <span></span>재설치합니다.
                                    </p>
                                    <a href='https://www.microsoft.com/ko-kr/download/internet-explorer-8-details.aspx' target='_blank'>다운로드</a>
                                </div>
                            </li>
                            <li class='even'>
                                <div class='tutorial_download_image'><img src='/resources/homepage/img/guidance/download_4.jpg' alt=''></div>
                                <div class='tutorial_download_text clear_fix'>
                                    <p class='tutorial_download_name'>익스플로러 9.0</p>
                                    <p>
                                        익스플로러 오류 날 때 <span></span>재설치합니다.
                                    </p>
                                    <a href='https://www.microsoft.com/ko-kr/download/internet-explorer-9-details.aspx' target='_blank'>다운로드</a>
                                </div>
                            </li>
                            <li>
                                <div class='tutorial_download_image'><img src='/resources/homepage/img/guidance/download_5.jpg' alt=''></div>
                                <div class='tutorial_download_text clear_fix'>
                                    <p class='tutorial_download_name'>크롬 브라우저</p>
                                    <p>
                                        플레이어 원활한 이용에 <span></span>필요합니다.
                                    </p>
                                    <a href='https://www.google.com/intl/ko_ALL/chrome/' target='_blank'>다운로드</a>
                                </div>
                            </li>
                            <li class='even'>
                                <div class='tutorial_download_image'><img src='/resources/homepage/img/guidance/download_6.jpg' alt=''></div>
                                <div class='tutorial_download_text clear_fix'>
                                    <p class='tutorial_download_name'>Acrobat Reader</p>
                                    <p>
                                        강의 노트(PDF 문서)를 볼 때 <span></span>필요합니다.
                                    </p>
                                    <a href='https://get.adobe.com/reader/?loc=kr' target='_blank'>다운로드</a>
                                </div>
                            </li>
                        </ul>
                    </div>

                </div>
            </div>
            <!-- CONTENTS END -->

            <!-- FOOTER -->
            <%@ include file="../common/mainBottom.jsp" %>
            <!-- FOOTER END -->
        </div>
    </frameset>
    <script src='/resources/homepage/js/dev_sub.js?timestamp=<%=timestamp%>'></script>
</body>

</html>