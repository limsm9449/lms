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
                        <div class="t_point">
                        	사용 가능한 포인트
                        </div>
                        <div class="t_point2">
                        	<a class="plus"><fmt:formatNumber value="${set.myPointInfo.REMAIN_POINT}" type="number"/></a> Point
                        </div>
                        <div class="t_point">
                        	1개월 이내 소멸 예정포인트
                        </div>
                        <div class="t_point2">
                        	<a class="plus"><fmt:formatNumber value="${set.myPointInfo.DELETE_POINT}" type="number"/></a> Point
                        </div>
                        <div class="s_point">
                        	<ul>
                        		<li>포인트는 <a class="plus">5,000P</a> 이상인 경우 1,000P 단위로 현금처럼 사용이 가능합니다.</li>
                            	<li>적립일로부터 <a class="plus">포인트별 유효기간</a>이 지난 후에는 자동 소멸되므로, 기간 내에 사용하셔야 합니다. </li>
                             </ul>
                             <button class="s_point_btn" onclick="page.goPage('/main/myPointGuide');"">포인트 정책 전문보기</button>
                        </div>
                        <!-- Contents -->
                    <div class='notice_search_box'>
                    	
                    	<div class="day_btn">
                            <button class="day_btn_chk <c:if test="${set.condiVO.searchMonth eq '3'}">btn_on</c:if>" onclick="page.goPage('/main/myPoint','searchMonth=3');">3개월</button>
                            <button class="day_btn_chk <c:if test="${set.condiVO.searchMonth eq '6'}">btn_on</c:if>" onclick="page.goPage('/main/myPoint','searchMonth=6');">6개월</button>
                            <button class="day_btn_chk <c:if test="${set.condiVO.searchMonth eq '9'}">btn_on</c:if>" onclick="page.goPage('/main/myPoint','searchMonth=9');">9개월</button>
                            <button class="day_btn_chk <c:if test="${set.condiVO.searchMonth eq '12'}">btn_on</c:if>" onclick="page.goPage('/main/myPoint','searchMonth=12');">12개월</button>
                            <button class="day_btn_chk <c:if test="${set.condiVO.searchMonth eq ''}">btn_on</c:if>" onclick="page.goPage('/main/myPoint','searchMonth=all');">전체</button>
                        </div>                        
                    </div>
					<!-- Search Result Area -->
                    <table class="point_table">
                    	<tr class="point_table_top">
                        	<td class="point_table_top_1">적립/사용일자</td>
                            <td class="point_table_top_2">적립/사용내역</td>
                            <td class="point_table_top_3">포인트내역</td>
                            <td class="point_table_top_4">유효기간</td>
                        </tr>
<c:if test="${empty set.myPointList}">
						<tr class="last_line">
							<td colspan="4" class="last center" style="border-right:none"><spring:message code="lms.msg.noSearchData" text="-" /></td>
						</tr>
</c:if> <c:forEach var="row" items="${set.myPointList}" varStatus="idx">
                        <tr>
                        	<td class="point_table_date">${row.POINT_DATE_STR}</td>
                            <td class="point_table_tilte first_line">[${row.POINT_NAME}] ${row.COURSE_NAME}</td>
	<c:if test="${row.POINT ge 0}">	                            
                            <td class="plus first_line" id="point_table_point"><fmt:formatNumber value="${row.POINT}" type="number"/> P</td>
	</c:if>                            
	<c:if test="${row.POINT lt 0}">	                            
                            <td class="minus" id="point_table_point"><fmt:formatNumber value="${row.POINT}" type="number"/> P</td>
	</c:if>                            
                            <td class="point_table_date">${row.VALID_DATE_STR}</td>
                        </tr>
</c:forEach>                 
                    </table>
                    <!-- Search Result Area END -->

                    <!-- Pager Area -->
                    <input type='hidden' id='pageNum' name='pageNum' value="${set.condiVO.pageNum}">
		            <div class='pager_box'>
	                    <div class='pager clear_fix'>
	                        <div class='pager_prev clear_fix' id="pagingLayerPrev"></div>
	                        <ul class='clear_fix' id="pagingLayer"></ul>
	                        <div class='pager_next clear_fix' id="pagingLayerNext"></div>
	                    </div>
	                </div>
                
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