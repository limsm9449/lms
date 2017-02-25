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
function lfn_btn(pKind, pParam) {
	if ( pKind == "approval") {
		if ( lfn_validate() == false )
			return false;
		
		btnUnbind("approvalBtn");
		if ( $("#pay_method").val() == "CASH" ) {
			var today = new Date();
			$("#approvalId").val(today.getTime());

			$.ajax({
				type :"POST",
				url : context +"/main/approval.do",
				dataType :"json",
				data : $("#frm").serialize(),
				success : function(json){
					if ( json.rtnMode == "OK") {
						alert("입금 확인후에 수강신청이 완료됩니다.\n승인후에 나의 강의실에서 과정을 들으시면 됩니다.");
						self.close();
						page.goHome();
					}
				},
				error : function(e) {
					alert("<spring:message code="lms.msg.systemError" text="-" />");
				}
			})
		} else {
			gfn_popup("/main/approvalP","courseId=" + $("#courseId").val() + 
										"&totalCost=" + $("#totalCost").val() + 
										"&paymentPoint=" + $("#paymentPoint").val() + 
										"&paymentCost=" + $("#paymentCost").val() +
										"&pay_method=" + $("#pay_method").val() +
										"&paymentBank=" + $("#paymentBank").val()
										,400,300);
		}
	}
}

function lfn_validate() {
	if ( $("#pay_method").val() == "CASH" && $("#paymentBank").val() == "" ) {
		alert("계좌번호를 선택하셔야 합니다.");
		$("#paymentBank").focus();
		return false;
	}
	
	return true;
}

function lfn_kindChg() {
	if ( $("#pay_method").val() == "CASH" ) {
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
		alert("사용가능 포인트를 넘었습니다.");
		$("#paymentPoint").focus();
		return false;
	}
	
	$("#paymentCost").val(parseInt($("#totalCost").val()) - parseInt($("#paymentPoint").val()));
	$("#good_mny").val(parseInt($("#totalCost").val()) - parseInt($("#paymentPoint").val()));
	
	$("#paymentCost1").html(checkThousand(parseInt($("#totalCost").val()) - parseInt($("#paymentPoint").val())));
	$("#paymentCost2").html(checkThousand(parseInt($("#totalCost").val()) - parseInt($("#paymentPoint").val())));
	
	return true;
}

