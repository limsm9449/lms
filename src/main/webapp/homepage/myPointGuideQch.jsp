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
    <title>Q learning - 마이페이지 - 포인트</title>

    <%@ include file="../common/commMainInclude.jsp" %>

    <link href='https://fonts.googleapis.com/css?family=Nanum+Gothic' rel='stylesheet'>
    <link rel='stylesheet' href='/resources/homepageQch/css/initialization.css'>
    <link rel='stylesheet' href='/resources/homepageQch/css/mypage/mypage_main.css'>
    <link rel='stylesheet' href='/resources/homepageQch/css/mypage/mypage_table.css'>
    <link rel='stylesheet' href='/resources/homepageQch/css/mypage/mypage.css'>
</head>


<script type="text/javascript">

$(document).ready(function(){
	f_makePageNavigator("pagingLayer",${set.condiVO.pageNum},${set.totalCount},${set.condiVO.limitUnit});
});

</script>

<body>

<form id="frm" name="frm" method="post">
	
<frameset rows='*'>
    <div class='wrap'>
        <!-- HEAD -->
        <%@ include file="../common/mainTopQch.jsp" %>
        <!-- HEAD END -->

        <!-- CONTENTS -->
        <div class='contents_wrap process'>
            <!-- QUICK MENU -->
            <%@ include file="../common/mainQuickMenuQch.jsp" %>
            
            <div class='contents_wrap_box'>
                <!-- Top -->
                <div class='top_area'>
                    <div class='clear_fix'>
                        <div class='process_history_box clear_fix'>
                            <span>
                                <img src='/resources/homepageQch/img/course/ic_home.jpg' alt=' '>
                            </span>
                            <p>HOME</p>
                            <span>
                                <img src='/resources/homepageQch/img/course/arr_right.jpg' alt=' '>
                            </span>
                            <p>마이페이지</p>
                            
                        </div>
                    </div>
                    <h1>
                        <span>마이</span>페이지
                    </h1>
                </div>
                <!-- Top END -->

                <div class='classroom_subtitle'>
                </div>

                <!-- TAB AREA -->
                <div class='register_method_tab clear_fix'>
                    <a href='javascript:' onclick="page.goPage('/main/myOrder');"><button id="g1">주문/신청 <span></span>조회</button></a>
                    <a href='javascript:'><button id="point_2" class="on">포인트<span></span></button></a>
                    <a href='javascript:' onclick="page.goPage('/main/myActivity');"><button>나의 <span></span>활동관리</button></a>
                    <a href="javascript:" onclick="page.goPage('/member/userMemberU');"><button>회원<span></span>정보수정</button></a>
                    <a href="javascript:" onclick="page.goPage('/member/memberChangePassword');"><button>비밀번호 <span></span>변경</button></a>
                </div>

                <!-- REGISTER PC VERSION -->
                <div class='register_method_pc1'>
                    <!-- <img src='../../img/notice/pc.jpg' alt=' '> -->
                    <ol>
                        <div class="title_point">
                        	포인트 정책<br>Point Guide
                        </div>
                        <div class="content_point">
                        	<li>① “큐러닝”은 “회원”의 구매활동, 이벤트 참여, 리뷰 작성 등에 따라 “회원”에게 일정한 “적립금”을 부여할 수 있습니다.</li>
                            <li>② “회원”은 “적립금”을 “사이트”에서 “강의 등”의 구매 시 결제 수단으로 사용할 수 있으며, “큐러닝”은 “적립금”의 적립기준, 사용방법, 사용기한 및 제한에 대한 사항을 “서비스”화면에 별도로 게시하거나 통지합니다. “적립금”의 사용조건에 관한 사항은 “큐러닝”의 정책에 따라 달라질 수 있습니다.</li>
                            <li>③ “적립금”의 유효기간은 원칙적으로 적립 후 1년이며, 유효기간 동안 사용하지 않을 경우 순차적으로 소멸됩니다. 다만, 마케팅 및 기타 프로모션 등을 통해 지급되거나 사전특약(사전 안내 포함)이 있는 “적립금”의 유효기간은 각각 별도로 설정될 수 있습니다.</li>
                            <li>④ “적립금”은 현금으로 환급될 수 없으며, “적립금”의 사용 기간이 만료되거나 이용계약이 종료되면 소멸됩니다.</li>
                            <li>⑤ “회원”은 “적립금”을 제3자에게 또는 다른 아이디로 양도할 수 없으며, 유상으로 거래하거나 현금으로 전환할 수 없습니다. </li>
                            <li>⑥ “큐러닝”은 “회원”이 “큐러닝”이 승인하지 않은 방법으로 “적립금”을 획득하거나 부정한 목적이나 용도로 “적립금”을 사용하는 경우 “적립금”의 사용을 제한하거나 “적립금”을 사용한 구매신청을 취소하거나 “회원” 자격을 정지할 수 있습니다.</li>
                            <li>⑦ “회원탈퇴” 시 적립된 “적립금” 중 미사용한 “적립금”은 즉시 소멸되며, 탈퇴 후 재가입하더라도 소멸된 “적립금”은 복구되지 아니합니다. </li>
                        </div>
                        <!-- Contents -->
                    
					<!-- Search Result Area -->
            	</div>
        </div>
        <!-- CONTENTS END -->

        <!-- FOOTER -->
        <%@ include file="../common/mainBottomQch.jsp" %>
        <!-- FOOTER END -->
    </div>
</frameset>

</form>

<script src='/resources/homepageQch/js/main.js'></script>


</body>
</html>