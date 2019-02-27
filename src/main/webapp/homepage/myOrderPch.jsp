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
    <title>Q learning - 마이페이지 - 주문/신청 조회</title>

    <%@ include file="../common/commMainInclude.jsp" %>

    <link href='https://fonts.googleapis.com/css?family=Nanum+Gothic' rel='stylesheet'>
    <link rel='stylesheet' href='/resources/homepagePch/css/initialization.css'>
    <link rel='stylesheet' href='/resources/homepagePch/css/mypage/mypage_main.css'>
    <link rel='stylesheet' href='/resources/homepagePch/css/mypage/mypage_table.css'>
    <link rel='stylesheet' href='/resources/homepagePch/css/mypage/mypage.css'>
</head>


<script type="text/javascript">

$(document).ready(function(){
	f_makePageNavigator("pagingLayer",${set.condiVO.pageNum},${set.totalCount},${set.condiVO.limitUnit},${set.pageCnt});
});

</script>

<body>

<form id="frm" name="frm" method="post">
	
<frameset rows='*'>
    <div class='wrap'>
        <!-- HEAD -->
        <%@ include file="../common/mainTopPch.jsp" %>
        <!-- HEAD END -->

        <!-- CONTENTS -->
        <div class='contents_wrap process'>
            <!-- QUICK MENU -->
            <%@ include file="../common/mainQuickMenuPch.jsp" %>
            
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
                    <a href='javascript:'><button id="g1" class="on">주문/신청 <span></span>조회</button></a>
                    <a href='javascript:' onclick="page.goPage('/main/myPoint');"><button id="point_2">포인트<span></span></button></a>
                    <a href='javascript:' onclick="page.goPage('/main/myActivity');"><button>나의 <span></span>활동관리</button></a>
                    <a href="javascript:" onclick="page.goPage('/member/userMemberU');"><button>회원<span></span>정보수정</button></a>
                    <a href="javascript:" onclick="page.goPage('/member/memberChangePassword');"><button>비밀번호 <span></span>변경</button></a>
                </div>

                <!-- REGISTER PC VERSION -->
                <div class='register_method_pc1'>
                    <!-- <img src='../../img/notice/pc.jpg' alt=' '> -->
                    <ol>
                        
                        <!-- Contents -->
                    <div class='notice_search_box'>
                    	<div class="day_btn">
                            <button class="day_btn_chk <c:if test="${set.condiVO.searchMonth eq '3'}">btn_on</c:if>" onclick="page.goPage('/main/myOrder','searchMonth=3');">3개월</button>
                            <button class="day_btn_chk <c:if test="${set.condiVO.searchMonth eq '6'}">btn_on</c:if>" onclick="page.goPage('/main/myOrder','searchMonth=6');">6개월</button>
                            <button class="day_btn_chk <c:if test="${set.condiVO.searchMonth eq '9'}">btn_on</c:if>" onclick="page.goPage('/main/myOrder','searchMonth=9');">9개월</button>
                            <button class="day_btn_chk <c:if test="${set.condiVO.searchMonth eq '12'}">btn_on</c:if>" onclick="page.goPage('/main/myOrder','searchMonth=12');">12개월</button>
                            <button class="day_btn_chk <c:if test="${set.condiVO.searchMonth eq ''}">btn_on</c:if>" onclick="page.goPage('/main/myOrder','searchMonth=all');">전체</button>
                        </div>
                        
                    </div>
					<!-- Search Result Area -->
                    <table class="my_table">
                    	<tr class="my_table_top">
                        	<td class="my_table_top_1">과정명</td>
                            <td class="my_table_top_2">결제일자</td>
                            <td class="my_table_top_3">결제금액</td>
                            <td class="my_table_top_4">결제수단</td>
                            <td class="my_table_top_5">결제상태</td>
                            <td class="my_table_top_6">영수증</td>
                        </tr>
<c:if test="${empty set.myOrderList}">
						<tr class="last_line">
							<td colspan="6" class="last center" style="border-right:none"><spring:message code="lms.msg.noSearchData" text="-" /></td>
						</tr>
</c:if>                             
<c:forEach var="row" items="${set.myOrderList}" varStatus="idx">
                        <tr>
                        	<td class="my_table_mid_1">
                                <div class='process_result_text'>
                                    <div class='process_result_text_top clear_fix'>
                                        <p>일반</p>
	<c:if test="${row.mobileYn eq 'Y'}">	                                        
                                        <p class='process_result_mobile'>모바일</p>
	</c:if>                                        
                                    </div>
                                    <p>${row.courseName}</p>
                                    <div class='process_result_text_bottom clear_fix'>
                                        <p>교육기간</p>
                                        <p class='process_result_payment'>${row.cFromDate} ~ ${row.cToDate} (${row.cPeriod}일)</p>
                                    </div>
                                </div>
                            </td>
                            <td class="my_table_mid_2">${row.paymentDate}</td>
                            <td class="my_table_mid_3"><fmt:formatNumber value="${row.courseCost}" type="number"/> 원</td>
                            <td class="my_table_mid_4">${row.paymentKindName}</td>
                            <td class="my_table_mid_5">${row.statusName}</td>
                            <td class="my_table_mid_6">
                            	<div class='process_result_btn con'>
	<c:if test="${row.status eq 'A'}">	                                        
                                    <button class='process_result_admission' onclick="javascript:Popup.showReceipt('${row.courseId}'); return false;">발급</button>
	</c:if>                                        
	<c:if test="${row.status ne 'A'}">	                                        
                                    <button class='process_result_admission'>-</button>
	</c:if>                                        
                                </div>
                            </td>
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
        <%@ include file="../common/mainBottomPch.jsp" %>
        <!-- FOOTER END -->
    </div>
</frameset>

</form>

<script src='/resources/homepagePch/js/main.js'></script>


</body>
</html>