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
    <link rel='stylesheet' href='/resources/homepageCch/css/initialization.css'>
    <link rel='stylesheet' href='/resources/homepageCch/css/classroom/basket.css'>
</head>

<script type="text/javascript">

function lfn_kindChg() {
	if ( $("#LGD_CUSTOM_USABLEPAY").val() == "SC0030" ) {
		$("#bankLi").css("display","table-row");
	} else {
		$("#bankLi").css("display","none");
	}
}

function lfn_pointChg() {
	if ( formValid.check("paymentPoint",{isNecess:true,isNum:true}) == false )
		return false;

	if ( parseInt($("#paymentPoint").val()) > parseInt($("#remainPoint").val()) ) {
		alert("사용가능 포인트를 넘었습니다. 포인트를 다시 입력해주세요.");
		return false;
	}

	if ( parseInt($("#paymentPoint").val()) > 0 && parseInt($("#paymentPoint").val()) < 1000 ) {
		$("#paymentPoint").val(0);
		alert("1,000 원 단위로 포인트를 사용하셔야 합니다.");
		return false;
	} 
	
	if ( parseInt($("#paymentPoint").val()) > 0 && parseInt($("#paymentPoint").val()) % 1000 != 0 ) {
		$("#paymentPoint").val(parseInt($("#paymentPoint").val()) - parseInt($("#paymentPoint").val()) % 1000);
		alert("1,000 원 단위로 포인트를 사용하셔야 합니다.");
		return false;
	} 

	$("#paymentCost").val(parseInt($("#totalCost").val()) - parseInt($("#paymentPoint").val()));
	$("#LGD_AMOUNT").val(parseInt($("#totalCost").val()) - parseInt($("#paymentPoint").val()));
	
	$("#paymentCost1").html(checkThousand(parseInt($("#totalCost").val()) - parseInt($("#paymentPoint").val())));
	$("#paymentCost2").html(checkThousand(parseInt($("#totalCost").val()) - parseInt($("#paymentPoint").val())));
	
	return true;
}

function lfn_pay() {
	if ( $("#LGD_CUSTOM_USABLEPAY").val() == "SC0030" && $("#paymentBank").val() == "" ) {
		alert("계좌번호를 선택하셔야 합니다.");
		$("#paymentBank").focus();
		return false;
	}

	if ( formValid.check("paymentPoint",{isNecess:true,isNum:true}) == false )
		return false;

	if ( parseInt($("#paymentPoint").val()) > 0 && parseInt($("#paymentPoint").val()) > parseInt($("#remainPoint").val()) ) {
		alert("사용가능 포인트를 넘었습니다.");
		$("#paymentPoint").focus();
		return false;
	}

	if ( parseInt($("#paymentPoint").val()) > 0 && parseInt($("#paymentPoint").val()) < 1000 ) {
		$("#paymentPoint").val(0);
		alert("1,000 원 단위로 포인트를 사용하셔야 합니다.");
		return false;
	} 
	
	if ( parseInt($("#paymentPoint").val()) % 1000 != 0 ) {
		$("#paymentPoint").val(parseInt($("#paymentPoint").val()) - parseInt($("#paymentPoint").val()) % 1000);
		alert("1,000 원 단위로 포인트를 사용하셔야 합니다.");
		return false;
	} 
	
	$("#paymentCost").val(parseInt($("#totalCost").val()) - parseInt($("#paymentPoint").val()));
	$("#LGD_AMOUNT").val(parseInt($("#totalCost").val()) - parseInt($("#paymentPoint").val()));

	$("#paymentKind").val($("#LGD_CUSTOM_USABLEPAY").val());

	if ( $("#paymentCost").val() == "0" && $("#LGD_CUSTOM_USABLEPAY").val() != "SC0030" ) {
		alert("계좌이체를 선택하셔야 합니다.");
		return false;
	}

	if ( confirm("결제하시겠습니까?") ) {
		if ( $("#LGD_CUSTOM_USABLEPAY").val() == "SC0030" ) {
			var today = new Date();
			$("#approvalId").val(today.getTime());
			
			$.ajax({
				type :"POST",
				url : context +"/paymentGateway/cashApproval.do",
				dataType :"json",
				data : $("#frm").serialize(),
				success : function(json){
					if ( json.rtnMode == "OK") {
						alert("입금 확인후에 수강신청이 완료됩니다.\n승인후에 나의 강의실에서 과정을 들으시면 됩니다.");
						page.goPage('/normalUser/waitingCourseList');
					}
				},
				error : function(e) {
					alert("<spring:message code="lms.msg.systemError" text="-" />");
				}
			})
		} else {
			window.open("",	"xpay", "width=660,height=680,scrollbars=no,resizable=no,status=no,toolbar=no,menubar=no");
			document.frm.target = "xpay";
			document.frm.submit();
		}
	}
}

