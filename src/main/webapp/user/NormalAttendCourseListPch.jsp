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
    <title>Q learning - 나의강의실 - 수강과정</title>

    <%@ include file="../common/commMainInclude.jsp" %>

    <link href='https://fonts.googleapis.com/css?family=Nanum+Gothic' rel='stylesheet'>
    <link rel='stylesheet' href='/resources/homepagePch/css/initialization.css'>
    <link rel='stylesheet' href='/resources/homepagePch/css/myclass/myclass_main.css'>
    <link rel='stylesheet' href='/resources/homepagePch/css/myclass/myclass_table.css'>
    <link rel='stylesheet' href='/resources/homepagePch/css/myclass/myclass.css'>
    <link rel='stylesheet' href='/resources/homepagePch/css/IE_style.css'>    
</head>

<script type="text/javascript">
</script>

<body>

<form name="frm" id="frm" method="post">
	<input id="courseId" name="courseId" type="hidden" value="">
	
<frameset rows='*'>
    <div class='wrap'>
        <!-- PC HEADER -->
        <%@ include file="../common/mainTopPch.jsp" %>
        <!-- HEAD END -->

        <!-- CONTENTS -->
        <div class='contents_wrap process' >
            <!-- QUICK MENU -->
            <%@ include file="../common/mainQuickMenuPch.jsp" %>

            <div class='contents_wrap_box'>
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

				<div class='classroom_subtitle'>
                </div>

                <!-- TAB AREA -->
                <div class='register_method_tab clear_fix'>
                    <a href='javascript:' ><button class="on" id="g1">수강중 <span></span>과정</button></a>
                    <a href='javascript:' onclick="page.goPage('/normalUser/waitingCourseList');"><button>대기중 <span></span>과정</button></a>
                    <a href='javascript:' onclick="page.goPage('/normalUser/myCourseList');"><button>수강완료 <span></span>과정</button></a>
                </div>
                
                <!-- REGISTER PC VERSION -->
                <div class='register_method_pc1'>
                    <ol>
                        
                        <!-- Contents -->
                    <div class="b_class">
						<!-- Search Result Area -->
<c:forEach var="row" items="${set.course}" varStatus="idx">
	                    <div class="class_1">
	                        <div class="class_1_img">
	                            <img id="mImg" src='/cImage/contents/${row.courseCode}/mImg1.jpg' alt=' '>
	                        </div>
	                        <div class="class_1_div1">
	                            <div class="class_1_title">
	                                <a href='#' class='user_lecture_list_subject' onclick="javascript:Popup.showStudyroomQch('${row.courseId}');">${row.courseName}</a>
	                            </div> 
<c:if test="${row.mobileYn eq 'Y'}">                        
	                            <div class="class_1_mobile">
	                                모바일 병행
	                            </div>
</c:if>	                            
	                        </div>
	                        
	                        <div class="class_1_div2">
	                        	<div class="class_1_per_div">
	                                <div class="class_1_chk1">
	                                    진도율
	                                </div>
	                                <div class="class_1_per per1">
	                                    <div class="class_1_chking1">
	                                        <div class="class_1_chking_per1" style="width:${row.progress}%;">
	                                        ${row.progress}%
	                                        </div>
	                                    </div>
	                                </div>
	                            </div>
	                            <div class="class_1_per_div per2">
	                                <div class="class_1_chk1">
	                                    학습기간
	                                </div>
	                                <div class="class_1_date">
	                                    ${row.cFromDate} ~ ${row.cToDate}
	                                </div>
	                            </div>
	                            <div class="class_1_per_div per3">
	                                <div class="class_1_chk1">
	                                    학습마감
	                                </div>
	                                <div class="class_1_date">
	                                    D-${row.remainDay}
	                                </div>
	                            </div>
	                        </div>
	                        
	                        <div class="class_1_div3">
	                        	<div class="class_btn">
	                                <div class="class_1_btn1" id="btn1_l1" onclick="javascript:Popup.showStudyroomQch('${row.courseId}')">
	                                    학습시작
	                                </div>
	<fmt:parseNumber value="${row.questProgressRatio}" var="questProgressRatio"/>
	<fmt:parseNumber value="${row.progress}"   var="progress"/>	                                
	<c:choose>
		<c:when test="${row.qgId eq '0' || questProgressRatio > progress}">
									<div class="class_1_btn1" id="btn1_l1" onclick="">-</div>
		</c:when>
		<c:when test="${row.questYn eq 'Y'}">
                              		<div class="class_1_btn1" id="btn1_l1" onclick="javascript:Popup.showQuestResult('${row.courseId}'); return false;">설문확인</div>
		</c:when>
		<c:otherwise>
                             		<div class="class_1_btn1" id="btn1_l1" onclick="javascript:Popup.showQuest('${row.courseId}'); return false;">설문참여</div>
		</c:otherwise>
	</c:choose>
	                            </div>
	                            <div class="class_btn right_btn">
	                                <div class="class_1_btn1" id="btn1_nshow" onclick="javascript:Popup.showUserBoard('DATA','${row.courseId}');">
	                                    자료실
	                                </div>
	<c:choose>
		<c:when test="${row.postscriptYn eq 'Y'}">
									<div class="class_1_btn1" id="btn1_l2" onclick="javascript:Popup.showPostscriptV('${row.courseId}'); return false;">수강후기 확인</div>
		</c:when>
		<c:otherwise>
									<div class="class_1_btn1" id="btn1_l2" onclick="javascript:Popup.showPostscript('${row.courseId}'); return false;">수강후기 참여</div>
		</c:otherwise>
	</c:choose>                 
	                            </div>
	                        </div>	                        
	                    </div>
</c:forEach>	                    
                    </div>
                    
                    
                <!-- Search Result Area END -->
				</div>
                <div class="M_txt">※ 학습관련 자료는 PC에서 다운받을 수 있습니다. </div>
            </div>
        </div>
        <!-- CONTENTS END -->

        <!-- FOOTER -->
        <%@ include file="../common/mainBottomPch.jsp" %>
        <!-- FOOTER END -->
    </div>
</frameset>

</form>
<script src='/resources/homepagePch/js/sub.js'></script>

</body>
</html>