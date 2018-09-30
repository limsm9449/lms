<%@ page contentType="text/html;charset=utf-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="ko" xml:lang="ko">
<head>
<title>
</title>

<%@ include file="../common/commUserInclude.jsp" %>


</head>


<script type="text/javascript">

function lfn_kindChg() {
	if ( $("#LGD_CUSTOM_USABLEPAY").val() == "SC0030" ) {
		$("#bankTr").css("display","table-row");
		$("#orderTr").css("display","none");
	} else {
		$("#bankTr").css("display","none");
		$("#orderTr").css("display","table-row");
	}
}

function lfn_pointChg() {
	if ( formValid.check("paymentPoint",{isNecess:true,isNum:true}) == false )
		return false;

	if ( parseInt($("#paymentPoint").val()) > parseInt($("#remainPoint").val()) ) {
		alert("사용가능 포인트를 넘었습니다. 포인트를 다시 입력해주세요.");
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

	if ( parseInt($("#paymentPoint").val()) > parseInt($("#remainPoint").val()) ) {
		alert("사용가능 포인트를 넘었습니다.");
		$("#paymentPoint").focus();
		return false;
	}
	
	$("#paymentCost").val(parseInt($("#totalCost").val()) - parseInt($("#paymentPoint").val()));
	$("#LGD_AMOUNT").val(parseInt($("#totalCost").val()) - parseInt($("#paymentPoint").val()));
	
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
					page.goPage("/normalUser/attendCourseList");
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
	<input id="courseId" name="courseId" type="hidden" value="${set.condiVO.courseId}"/>
	<input type="hidden" name="approvalId" id="approvalId" value=""/>

	<input type="hidden" name="CST_MID" id="CST_MID" value="<%=request.getAttribute("g_CST_MID")%>"/>
	<input type="hidden" name="CST_PLATFORM" id="CST_PLATFORM" value="<%=request.getAttribute("g_CST_PLATFORM")%>"/>
	<input type="hidden" name="LGD_WINDOW_TYPE" id="LGD_WINDOW_TYPE" value="iframe"/>
	<input type="hidden" name="LGD_CUSTOM_SWITCHINGTYPE" id="LGD_CUSTOM_SWITCHINGTYPE" value="IFRAME"/>
	<input type="hidden" name="LGD_OID" id="LGD_OID" value=""/>
	<input type="hidden" name="LGD_TIMESTAMP" id="LGD_TIMESTAMP" value=""/>
	<input type="hidden" name="LGD_PRODUCTINFO" id="LGD_PRODUCTINFO" value="${set.condiVO.coursePayDesc}"/>



<!-- skipnav -->
<div id="skipnav"><a href="#side" class="skip">좌측메뉴 바로가기</a></div>
<div id="skipnav"><a href="#contents" class="skip">컨텐츠 바로가기</a></div>
<!-- skipnav -->

<!-- wrap -->
<div id="wrap" class="site">
  <%@ include file="../home/userTop.jsp" %>
  <hr />
  <!-- container -->
  <div id="container" class="site">
   	 	<!-- side -->
   	 	<%
   	 		String menuId = "cart";
   	 	%>
		<%@ include file="../home/userLeft2.jsp" %>
		<!-- end side -->
		
    	<!-- contents -->
		<div id="contents" class="site">
			<!-- location -->
			<div id="location"><a href="/" class="home">HOME</a><span>&gt;</span>수강신청<span>&gt;</span>결제정보입력</div>
			<!-- title -->
			<h3 class="tit_big">장바구니</h3>
		      <div class="artcle">
		      	<div class="orderflow_box">
		          <img src="/resources/images/sub/img_orderflow_2.png" alt="결제순서 2단계 결제정보입력" />
		          <ul class="order_tip">
		            <li>고객님께서 장바구니에 담으신 과정 및 상품입니다. 담긴 날로부터 30일간 자동 저장됩니다.</li>
								<li>결제 시 가격정보를 확인 후 구매하시기 바랍니다.</li>
								<li>과정은 매월 21일 기준으로 정보 변경됩니다.(참고도서 포함)</li>
		          </ul>
		        </div>
		        <div class="payment_box">
		          <p class="big_4"><span class="blue">결제하는 과정 및 상품</span></p>
		          <table class="cart_list">
		          	<caption>결제 리스트</caption>
		  					<thead>
		  					  <tr class="guide">
		    						<th width="10"></th>
		    						<th></th>
		    						<th width="160"></th>
		    					</tr>
		  					</thead>
		  					<tbody>
		  						<tr class="head">
		  							<td></td>
		  							<td class="center">강의 및 교재 정보</td>
		  							<td class="center">금액</td>
		  						</tr>
					  <c:forEach var="row" items="${set.courseList}" varStatus="idx">
			              <tr <c:if test="${idx.index + 1 eq fn:length(set.courseList)}"> class="last_line"</c:if>>
			              	<td class="center"></td>
			                <td class="title">
			                	<nobr><p class="subject"><span class="blue">[${row.categoryName}] ${row.courseName}</span></p></nobr>
								<c:forEach var="subRow" items="${row.cartWeekList}">
									<nobr><p class="chap">${subRow.week}. ${subRow.title} => ${subRow.weekCost}</p></nobr>
									<br>
								</c:forEach>
			               	</td>
			                <td class="center"><fmt:formatNumber value="${row.courseCost}" type="number"/> 원</td>
			              </tr>
		              </c:forEach>
		            </tbody>
		          </table>
		          <div id="payment_total">
		          	<p>
			          	주문금액 :
			          	<span class="blue big"><fmt:formatNumber value="${set.condiVO.paymentCost}" type="number"/></span>
			          	원
			          	<span class="icon"><img src="/resources/images/sub/icon/icon_minus.png" alt="" /></span>
			          	포인트 :
			          	<span class="blue big"><input id="paymentPoint" name="paymentPoint" type="text" value="0" onblur="lfn_pointChg();" style="width:40px"/></span>
			          	원 (잔여 포인트 : ${set.condiVO.point})
			          	<span class="icon"><img src="/resources/images/sub/icon/icon_eq.png" alt="" /></span>
			          	<span class="strong">최종 결제금액 :</span>
			          	<span class="blue big" id="paymentCost1"><fmt:formatNumber value="${set.condiVO.paymentCost}" type="number"/></span>
			          	원
			          	<input id="totalCost" name="totalCost" type="hidden" readonly value="${set.condiVO.paymentCost}"/>
			          	<input id="remainPoint" name="remainPoint" type="hidden" value="${set.condiVO.point}"/>
			          	<input id="paymentCost" name="paymentCost" type="hidden" value="${set.condiVO.paymentCost}"/>
			          	<input type="hidden" name="LGD_AMOUNT" id="LGD_AMOUNT" class="w100" readonly value="${set.condiVO.paymentCost}" maxlength="9"/>
		          	</p>
		          </div>
				  <div class="space_div"></div>
		          <p class="big_4 no_bd"><span class="blue">주문하시는 분 정보</span></p>
		          <table class="mem_form">
		            <caption>결제자 정보</caption>
		  					<thead>
		  					  <tr class="guide">
		    						<th width="140"></th>
		    						<th></th>
		    					</tr>
		  					</thead>
		  					<tbody>
	                    <tr>
	                        <th>주문자명</th>
	                        <td>${set.memberVO.userName}<input type="hidden" name="LGD_BUYER" class="w100" readonly value="${set.memberVO.userName}"/></td>
	                    </tr>
	                    <tr>
	                        <th>E-mail</th>
	                        <td>${set.memberVO.email}<input type="hidden" name="LGD_BUYEREMAIL" class="w200" readonly value="${set.memberVO.email}" maxlength="30" /></td>
	                    </tr>
	                    <tr>
	                        <th>휴대폰번호</th>
	                        <td>${set.memberVO.mobile}<input type="hidden" name="buyr_tel2" class="w100" readonly value="${set.memberVO.mobile}"/></td>
	                    </tr>		
		            </tbody>  
		          </table>
		          <br />
		          <br />
		          <p class="big_4 no_bd"><span class="blue">결제정보 입력</span></p>
		          <table class="mem_form">
		            <caption>결제 선택</caption>
		  					<thead>
		  					  <tr class="guide">
		    						<th width="140"></th>
		    						<th></th>
		    					</tr>
		  					</thead>
		  					<tbody>
		              <tr>
		                <th><label for="LGD_CUSTOM_USABLEPAY" class="must">결제방식 선택</label></th>
		                <td>
                            <select id="LGD_CUSTOM_USABLEPAY" name="LGD_CUSTOM_USABLEPAY" onchange="lfn_kindChg()" style="width:100px">
                                <option value="SC0010">신용카드</option>				
								<option value="SC0030">계좌이체</option>				
								<!-- option value="SC0040">무통장입금</option-->				
								<option value="SC0060">휴대폰</option>				
								<option value="SC0070">유선전화결제</option>				
								<option value="SC0090">OK캐쉬백</option>				
								<option value="SC0111">문화상품권</option>				
								<option value="SC0112">게임문화상품권</option>	
                            </select>
						</td>
		              </tr>
                      <tr id="bankTr" style="display:none">
                        <th><label for="paymentBank" class="must">은행</label></th>
	                        <td>
								<select id="paymentBank" name="paymentBank" style="width:200px">
									<option value="" selected></option>
									<c:forEach var="row" items="${set.bankList}" varStatus="idx">
										<option value="${row.seq}">${row.bankName} ${row.accNo} ${row.user}</option>
									</c:forEach>
								</select>
	                        </td>
                      </tr>
		              <tr>
		                <th><label for="pay_type" class="must">결제금액</label></th>
		                <td><p class="total">최종결제 금액 : <span class="blue big" id="paymentCost2"><fmt:formatNumber value="${set.condiVO.paymentCost}" type="number"/></span>원</p></td>
		              </tr>
		            </tbody>
		          </table>
		        	<div class="center_btn"><a href="javascript:" id="approvalBtn" onclick="lfn_pay();"><img src="/resources/images/sub/btn_pay_next.png" alt="결제신청" /></a></div>
		          
		          
		        </div>
		      </div>
			
		</div>
		<!-- end content -->

	</div>
  <!-- end container -->
  <!-- footer_wrap -->
	<%@ include file="../home/bottom.jsp" %>
  <!-- end footer_wrap -->
</div>


</form>


</body>
</html>