function lfn_pay() {
	if ( $("#pay_method").val() == "CASH" && $("#paymentBank").val() == "" ) {
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
	$("#good_mny").val(parseInt($("#totalCost").val()) - parseInt($("#paymentPoint").val()));
	
	//은행/카드 구분
	if ( $("#pay_method").val() == "CASH" )
		$("#paymentKind").val("CASH");
	else
		$("#paymentKind").val("CARD");
	
	btnUnbind("approvalBtn");
	if ( $("#pay_method").val() == "CASH" ) {
		var today = new Date();
		$("#approvalId").val(today.getTime());

		$.ajax({
			type :"POST",
			url : context +"/main/approval.do",
			dataType :"json",
			data : $("#order_info").serialize(),
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
		//결재 activeX
		jsf__pay(document.order_info);

		//결재번호 및 결재종류
		$("#approvalId").val($("#ordr_idxx").val());
		$("#paymentKind").val($("#pay_method").val());
		
		document.order_info.submit();
	}
}
</script>


<%@ include file="./cfg/site_conf_inc.jsp"%>
<script type="text/javascript" src="<%= g_conf_js_url %>"></script>

<%
    /* = -------------------------------------------------------------------------- = */
    /* =   Javascript source Include END                                            = */
    /* ============================================================================== */
%>
    <script type="text/javascript">
        /* 플러그인 설치(확인) */
        StartSmartUpdate();
        
        /*  해당 스크립트는 타브라우져에서 적용이 되지 않습니다.
        if( document.Payplus.object == null )
        {
            openwin = window.open( "chk_plugin.html", "chk_plugin", "width=420, height=100, top=300, left=300" );
        }
        */

        /* Payplus Plug-in 실행 */
        function  jsf__pay( form )
        {
            var RetVal = false;

            /* Payplus Plugin 실행 */
            if ( MakePayMessage( form ) == true )
            {
                openwin = window.open( "/homepage/proc_win.html", "proc_win", "width=449, height=209, top=300, left=300" );
                RetVal = true ;
            }
            
            else
            {
                /*  res_cd와 res_msg변수에 해당 오류코드와 오류메시지가 설정됩니다.
                    ex) 고객이 Payplus Plugin에서 취소 버튼 클릭시 res_cd=3001, res_msg=사용자 취소
                    값이 설정됩니다.
                */
                res_cd  = document.order_info.res_cd.value ;
                res_msg = document.order_info.res_msg.value ;

            }

            return RetVal ;
        }

        // Payplus Plug-in 설치 안내 
        function init_pay_button()
        {
            if ((navigator.userAgent.indexOf('MSIE') > 0) || (navigator.userAgent.indexOf('Trident/7.0') > 0))
            {
                try
                {
                    if( document.Payplus.object == null )
                    {
                        document.getElementById("display_setup_message").style.display = "block" ;
                    }
                    else{
                        document.getElementById("display_pay_button").style.display = "block" ;
                    }
                }
                catch (e)
                {
                    document.getElementById("display_setup_message").style.display = "block" ;
                }
            }
            else
            {
                try
                {
                    if( Payplus == null )
                    {
                        document.getElementById("display_setup_message").style.display = "block" ;
                    }
                    else{
                        document.getElementById("display_pay_button").style.display = "block" ;
                    }
                }
                catch (e)
                {
                    document.getElementById("display_setup_message").style.display = "block" ;
                }
            }
        }

        /* 주문번호 생성 예제 */
        function init_orderid()
        {
            var today = new Date();
            var year  = today.getFullYear();
            var month = today.getMonth() + 1;
            var date  = today.getDate();
            var time  = today.getTime();

            if(parseInt(month) < 10) {
                month = "0" + month;
            }

            if(parseInt(date) < 10) {
                date = "0" + date;
            }

            var order_idxx = "QP" + year + "" + month + "" + date + "" + time;

            document.order_info.ordr_idxx.value = order_idxx;
            document.order_info.good_name.value = order_idxx;
    
            /*
             * 인터넷 익스플로러와 파이어폭스(사파리, 크롬.. 등등)는 javascript 파싱법이 틀리기 때문에 object 가 인식 전에 실행 되는 문제
             * 기존에는 onload 부분에 추가를 했지만 setTimeout 부분에 추가
             * setTimeout 300의 의미는 플러그인 인식속도에 따른 여유시간 설정
             * - 20101018 -
             */
            setTimeout("init_pay_button();",300);
        }

        /* onLoad 이벤트 시 Payplus Plug-in이 실행되도록 구성하시려면 다음의 구문을 onLoad 이벤트에 넣어주시기 바랍니다. */
        function onload_pay()
        {
             if( jsf__pay(document.order_info) )
                document.order_info.submit();
        }

    </script>
    
<body onload="init_orderid();">

<%
	/* 환경 설정 */
%>
<%!
    /* ============================================================================== */
    /* =   null 값을 처리하는 메소드                                                = */
    /* = -------------------------------------------------------------------------- = */
        public String f_get_parm( String val )
        {
          if ( val == null ) val = "";
          return  val;
        }
    /* ============================================================================== */
%>
   

<body>

<form id="order_info" name="order_info" method="post" action="/main/ppAxHub.do" onsubmit="return false;">
	<input id="courseId" name="courseId" type="hidden" value="${set.condiVO.courseId}"/>
	<input id="approvalId" name="approvalId" type="hidden" value=""/>
	<input id="paymentKind" name="paymentKind" type="hidden" value=""/>

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
			          	<input type="hidden" name="good_mny" id="good_mny" class="w100" readonly value="${set.condiVO.paymentCost}" maxlength="9"/>
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
	                    <!-- 주문번호(ordr_idxx) -->
	                    <tr id="orderTr">
	                        <th>주문 번호</th>
	                        <td><input type="text" name="ordr_idxx" id="ordr_idxx" class="w200" value="" readonly maxlength="40"/></td>
	                    </tr>
	                    <!-- 상품명(good_name) -->
	                    <tr style="display:none">
	                        <th>상품명</th>
	                        <td><input type="text" name="good_name" class="w100" value=""/></td>
	                    </tr>
	                    <!-- 주문자명(buyr_name) -->
	                    <tr>
	                        <th>주문자명</th>
	                        <td>${set.memberVO.userName}<input type="hidden" name="buyr_name" class="w100" readonly value="${set.memberVO.userName}"/></td>
	                    </tr>
	                    <!-- 주문자 E-mail(buyr_mail) -->
	                    <tr>
	                        <th>E-mail</th>
	                        <td>${set.memberVO.email}<input type="hidden" name="buyr_mail" class="w200" readonly value="${set.memberVO.email}" maxlength="30" /></td>
	                    </tr>
	                    <!-- 주문자 연락처1(buyr_tel1) -->
	                    <tr style="display:none">
	                        <th>전화번호</th>
	                        <td><input type="text" name="buyr_tel1" class="w100" readonly value="${set.memberVO.homeTel}"/></td>
	                    </tr>
	                    <!-- 휴대폰번호(buyr_tel2) -->
	                    <tr>
	                        <th>휴대폰번호</th>
	                        <td>${set.memberVO.mobile}<input type="hidden" name="buyr_tel2" class="w100" readonly value="${set.memberVO.mobile}"/></td>
	                    </tr>		
		              <tr>
		                <th><label for="homeZip1" class="must">주소 / 연락처</label></th>
		                <td>
		                .....................
		                </td>
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
		                <th><label for="pay_method" class="must">결제방식 선택</label></th>
		                <td>
                            <select id="pay_method" name="pay_method" onchange="lfn_kindChg()" style="width:100px">
                                <option value="100000000000">신용카드</option>
								<option value="CASH">무통장입금</option>
                                <!--option value="010000000000">계좌이체</option>
                                <option value="001000000000">가상계좌</option>
                                <option value="000100000000">포인트</option>
                                <option value="000010000000">휴대폰</option>
                                <option value="000000001000">상품권</option>
                                <option value="000000000010">ARS</option>
                                <option value="111000000000">신용카드/계좌이체/가상계좌</option-->
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
		          <p>※ 신용카드 및 계좌 관련한 모든 정보 입력은 (주)KCP에서 이루어지며 귀하의 신용카드 관련정보를 입력 받지 않습니다.</p>
							<p>※ 신용카드 결제나 계좌이체를 하시려면 결제 버튼을 클릭하세요.</p>
		        	<div class="center_btn"><a href="javascript:" id="approvalBtn" onclick="lfn_pay();"><img src="/resources/images/sub/btn_pay_next.png" alt="결제신청" /></a></div>
		          
		          <!-- Payplus Plug-in 설치 안내 -->
		          <div id="display_setup_message" style="display:none">
		             <p class="txt">
		             결제를 계속 하시려면 상단의 노란색 표시줄을 클릭 하시거나 <a href="http://pay.kcp.co.kr/plugin_new/file/KCPUXWizard.exe"><span>[수동설치]</span></a>를 눌러
		             Payplus Plug-in을 설치하시기 바랍니다.
		             [수동설치]를 눌러 설치하신 경우 새로고침(F5)키를 눌러 진행하시기 바랍니다.
		             </p>
		           </div>
		          
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

<%
    /* = -------------------------------------------------------------------------- = */
    /* =   1. 주문 정보 입력 END                                                    = */
    /* ============================================================================== */
%>

<%
    /* ============================================================================== */
    /* =   2. 가맹점 필수 정보 설정                                                 = */
    /* = -------------------------------------------------------------------------- = */
    /* =   ※ 필수 - 결제에 반드시 필요한 정보입니다.                               = */
    /* =   site_conf_inc.jsp 파일을 참고하셔서 수정하시기 바랍니다.                 = */
    /* = -------------------------------------------------------------------------- = */
    // 요청종류 : 승인(pay)/취소,매입(mod) 요청시 사용
%>
    <input type="hidden" name="req_tx"          value="pay" />
    <input type="hidden" name="site_cd"         value="<%= g_conf_site_cd   %>" />
    <input type="hidden" name="site_name"       value="<%= g_conf_site_name %>" />
<%
    /*
       할부옵션 : Payplus Plug-in에서 카드결제시 최대로 표시할 할부개월 수를 설정합니다.(0 ~ 18 까지 설정 가능)
       ※ 주의  - 할부 선택은 결제금액이 50,000원 이상일 경우에만 가능, 50000원 미만의 금액은 일시불로만 표기됩니다
                  예) value 값을 "5" 로 설정했을 경우 => 카드결제시 결제창에 일시불부터 5개월까지 선택가능
    */
%>
    <input type="hidden" name="quotaopt"        value="12"/>
    <!-- 필수 항목 : 결제 금액/화폐단위 -->
    <input type="hidden" name="currency"        value="WON"/>
<%
    /* = -------------------------------------------------------------------------- = */
    /* =   2. 가맹점 필수 정보 설정 END                                             = */
    /* ============================================================================== */
%>

<%
    /* ============================================================================== */
    /* =   3. Payplus Plugin 필수 정보(변경 불가)                                   = */
    /* = -------------------------------------------------------------------------- = */
    /* =   결제에 필요한 주문 정보를 입력 및 설정합니다.                            = */
    /* = -------------------------------------------------------------------------- = */
%>
    <!-- PLUGIN 설정 정보입니다(변경 불가) -->
    <input type="hidden" name="module_type"     value="<%= module_type %>"/>
<!--
      ※ 필 수
          필수 항목 : Payplus Plugin에서 값을 설정하는 부분으로 반드시 포함되어야 합니다
          값을 설정하지 마십시오
-->
    <input type="hidden" name="res_cd"          value=""/>
    <input type="hidden" name="res_msg"         value=""/>
    <input type="hidden" name="tno"             value=""/>
    <input type="hidden" name="trace_no"        value=""/>
    <input type="hidden" name="enc_info"        value=""/>
    <input type="hidden" name="enc_data"        value=""/>
    <input type="hidden" name="ret_pay_method"  value=""/>
    <input type="hidden" name="tran_cd"         value=""/>
    <input type="hidden" name="bank_name"       value=""/>
    <input type="hidden" name="bank_issu"       value=""/>
    <input type="hidden" name="use_pay_method"  value=""/>

    <!--  현금영수증 관련 정보 : Payplus Plugin 에서 설정하는 정보입니다 -->
    <input type="hidden" name="cash_tsdtime"    value=""/>
    <input type="hidden" name="cash_yn"         value=""/>
    <input type="hidden" name="cash_authno"     value=""/>
    <input type="hidden" name="cash_tr_code"    value=""/>
    <input type="hidden" name="cash_id_info"    value=""/>

	<!-- 2012년 8월 18일 전자상거래법 개정 관련 설정 부분 -->
	<!-- 제공 기간 설정 0:일회성 1:기간설정(ex 1:2012010120120131)  -->
	<input type="hidden" name="good_expr" value="0">

	<!-- 가맹점에서 관리하는 고객 아이디 설정을 해야 합니다.(필수 설정) -->
	<input type="hidden" name="shop_user_id"    value=""/>
	<!-- 복지포인트 결제시 가맹점에 할당되어진 코드 값을 입력해야합니다.(필수 설정) -->
    <input type="hidden" name="pt_memcorp_cd"   value=""/>

<%
    /* = -------------------------------------------------------------------------- = */
    /* =   3. Payplus Plugin 필수 정보 END                                          = */
    /* ============================================================================== */
%>

<%
    /* ============================================================================== */
    /* =   4. 옵션 정보                                                             = */
    /* = -------------------------------------------------------------------------- = */
    /* =   ※ 옵션 - 결제에 필요한 추가 옵션 정보를 입력 및 설정합니다.             = */
    /* = -------------------------------------------------------------------------- = */

	/* 사용카드 설정 여부 파라미터 입니다.(통합결제창 노출 유무)
	<input type="hidden" name="used_card_YN"        value="Y"/> */
	/* 사용카드 설정 파라미터 입니다. (해당 카드만 결제창에 보이게 설정하는 파라미터입니다. used_card_YN 값이 Y일때 적용됩니다.
	/<input type="hidden" name="used_card"        value="CCBC:CCKM:CCSS"/> */

    /* 신용카드 결제시 OK캐쉬백 적립 여부를 묻는 창을 설정하는 파라미터 입니다
         포인트 가맹점의 경우에만 창이 보여집니다
        <input type="hidden" name="save_ocb"        value="Y"/> */

	/* 고정 할부 개월 수 선택
	       value값을 "7" 로 설정했을 경우 => 카드결제시 결제창에 할부 7개월만 선택가능
    <input type="hidden" name="fix_inst"        value="07"/> */

    /*  무이자 옵션
            ※ 설정할부    (가맹점 관리자 페이지에 설정 된 무이자 설정을 따른다)                             - "" 로 설정
            ※ 일반할부    (KCP 이벤트 이외에 설정 된 모든 무이자 설정을 무시한다)                           - "N" 로 설정
            ※ 무이자 할부 (가맹점 관리자 페이지에 설정 된 무이자 이벤트 중 원하는 무이자 설정을 세팅한다)   - "Y" 로 설정
    <input type="hidden" name="kcp_noint"       value=""/> */

    /*  무이자 설정
            ※ 주의 1 : 할부는 결제금액이 50,000 원 이상일 경우에만 가능
            ※ 주의 2 : 무이자 설정값은 무이자 옵션이 Y일 경우에만 결제 창에 적용
            예) 전 카드 2,3,6개월 무이자(국민,비씨,엘지,삼성,신한,현대,롯데,외환) : ALL-02:03:04
            BC 2,3,6개월, 국민 3,6개월, 삼성 6,9개월 무이자 : CCBC-02:03:06,CCKM-03:06,CCSS-03:06:04
    <input type="hidden" name="kcp_noint_quota" value="CCBC-02:03:06,CCKM-03:06,CCSS-03:06:09"/> */


	/* 해외카드 구분하는 파라미터 입니다.(해외비자, 해외마스터, 해외JCB로 구분하여 표시)
	<input type="hidden" name="used_card_CCXX"        value="Y"/> */

    /*  가상계좌 은행 선택 파라미터
         ※ 해당 은행을 결제창에서 보이게 합니다.(은행코드는 매뉴얼을 참조)
    <input type="hidden" name="wish_vbank_list" value="05:03:04:07:11:23:26:32:34:81:71"/> */

    /*  가상계좌 입금 기한 설정하는 파라미터 - 발급일 + 3일
    <input type="hidden" name="vcnt_expire_term" value="3"/> */

    /*  가상계좌 입금 시간 설정하는 파라미터
         HHMMSS형식으로 입력하시기 바랍니다
         설정을 안하시는경우 기본적으로 23시59분59초가 세팅이 됩니다
         <input type="hidden" name="vcnt_expire_term_time" value="120000"/> */

    /* 포인트 결제시 복합 결제(신용카드+포인트) 여부를 결정할 수 있습니다.- N 일경우 복합결제 사용안함
        <input type="hidden" name="complex_pnt_yn" value="N"/>    */

    /* 현금영수증 등록 창을 출력 여부를 설정하는 파라미터 입니다
         ※ Y : 현금영수증 등록 창 출력
         ※ N : 현금영수증 등록 창 출력 안함 
	※ 주의 : 현금영수증 사용 시 KCP 상점관리자 페이지에서 현금영수증 사용 동의를 하셔야 합니다
        <input type="hidden" name="disp_tax_yn"     value="Y"/> */

    /* 결제창에 가맹점 사이트의 로고를 플러그인 좌측 상단에 출력하는 파라미터 입니다
       업체의 로고가 있는 URL을 정확히 입력하셔야 하며, 최대 150 X 50  미만 크기 지원

	※ 주의 : 로고 용량이 150 X 50 이상일 경우 site_name 값이 표시됩니다.
        <input type="hidden" name="site_logo"       value="" /> */

	/* 결제창 영문 표시 파라미터 입니다. 영문을 기본으로 사용하시려면 Y로 세팅하시기 바랍니다
		2010-06월 현재 신용카드와 가상계좌만 지원됩니다
	    <input type='hidden' name='eng_flag'      value='Y'> */

	/* KCP는 과세상품과 비과세상품을 동시에 판매하는 업체들의 결제관리에 대한 편의성을 제공해드리고자, 
	   복합과세 전용 사이트코드를 지원해 드리며 총 금액에 대해 복합과세 처리가 가능하도록 제공하고 있습니다
	   복합과세 전용 사이트 코드로 계약하신 가맹점에만 해당이 됩니다
       상품별이 아니라 금액으로 구분하여 요청하셔야 합니다
	   총결제 금액은 과세금액 + 부과세 + 비과세금액의 합과 같아야 합니다. 
	   (good_mny = comm_tax_mny + comm_vat_mny + comm_free_mny)
	
	    <input type="hidden" name="tax_flag"       value="TG03">  <!-- 변경불가	   -->
	    <input type="hidden" name="comm_tax_mny"   value=""    >  <!-- 과세금액	   --> 
        <input type="hidden" name="comm_vat_mny"   value=""    >  <!-- 부가세	   -->
	    <input type="hidden" name="comm_free_mny"  value=""    >  <!-- 비과세 금액 --> */

	/* skin_indx 값은 스킨을 변경할 수 있는 파라미터이며 총 7가지가 지원됩니다. 
	   변경을 원하시면 1부터 7까지 값을 넣어주시기 바랍니다. 

		<input type='hidden' name='skin_indx'      value='1'> */

	/* 상품코드 설정 파라미터 입니다.(상품권을 따로 구분하여 처리할 수 있는 옵션기능입니다.)
	    <input type='hidden' name='good_cd'      value=''> */

    /* = -------------------------------------------------------------------------- = */
    /* =   4. 옵션 정보 END                                                         = */
    /* ============================================================================== */
%>

</form>


</body>
</html>

