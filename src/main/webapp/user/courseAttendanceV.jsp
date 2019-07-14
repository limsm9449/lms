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
                        출석<span>현황</span>
                    </h1>
                    <div class='top_text_box clear_fix'>
                        <span><img src='/resources/homepage/img/support/notice_bg.jpg' alt=' '></span>
                        <p class='top_title'>Attendance</p>
                        <p>
                             출석현황을 자세하게 확인할 수 있습니다.
                        </p>
                    </div>
                </div>
                <!-- TOP END -->

                <div class='lecture_detail_table_box score'>
                    <table>
                        <tr>
                            <th class='col_1'>일자</th>
                            <th class='col_2'>출석 횟수</th>
                            <th class='col_3'>최초학습일</th>
                            <th class='col_4'>최종학습일</th>
                            <th class='col_5'>학습차수</th>
                        </tr>
<c:forEach var="row" items="${set.attendanceDays}" varStatus="idx">
                        <tr>
                            <td class='col_1'>${row.studyDay}</td>
                            <td class='col_2'>${row.attendanceCnt}</td>
                            <td class='col_3'>${row.studyStart}</td>
                            <td class='col_4'>${row.studyEnd}</td>
                            <td class='col_5'>${row.weekCnt}차 ${row.pageCnt} 페이지</td>
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