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
    <title>Q learning - 전체과정</title>
    
    <%@ include file="../common/commMainInclude.jsp" %>

    <link href='https://fonts.googleapis.com/css?family=Nanum+Gothic' rel='stylesheet'>
    <link rel='stylesheet' href='/resources/homepage/css/initialization.css'>
    <link rel='stylesheet' href='/resources/homepage/css/classroom/classroom.css'>
</head>

<script type="text/javascript">

$(document).ready(function(){
});

</script>

<body>
<form name="frm" id="frm" method="post">
	<input id="courseId" name="courseId" type="hidden" value="">
</form>
<frameset rows='*'>    
    <div class='wrap'>
        
		<!-- HEAD -->
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
                            <p>나의강의실</p>
                        </div>
                    </div>
                    <h1>
                        나의<span>강의실</span>
                    </h1>
                </div>
                <!-- Top END -->

                <!-- User Info -->
                <div class='user_info'>
                    <p class='user_info_name'>
                        <span>${session.userName}님</span>의 나의강의실입니다.
                    </p>
                    <div class='clear_fix'>
                        <div class='user_info_text'>
                            <p class='user_info_text_title'>학습중</p>
                            <p><strong>${set.courseSummary.attendCourseCnt}</strong>과정</p>
                        </div>
                        <div class='user_info_text'>
                            <p class='user_info_text_title'>대기</p>
                            <p><strong>${set.courseSummary.waitingCourseCnt}</strong>과정</p>
                        </div>
                        <div class='user_info_text'>
                            <p class='user_info_text_title'>수료</p>
                            <p><strong>${set.courseSummary.completeCourseCnt}</strong>과정</p>
                        </div>
                        <div class='user_info_text'>
                            <p class='user_info_text_title'>학습종료</p>
                            <p><strong class='last_right'>D - ${set.courseSummary.courseRemainDay}</strong></p>
                        </div>
                        <div class='user_info_my clear_fix'>
                            <div class='user_info_image_box'>
                                <p>나의정보</p>
                                <span>
                                    <img src='/resources/homepage/img/classroom/ic_info.png' alt=''>
                                </span>
                            </div>
                            <ul class='user_info_info_box'>
<c:if test="${!empty session.compName}">      		
                                <li>
                                    소속 : <span>${session.compName}</span>
                                </li>
</c:if>                                
                                <li>
                                    휴대폰 : <span>${session.mobile}</span>
                                </li>
                                <li>
                                    이메일 : <span>${session.email}</span>
                                </li>
                            </ul>
                            <div class='user_info_btn_box clear_fix'>
                                <button onclick="page.goPage('/member/userMemberU');">회원정보 수정</button>
                                <button onclick="page.goPage('/member/memberChangePassword');" class='last_right'>비밀번호 변경</button>
                            </div>
                        </div>
                    </div>
                </div>
                <!-- User Info END -->

                <!-- User CS -->
                <div class='user_cs clear_fix'>
                    <div class='user_cs_notice_box'>
                        <div class='user_cs_title clear_fix'>
                            <p>공지사항</p>
                            <p class='user_cs_more' onclick="page.goPage('/main/noticeList');">MORE +</p>
                        </div>
                        <ul>
<c:forEach var="row" items="${set.noticeList}" varStatus="idx">
                            <li class='user_cs_list'>
                                <a href="javascript:" onclick="page.goPage('/main/noticeV','seq=${row.seq}&pageNum=0&findString=');" class='clear_fix'>
                                    <p>${row.title}</p>
                                    <p class='user_cs_list_date'>${row.createDate}</p>
                                </a>
                            </li>
</c:forEach>                            
                        </ul>
                    </div>
                    <div class='user_cs_counsel'>
                        <div class='user_cs_title clear_fix'>
                            <p>
                                상담내역
                            </p>
                            <p class='user_cs_more' onclick="page.goPage('/counsel/userCounselList');">MORE +</p>
                        </div>
                        <ul>
