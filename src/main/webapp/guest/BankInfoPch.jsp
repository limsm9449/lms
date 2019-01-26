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
    <title>Q learning - 입금계좌</title>
    
    <%@ include file="../common/commMainInclude.jsp" %>
	
	<link href='https://fonts.googleapis.com/css?family=Nanum+Gothic' rel='stylesheet'>
    <link rel='stylesheet' href='/resources/homepagePch/css/initialization.css'>
    <link rel='stylesheet' href='/resources/homepagePch/css/notice/notice_main.css'>
    <link rel='stylesheet' href='/resources/homepagePch/css/notice/notice.css'>
</head>

<body>
<frameset rows='*'>
    <div class='wrap'>
        <!-- HEAD START -->
        <%@ include file="../common/mainTopPch.jsp" %>
        <!-- HEAD END -->

        <!-- CONTENTS -->
        <div class='contents_wrap process'>
            <!-- QUICK MENU -->
       	 	<%@ include file="../common/mainQuickMenuPch.jsp" %>
       	 	<!-- QUICK MENU -->

            <div class='contents_wrap_box'>

                <!-- Top -->
                <div class='top_area'>
                    <div class='clear_fix'>
                        <div class='process_history_box clear_fix'>
                            <span>
                                <img src='/resources/homepagePch/img/course/ic_home.jpg' alt=' '>
                            </span>
                            <p>HOME</p>
                            <span>
                                <img src='/resources/homepagePch/img/course/arr_right.jpg' alt=' '>
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
                    <a href="javascript:" onclick="page.goPage('/main/noticeList');"><button id="g1">공지<span></span>사항</button></a>
                    <a href="javascript:" onclick="page.goPage('/main/faqList');"><button>자주 <span></span>묻는 질문</button></a>
                    <a href="javascript:" onclick="page.goPage('/main/mailQuestion');"><button>1:1 <span></span>메일문의</button></a>
                    <a href="javascript:" onclick="page.goPage('/main/tutorial');"><button>학습<span></span>지원</button></a>
                    <a href="javascript:"><button class="on">입금계좌<span></span>안내</button></a>
                </div>

                <!-- REGISTER PC VERSION -->
                <div class='register_method_pc5'>
                    <!-- <img src='/resources/homepagePch/img/notice/pc.jpg' alt=' '> -->
                    <ol>
                        <li class='pc_list_item'>
                            <h1 class="two_h1">
                            입금계좌<span class="two_h1_span">안내</span>
                        	</h1>
                        <div class='top_text_box clear_fix'>
                        <span><img src='/resources/homepagePch/img/notice/notice5_bg.png' alt=' '></span>
                            <p class='top_title' id="top_t1">큐러닝으로 입금 가능한 계좌번호입니다.</p>
                            <p>
                                큐러닝의 입금계좌를 알려드립니다.
                            </p>
                        </div>
                    </div>

                    <div class='account_list_box'>
                        <table>
                            <tr class='account_table_head'>
                                <th class='account_col1'>번호</th>
                                <th class='account_col2'>은행명</th>
                                <th class='account_col3'>계좌번호</th>
                                <th class='account_col4 last_right'>예금주</th>
                            </tr>
<c:forEach var="row" items="${set.bankList}" varStatus="idx">
                            <tr>
                                <td class='account_col1'>${idx.index + 1}</td>
                                <td class='account_col2'>${row.bankName}</td>
                                <td class='account_col3'>${row.accNo}</td>
                                <td class='account_col4 last_right'>${row.user}</td>
                            </tr>
</c:forEach>  
                        </table>
                    </div>
                        </li>
                    </ol>
        	</div>
        </div>
        <!-- CONTENTS END -->

        <!-- FOOTER -->
        <%@ include file="../common/mainBottomPch.jsp" %>
        <!-- FOOTER END -->
    </div>
</frameset>
<script src='/resources/homepagePch/js/main.js'></script>

</body>

</html>