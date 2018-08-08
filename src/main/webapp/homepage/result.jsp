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

<script type="text/javascript">
/* 신용카드 영수증 */ 
/* 실결제시 : "https://admin8.kcp.co.kr/assist/bill.BillAction.do?cmd=card_bill&tno=" */ 
/* 테스트시 : "https://testadmin8.kcp.co.kr/assist/bill.BillAction.do?cmd=card_bill&tno=" */ 
function receiptView( tno, ordr_idxx, amount ) 
      {
          receiptWin = "https://admin8.kcp.co.kr/assist/bill.BillActionNew.do?cmd=card_bill&tno=";
          receiptWin += tno + "&";
          receiptWin += "order_no=" + ordr_idxx + "&"; 
          receiptWin += "trade_mony=" + amount ;

          window.open(receiptWin, "", "width=455, height=815"); 
      }
 
/* 현금 영수증 */ 
/* 실결제시 : "https://admin.kcp.co.kr/Modules/Service/Cash/Cash_Bill_Common_View.jsp" */ 
/* 테스트시 : "https://testadmin8.kcp.co.kr/Modules/Service/Cash/Cash_Bill_Common_View.jsp" */   
function receiptView2( site_cd, order_id, bill_yn, auth_no ) 
{ 
	receiptWin2 = "https://testadmin8.kcp.co.kr/Modules/Service/Cash/Cash_Bill_Common_View.jsp"; 
	receiptWin2 += "?"; 
	receiptWin2 += "term_id=PGNW" + site_cd + "&"; 
	receiptWin2 += "orderid=" + order_id + "&"; 
	receiptWin2 += "bill_yn=" + bill_yn + "&"; 
	receiptWin2 += "authno=" + auth_no ; 
 
	window.open(receiptWin2, "", "width=370, height=625"); 
}
/* 가상 계좌 모의입금 페이지 호출 */
/* 테스트시에만 사용가능 */
/* 실결제시 해당 스크립트 주석처리 */
function receiptView3() 
{ 
	receiptWin3 = "http://devadmin.kcp.co.kr/Modules/Noti/TEST_Vcnt_Noti.jsp"; 
	window.open(receiptWin3, "", "width=520, height=300"); 
} 
</script>


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

<form name="frm" id="frm" method="post">

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
			<div id="location"><a href="/" class="home">HOME</a><span>&gt;</span>수강신청<span>&gt;</span>결제완료</div>

