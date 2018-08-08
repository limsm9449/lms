<%@ page language="java" contentType="text/html;charset=euc-kr"%>

<%
    /* ============================================================================== */
    /* =   PAGE : ���� ��û PAGE                                                    = */
    /* = -------------------------------------------------------------------------- = */
    /* =   �� �������� Payplus Plug-in�� ���ؼ� �����ڰ� ���� ��û�� �ϴ� ������    = */
    /* =   �Դϴ�. �Ʒ��� �� �ʼ�, �� �ɼ� �κа� �Ŵ����� �����ϼż� ������        = */
    /* =   �����Ͽ� �ֽñ� �ٶ��ϴ�.                                                = */
    /* = -------------------------------------------------------------------------- = */
    /* =   ������ ������ �߻��ϴ� ��� �Ʒ��� �ּҷ� �����ϼż� Ȯ���Ͻñ� �ٶ��ϴ�.= */
    /* =   ���� �ּ� : http://kcp.co.kr/technique.requestcode.do			        = */
    /* = -------------------------------------------------------------------------- = */
    /* =   Copyright (c)  2013   KCP Inc.   All Rights Reserverd.                   = */
    /* ============================================================================== */
%>
<%
    /* ============================================================================== */
    /* =   ȯ�� ���� ���� Include                                                   = */
    /* = -------------------------------------------------------------------------- = */
    /* =   �� �ʼ�                                                                  = */
    /* =   �׽�Ʈ �� �ǰ��� ������ site_conf_inc.jsp ������ �����Ͻñ� �ٶ��ϴ�.    = */
    /* = -------------------------------------------------------------------------- = */
%>
	<%@ include file="../cfg/site_conf_inc.jsp" %>
<%
	request.setCharacterEncoding ( "euc-kr" ) ;
    /* = -------------------------------------------------------------------------- = */
    /* =   ȯ�� ���� ���� Include END                                               = */
    /* ============================================================================== */
%>
<%!
    /* ============================================================================== */
    /* =   null ���� ó���ϴ� �޼ҵ�                                                = */
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
<link href="css/style.css" rel="stylesheet" type="text/css" id="cssLink"/>

<%
    /* ============================================================================== */
    /* =   Javascript source Include                                                = */
    /* = -------------------------------------------------------------------------- = */
    /* =   �� �ʼ�                                                                  = */
    /* =   �׽�Ʈ �� �ǰ��� ������ site_conf_inc.jsp������ �����Ͻñ� �ٶ��ϴ�.     = */
    /* = -------------------------------------------------------------------------- = */
%>
    <script type="text/javascript" src="<%= g_conf_js_url %>"></script>
<%
    /* = -------------------------------------------------------------------------- = */
    /* =   Javascript source Include END                                            = */
    /* ============================================================================== */
%>
    <script type="text/javascript">
        /* �÷����� ��ġ(Ȯ��) */
        StartSmartUpdate();
        
        /*  �ش� ��ũ��Ʈ�� Ÿ���������� ������ ���� �ʽ��ϴ�.
        if( document.Payplus.object == null )
        {
            openwin = window.open( "chk_plugin.html", "chk_plugin", "width=420, height=100, top=300, left=300" );
        }
        */

        /* Payplus Plug-in ���� */
        function  jsf__pay( form )
        {
            var RetVal = false;

            /* Payplus Plugin ���� */
            if ( MakePayMessage( form ) == true )
            {
                openwin = window.open( "proc_win.html", "proc_win", "width=449, height=209, top=300, left=300" );
                RetVal = true ;
            }
            
            else
            {
                /*  res_cd�� res_msg������ �ش� �����ڵ�� �����޽����� �����˴ϴ�.
                    ex) ���� Payplus Plugin���� ��� ��ư Ŭ���� res_cd=3001, res_msg=����� ���
                    ���� �����˴ϴ�.
                */
                res_cd  = document.order_info.res_cd.value ;
                res_msg = document.order_info.res_msg.value ;

            }

            return RetVal ;
        }

        // Payplus Plug-in ��ġ �ȳ� 
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

        /* �ֹ���ȣ ���� ���� */
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

            var order_idxx = "TEST" + year + "" + month + "" + date + "" + time;

            document.order_info.ordr_idxx.value = order_idxx;

            /*
             * ���ͳ� �ͽ��÷η��� ���̾�����(���ĸ�, ũ��.. ���)�� javascript �Ľ̹��� Ʋ���� ������ object �� �ν� ���� ���� �Ǵ� ����
             * �������� onload �κп� �߰��� ������ setTimeout �κп� �߰�
             * setTimeout 300�� �ǹ̴� �÷����� �νļӵ��� ���� �����ð� ����
             * - 20101018 -
             */
            setTimeout("init_pay_button();",300);
        }

        /* onLoad �̺�Ʈ �� Payplus Plug-in�� ����ǵ��� �����Ͻ÷��� ������ ������ onLoad �̺�Ʈ�� �־��ֽñ� �ٶ��ϴ�. */
        function onload_pay()
        {
             if( jsf__pay(document.order_info) )
                document.order_info.submit();
        }

    </script>
