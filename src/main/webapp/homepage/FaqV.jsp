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
    <title>Q learning - 공지사항 상세보기</title>

	<%@ include file="../common/commMainInclude.jsp" %>
	
    <link href='https://fonts.googleapis.com/css?family=Nanum+Gothic' rel='stylesheet'>
    <link rel='stylesheet' href='/resources/homepage/css/initialization.css'>
    <link rel='stylesheet' href='/resources/homepage/css/support/notice_detail.css'>
</head>

<body>
<form name="frm" id="frm" method="post">

    <frameset rows='*'>
        <div class='wrap'>
            <!-- PC HEADER -->
            <%@ include file="../common/mainTop.jsp" %>
            <!-- HEAD END -->

            <!-- CONTENTS -->
            <div class='contents_wrap support' onmouseover='sub_hide()'>
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
                                <p>고객지원</p>
                                <span>
                                    <img src='/resources/homepage/img/course/arr_right.jpg' alt=' '>
                                </span>
                                <p>Faq</p>
                            </div>
                        </div>
                        <h1>
                            FAQ</span>
                        </h1>
                    </div>
                    <!-- Top END -->

                    <!-- Contents -->
                    <div class='notice_detail_box'>
                        <div class='notice_title_box'>
                            <p>${set.boardFaq.title}</p>
                        </div>
                        <div class='notice_info_box clear_fix'>
                            <div class='notice_visit'>
                                <p class='type'>분류</p>
                                <p>${set.boardFaq.categoryName}</p>
                            </div>
                            <div class='notice_visit'>
                                <p class='type'>조회</p>
                                <p>${set.boardFaq.viewCnt}</p>
                            </div>
                            <div class='notice_regDate'>
                                <p class='type'>등록일</p>
                                <p>${set.boardFaq.createDate}</p>
                            </div>
                        </div>
                        <div>
			             	${set.boardFaq.contents}
			            </div>
                    </div>
                    <div class='detail_btn_area'>
                        <a href="#" onclick="page.goPage('/main/faqList', decodeURIComponent('${set.condiVO.prevParams}'));" class='bg_color'>목록으로 돌아가기</a>
                    </div>
                    
                    <!-- Contents END -->
                </div>
            </div>
            <!-- CONTENTS END -->

            <!-- FOOTER -->
            <%@ include file="../common/mainBottom.jsp" %>
            <!-- FOOTER END -->
        </div>
    </frameset>
</form>
    
    <script src='/resources/homepage/js/sub.js?timestamp=<%=timestamp%>'></script>
</body>

</html>