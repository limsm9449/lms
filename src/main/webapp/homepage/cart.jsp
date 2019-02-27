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
    <title>Q learning - 나의강의실 - 장바구니</title>

    <%@ include file="../common/commMainInclude.jsp" %>

    <link href='https://fonts.googleapis.com/css?family=Nanum+Gothic' rel='stylesheet'>
    <link rel='stylesheet' href='/resources/homepage/css/initialization.css'>
    <link rel='stylesheet' href='/resources/homepage/css/classroom/basket.css'>
</head>

<script type="text/javascript">

function lfn_btn(pKind, pParam) {
	if ( pKind == "cartApplication" ) {
		if ( $('input:checkbox[name="chk"]:checked').length == 0 ) {
			alert("신청할 과정이 없습니다.");
			return false;
		}
		<c:choose>
			<c:when test="${set.condiVO.compType eq 'B2B'}">
				if ( confirm("과정을 신청하시겠습니까?") == true ) {
					var cb = $('input:checkbox[name="chk"]:checked');
					var courseIds = "";
					for ( var i = 0; i < cb.length; i++ ) {
						courseIds += (courseIds == "" ? "" : ",") + cb[i].value;
					}
					$.ajax({
						type :"POST",
						url : context + "/siteManager/axUserCourseRegister.do",
						dataType :"json",
						data : "courseId=" + courseIds,
						success : function(json){
							if ( json.rtnMode == "OK") {
								alert("과정이 신청되었습니다.");
								page.goPage('/main/myClassroom', '');
							} else {
								alert("<spring:message code="lms.msg.systemError" text="-" />");
							}
						},
						error : function(e) {
							alert("<spring:message code="lms.msg.systemError" text="-" />");
						}
					})
				}
			</c:when>
			<c:otherwise>
				if ( confirm("해당 과정으로 결제하시겠습니까?") == true ) {
					var cb = $('input:checkbox[name="chk"]:checked');
					var courseIds = "";
					for ( var i = 0; i < cb.length; i++ ) {
						courseIds += (courseIds == "" ? "" : ",") + cb[i].value;
					}
					gfn_goPage("/paymentGateway/cartPay", "courseId=" + courseIds); 
				}
			</c:otherwise>
		</c:choose>		
	} else if ( pKind == "cartDel" ) {
		if ( confirm("장바구니에서 삭제 하시겠습니까?") == true ) {
			gfn_goPage("/main/cartDel","cartCourseId=" + pParam.courseId);
		}
	} else if ( pKind == "cartSelectDel" ) {
		$("#aChk").prop("checked", "checked");
		gfn_allChk('aChk','chk');

		if ( confirm("장바구니에서 삭제 하시겠습니까?") == true ) {
			gfn_goPage("/main/cartSelectDel","cartCourseId=" + gfn_cbCheckedValues("chk",","));
		}
	}
}

</script>

<body>

<form name="frm" id="frm" method="post">