</head>

<body onload="init_orderid();">

<div id="sample_wrap">

<!-- �ֹ����� �Է� form : order_info -->
<form name="order_info" method="post" action="pp_ax_hub.jsp" >

<%
    /* ============================================================================== */
    /* =   1. �ֹ� ���� �Է�                                                        = */
    /* = -------------------------------------------------------------------------- = */
    /* =   ������ �ʿ��� �ֹ� ������ �Է� �� �����մϴ�.                            = */
    /* = -------------------------------------------------------------------------- = */
%>
                    <h1>[������û] <span> �� �������� ������ ��û�ϴ� ����(����) �������Դϴ�.</span></h1>
                    <!-- ��� ���� -->
                    <div class="sample">
                            <p>�� �������� ������ ��û�ϴ� �������Դϴ�.<br />
                            ���� ������û �������� �����ϰ� �Ǹ� �� ���������� ������ ���� Payplus Plug-in��<br />
                            ���� PC�� ��ġ�Ǿ� �ִ��� Ȯ���մϴ�.<br /><br />
                            ���� PC�� Payplus Plug-in�� ��ġ���� ���� ��� <span>������ ����� ����� �˸�ǥ����</span>�̳� �ϴ���
                            <span>[������ġ]</span>�� ���� <span>Payplus Plug-in ��ġ</span>�� �����մϴ�.<br /><br />
                            ������û ��ư�� Ŭ���ϰ� �� ��� Payplus Plug-in�� ����Ǹ� Payplus Plug-in�� ���� ������û ������ ��ȣȭ�Ͽ�
                            ������û �������� �����մϴ�.<br /><br />
                            �Ҽ� ���� �� <span>�� �ʼ�, �� �ɼ�</span>ǥ�ð� ���Ե� ������ �������� ��Ȳ�� �°� ������ ���� �����Ͻñ� �ٶ��ϴ�.
                            </p>

                <!-- �ֹ����� Ÿ��Ʋ -->
                    <h2>&sdot; �ֹ� ����</h2>
                    <table class="tbl" cellpadding="0" cellspacing="0">
