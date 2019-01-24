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
    <title>Q learning - 나의강의실 - 장바구니 - 상품결제결과</title>

    <%@ include file="../common/commMainInclude.jsp" %>

    <link href='https://fonts.googleapis.com/css?family=Nanum+Gothic' rel='stylesheet'>
    <link rel='stylesheet' href='/resources/homepageQch/css/initialization.css'>
    <link rel='stylesheet' href='/resources/homepageQch/css/mypage/basket.css'>
    <link rel='stylesheet' href='/resources/homepageQch/css/mypage/mypage.css'>

    <style>
        html{
            overflow-y:hidden;
        }
    </style>
</head>

<body style='background:#fff'>
<frameset rows='*'>
    <div class='wrap'>
        <!-- CONTENTS -->
        <div class='contents_wrap process'>
            <div class='contents_wrap_box popup'>
                <div class='basket_completed_popup'>
                    <div class='title clear_fix'>
                        <p>영수증<span class="span_txt">(공급받는자용)</span></p>
                    </div>
                    <div class='basket_popup_contents'>
                        <table class="print_table">
                            <tr class="print_table_top">
                                <td class="print_table_title print_t1" rowspan="4">공<br><br>급<br><br>자</td>
                                <td class="print_table_title print_t2">사업자 등록 번호</td>
                                <td class="print_table_content print_t3">119-81-78776</td>
                            </tr>
                            <tr class="print_table_top">
                                <td class="print_table_title">상호</td>
                                <td class="print_table_content">㈜큐피플</td>
                            </tr>
                            <tr class="print_table_top">
                                <td class="print_table_title">사업자 소재시</td>
                                <td class="print_table_content">서울특별시 금천구 가산디지털1로 145, 4층 410, 411호(가산동, 에이스하이엔드타워3차)</td>
                            </tr>
                            <tr class="print_table_top">
                                <td class="print_table_title">업태</td>
                                <td class="print_table_content">서비스(교육)업</td>
                            </tr>
                    	</table>
                        
                        
                        <table class="print_table2">
                            <tr class="print_table2_top">
                                <td class="print_table2_title print_t1" rowspan="4">공<br><br>급<br><br>받<br><br>는<br><br>자</td>
                                <td class="print_table2_title print_t2">성명</td>
                                <td class="print_table2_content print_t3">${set.dataHm.USER_NAME}</td>
                            </tr>
                            <tr class="print_table2_top">
                                <td class="print_table2_title">결제 내역</td>
                                <td class="print_table2_content">${set.dataHm.COURSE_NAME}</td>
                            </tr>
                            <tr class="print_table2_top">
                                <td class="print_table2_title">결제 금액</td>
                                <td class="print_table2_content"><fmt:formatNumber value="${set.dataHm.COURSE_COST}" type="number"/> 원</td>
                            </tr>
                            <tr class="print_table2_top">
                                <td class="print_table2_title">결제 일자</td>
                                <td class="print_table2_content">${set.dataHm.CONFIRM_DATE}</td>
                            </tr>
                    	</table>
                    
                        <p>* 위 금액을 정희 영수하였습니다. </p>
                    </div>
                </div>

            </div>
        </div>
        <!-- CONTENTS END -->
    </div>
</frameset>
<script src='/resources/homepageQch/js/sub.js'></script>

</body>
</html>