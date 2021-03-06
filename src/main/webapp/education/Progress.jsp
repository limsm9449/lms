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
    <title>Q learning - 진도상세</title>

    <%@ include file="../common/commMainInclude.jsp" %>

    <link href='https://fonts.googleapis.com/css?family=Nanum+Gothic' rel='stylesheet'>
    <link rel='stylesheet' href='/resources/homepage/css/initialization.css'>
    <link rel='stylesheet' href='/resources/homepage/css/classroom/lecture_detail.css'>
</head>

<body style='background:#fff'>
<frameset rows='*'>
    <div class='wrap'>
        <!-- CONTENTS -->
        <div class='contents_wrap process'>
            <div class='contents_wrap_box popup'>
                <!-- TOP -->
                <div class='top_area'>
                    <h1>
                        진도<span>상세</span>
                    </h1>
                    <div class='top_text_box clear_fix'>
                        <span><img src='/resources/homepage/img/support/notice_bg.jpg' alt=' '></span>
                        <p class='top_title'>Progress</p>
                        <p>
                            현재 과정의 진도를 자세하게 확인할 수 있습니다.
                        </p>
                    </div>
                </div>
                <!-- TOP END -->

                <div class='lecture_detail_table_box score'>
                    <table>
                        <tr>
                            <th class='col_1'>레포트 점수(${set.evaluation.reportRate})</th>
                            <th class='col_2'>평가 점수(${set.evaluation.examRate})</th>
                            <th class='col_3'>토론 점수(${set.evaluation.discussionRate})</th>
                            <th class='col_4'>강의진도 점수(${set.evaluation.progressRate})</th>
                            <th class='col_5'>합계 점수</th>
                        </tr>
                        <tr>
                            <td class="col_1">${set.evaluation.reportCalc}</td>
							<td class="col_2">${set.evaluation.examCalc}</td>
							<td class="col_3">${set.evaluation.discussionCalc}</td>
							<td class="col_4">${set.evaluation.progressCalc}</td>
							<td class="col_5">${set.evaluation.total}</td>
                        </tr>
                    </table>
                </div>

                <div class='lecture_detail_table_box score'>
                    <table>
                        <tr>
                            <th class='col_1'>학습기간</th>
                            <th class='col_2'>최초학습일</th>
                            <th class='col_3'>최종학습일</th>
                        </tr>
                        <tr>
                            <td class="col_1">${set.evaluation.cFromDate} ~ ${set.evaluation.cToDate} (${set.evaluation.cPeriod} 일)</td>
							<td class="col_2">${set.evaluation.studyStart}</td>
							<td class="col_3">${set.evaluation.studyEnd}</td>
                        </tr>
                    </table>
                </div>

                <div class='lecture_detail_table_box contents'>
                    <table>
                        <tr>
                            <th class='col_1'>차시</th>
                            <th class='col_2'>차시명</th>
                            <th class='col_3'>진도율</th>
                            <th class='col_4'>학습일자</th>
                        </tr>
<c:forEach var="row" items="${set.week}" varStatus="idx">
                        <tr>
                            <td class='col_1'>${row.week}</td>
                            <td class='col_2'>${row.title}</td>
                            <td class='col_3'>${row.progressRate} %</td>
                            <td class='col_4'>${row.studyStart} ~ ${row.studyEnd}</td>
                        </tr>
</c:forEach>                        
                    </table>
                </div>
                
	            <div class='detail_btn_area'>
	                <button onclick='window.close();'>닫기</button>
	            </div> 
            </div>

        </div>
        <!-- CONTENTS END -->
    </div>
</frameset>
<script src='/resources/homepage/js/dev_sub.js?timestamp=<%=timestamp%>'></script>
</body>
</html>