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
    <title>Q learning - 자료실</title>

    <%@ include file="../common/commMainInclude.jsp" %>

    <link href='https://fonts.googleapis.com/css?family=Nanum+Gothic' rel='stylesheet'>
    <link rel='stylesheet' href='/resources/homepage/css/initialization.css'>
    <link rel='stylesheet' href='/resources/homepage/css/support/notice_detail.css'>
</head>

<body style='background:#fff'>
<form id="frm" name="frm" action="" method="post">
	<input id="courseId" name="courseId" value="${set.condiVO.courseId}" type="hidden"/>
	<input id="seq" name="seq" value="${set.condiVO.seq}" type="hidden"/>
	<input id="prevParams" name="prevParams" type="hidden" value="${set.condiVO.prevParams}">
	
<frameset rows='*'>
    <div class='wrap'>
        <!-- CONTENTS -->
        <div class='contents_wrap process'>
            <div class='contents_wrap_box popup'>
                <!-- TOP -->
                <div class='top_area'>
                    <h1>
                            공지사항<span>상세</span>보기
                        </h1>
                        <div class='top_text_box clear_fix'>
                            <span><img src='/resources/homepage/img/support/notice_bg.jpg' alt=' '></span>
                            <p class='top_title'>NEWS & NOTICE!</p>
                            <p>
                                큐러닝의 소식과 공지사항을 알려드립니다. <span></span>항상 유익하고 풍성한 소식 놓치지 말고 확인하세요.
                            </p>
                        </div>
                </div>
                <!-- TOP END -->

                <div class='notice_detail_box'>
                    <div class='notice_title_box'>
                        <p><c:out value="${set.data.title}" escapeXml="true" /></p>
                    </div>
                    <div class='notice_info_box clear_fix'>
                        <div class='notice_visit'>
                            <p class='type'>조회</p>
                            <p>${set.data.viewCnt}</p>
                        </div>
                        <div class='notice_regDate'>
                            <p class='type'>등록일</p>
                            <p>${set.data.createDate}</p>
                        </div>
                    </div>
                    <div class='iframe_contents'>
                        <c:out value="${set.data.contents}" escapeXml="" />
                    </div>
                </div>
                <div class='detail_btn_area'>
                    <button onclick="page.goPage('/board/userBoardNoticeList', decodeURIComponent('${set.condiVO.prevParams}'));">목록으로</button>
                </div>

            </div>
        </div>
        <!-- CONTENTS END -->
    </div>
</frameset>

</form>
<script src='/resources/homepage/js/dev_sub.js?timestamp=<%=timestamp%>'></script>
</body>
</html>