<%
                    /* ============================================================================== */
                    /* =   1-1. ���� ���� ���� ����                                                 = */
                    /* = -------------------------------------------------------------------------- = */
                    /* =   ������ �ʿ��� ���� ���� ������ �����մϴ�.                               = */
                    /* =                                                                            = */
                    /* =  �ſ�ī�� : 100000000000, ������ü : 010000000000, ������� : 001000000000 = */
                    /* =  ����Ʈ   : 000100000000, �޴���   : 000010000000, ��ǰ��   : 000000001000 = */
                    /* =  ARS      : 000000000010                                                   = */
                    /* =                                                                            = */
                    /* =  ���� ���� ������ ��� PayPlus Plugin���� ������ ���������� ǥ�õ˴ϴ�.    = */
                    /* =  Payplug Plugin���� ���� ���������� ǥ���ϰ� ������ ��� �����Ͻ÷��� ���� = */
                    /* =  ���ܿ� �ش��ϴ� ��ġ�� �ش��ϴ� ���� 1�� �����Ͽ� �ֽʽÿ�.               = */
                    /* =                                                                            = */
                    /* =  ��) �ſ�ī��, ������ü, ������¸� ���ÿ� ǥ���ϰ��� �ϴ� ���            = */
                    /* =  pay_method = "111000000000"                                               = */
                    /* =  �ſ�ī��(100000000000), ������ü(010000000000), �������(001000000000)��  = */
                    /* =  �ش��ϴ� ���� ��� �����ָ� �˴ϴ�.                                       = */
                    /* =                                                                            = */
                    /* = �� �ʼ�                                                                    = */
                    /* =  KCP�� ��û�� �����������θ� ������ �����մϴ�.                            = */
                    /* = -------------------------------------------------------------------------- = */
%>
                    <tr>
                        <th>���� ���</th>
                        <td>
                            <select name="pay_method">
                                <option value="100000000000">�ſ�ī��</option>
                                <option value="010000000000">������ü</option>
                                <option value="001000000000">�������</option>
                                <option value="000100000000">����Ʈ</option>
                                <option value="000010000000">�޴���</option>
                                <option value="000000001000">��ǰ��</option>
                                <option value="000000000010">ARS</option>
                                <option value="111000000000">�ſ�ī��/������ü/�������</option>
                            </select>
                        </td>
                    </tr>
                    <!-- �ֹ���ȣ(ordr_idxx) -->
                    <tr>
                        <th>�ֹ� ��ȣ</th>
                        <td><input type="text" name="ordr_idxx" class="w200" value="" maxlength="40"/></td>
                    </tr>
                    <!-- ��ǰ��(good_name) -->
                    <tr>
                        <th>��ǰ��</th>
                        <td><input type="text" name="good_name" class="w100" value="�ȭ"/></td>
                    </tr>
                    <!-- �����ݾ�(good_mny) - �� �ʼ� : �� ������ ,(�޸�)�� ������ ���ڸ� �Է��Ͽ� �ֽʽÿ�. -->
                    <tr>
                        <th>���� �ݾ�</th>
                        <td><input type="text" name="good_mny" class="w100" value="1004" maxlength="9"/>��(���ڸ� �Է�)</td>
                    </tr>
                    <!-- �ֹ��ڸ�(buyr_name) -->
                    <tr>
                        <th>�ֹ��ڸ�</th>
                        <td><input type="text" name="buyr_name" class="w100" value="ȫ�浿"/></td>
                    </tr>
                    <!-- �ֹ��� E-mail(buyr_mail) -->
                    <tr>
                        <th>E-mail</th>
                        <td><input type="text" name="buyr_mail" class="w200" value="test@test.co.kr" maxlength="30" /></td>
                    </tr>
                    <!-- �ֹ��� ����ó1(buyr_tel1) -->
                    <tr>
                        <th>��ȭ��ȣ</th>
                        <td><input type="text" name="buyr_tel1" class="w100" value="02-2108-1000"/></td>
                    </tr>
                    <!-- �޴�����ȣ(buyr_tel2) -->
                    <tr>
                        <th>�޴�����ȣ</th>
                        <td><input type="text" name="buyr_tel2" class="w100" value="010-0000-0000"/></td>
                    </tr>
                    </table>

                    <!-- ���� ��û/ó������ �̹��� -->
                    <div class="btnset" id="display_pay_button" style="display:block">
                      <input name="" type="submit" class="submit" value="������û" onclick="return jsf__pay(this.form);"/>
                      <a href="../index.html" class="home">ó������</a>
                    </div>
                    <!-- Payplus Plug-in ��ġ �ȳ� -->
                    <div id="display_setup_message" style="display:none">
                       <p class="txt">
                       ������ ��� �Ͻ÷��� ����� ����� ǥ������ Ŭ�� �Ͻðų� <a href="http://pay.kcp.co.kr/plugin_new/file/KCPUXWizard.exe"><span>[������ġ]</span></a>�� ����
                       Payplus Plug-in�� ��ġ�Ͻñ� �ٶ��ϴ�.
                       [������ġ]�� ���� ��ġ�Ͻ� ��� ���ΰ�ħ(F5)Ű�� ���� �����Ͻñ� �ٶ��ϴ�.
                       </p>
                     </div>
                   </div>
                  <div class="footer">
                    Copyright (c) KCP INC. All Rights reserved.
                  </div>