function LPad(digit, size, attatch) {
    var add = "";
    digit = digit.toString();

    if (digit.length < size) {
        var len = size - digit.length;
        for (i = 0; i < len; i++) {
            add += attatch;
        }
    }
    return add + digit;
}

$(document.body).ready(function () {
	var now = new Date();
	var years = now.getFullYear();
	var months = LPad(now.getMonth() + 1, 2, "0");
	var dates = LPad(now.getDate(), 2, "0");
	var hours = LPad(now.getHours(), 2, "0");
	var minutes = LPad(now.getMinutes(), 2, "0");
	var seconds = LPad(now.getSeconds(), 2, "0");
	var timeValue = years + months + dates + hours + minutes + seconds; 
	document.getElementById("LGD_OID").value = timeValue;
	document.getElementById("LGD_TIMESTAMP").value = timeValue;
	document.getElementById("approvalId").value = timeValue;
});
</script>

<body>

<form id="frm" name="frm" method="post" action="/paymentGateway/payreqCrossplatform.do" onsubmit="return false;">
	<div style="display:none">
		<!-- 이것은 자동이동을 막기위함이다. -->
		<input type="submit" onclick="return false;" />
		<input type="text"/>
	</div>
	<input id="courseId" name="courseId" type="hidden" value="${set.condiVO.courseId}"/>
	<input id="cartWeeks" name="cartWeeks" type="hidden" value="${set.condiVO.cartWeeks}"/>
	<input type="hidden" name="approvalId" id="approvalId" value=""/>

	<input type="hidden" name="CST_MID" id="CST_MID" value="<%=request.getAttribute("g_CST_MID")%>"/>
	<input type="hidden" name="CST_PLATFORM" id="CST_PLATFORM" value="<%=request.getAttribute("g_CST_PLATFORM")%>"/>
	<input type="hidden" name="LGD_WINDOW_TYPE" id="LGD_WINDOW_TYPE" value="iframe"/>
	<input type="hidden" name="LGD_CUSTOM_SWITCHINGTYPE" id="LGD_CUSTOM_SWITCHINGTYPE" value="IFRAME"/>
	<input type="hidden" name="LGD_OID" id="LGD_OID" value=""/>
	<input type="hidden" name="LGD_TIMESTAMP" id="LGD_TIMESTAMP" value=""/>
	<input type="hidden" name="LGD_PRODUCTINFO" id="LGD_PRODUCTINFO" value="${set.condiVO.coursePayDesc}"/>

