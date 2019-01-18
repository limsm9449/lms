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
    <title>Q learning - 나의강의실 - 학습 Q&A 내역 상세보기</title>

    <%@ include file="../common/commMainInclude.jsp" %>

    <link href='https://fonts.googleapis.com/css?family=Nanum+Gothic' rel='stylesheet'>
	<link rel='stylesheet' href='/resources/homepageQch/css/initialization.css'>
    <link rel='stylesheet' href='/resources/homepageQch/css/mypage/mypage_main.css'>
    <link rel='stylesheet' href='/resources/homepageQch/css/mypage/mypage_table.css'>
    <link rel='stylesheet' href='/resources/homepageQch/css/mypage/mypage.css'>
</head>

<script type="text/javascript">

function lfn_btn(pKind, pParam) {
	if ( pKind =="list" ) {
		gfn_goPage("/main/myQnaList",""); 
	}
}

</script>

<body style='background:#fff'>

<form id="frm" name="frm" method="post">

<frameset rows='*'>
    <div class='wrap'>
        <!-- PC HEADER -->
        <%@ include file="../common/mainTopQch.jsp" %>
        <!-- HEAD END -->

        <!-- CONTENTS -->
        <div class='contents_wrap process'>
            <!-- QUICK MENU -->
            <%@ include file="../common/mainQuickMenuQch.jsp" %>

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
                            <p>상담상세보기</p>
                        </div>
                    </div>
                    <h1>
                        상담 <span>상세</span>보기
                    </h1>
                </div>
                <!-- Top END -->

                <div class='classroom_subtitle' id="detail_2">
                </div>

                <!-- TAB AREA -->
                

                <!-- REGISTER PC VERSION -->
                <div class='register_method_pc1' id="detail_3">
                    <!-- <img src='../../img/notice/pc.jpg' alt=' '> -->
                    <ol>
                        
                        <!-- Contents -->
                    
                    
                    
					<!-- Search Result Area -->
                    <div class="pra2_point">
                        <div class="t1_point">
                            학습 Q&A 내역
                        </div>
                        <div class="t1_point_txt" id="detail_4">
                            상세보기 
                        </div>
                    </div>
                    <table class="QAde_table" id="QAde_t1">
                    	<tr class="QAde_table_top">
                        	<td class="QAde_table_top_1">과정명</td>
                            <td class="QAde_table_top_2">${set.myQnaData.courseName}</td>
                            <td class="QAde_table_top_3">등록일</td>
                            <td class="QAde_table_top_4">${set.myQnaData.createDateStr}</td>
                        </tr>
                        <tr>
                        	<td class="QAde_table_top_1">제목</td>
                            <td class="QAde_table_top_4"  colspan="3">${set.myQnaData.title}</td>
                        </tr>
                        <tr>
                        	<td class="QAde_table_top_1">내용</td>
                            <td class="QAde_table_top_4"  colspan="3">${set.myQnaData.contents}</td>
                        </tr>
                        <tr>
                            <td class="QAde_table_top_4"  colspan="4"></td>
                        </tr>
                        <tr>
                        	<td class="QAde_table_top_1">답변</td>
                            <td class="QAde_table_top_4"  colspan="3">${set.myQnaData.answer}</td>
                        </tr>
                    </table>
                    <div class="QAde_btndiv">
                    		<button class="QA_back_btn" onclick="lfn_btn('list');">목록으로</button>
                    </div>

                    
                    <!-- Search Result Area END -->
                   
            </div>
        </div>
        <!-- CONTENTS END -->

        <!-- FOOTER -->
        <%@ include file="../common/mainBottomQch.jsp" %>
        <!-- FOOTER END -->
    </div>
</frameset>

</form>

<script src='/resources/homepageQch/js/main.js'></script>

</body>
</html>