<%
    /* = -------------------------------------------------------------------------- = */
    /* =   1. �ֹ� ���� �Է� END                                                    = */
    /* ============================================================================== */
%>

<%
    /* ============================================================================== */
    /* =   2. ������ �ʼ� ���� ����                                                 = */
    /* = -------------------------------------------------------------------------- = */
    /* =   �� �ʼ� - ������ �ݵ�� �ʿ��� �����Դϴ�.                               = */
    /* =   site_conf_inc.jsp ������ �����ϼż� �����Ͻñ� �ٶ��ϴ�.                 = */
    /* = -------------------------------------------------------------------------- = */
    // ��û���� : ����(pay)/���,����(mod) ��û�� ���
%>
    <input type="hidden" name="req_tx"          value="pay" />
    <input type="hidden" name="site_cd"         value="<%= g_conf_site_cd   %>" />
    <input type="hidden" name="site_name"       value="<%= g_conf_site_name %>" />
<%
    /*
       �Һοɼ� : Payplus Plug-in���� ī������� �ִ�� ǥ���� �Һΰ��� ���� �����մϴ�.(0 ~ 18 ���� ���� ����)
       �� ����  - �Һ� ������ �����ݾ��� 50,000�� �̻��� ��쿡�� ����, 50000�� �̸��� �ݾ��� �Ͻúҷθ� ǥ��˴ϴ�
                  ��) value ���� "5" �� �������� ��� => ī������� ����â�� �ϽúҺ��� 5�������� ���ð���
    */
%>
    <input type="hidden" name="quotaopt"        value="12"/>
    <!-- �ʼ� �׸� : ���� �ݾ�/ȭ����� -->
    <input type="hidden" name="currency"        value="WON"/>
<%
    /* = -------------------------------------------------------------------------- = */
    /* =   2. ������ �ʼ� ���� ���� END                                             = */
    /* ============================================================================== */
%>

<%
    /* ============================================================================== */
    /* =   3. Payplus Plugin �ʼ� ����(���� �Ұ�)                                   = */
    /* = -------------------------------------------------------------------------- = */
    /* =   ������ �ʿ��� �ֹ� ������ �Է� �� �����մϴ�.                            = */
    /* = -------------------------------------------------------------------------- = */
%>
    <!-- PLUGIN ���� �����Դϴ�(���� �Ұ�) -->
    <input type="hidden" name="module_type"     value="<%= module_type %>"/>
<!--
      �� �� ��
          �ʼ� �׸� : Payplus Plugin���� ���� �����ϴ� �κ����� �ݵ�� ���ԵǾ�� �մϴ�
          ���� �������� ���ʽÿ�
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

    <!--  ���ݿ����� ���� ���� : Payplus Plugin ���� �����ϴ� �����Դϴ� -->
    <input type="hidden" name="cash_tsdtime"    value=""/>
    <input type="hidden" name="cash_yn"         value=""/>
    <input type="hidden" name="cash_authno"     value=""/>
    <input type="hidden" name="cash_tr_code"    value=""/>
    <input type="hidden" name="cash_id_info"    value=""/>

	<!-- 2012�� 8�� 18�� ���ڻ�ŷ��� ���� ���� ���� �κ� -->
	<!-- ���� �Ⱓ ���� 0:��ȸ�� 1:�Ⱓ����(ex 1:2012010120120131)  -->
	<input type="hidden" name="good_expr" value="0">

	<!-- ���������� �����ϴ� �� ���̵� ������ �ؾ� �մϴ�.(�ʼ� ����) -->
	<input type="hidden" name="shop_user_id"    value=""/>
	<!-- ��������Ʈ ������ �������� �Ҵ�Ǿ��� �ڵ� ���� �Է��ؾ��մϴ�.(�ʼ� ����) -->
    <input type="hidden" name="pt_memcorp_cd"   value=""/>