<frameset rows='*'>
    <div class='wrap'>
        <!-- PC HEADER -->
        <%@ include file="../common/mainTopCch.jsp" %>
        <!-- HEAD END -->

        <!-- CONTENTS -->
        <div class='contents_wrap process' >
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
                        <li class='basket_step_list clear_fix'>
                            <span><img src='/resources/homepageCch/img/classroom/basket_step1_inactive.png' alt=' '></span>
                            <p class='basket_title'>장바구니</p>
                        </li>
                        <li class='basket_arr'>
                            <img src='/resources/homepageCch/img/etc/arr_right.png' alt=' '>
                        </li>
                        <li class='basket_step_list clear_fix on'>
                            <span><img src='/resources/homepageCch/img/classroom/basket_step2_active.png' alt=' '></span>
                            <p class='basket_title'>결제정보입력</p>
                            <p>총 결제금액을 확인하시고 배송 및 결제정보를 확인해주십시오.</p>
                        </li>
                        <li class='basket_arr'>
                            <img src='/resources/homepageCch/img/etc/arr_right.png' alt=' '>
                        </li>
                        <li class='basket_step_list clear_fix'>
                            <span><img src='/resources/homepageCch/img/classroom/basket_step3_inactive.png' alt=' '></span>
                            <p class='basket_title'>결제완료</p>
                        </li>
                    </ul>
                    <p class='basket_note'>
                        <span></span>고객님께서 장바구니에 담으신 과정 및 상품입니다.<br>
                        <span></span>결제시 가격정보를 확인한 후 구매하시기 바랍니다.<br>
                        <span></span>과정은 매월 21일 기준으로 정보 변경됩니다. (참고도서 포함)
                    </p>
                </div>

                <p class='basket_payment_title'>결제하는 과정 및 상품</p>
                <div class='basket_payment lectures'>
                    <div class='basket_lectures_title clear_fix'>
                        <p>강의 및 교재 정보</p>
                        <p class='sum'>주문 금액</p>
                    </div>
<c:forEach var="row" items="${set.courseList}" varStatus="idx">
                    <div class='basket_lectures_lecture clear_fix'>
                        <p>[${row.categoryName}] ${row.courseName}</p>
                        <p class='sum'><span class='text'><fmt:formatNumber value="${row.courseCost}" type="number"/></span>원</p>
	<c:if test="${row.courseCost ne row.courseOrgCost}">
						<p class='sum'>(시중가격 : <span class='text'><fmt:formatNumber value="${row.courseOrgCost}" type="number"/></span>원)</p>
	</c:if>
                    </div>
	<c:if test="${not empty row.cartWeekList}">
                    <p class='register_course_list_text'>차시 리스트</p>
                    <div class='register_course_list clear_fix'>
		<c:forEach var="subRow" items="${row.cartWeekList}">
                        <p class='n_course_list_left'>${subRow.week}. ${subRow.title}</p>
                        <p class='n_course_list_right'><fmt:formatNumber value="${subRow.weekCost}" type="number"/> 원</p>
		</c:forEach>                        
                    </div>
	</c:if>                    
