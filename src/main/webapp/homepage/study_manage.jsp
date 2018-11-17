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
    <title>Q learning - 교육안내 - 학습관리</title>

    <%@ include file="../common/commMainInclude.jsp" %>
    
    <link href='https://fonts.googleapis.com/css?family=Nanum+Gothic' rel='stylesheet'>
    <link rel='stylesheet' href='/resources/homepage/css/initialization.css'>
    <link rel='stylesheet' href='/resources/homepage/css/guidance/study_manage.css'>
</head>

<body>
<frameset rows='*'>
    <div class='wrap'>
        <!-- PC HEADER -->
        <%@ include file="../common/mainTop.jsp" %>
        <!-- HEAD END -->

        <!-- CONTENTS -->
        <div class='contents_wrap process' >
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
                            <p>학습관리</p>
                        </div>
                    </div>
                    <h1>
                        교육<span>안내</span>
                    </h1>
                </div>
                <!-- Top END -->

                <div class='classroom_subtitle'>
                    <p class='subtitle'>학습관리</p>
                    <p>큐러닝은 학습자를 위한 차별화된 맞춤형 서비스를 제공하여 학습성취도가 향상되도록 노력하고 있습니다.</p>
                </div>
            </div>
        </div>   
        <div class='study_method_activity'>
            <div class='sub_title'>
                <p>학습관리 안내</p>
            </div>
            <div class='study_manage_text'>
                <p>
                    큐러닝은 학습자의 만족도를 높이기 위해서 <span></span>차별화된 맞춤형 서비스를 제공하여 <span></span>학습성취도가 향상되도록 <span></span>노력하고 있습니다.
                </p>
                <p class='name'>큐러닝의 학습자 중심 접근교육</p>
            </div>
        </div>
        <div class='study_method_func'>
            <ul>
                <li class='function_list clear_fix'>
                    <span>
                        <img src='/resources/homepage/img/guidance/mng_ic1.png' alt=' '>
                    </span>
                    <p class='title mobile_right'>양질의 콘텐츠 제공</p>
                    <p>지속적인 R&D활동의 일환으로 큐러닝의 <span></span>독창적인 개발방법론에 기반한 <span></span>맞춤형 콘텐츠 개발</p>
                </li>
                <li class='function_list clear_fix right'>
                    <p class='title'>맞춤 서비스 제공</p>
                    <span>
                        <img src='/resources/homepage/img/guidance/mng_ic2.png' alt=' '>
                    </span>
                    <p>오프라인 교육의 진단, 컨설팅, 개발 및 운영 피드백에 <span></span>이르는 Total HR Solution 제공 <span></span>고객사 실정에 꼭 필요한 교육 개발 및 커스터 마이징을 <span></span>통한 자체 프로그램 운영</p>
                </li>
                <li class='function_list clear_fix bottom'>
                    <span>
                        <img src='/resources/homepage/img/guidance/mng_ic3.png' alt=' '>
                    </span>
                    <p class='title mobile_right'>체계화된 <span></span>학습현황 관리</p>
                    <p class='mg_r'>체계적인 요구분석으로 최적의 러닝 솔루션 도출 <span></span>교육 전/중/후 총체적인 학습 경험 제공을 통한 성과향상 보장 <span></span>교육 후 실제 성과를 평가하기 위한 가치 측정 및 개선 실시</p>
                </li>
                <li class='function_list clear_fix right bottom'>
                    <p class='title'>알기쉬운 교육안내, <span></span>고객지원 서비스</p>
                    <span>
                        <img src='/resources/homepage/img/guidance/mng_ic4.png' alt=' '>
                    </span>
                    <p>수강신청, 학습안내, 학습상담 등 고객에게 <span></span>보다 빠르고 간편하며 원활한 고객지원 <span></span>활동 제공</p>
                </li>
            </ul>
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