<%
    /* = -------------------------------------------------------------------------- = */
    /* =   3. Payplus Plugin �ʼ� ���� END                                          = */
    /* ============================================================================== */
%>

<%
    /* ============================================================================== */
    /* =   4. �ɼ� ����                                                             = */
    /* = -------------------------------------------------------------------------- = */
    /* =   �� �ɼ� - ������ �ʿ��� �߰� �ɼ� ������ �Է� �� �����մϴ�.             = */
    /* = -------------------------------------------------------------------------- = */

    /* ���ī�� ���� ���� �Ķ���� �Դϴ�.(���հ���â ���� ����)
    <input type="hidden" name="used_card_YN"        value="Y"/> */
    /* ���ī�� ���� �Ķ���� �Դϴ�. (�ش� ī�常 ����â�� ���̰� �����ϴ� �Ķ�����Դϴ�. used_card_YN ���� Y�϶� ����˴ϴ�.
    /<input type="hidden" name="used_card"        value="CCBC:CCKM:CCSS"/> */

    /* �ſ�ī�� ������ OKĳ���� ���� ���θ� ���� â�� �����ϴ� �Ķ���� �Դϴ�
         ����Ʈ �������� ��쿡�� â�� �������ϴ�
        <input type="hidden" name="save_ocb"        value="Y"/> */

    /* ���� �Һ� ���� �� ����
           value���� "7" �� �������� ��� => ī������� ����â�� �Һ� 7������ ���ð���
    <input type="hidden" name="fix_inst"        value="07"/> */

    /*  ������ �ɼ�
            �� �����Һ�    (������ ������ �������� ���� �� ������ ������ ������)                             - "" �� ����
            �� �Ϲ��Һ�    (KCP �̺�Ʈ �̿ܿ� ���� �� ��� ������ ������ �����Ѵ�)                           - "N" �� ����
            �� ������ �Һ� (������ ������ �������� ���� �� ������ �̺�Ʈ �� ���ϴ� ������ ������ �����Ѵ�)   - "Y" �� ����
    <input type="hidden" name="kcp_noint"       value=""/> */

    /*  ������ ����
            �� ���� 1 : �Һδ� �����ݾ��� 50,000 �� �̻��� ��쿡�� ����
            �� ���� 2 : ������ �������� ������ �ɼ��� Y�� ��쿡�� ���� â�� ����
            ��) �� ī�� 2,3,6���� ������(����,��,����,�Ｚ,����,����,�Ե�,��ȯ) : ALL-02:03:04
            BC 2,3,6����, ���� 3,6����, �Ｚ 6,9���� ������ : CCBC-02:03:06,CCKM-03:06,CCSS-03:06:04
    <input type="hidden" name="kcp_noint_quota" value="CCBC-02:03:06,CCKM-03:06,CCSS-03:06:09"/> */

    /* �ؿ�ī�� �����ϴ� �Ķ���� �Դϴ�.(�ؿܺ���, �ؿܸ�����, �ؿ�JCB�� �����Ͽ� ǥ��)
    <input type="hidden" name="used_card_CCXX"        value="Y"/> */

    /*  ������� ���� ���� �Ķ����
         �� �ش� ������ ����â���� ���̰� �մϴ�.(�����ڵ�� �Ŵ����� ����)
    <input type="hidden" name="wish_vbank_list" value="05:03:04:07:11:23:26:32:34:81:71"/> */

    /*  ������� �Ա� ���� �����ϴ� �Ķ���� - �߱��� + 3��
    <input type="hidden" name="vcnt_expire_term" value="3"/> */

    /*  ������� �Ա� �ð� �����ϴ� �Ķ����
         HHMMSS�������� �Է��Ͻñ� �ٶ��ϴ�
         ������ ���Ͻô°�� �⺻������ 23��59��59�ʰ� ������ �˴ϴ�
         <input type="hidden" name="vcnt_expire_term_time" value="120000"/> */

    /* ����Ʈ ������ ���� ����(�ſ�ī��+����Ʈ) ���θ� ������ �� �ֽ��ϴ�.- N �ϰ�� ���հ��� ������
        <input type="hidden" name="complex_pnt_yn" value="N"/>    */

    /* ���ݿ����� ��� â�� ��� ���θ� �����ϴ� �Ķ���� �Դϴ�
         �� Y : ���ݿ����� ��� â ���
         �� N : ���ݿ����� ��� â ��� ���� 
    �� ���� : ���ݿ����� ��� �� KCP ���������� ���������� ���ݿ����� ��� ���Ǹ� �ϼž� �մϴ�
        <input type="hidden" name="disp_tax_yn"     value="Y"/> */

    /* ����â�� ������ ����Ʈ�� �ΰ� �÷����� ���� ��ܿ� ����ϴ� �Ķ���� �Դϴ�
       ��ü�� �ΰ� �ִ� URL�� ��Ȯ�� �Է��ϼž� �ϸ�, �ִ� 150 X 50  �̸� ũ�� ����

    �� ���� : �ΰ� �뷮�� 150 X 50 �̻��� ��� site_name ���� ǥ�õ˴ϴ�.
        <input type="hidden" name="site_logo"       value="" /> */

    /* ����â ���� ǥ�� �Ķ���� �Դϴ�. ������ �⺻���� ����Ͻ÷��� Y�� �����Ͻñ� �ٶ��ϴ�
    	2010-06�� ���� �ſ�ī��� ������¸� �����˴ϴ�
        <input type='hidden' name='eng_flag'      value='Y'> */

    /* KCP�� ������ǰ�� �������ǰ�� ���ÿ� �Ǹ��ϴ� ��ü���� ���������� ���� ���Ǽ��� �����ص帮����, 
       ���հ��� ���� ����Ʈ�ڵ带 ������ �帮�� �� �ݾ׿� ���� ���հ��� ó���� �����ϵ��� �����ϰ� �ֽ��ϴ�
       ���հ��� ���� ����Ʈ �ڵ�� ����Ͻ� ���������� �ش��� �˴ϴ�
       ��ǰ���� �ƴ϶� �ݾ����� �����Ͽ� ��û�ϼž� �մϴ�
       �Ѱ��� �ݾ��� �����ݾ� + �ΰ��� + ������ݾ��� �հ� ���ƾ� �մϴ�. 
       (good_mny = comm_tax_mny + comm_vat_mny + comm_free_mny)

        <input type="hidden" name="tax_flag"       value="TG03">  <!-- ����Ұ�	   -->
        <input type="hidden" name="comm_tax_mny"   value=""    >  <!-- �����ݾ�	   --> 
        <input type="hidden" name="comm_vat_mny"   value=""    >  <!-- �ΰ���	   -->
        <input type="hidden" name="comm_free_mny"  value=""    >  <!-- ����� �ݾ� --> */

    /* skin_indx ���� ��Ų�� ������ �� �ִ� �Ķ�����̸� �� 7������ �����˴ϴ�. 
       ������ ���Ͻø� 1���� 7���� ���� �־��ֽñ� �ٶ��ϴ�. 

        <input type='hidden' name='skin_indx'      value='1'> */

    /* ��ǰ�ڵ� ���� �Ķ���� �Դϴ�.(��ǰ���� ���� �����Ͽ� ó���� �� �ִ� �ɼǱ���Դϴ�.)
        <input type='hidden' name='good_cd'      value=''> */

    /* = -------------------------------------------------------------------------- = */
    /* =   4. �ɼ� ���� END                                                         = */
    /* ============================================================================== */
%>
</form>
</div>
</body>
</html>