</c:forEach>                    
                    <div class='basket_lectures_result clear_fix'>
                        <p class='first'>주문금액 : <span class='text'><fmt:formatNumber value="${set.condiVO.paymentCost}" type="number"/></span>원</p>
                        <span class='ic_first'><img src='/resources/homepageQch/img/classroom/basket_ic1.png' alt=' '></span>
                        <p class='second'>적용포인트<img src="/resources/homepageQch/img/classroom/ic_att.png"> : <span class='text'><input id="paymentPoint" name="paymentPoint" type="text" value="0" onblur="lfn_pointChg();" class="basket_discount"/></span>원</p>
                        <span class='ic_second'><img src='/resources/homepageQch/img/classroom/basket_ic2.png' alt=' '></span>
                        <p class='last_payment'>최종결제금액 : <span class='text' id="paymentCost1"><fmt:formatNumber value="${set.condiVO.paymentCost}" type="number"/></span>원</p>
                        <p class='third_text'><img src="/resources/homepageQch/img/classroom/ic_att.png">포인트는 1,000 단위로 사용이 가능합니다.</p>
                        
                        <input id="totalCost" name="totalCost" type="hidden" readonly value="${set.condiVO.paymentCost}"/>
			          	<input id="remainPoint" name="remainPoint" type="hidden" value="${set.condiVO.point}"/>
			          	<input id="paymentCost" name="paymentCost" type="hidden" value="${set.condiVO.paymentCost}"/>
			          	<input type="hidden" name="LGD_AMOUNT" id="LGD_AMOUNT" class="w100" readonly value="${set.condiVO.paymentCost}" maxlength="9"/>
                    </div>
                </div>
                <div class="basket_point">
                	<p>잔여 포인트 : <span class='t_point_txt'><fmt:formatNumber value="${set.condiVO.point}" type="number"/></span>P</p>
                </div>

                <p class='basket_payment_title'>주문하시는 분 정보</p>
                <div class='basket_payment user'>
                    <ul>
                        <li class='basket_user_list clear_fix'>
                            <span></span>
                            <p class='basket_user_type'>주문자명</p>
                            <p>${set.memberVO.userName}<input type="hidden" name="LGD_BUYER" class="w100" readonly value="${set.memberVO.userName}"/></p>
                        </li>
                        <li class='basket_user_list clear_fix'>
                            <span></span>
                            <p class='basket_user_type'>E - mail</p>
                            <p>${set.memberVO.email}<input type="hidden" name="LGD_BUYEREMAIL" class="w200" readonly value="${set.memberVO.email}" maxlength="30" /></p>
                        </li>
                        <li class='basket_user_list clear_fix'>
                            <span></span>
                            <p class='basket_user_type'>휴대폰번호</p>
                            <p>${set.memberVO.mobile}<input type="hidden" name="buyr_tel2" class="w100" readonly value="${set.memberVO.mobile}"/></p>
                        </li>
                    </ul>
                </div>

                <p class='basket_payment_title'>결제정보 입력 <span><img src="/resources/homepageQch/img/classroom/ic_att.png">0원 결제(무료강의, 전액 포인트 결제) 시에는 결제방식에서 [계좌이체]를 선택하셔야 수강이 가능합니다.</span></p>
                <div class='basket_payment info'>    
                    <ul>
                        <li class='basket_info_list clear_fix'>
                            <span></span>
                            <p class='basket_info_type'>결제방식 선택</p>
                            <select id="LGD_CUSTOM_USABLEPAY" name="LGD_CUSTOM_USABLEPAY" onchange="lfn_kindChg()" style="width:160px">
                                <option value="SC0010">신용카드</option>				
								<option value="SC0030">계좌이체</option>				
								<option value="SC0060">휴대폰 소액결제</option>				
								<!-- option value="SC0040">무통장입금</option>				
								<option value="SC0090">OK캐쉬백</option>				
								<option value="SC0111">문화상품권</option>				
								<option value="SC0112">게임문화상품권</option-->	
                            </select>
                            <input type="hidden" name="paymentKind" id="paymentKind"/>
                        </li>
                        <li class='basket_info_list clear_fix' id="bankLi" style="display:none">
                            <span></span>
                            <p class='basket_info_type'>은행 선택</p>
                            <select id="paymentBank" name="paymentBank" style="width:300px">
									<option value="" selected></option>
									<c:forEach var="row" items="${set.bankList}" varStatus="idx">
										<option value="${row.seq}">${row.bankName} ${row.accNo} ${row.user}</option>
									</c:forEach>
								</select>
                        </li>
                        <div style="height:10px;"></div>
                        <li class='basket_info_list clear_fix'>
                            <span></span>
                            <p class='basket_info_type'>결제금액</p>
                            <p>최종결제금액 : <span class='text' id="paymentCost2"><fmt:formatNumber value="${set.condiVO.paymentCost}" type="number"/></span>원</p>
                        </li>
                    </ul>
                </div>

                <div class='detail_btn_area'>
                    <button id="approvalBtn" onclick="lfn_pay();" class='bg_color'>결제하기</button>
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

<script src='/resources/homepageCch/js/sub.js'></script>
</body>
</html>