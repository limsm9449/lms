<%@ page contentType="text/html;charset=euc-kr" %>

<%
    /* ============================================================================== */
    /* =   PAGE : 매입 요청 PAGE                                                    = */
    /* = -------------------------------------------------------------------------- = */
    /* =   아래의 ※ 주의 ※ 부분을 꼭 참고하시여 연동을 진행하시기 바랍니다.       = */
    /* = -------------------------------------------------------------------------- = */
    /* =   연동시 오류가 발생하는 경우 아래의 주소로 접속하셔서 확인하시기 바랍니다.= */
    /* =   접속 주소 : http://kcp.co.kr/technique.requestcode.do			        = */
    /* = -------------------------------------------------------------------------- = */
    /* =   Copyright (c)  2013   KCP Inc.   All Rights Reserverd.                   = */
    /* ============================================================================== */
%>
<%
	request.setCharacterEncoding ( "euc-kr" ) ;
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

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head>
    <title>*** KCP [AX-HUB Version] ***</title>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr" />
    <link href="css/style.css" rel="stylesheet" type="text/css"/>

    <script type="text/javascript">
    function  jsf__go_mod( form )
    {
        var RetVal = false ;
        if ( form.tno.value.length < 14 )
        {
            alert( "KCP 거래 번호를 입력하세요" );
            form.tno.focus();
            form.tno.select();
        }
        else
        {
            openwin = window.open( "proc_win.html", "proc_win", "width=449, height=209, top=300, left=300" );
            RetVal = true ;
        }

        return RetVal ;
    }
    </script>
</head>

<body>

    <div id="sample_wrap">
<%
    /* ============================================================================== */
    /* =   1. 매입 요청 정보 입력 폼(modify_info)                                   = */
    /* = -------------------------------------------------------------------------- = */
    /* =   매입 요청에 필요한 정보를 설정합니다.                                    = */
    /* = -------------------------------------------------------------------------- = */
%>
    <form name="modify_info" method="post" action="pp_ax_hub.jsp">

                 <!-- 타이틀 Start-->
                    <h1>[매입요청] <span>이 페이지는 결제건에 대해 매입을 요청하는 샘플(예시) 페이지입니다.</span></h1>
                 <!-- 타이틀 End -->

                    <!-- 상단 테이블 Start -->
                    <div class="sample">
                    <p>
                        소스 수정 시 소스 안에 <span>※ 주의 ※</span> 표시가 포함된 문장은 가맹점의 상황에 맞게 적절히 수정 <br/>
						적용하시길 바랍니다.<br/>
                        이 페이지는 결제된 건에 대한 매입을 요청하는 페이지 입니다. <br/>
                        <span>이 페이지는 KCP에 수동매입 가맹점으로 등록된 경우에만 사용합니다.<br/>
                        수동매입 가맹점인 경우에만 사용하시기 바랍니다.</span><br/>
                        결제가 승인되면 결과값으로 KCP 거래번호(tno)값을 받으실 수 있습니다.<br/>
                        가맹점에서는 이 KCP 거래번호(tno)값으로 매입요청을 하실 수 있습니다.
                    </p>
                    <!-- 상단 테이블 End -->

                <!-- 매입 요청 정보 입력 테이블 Start -->
                    <h2>&sdot; 매 입 요 청</h2>
                    <table class="tbl" cellpadding="0" cellspacing="0">
                    <!-- 요청 구분 : 매입 -->
                    <tr>
                        <th>요청 구분</th>
                        <td>매입 요청</td>
         			</tr>
                    <!-- Input : 결제된 건의 거래번호(14 byte) 입력 -->
                    <tr>
                        <th>KCP 거래번호</th>
                        <td><input type="text" name="tno" value=""  class="frminput" maxlength="14"/></td>
                    </tr>
                </table>
                <!-- 매입 요청 정보 입력 테이블 End -->

                    <!-- 결제 버튼 테이블 Start -->
                    <div class="btnset">
                    <input name="" type="submit" class="submit" value="매입요청" onclick="return jsf__go_mod(this.form);"/>
                    </div>
                    <!-- 결제 버튼 테이블 End -->
                </div>
            <div class="footer">
                Copyright (c) KCP INC. All Rights reserved.
            </div>

<%
    /* ============================================================================== */
    /* =   1-1. 매입 요청 필수 정보 설정                                            = */
    /* = -------------------------------------------------------------------------- = */
    /* =   ※ 필수 - 반드시 필요한 정보입니다.                                      = */
    /* = -------------------------------------------------------------------------- = */
%>
        <input type="hidden" name="req_tx"   value="mod"  />
        <input type="hidden" name="mod_type" value="STMR" />
    </form>
<%
    /* = -------------------------------------------------------------------------- = */
    /* =   1. 매입 요청 정보 END                                                    = */
    /* ============================================================================== */
%>
</div>
</body>
</html>
