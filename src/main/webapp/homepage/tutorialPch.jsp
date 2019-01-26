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
    <link rel='stylesheet' href='/resources/homepagePch/css/initialization.css'>
    <link rel='stylesheet' href='/resources/homepagePch/css/notice/notice_main.css'>
    <link rel='stylesheet' href='/resources/homepagePch/css/notice/notice.css'>
</head>

<script type="text/javascript">
$(document).ready(function() {
	<c:if test="${!empty set.condiVO.shap}">	      	
		gfn_goScreenPosition("${set.condiVO.shap}");
	</c:if>
});
</script>

 
 
<body>
<frameset rows='*'>
    <div class='wrap'>
        <!-- HEAD START -->
        <%@ include file="../common/mainTopPch.jsp" %>
        <!-- HEAD END -->

        <!-- CONTENTS -->
        <div class='contents_wrap process'>
            <!-- QUICK MENU -->
       	 	<%@ include file="../common/mainQuickMenuPch.jsp" %>
       	 	<!-- QUICK MENU -->


            <div class='contents_wrap_box'>

                <!-- Top -->
                <div class='top_area'>
                    <div class='clear_fix'>
                        <div class='process_history_box clear_fix'>
                            <span>
                                <img src='/resources/homepagePch/img/course/ic_home.jpg' alt=' '>
                            </span>
                            <p>HOME</p>
                            <span>
                                <img src='/resources/homepagePch/img/course/arr_right.jpg' alt=' '>
                            </span>
                            <p>고객지원</p>
                            
                        </div>
                    </div>
                    <h1>
                        고객<span>지원</span>
                    </h1>
                </div>
                <!-- Top END -->

                <div class='classroom_subtitle'>
                </div>

                <!-- TAB AREA -->
                <div class='register_method_tab clear_fix'>
                    <a href="javascript:" onclick="page.goPage('/main/noticeList');"><button id="g1">공지<span></span>사항</button></a>
                    <a href="javascript:" onclick="page.goPage('/main/faqList');"><button>자주 <span></span>묻는 질문</button></a>
                    <a href="javascript:" onclick="page.goPage('/main/mailQuestion');"><button>1:1 <span></span>메일문의</button></a>
                    <a href="javascript:"><button class="on">학습<span></span>지원</button></a>
                    <a href="javascript:" onclick="page.goPage('/guest/bankInfo');"><button>입금계좌<span></span>안내</button></a>
                </div>
                
                <!-- REGISTER PC VERSION -->
                <div class='register_method_pc4'>
                    <!-- <img src='/resources/homepagePch/img/notice/pc.jpg' alt=' '> -->
                    <ol>
                        <li class='pc_list_item'>
                         <h1 class="two_h1">
                            학습<span class="two_h1_span">지원</span>
                        	</h1>
                        <div class='top_text_box clear_fix'>
                        <span><img src='/resources/homepagePch/img/notice/notice1_bg.png' alt=' '></span>
                            <p class='top_title' id="top_t1">Learning support</p>
                            <p>
                                강의에 필요한 프로그램과 원격지원 서비스를 알려 드립니다.
                            </p>
                        </div>
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
                                <div class='tutorial_download_image'><img src='/resources/homepagePch/img/notice/download_1.jpg' alt=''></div>
                                <div class='tutorial_download_text clear_fix'>
                                    <p class='tutorial_download_name'>Flash player</p>
                                    <p>
                                        플래시가 브라우저에서 실행되기 위한 <span></span>ActiveX Plug-in 입니다.
                                    </p>
                                    <a href='https://get.adobe.com/flashplayer/?loc=kr' target='_blank'>다운로드</a>
                                </div>
                            </li>
                            <li class='even'>
                                <div class='tutorial_download_image'><img src='/resources/homepagePch/img/notice/download_2.jpg' alt=''></div>
                                <div class='tutorial_download_text clear_fix'>
                                    <p class='tutorial_download_name double_line'>윈도우즈 미디어 플레이어(v11-xp)</p>
                                    <p>
                                        샘플 강의 재생 시 <span></span>(OS가 정품일 경우 설치가능)
                                    </p>
                                    <a href='https://www.microsoft.com/ko-kr/download/windows-media-player-details.aspx' target='_blank'>다운로드</a>
                                </div>
                            </li>
                            <li>
                                <div class='tutorial_download_image'><img src='/resources/homepagePch/img/notice/download_3.jpg' alt=''></div>
                                <div class='tutorial_download_text clear_fix'>
                                    <p class='tutorial_download_name'>익스플로러 8.0</p>
                                    <p>
                                        익스플로러 오류 날 때 <span></span>재설치합니다.
                                    </p>
                                    <a href='https://www.microsoft.com/ko-kr/download/internet-explorer-8-details.aspx' target='_blank'>다운로드</a>
                                </div>
                            </li>
                            <li class='even'>
                                <div class='tutorial_download_image'><img src='/resources/homepagePch/img/notice/download_4.jpg' alt=''></div>
                                <div class='tutorial_download_text clear_fix'>
                                    <p class='tutorial_download_name'>익스플로러 9.0</p>
                                    <p>
                                        익스플로러 오류 날 때 <span></span>재설치합니다.
                                    </p>
                                    <a href='https://www.microsoft.com/ko-kr/download/internet-explorer-9-details.aspx' target='_blank'>다운로드</a>
                                </div>
                            </li>
                            <li>
                                <div class='tutorial_download_image'><img src='/resources/homepagePch/img/notice/download_5.jpg' alt=''></div>
                                <div class='tutorial_download_text clear_fix'>
                                    <p class='tutorial_download_name'>크롬 브라우저</p>
                                    <p>
                                        플레이어 원활한 이용에 <span></span>필요합니다.
                                    </p>
                                    <a href='https://www.google.com/intl/ko_ALL/chrome/' target='_blank'>다운로드</a>
                                </div>
                            </li>
                            <li class='even'>
                                <div class='tutorial_download_image'><img src='/resources/homepagePch/img/notice/download_6.jpg' alt=''></div>
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
                    <div class="support_remote_service clear_fix">
                        <div class="support_remote_text">
                            <p class='support_remote_title'>
                                PC <span></span>원격지원 서비스
                            </p>
                            <p>
                                전화상담만으로 해결이 <span></span>어려운 경우, 전문 상담원이 <span></span>직접 PC 화면을 컨트롤해 <span></span>문제를
                                해결해 드립니다.
                            </p>
                            <div class='support_text_btn_box clear_fix'>
                                <button onclick="alert('작업중입니다.');">신청하기</button>
                                <button onclick="alert('작업중입니다.');" class='last_right'>연결하기</button>
                            </div>
                        </div>
                        <div class="support_remote_step">
                            <ol class='support_step_list clear_fix'>
                                <li>
                                    <p class='support_step_list_title'>
                                        Step 1.
                                        <strong>신청하기</strong>
                                    </p>
                                    <p>
                                        버튼을 통해 <span></span>신청서 작성
                                    </p>
                                </li>
                                <li class='mobile_last_right'>
                                    <p class='support_step_list_title'>
                                        Step 2.
                                        <strong>전화연결</strong>
                                    </p>
                                    <p>
                                        신청 접수 후 큐러닝 <span></span>콜센터에서 전화연결
                                    </p>
                                </li>
                                <li>
                                    <p class='support_step_list_title'>
                                        Step 3.
                                        <strong>PC 연결</strong>
                                    </p>
                                    <p>
                                        상담원과 시간 협의 후 <span></span>지정시간에 연결
                                    </p>
                                </li>
                                <li class='last_right'>
                                    <p class='support_step_list_title'>
                                        Step 4.
                                        <strong>진단 및 해결</strong>
                                    </p>
                                    <p>
                                        상담원과 통화 후 <span></span>문제 진단 및 해결
                                    </p>
                                </li>
                            </ol>
                            <ul class='support_step_text_list'>
                                <li>
                                    <p>* PC에 설치되어 있는 방화벽, 보안 프로그램 등에 의해 원격지원 서비스가 불가한 경우도 있습니다.</p>
                                </li>
                                <li>
                                    <p>* 공공장소의 PC는 원격제어에 제한이 있을 수 있습니다.</p>
                                </li>
                                <li>
                                    <p>* PC 원격지원 운영시간: 평일 09:00 ~ 20:30(화, 목 운영 / 주말 및 공휴일은 휴무)</p>
                                </li>
                            </ul>
                        </div>
                    </div>
                        <!-- Contents -->
                    
                    <!-- Contents END -->
                        </li>
                    </ol>
                </div>
                
                
            </div>
        </div>
        <!-- CONTENTS END -->

        <!-- FOOTER -->
        <%@ include file="../common/mainBottomPch.jsp" %>
        <!-- FOOTER END -->
    </div>
</frameset>
<script src='/resources/homepagePch/js/main.js'></script>

</body>

</html>