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
    <link rel='stylesheet' href='/resources/homepage/css/initialization.css'>
    <link rel='stylesheet' href='/resources/homepage/css/support/notice.css'>
</head>

<script type="text/javascript">

$(document).ready(function() {
	f_makePageNavigator("pagingLayer",${set.condiVO.pageNum},${set.totalCount},${set.pageUnit});
});

function lfn_btn(pKind, pParam) {
	if ( pKind == "view") {
		$("#seq").val(pParam.seq);
		
		gfn_goPage("/main/eventV",$("#frm").serialize());
	}
}

</script>

<body>
<form name="frm" id="frm" method="post">
	<input id="seq" name="seq" type="hidden" value="">
	
    <frameset rows='*'>
        <div class='wrap'>
            <!-- HEADER -->
            <%@ include file="../common/mainTop.jsp" %>
            <!-- HEAD END -->

            <!-- CONTENTS -->
            <div class='contents_wrap support' >
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
                                <p>Error</p>
                            </div>
                        </div>
                        <h1>
                            Error</span>
                        </h1>
                    </div>
                    <!-- Top END -->

					<div class='notice_list_box'>
                        등록되어 있지 않은 회사 이거나 사용 중지된 회사입니다. 
                    </div>
                    
               	</div>
            </div>
            <!-- CONTENTS END -->

            <!-- FOOTER -->
            <%@ include file="../common/mainBottom.jsp" %>
            <!-- FOOTER END -->
        </div>
    </frameset>
</form>
    
    <script src='/resources/homepage/js/dev_sub.js?timestamp=<%=timestamp%>'></script>
</body>

</html>