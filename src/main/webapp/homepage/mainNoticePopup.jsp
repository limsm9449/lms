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
    <title>Q learning - 공지팝업</title>

    <%@ include file="../common/commMainInclude.jsp"%>

    <link href='https://fonts.googleapis.com/css?family=Nanum+Gothic' rel='stylesheet'>
    <link rel='stylesheet' href='/resources/homepageQch/css/initialization.css'>
    <link rel='stylesheet' href='/resources/homepageQch/css/notice/notice_main.css'>
    <link rel='stylesheet' href='/resources/homepageQch/css/notice/notice.css'>
    <link rel='stylesheet' href='/resources/homepageQch/css/notice/notice_detail.css'>

    <style>
        html{
            overflow-y:hidden;
        }
    </style>
</head>

<script type="text/javascript">

function fn_close( isOneOpen ) {
	if ( isOneOpen ) {
		$.cookie(cookieName + '_notice_${set.noticeHm.SEQ}', "Y", { expires: 1 });
	} else {
		$.cookie(cookieName + '_notice_${set.noticeHm.SEQ}', "N", { expires: 1 });
	}
	
	window.close();
}
</script>

<body style='background:#fff'>
<frameset rows='*'>
    <div class='wrap' id="p_wrap">
        <!-- CONTENTS -->
        <div class='contents_wrap process'>
            <div class='contents_wrap_box popup' id="r_pop">
                <div class='basket_completed_popup'>
<div class='notice_detail_box'>
                        <div class='notice_title_box'>
                            <p>${set.noticeHm.TITLE}</p>
                        </div>
                        <div class='notice_info_box clear_fix'>
                            <div class='notice_visit'>
                                <p class='type'>조회</p>
                                <p>${set.noticeHm.VIEW_CNT}</p>
                            </div>
                            <div class='notice_regDate'>
                                <p class='type'>등록일</p>
                                <p>${set.noticeHm.CREATE_DATE_STR}</p>
                            </div>
                        </div>
                        <div class='iframe_contents'>
                            ${set.noticeHm.CONTENTS}
                        </div>
                    </div>
                    <div class='detail_btn_area popbtn'>
                        <button onclick='fn_close(true)' class="pop_day_btn">하루동안 보지 않기</button>
                        <button onclick='fn_close(false)' class="pop_close_btn">닫기</button>
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