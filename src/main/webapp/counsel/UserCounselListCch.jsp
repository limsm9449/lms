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
    <title>Q learning - 마이페이지 - 상담내역</title>

    <%@ include file="../common/commMainInclude.jsp" %>


    <link href='https://fonts.googleapis.com/css?family=Nanum+Gothic' rel='stylesheet'>
    <link rel='stylesheet' href='/resources/homepageCch/css/initialization.css'>
    <link rel='stylesheet' href='/resources/homepageCch/css/mypage/mypage_main.css'>
    <link rel='stylesheet' href='/resources/homepageCch/css/mypage/mypage_table.css'>
    <link rel='stylesheet' href='/resources/homepageCch/css/mypage/mypage.css'>    
</head>

<script type="text/javascript">
$(document).ready(function() {
});

function lfn_btn(pKind, pParam) {
	if ( pKind == "search" || pKind == "paging" || pKind == "refresh" ) {
		if ( pKind == "search" )
			$("#pageNum").val(1);
		else if ( pKind == "paging" )
			$("#pageNum").val(pParam.page);
		
		f_submitSelf("/counsel/userCounselList");
	} else if ( pKind == "new" ) {
		gfn_goPage("/counsel/userCounselN",$("#frm").serialize());
	} else if ( pKind == "view") {
		$("#seq").val(pParam.seq);
		
		gfn_goPage("/counsel/userCounselV",$("#frm").serialize());
	}
}

</script>

<body>

<form id="frm" name="frm" method="post">
	<input type="hidden" id="seq" name="seq" value=""/>
	
<frameset rows='*'>
    <div class='wrap'>
        <!-- HEAD -->
        <%@ include file="../common/mainTopCch.jsp" %>
        <!-- HEAD END -->

        <!-- CONTENTS -->
        <div class='contents_wrap process'>
            <!-- QUICK MENU -->
            <%@ include file="../common/mainQuickMenuCch.jsp" %>
            
            <div class='contents_wrap_box'>

                <!-- Top -->
                <div class='top_area'>
                    <div class='clear_fix'>
                        <div class='process_history_box clear_fix'>
                            <span>
                                <img src='/resources/homepageCch/img/course/ic_home.jpg' alt=' '>
                            </span>
                            <p>HOME</p>
                            <span>
                                <img src='/resources/homepageCch/img/course/arr_right.jpg' alt=' '>
                            </span>
                            <p>마이페이지</p>
                        </div>
                    </div>
                    <h1>
                        <span>마이</span>페이지
                    </h1>
                </div>
                <!-- Top END -->

                <div class='classroom_subtitle' id="detail_2">
                </div>


                <!-- REGISTER PC VERSION -->
                <div class='register_method_pc1' id="detail_3">
                    <!-- <img src='../../img/notice/pc.jpg' alt=' '> -->
                    <ol>
                        

                    <div class="pra2_point">
                        <div class="t1_point">
                            상담내역
                        </div>
                        <div class="t1_point_txt" id="detail_4">
                            1:1 메일 문의에 대한 답변을 확인하실 수 있습니다.
                        </div>
                    </div>
                    
                    <table class="pra_table">
                    	<tr class="pra_table_top">
                        	<td class="pra_table_top_1">번호</td>
                            <td class="pra_table_top_2">분류</td>
                            <td class="pra_table_top_3">제목</td>
                            <td class="pra_table_top_4">등록일</td>
                            <td class="pra_table_top_5">답변상태</td>
                        </tr>
<c:if test="${empty set.list}">
					<tr class="last_line">
						<td colspan="5" class="last center" style="border-right:none"><spring:message code="lms.msg.noSearchData" text="-" /></td>
					</tr>
</c:if>                  
<c:forEach var="row" items="${set.list}" varStatus="idx">  
                    <tr>
                        <td class='pra_table_mid_1'>${row.rownum}</td>
                        <td class='pra_table_mid_2'>${row.categoryName}</td>
                        <td class='pra_table_mid_3'>
                            <a href="#" onClick="javascript:lfn_btn('view',{seq:'${row.seq}'}); return false;"><c:out value="${row.title}" escapeXml="true" /></a>
                        </td>
                        <td class='pra_table_mid_4'>${row.createDate}</td>
                        <td class='pra_table_mid_5'>${row.answerYn}</td>
                    </tr>
</c:forEach>  
                    </table>
                    
                    <!-- Search Result Area END -->
                    <div class='detail_btn_area'>
                    	<a href="#" onclick="javascript:lfn_btn('new');" class='bg_color'>등록하기</a>
                	</div>
            </div>
        </div>
        <!-- CONTENTS END -->

        <!-- FOOTER -->
        <%@ include file="../common/mainBottomCch.jsp" %>
        <!-- FOOTER END -->
    </div>
</frameset>
</form>

<script src='/resources/homepageCch/js/main.js'></script>
</body>
</html>