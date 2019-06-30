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
    <title>Q learning - 공지사항</title>

	<%@ include file="../common/commMainInclude.jsp" %>
	
    <link href='https://fonts.googleapis.com/css?family=Nanum+Gothic' rel='stylesheet'>
    <link rel='stylesheet' href='/resources/homepageQch/css/initialization.css'>
    <link rel='stylesheet' href='/resources/homepageQch/css/notice/notice_main.css'>
    <link rel='stylesheet' href='/resources/homepageQch/css/notice/notice.css'>
    <link rel='stylesheet' href='/resources/homepageQch/css/classroom/notice_qstar.css'>
</head>


<body>
<form name="frm" id="frm" method="post">
	<div style="display:none">
		<!-- 이것은 자동이동을 막기위함이다. -->
		<input type="submit" onclick="return false;" />
		<input type="text"/>
	</div>
	<input id="seq" name="seq" type="hidden" value="">
	<input id="prevParams" name="prevParams" type="hidden" value="">
	
<frameset rows='*'>
    <div class='wrap'>
        <!-- HEAD -->
        <!-- HEAD START -->
        <%@ include file="../common/mainTopQch.jsp" %>
        <!-- HEAD END -->

        <!-- CONTENTS -->
        <div class='contents_wrap process'>
            <!-- QUICK MENU -->
       	 	<%@ include file="../common/mainQuickMenuQch.jsp" %>
       	 	<!-- QUICK MENU -->
       	 	
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
                            <p>강사지원</p>
                        </div>
                    </div>
                    <h1>
                        강사<span>지원</span>
                    </h1>
                </div>
                <!-- Top END -->

                <div class="qstar_notice">
                    <img src="/resources/homepageQch/img/support/qstar_notice.png"/>
                    <a href="https://docs.google.com/forms/d/15tlmkZIwwXznSGcszhmpVekZHL4G_yeABJS9qVFSyJE/closedform">
                        <img src="/resources/homepageQch/img/support/qstar_notice_btn.png"/>
                    </a>
                </div>
                
            </div>
        </div>
        <!-- CONTENTS END -->

        <!-- FOOTER -->
        <%@ include file="../common/mainBottomQch.jsp" %>
        <!-- FOOTER END -->
    </div>
</frameset>
<script src='/resources/homepageQch/js/main.js'></script>

</form>
    
</body>
</html>