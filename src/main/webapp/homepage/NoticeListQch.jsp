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
        
</head>

<script type="text/javascript">

$(document).ready(function() {
	f_makePageNavigator("pagingLayer",${set.condiVO.pageNum},${set.totalCount},${set.pageUnit},${set.pageCnt});
});

function lfn_btn(pKind, pParam) {
	if ( pKind == "search" || pKind == "paging" || pKind == "refresh" ) {
		if ( pKind == "search" )
			$("#pageNum").val(1);
		else if ( pKind == "paging" )
			$("#pageNum").val(pParam.page);
		
		f_submitSelf("/main/noticeList");
	} else if ( pKind == "view") {
		$("#seq").val(pParam.seq);

		$("#prevParams").val(encodeURIComponent($("#frm").serialize()));
		
		gfn_goPage("/main/noticeV",$("#frm").serialize());
	}
}

</script>

<body>
<form name="frm" id="frm" method="post">
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
                            <p>고객지원</p>
                        </div>
                    </div>
                    <h1>
                        고객<span>지원</span>
                    </h1>
                </div>
                <!-- Top END -->

                <div class='classroom_subtitle'>
                </div>

                <!-- TAB AREA -->
                <div class='register_method_tab clear_fix'>
                    <a href="javascript:"><button class="on" id="g1">공지<span></span>사항</button></a>
                    <a href="javascript:" onclick="page.goPage('/main/faqList');"><button>자주 <span></span>묻는 질문</button></a>
                    <a href="javascript:" onclick="page.goPage('/main/mailQuestion');"><button>1:1 <span></span>메일문의</button></a>
                    <a href="javascript:" onclick="page.goPage('/main/tutorial');"><button>학습<span></span>지원</button></a>
                    <a href="javascript:" onclick="page.goPage('/guest/bankInfo');"><button>입금계좌<span></span>안내</button></a>
                </div>

                <!-- REGISTER PC VERSION -->
                <div class='register_method_pc1'>
                    <!-- <img src='/resources/homepageQch/img/notice/pc.jpg' alt=' '> -->
                    <ol>
                        <li class='pc_list_item'>
                            <h1 class="two_h1">
                            공지<span class="two_h1_span">사항</span>
                        	</h1>
                        <div class='top_text_box clear_fix'>
                        	<span><img src='/resources/homepageQch/img/notice/notice1_bg.png' alt=' '></span>
                            <p class='top_title'>NEWS & NOTICE!</p>
                            <p>
                                큐러닝의 소식과 공지사항을 알려드립니다. <span></span>항상 유익하고 풍성한 소식 놓치지 말고 확인하세요.
                            </p>
                            
                        </div>
                        <!-- Contents -->
                    <div class='notice_search_box'>
                    	<input type='text' name='findString' id='findString' value="${set.condiVO.findString}" placeholder='검색어를 입력해 주세요.'>
                        <button onclick="lfn_btn('search');">검색</button>
                    </div>

                    <div class='notice_list_box'>
                        <table>
                            <tr class='notice_table_head'>
                                <th class='notice_col1'>번호</th>
                                <th class='notice_col3'>제목</th>
                                <th class='notice_col4'>등록일</th>
                                <th class='notice_col5 last_right'>조회</th>
                            </tr>
<c:forEach var="row" items="${set.boardNoticeList}" varStatus="idx">
                            <tr>
                                <td class='notice_col1'>${row.rownum}</td>
                                <td class='notice_col3'><a href="#" onClick="javascript:lfn_btn('view',{seq:'${row.seq}'}); return false;">${row.title}</a></td>
                                <td class='notice_col4'>${row.createDate}</td>
                                <td class='notice_col5 last_right'>${row.viewCnt}</td>
                            </tr>
</c:forEach>   
                        </table>
                    </div>

					<input type='hidden' id='pageNum' name='pageNum' value="${set.condiVO.pageNum}">
                    <div class='pager_box'>
	                    <div class='pager clear_fix'>
	                        <div class='pager_prev clear_fix' id="pagingLayerPrev">
	                        </div>
	                        <ul class='clear_fix' id="pagingLayer">
	                        </ul>
	                        <div class='pager_next clear_fix' id="pagingLayerNext">
	                        </div>
	                    </div>
	                </div>
		            <!-- Pager Area END -->
                    <!-- Contents END -->
                        </li>
                    </ol>
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