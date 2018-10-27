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
    <title>Q learning - 나의강의실 - 수강완료</title>

    <%@ include file="../common/commMainInclude.jsp" %>

    <link href='https://fonts.googleapis.com/css?family=Nanum+Gothic' rel='stylesheet'>
    <link rel='stylesheet' href='/resources/homepage/css/initialization.css'>
    <link rel='stylesheet' href='/resources/homepage/css/classroom/lecture.css'>
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
                            <p>나의강의실</p>
                            <span>
                                <img src='/resources/homepage/img/course/arr_right.jpg' alt=' '>
                            </span>
                            <p>수강완료과정</p>
                        </div>
                    </div>
                    <h1>
                        나의<span>강의실</span>
                    </h1>
                </div>
                <!-- Top END -->

                <div class='classroom_subtitle'>
                    <p class='subtitle'>수강완료과정</p>
                    <p>수강완료과정 목록입니다.</p>
                </div>

                <table class='classroom_lecture completed'>
                    <tr>
                        <th class='col_1'>강의제목</th>
                        <th class='col_2'>학습기간</th>
                        <th class='col_3'>진도</th>
                        <th class='col_4'>총점수</th>
                        <th class='col_5'>시험</th>
                        <th class='col_6'>수료여부</th>
                        <th class='col_7'>수강후기</th>
                    </tr>
<c:if test="${empty set.course}">
					<tr class="last_line"><td colspan="7" class="last center">수강 완료과정이 없습니다.</td></tr>
</c:if>					
<c:forEach var="row" items="${set.course}" varStatus="idx">
                    <tr>
	<c:choose>
		<c:when test="${row.mode eq 'REVIEW'}">
			         <td class="col_1"><nobr><a href="#" onclick="javascript:Popup.showReviewCourse('${row.courseId}','${row.hPx + 100}','${row.vPx + 100}')"><span>${row.courseName}</span></nobr></a></td>
		</c:when>
		<c:otherwise>
			         <td class="col_1"><nobr><span>${row.courseName}</span></nobr></td>
		</c:otherwise>
	</c:choose>	                    
	<c:if test="${row.termYn eq 'Y'}">
	                 <td class='col_2'>${row.studyPeriodFrom} ~ ${row.studyPeriodTo}</td>
	</c:if>	                    
	<c:if test="${row.termYn eq 'N'}">
	                 <td class='col_2'>${row.cPeriod} 일</td>
	</c:if>	  
                        
                        <td class='col_3'>${row.progress} %</td>
                        <td class='col_4'>${row.total} 점</td>
	<c:choose>
		<c:when test="${row.examYn eq 'N'}">
					   	<td class="col_5">미응시</td>
		</c:when>
		<c:otherwise>
			           	<td class="col_5">${row.examRate} 점</td>
		</c:otherwise>
	</c:choose>                        
	<c:choose>
		<c:when test="${row.completeYn eq 'Y'}">
					   	<td class="col_6">수료</td>
		</c:when>
		<c:otherwise>
			           	<td class="col_6">미수료</td>
		</c:otherwise>
	</c:choose>                        
	<c:choose>
		<c:when test="${row.courseEval eq '0'}">
					    <td class="col_7"><button onclick="Popup.showPostscript('${row.courseId}')">작성하기</button></td>
		</c:when>
		<c:otherwise>
       					<td class=""col_7"">
							<div class='clear_fix' onclick="Popup.showPostscriptV('${row.courseId}')">
                                <span><img src='/resources/homepage/img/process/${row.grade1}.png' alt=''></span>
                                <span><img src='/resources/homepage/img/process/${row.grade2}.png' alt=''></span>
                                <span><img src='/resources/homepage/img/process/${row.grade3}.png' alt=''></span>
                                <span><img src='/resources/homepage/img/process/${row.grade4}.png' alt=''></span>
                                <span><img src='/resources/homepage/img/process/${row.grade5}.png' alt=''></span>
                            </div>       					
						</td>
		</c:otherwise>
	</c:choose>		            
                    </tr>
</c:forEach>                    
                </table>
            </div>
        </div>
        <!-- CONTENTS END -->

        <!-- FOOTER -->
        <%@ include file="../common/mainBottom.jsp" %>
        <!-- FOOTER END -->
    </div>
</frameset>
<script src='/resources/homepage/js/sub.js?timestamp=<%=timestamp%>'></script>
</body>
</html>