<c:forEach var="row" items="${set.counselList}" varStatus="idx">
                            <li class='user_cs_list'>
                                <a href="javascript:" onclick="page.goPage('/counsel/userCounselV','seq=${row.seq}&pageNum=0&findString=');" class='clear_fix'>
                                    <p>${row.title}</p>
                                    <p class='user_cs_list_date'>${row.createDate}</p>
                                </a>
                            </li>
</c:forEach>                            
                        </ul>
                    </div>
                </div>
                <!-- User CS END -->

                <!-- User Lecture -->
                <div class='user_lecture'>
                    <div class="user_lecture_tab_box clear_fix">
                        <button class='on clear_fix' onclick='lecture_view(this, "present")'>
                            <p class='user_lecture_btn_title first'>
                                학습중인 과정
                                <span>(${set.courseSummary.attendCourseCnt})</span>
                            </p>
                            <a href="javascript:" onclick="page.goPage('/normalUser/attendCourseList');">MORE +</a>
                        </button>
                        <button class='clear_fix' onclick='lecture_view(this, "past")'>
                            <p class='user_lecture_btn_title'>
                                수강이력/수료증
                                <span>(${set.courseSummary.completeCourseCnt})</span>
                            </p>
                            <a href="javascript:" onclick="page.goPage('/normalUser/myCourseList');">MORE +</a>
                        </button>
                    </div>
                    <div class='user_lecture_list_title list present clear_fix'>
                        <p class='user_lecture_list_subject'>과정명</p>
                        <p>진도율</p>
                        <p class='user_lecture_list_date'>학습기간</p>
                        <p>학습마감</p>
                        <p class='user_lecture_list_start last_right'>학습시작</p>
                    </div>
                    <div class='user_lecture_list_title list past clear_fix'>
                        <p class='user_lecture_list_subject'>과정명</p>
                        <p class='user_lecture_list_date'>학습기간</p>
                        <p>점수</p>
                        <p>수료여부</p>
                        <p class='last_right'>수료증</p>
                    </div>

                    <!-- 학습중인 과정 List -->
                    <ul class='user_lecture_list present clear_fix'>
<c:forEach var="row" items="${set.attendCourseList}" varStatus="idx">
                        <li class='list clear_fix'>
                            <p class='user_lecture_list_subject' onclick="javascript:Popup.showStudyroom('${row.courseId}');">
                                ${row.courseName}
                            </p>
                            <p>${row.progress}%</p>
                            <p class='user_lecture_list_date'>${row.cFromDate} ~ ${row.cToDate}</p>
                            <p>D-${row.remainDay}</p>
	<c:if test="${row.isStudy eq 'Y'}">                            
                            <button class='user_lecture_list_start' onclick="javascript:Popup.showStudyroom('${row.courseId}');">학습시작</button>
	</c:if>                            
	<c:if test="${row.isStudy eq 'N'}">                            
                            <button class='user_lecture_list_start' onclick="">학습대기중</button>
	</c:if>                            
                        </li>
</c:forEach>                        
                    </ul>

                    <!-- 수강이력/수료증 List -->
                    <ul class='user_lecture_list past clear_fix'> 
<c:forEach var="row" items="${set.completeCourseList}" varStatus="idx"> 
                        <li class='list clear_fix'>
                            <p class='user_lecture_list_subject'>
                                ${row.courseName}
                            </p>
                            <p class='user_lecture_list_date'>${row.cFromDate} ~ ${row.cToDate}</p>
                            <p>${row.total}%</p>
	<c:if test="${row.completeYn eq 'Y'}">      		
                            <p>수료</p>
                            <p class='last'>발급</p>
	</c:if>                            
	<c:if test="${row.completeYn eq 'N'}">      		
                            <p>미수료</p>
                            <p class='last'>-</p>
	</c:if>                            
                        </li>
</c:forEach>                        
                    </ul>
                </div>
                <!-- User Lecture END -->
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