<%
	request.setCharacterEncoding("euc-kr") ;
    /* ============================================================================== */
    /* =   지불 결과                                                                = */
    /* = -------------------------------------------------------------------------- = */
	String site_cd			= f_get_parm( request.getParameter( "site_cd"		 ) );      // 사이트 코드
    String req_tx           = f_get_parm( request.getParameter( "req_tx"         ) );      // 요청 구분(승인/취소)
    String use_pay_method   = f_get_parm( request.getParameter( "use_pay_method" ) );      // 사용 결제 수단
    String bSucc            = f_get_parm( request.getParameter( "bSucc"          ) );      // 업체 DB 정상처리 완료 여부
    /* = -------------------------------------------------------------------------- = */
    String res_cd           = f_get_parm( request.getParameter( "res_cd"         ) );      // 결과 코드
    String res_msg          = f_get_parm( request.getParameter( "res_msg"        ) );      // 결과 메시지
    String panc_mod_mny     = f_get_parm( request.getParameter( "panc_mod_mny"   ) );      // 부분취소 금액
    String panc_rem_mny     = f_get_parm( request.getParameter( "panc_rem_mny"   ) );      // 부분취소 가능 금액
	String mod_type         = f_get_parm( request.getParameter( "mod_type"       ) );
	String res_msg_bsucc    = "";
    /* = -------------------------------------------------------------------------- = */
    String amount           = f_get_parm( request.getParameter( "amount"         ) );      // 금액
    String ordr_idxx        = f_get_parm( request.getParameter( "ordr_idxx"      ) );      // 주문번호
    String tno              = f_get_parm( request.getParameter( "tno"            ) );      // KCP 거래번호
    String good_mny         = f_get_parm( request.getParameter( "good_mny"       ) );      // 결제 금액
    String good_name        = f_get_parm( request.getParameter( "good_name"      ) );      // 상품명
    String buyr_name        = f_get_parm( request.getParameter( "buyr_name"      ) );      // 구매자명
    String buyr_tel1        = f_get_parm( request.getParameter( "buyr_tel1"      ) );      // 구매자 전화번호
    String buyr_tel2        = f_get_parm( request.getParameter( "buyr_tel2"      ) );      // 구매자 휴대폰번호
    String buyr_mail        = f_get_parm( request.getParameter( "buyr_mail"      ) );      // 구매자 E-Mail
    /* = -------------------------------------------------------------------------- = */
	// 공통
	String pnt_issue        = f_get_parm( request.getParameter( "pnt_issue"      ) );      // 포인트 서비스사
    String app_time         = f_get_parm( request.getParameter( "app_time"       ) );      // 승인시간 (공통)
	/* = -------------------------------------------------------------------------- = */
    // 신용카드
    String card_cd          = f_get_parm( request.getParameter( "card_cd"        ) );      // 카드 코드
    String card_name        = f_get_parm( request.getParameter( "card_name"      ) );      // 카드명
	String noinf			= f_get_parm( request.getParameter( "noinf"			 ) );      // 무이자 여부
    String quota            = f_get_parm( request.getParameter( "quota"          ) );      // 할부개월
	String app_no           = f_get_parm( request.getParameter( "app_no"         ) );      // 승인번호
    /* = -------------------------------------------------------------------------- = */
    // 계좌이체
    String bank_name        = f_get_parm( request.getParameter( "bank_name"      ) );      // 은행명
	String bank_code        = f_get_parm( request.getParameter( "bank_code"      ) );      // 은행코드
    /* = -------------------------------------------------------------------------- = */
    // 가상계좌
    String bankname         = f_get_parm( request.getParameter( "bankname"       ) );      // 입금할 은행
    String depositor        = f_get_parm( request.getParameter( "depositor"      ) );      // 입금할 계좌 예금주
    String account          = f_get_parm( request.getParameter( "account"        ) );      // 입금할 계좌 번호
    String va_date          = f_get_parm( request.getParameter( "va_date"        ) );      // 가상계좌 입금마감시간
    /* = -------------------------------------------------------------------------- = */
    // 포인트
	String add_pnt          = f_get_parm( request.getParameter( "add_pnt"        ) );      // 발생 포인트
    String use_pnt          = f_get_parm( request.getParameter( "use_pnt"        ) );      // 사용가능 포인트
    String rsv_pnt          = f_get_parm( request.getParameter( "rsv_pnt"        ) );      // 적립 포인트
    String pnt_app_time     = f_get_parm( request.getParameter( "pnt_app_time"   ) );      // 승인시간
    String pnt_app_no       = f_get_parm( request.getParameter( "pnt_app_no"     ) );      // 승인번호
    String pnt_amount       = f_get_parm( request.getParameter( "pnt_amount"     ) );      // 적립금액 or 사용금액
    /* = -------------------------------------------------------------------------- = */
	//휴대폰
	String commid			= f_get_parm( request.getParameter( "commid"		 ) );      // 통신사 코드
	String mobile_no		= f_get_parm( request.getParameter( "mobile_no"      ) );      // 휴대폰 번호
	/* = -------------------------------------------------------------------------- = */
	//상품권
	String tk_van_code      = f_get_parm( request.getParameter( "tk_van_code"    ) );      // 발급사 코드
	String tk_app_no        = f_get_parm( request.getParameter( "tk_app_no"      ) );      // 승인 번호
	/* = -------------------------------------------------------------------------- = */
    // 현금영수증
    String cash_yn          = f_get_parm( request.getParameter( "cash_yn"        ) );      // 현금 영수증 등록 여부
    String cash_authno      = f_get_parm( request.getParameter( "cash_authno"    ) );      // 현금 영수증 승인 번호
    String cash_tr_code     = f_get_parm( request.getParameter( "cash_tr_code"   ) );      // 현금 영수증 발행 구분
    String cash_id_info     = f_get_parm( request.getParameter( "cash_id_info"   ) );      // 현금 영수증 등록 번호
	/* ============================================================================== */

    String req_tx_name = "";

    if ( req_tx.equals( "pay" ) ) { 
		req_tx_name = "지불" ;
	} else if( req_tx.equals( "mod" ) ) { 
		req_tx_name = "취소/매입" ;
	}

    if ( "pay".equals ( req_tx ) ) {
    	if ( !"0000".equals( res_cd ) ) {
            res_msg_bsucc = "결제처리시 오류가 발생하여 시스템에서 자동으로 취소 요청을 하였습니다. <br> 관리자에게 전화하여 확인하시기 바랍니다." ;
            %>
			<!-- title -->
			<h3 class="tit_big">결제 결과</h3>
		      <div class="artcle">
		        <div class="payresult_msg">
		        	<div class="msg">
			          <p class="big_2"><span class="big">결제처리시 에러가 발생했습니다.</span></p>
  						<p class="big_2"><%=res_msg_bsucc%></p>
					</div>
		        </div>
		      </div>
<%            	
    	} else if ( "false".equals ( bSucc ) ) {
            // 업체 DB 처리 실패
            if ( "0000".equals ( res_cd ) ) {
                res_msg_bsucc = "결제는 정상적으로 이루어졌지만 내부오류로 결제 결과를 처리하는 중 오류가 발생하여 시스템에서 자동으로 취소 요청을 하였습니다. <br> 관리자에게 전화하여 확인하시기 바랍니다." ;
			} else {
				res_msg_bsucc = "결제는 정상적으로 이루어졌지만 내부오류로 결제 결과를 처리하는 중 오류가 발생하여 시스템에서 자동으로 취소 요청을 하였으나, <br> <b>취소가 실패 되었습니다.</b><br> 관리자에게 전화하여 확인하시기 바랍니다." ;
			}
%>
			<!-- title -->
			<h3 class="tit_big">결제 결과</h3>
		      <div class="artcle">
		        <div class="payresult_msg">
		        	<div class="msg">
			          <p class="big_2"><span class="big">결제처리시 에러가 발생했습니다.</span></p>
  						<p class="big_2"><%=res_msg_bsucc%></p>
					</div>
		        </div>
		      </div>
<%            	
		} else {
			//정상처리인 경우
%>
			<!-- title -->
			<h3 class="tit_big">장바구니</h3>
		      <div class="artcle">
		      	<div class="orderflow_box">
		          <img src="/resources/images/sub/img_orderflow_3.png" alt="결제순서 3단계 결제완료" />
		        </div>
		        <div class="payresult_msg">
		        	<div class="msg">
			          <p class="big_2">결제가 모두 완료 되었습니다.</p>
								<p class="big_2"><span class="big">나의 강의실</span>로 가시면 결제한 과정을 확인 할 수 있습니다.</p>
								<a href="javascript:" onclick="page.goPage('/normalUser/attendCourseList');"><img src="/resources/images/sub/btn_go_studyroom.png" alt="나의 강의실로" /></a>
							</div>
		        </div>
		      </div>
<%			
		}
    }
%>


			
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