<frameset rows='*'>
    <div class='wrap'>
        <!-- PC HEADER -->
        <%@ include file="../common/mainTop.jsp" %>
        <!-- HEAD END -->

        <!-- CONTENTS -->
        <div class='contents_wrap process' >
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
                            <p>나의강의실</p>
                            <span>
                                <img src='/resources/homepage/img/course/arr_right.jpg' alt=' '>
                            </span>
                            <p>장바구니</p>
                        </div>
                    </div>
                    <h1>
                        장바<span>구니</span>
                    </h1>
                </div>
                <!-- Top END -->

                <div class='basket_step_box'>
                    <ul>
                        <li class='basket_step_list clear_fix on'>
                            <span><img src='/resources/homepage/img/classroom/basket_step1_active.png' alt=' '></span>
                            <p class='basket_title'>장바구니</p>
                            <p>장바구니의 최종 금액을 확인하시고 선택하여 주십시오.</p>
                        </li>
                        <li class='basket_arr'>
                            <img src='/resources/homepage/img/etc/arr_right.png' alt=' '>
                        </li>
                        <li class='basket_step_list clear_fix'>
                            <span><img src='/resources/homepage/img/classroom/basket_step2_inactive.png' alt=' '></span>
                            <p class='basket_title'>결제정보입력</p>
                        </li>
                        <li class='basket_arr'>
                            <img src='/resources/homepage/img/etc/arr_right.png' alt=' '>
                        </li>
                        <li class='basket_step_list clear_fix'>
                            <span><img src='/resources/homepage/img/classroom/basket_step3_inactive.png' alt=' '></span>
                            <p class='basket_title'>결제완료</p>
                        </li>
                    </ul>
                    <p class='basket_note'>
                        <span></span>고객님께서 장바구니에 담으신 과정 및 상품입니다.<br>
                        <span></span>결제시 가격정보를 확인한 후 구매하시기 바랍니다.<br>
                        <span></span>과정은 매월 21일 기준으로 정보 변경됩니다. (참고도서 포함)
                    </p>
                </div>

                <div class='process_search_result'>
                    <p class='basket_list_title'>신청과정</p>
                    <div class='clear_fix'>
                        <div class='process_result_checkbox'>
                            <input type='checkbox' name="aChk" id="aChk"  onclick="gfn_allChk('aChk','chk');">
                        </div>
                        <p class='process_result_con'>과정명</p>
                        <p class='process_result_btn'>선택</p>
                        <p class='process_result_review'>주문금액</p>
                    </div>
                    <ul class='process_result_list'>
<c:forEach var="row" items="${set.courseList}" varStatus="idx">
                        <li class='clear_fix'>
                            <div class='process_result_checkbox con'>
                                <input type='checkbox' name="chk" id="chk" value="${row.courseId}">
                            </div>
                            <div class='process_result_con con clear_fix'>
                                <div class='process_result_img'>
                                    <img src='/cImage/contents/${row.courseCode}/mImg1.jpg' alt=' '>
                                </div>
                                <div class='process_result_text'>
                                    <div class='process_result_text_top clear_fix'>
                                        <p>일반</p>
	<c:if test="${row.mobileYn eq 'Y'}">
                                        <p class='process_result_mobile'>모바일</p>
	</c:if>                                        
                                    </div>
                                    <p>${row.courseName}</p>
                                    <div class='process_result_text_bottom clear_fix'>
                                        <p>교육기간</p>
                                        <p class='process_result_payment'>${row.cFromDate} ~ ${row.cToDate} (${row.cPeriod} 일)</p>
                                    </div>
                                </div>
                            </div>
                            <div class='process_result_btn con'>
                                <button class='bg_color' onclick="lfn_btn('cartDel',{courseId:'${row.courseId}'}); return false;">선택과정 삭제</button>
                            </div>
                            <div class='process_result_review con'>
                                <p><fmt:formatNumber value="${row.courseCost}" type="number"/> 원</p>
                            </div>
<c:if test="${not empty row.cartWeekList}">
                            <table class='register_compose_table'>
                                <tr>
                                    <th>차시 제목</th>
                                    <th class='last_right part_only'>교육비</th>
                                </tr>
	<c:forEach var="subRow" items="${row.cartWeekList}">                                
                                <tr>
                                    <td class='register_compose_lecture'>
                                        <p>
                                            ${subRow.week}<span></span>
                                            ${subRow.title}
                                        </p>
                                    </td>
                                    <td class='last_right part_only'><fmt:formatNumber value="${subRow.weekCost}" type="number"/> 원</td>
                                </tr>
	</c:forEach>                                
                            </table>
</c:if>                            
                        </li>
</c:forEach>                        
                    </ul>
                </div>

                <div class='detail_btn_area'>
                    <button onclick="lfn_btn('cartSelectDel'); return false;">장바구니 비우기</button>
                    <button onclick="lfn_btn('cartApplication'); return false;" class='bg_color'>전체과정 주문</button>
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

<script src='/resources/homepage/js/dev_sub.js'></script>
</body>
</html>