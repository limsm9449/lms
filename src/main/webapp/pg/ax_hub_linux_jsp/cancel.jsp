<%@ page contentType="text/html;charset=euc-kr" %>

<%
    /* ============================================================================== */
    /* =   PAGE : ��� ��û PAGE                                                    = */
    /* = -------------------------------------------------------------------------- = */
    /* =   �Ʒ��� �� ���� �� �κ��� �� �����Ͻÿ� ������ �����Ͻñ� �ٶ��ϴ�.       = */
    /* = -------------------------------------------------------------------------- = */
    /* =   ������ ������ �߻��ϴ� ��� �Ʒ��� �ּҷ� �����ϼż� Ȯ���Ͻñ� �ٶ��ϴ�.= */
    /* =   ���� �ּ� : http://kcp.co.kr/technique.requestcode.do			        = */
    /* = -------------------------------------------------------------------------- = */
    /* =   Copyright (c)  2013   KCP Inc.   All Rights Reserverd.                   = */
    /* ============================================================================== */
%>
<%
	request.setCharacterEncoding ( "euc-kr" ) ;
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
<%
    /* ============================================================================== */
    /* =   ��ҿ� �ʿ��� ����                                                       = */
    /* = -------------------------------------------------------------------------- = */
    String tno        = f_get_parm( request.getParameter("param")) ;     // ��� ��û �ŷ���ȣ
    /* ============================================================================== */
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head>
    <title>*** KCP [AX-HUB Version] ***</title>
	<meta http-equiv="Content-Type" content="text/html; charset=euc-kr" />
    <link href="sample/css/style.css" rel="stylesheet" type="text/css"/>

        <script type="text/javascript">
        /* ��� ��ư�� ������ �� ȣ�� */
    function  jsf__go_cancel( form )
    {
        var RetVal = false ;
        if ( form.mod_type.value != 'mod_type_not_sel' )
        {
            if ( form.tno.value.length < 14 )
            {
                alert( "KCP �ŷ� ��ȣ�� �Է��ϼ���" );
                form.tno.focus();
                form.tno.select();
            }
            else
            {
                RetVal = true ;
            }
        }
        else
        {
            alert( "�ŷ� ������ �����Ͽ� �ֽʽÿ�." );
            form.mod_type.focus();
        }
            return RetVal ;
    }
    </script>

    <body>

    <div id="sample_wrap">
<%
    /* ============================================================================== */
    /* =    1. ��� ��û ���� �Է� ��(cancel_info)                                  = */
    /* = -------------------------------------------------------------------------- = */
    /* =   ��� ��û�� �ʿ��� ������ �����մϴ�.                                    = */
    /* = -------------------------------------------------------------------------- = */
%>
    <form name="cancel_info" action="./sample/pp_ax_hub.jsp" method="post">

                 <!-- Ÿ��Ʋ Start-->
                    <h1>[��ҿ�û] <span>�� �������� �����ǿ� ���� ��Ҹ� ��û�ϴ� ����(����) �������Դϴ�.</span></h1>
                 <!-- Ÿ��Ʋ End -->

                    <!-- ��� ���̺� Start -->
                    <div class="sample">
                    <p>
                        �ҽ� ���� �� �ҽ� �ȿ� <span>�� ���� ��</span> ǥ�ð� ���Ե� ������ �������� ��Ȳ�� �°� ������ ���� <br/>
						�����Ͻñ� �ٶ��ϴ�.<br/>
                        <span>�� �������� ������ �ǿ� ���� ��Ҹ� ��û�ϴ� ������ �Դϴ�.</span><br/>
                        ������ ���εǸ� ��������� KCP �ŷ���ȣ(tno)���� ������ �� �ֽ��ϴ�.<br/>
						������������ KCP �ŷ���ȣ(tno)������ ��ҿ�û�� �Ͻ� �� �ֽ��ϴ�.
                    </p>
                    <!-- ��� ���̺� End -->
                <!-- ��� ��û ���� �Է� ���̺� Start -->
                    <h2>&sdot; ��� ��û</h2>
                    <table class="tbl" cellpadding="0" cellspacing="0">
                    <!-- ��û ���� : ��� -->
                    <tr>
                        <th>��û ����</th>
                        <td>
                            <select name='mod_type' onChange="jsf__chk_mod_type()">
                                <option value='mod_type_not_sel' selected>�����Ͻʽÿ�</option>
                                <option value='STSC'>���</option>
                                <option value='STPC'>�κ����</option>
                            </select>
						    <br/><b>�� �κ���Ҵ� �ſ�ī��, ������ü�� �����մϴ�. ��</b>
                        </td>
                    </tr>
                    <!-- Input : ������ ���� �ŷ���ȣ(14 byte) �Է� -->
                    <tr>
                        <th>KCP �ŷ���ȣ</th>
                        <td><input type="text" name="tno" value="<%=tno%>"  class="w200" maxlength="14"/></td>
                    </tr>
                     <!-- Input : ���� ����(mod_desc) �Է� -->
                    <tr>
                        <th>���� ����</th>
                        <td><input type="text" name="mod_desc" value="" class="w200" maxlength="50"/></td>
                    </tr>
                     <!-- Input : ��� ��û �ݾ�(mod_mny) �Է� -->
                    <tr>
                        <th>��� ��û �ݾ�<br/>(�κ���ҽ� ���)</th>
                        <td>
                            <input type='text' name='mod_mny' value='' class="w200" size='20' maxlength='14'>
                        </td>
                    </tr>
                     <!-- Input : ��� ���� �ݾ�(rem_mny) �Է� -->
                    <tr>
                        <th>��� ���� �ܾ�<br/>(�κ���ҽ� ���)</th>
                        <td>
                            <input type='text' name='rem_mny' value='' class="w200" size='20' maxlength='14'>
                        </td>
                    </tr>

					<% /*
					<!-- ���հ��� �κ���� ������ �ּ��� Ǯ�� �ֽñ� �ٶ��ϴ� -->
					<!-- ���ް� �κ���� ��û �ݾ� -->
                    <tr>
                        <th>���ް� �κ���� �ݾ�</th>
                        <td>
							<input type="text" name="mod_tax_mny" value="" class="w200" size="20" maxlength="9"/>
						</td>
                    </tr>
					<!-- �ΰ��� �κ���� ��û �ݾ�  -->
                    <tr>
                        <th>�ΰ��� �κ���� �ݾ�</th>
                        <td>
							<input type="text" name="mod_vat_mny" value="" class="w200" size="20" maxlength="9"/>
						</td>
                    </tr>
					<!-- ����� �κ���� ��û �ݾ� -->
                    <tr>
                        <th>����� �κ���� �ݾ�</th>
                        <td>
							<input type="text" name="mod_free_mny" value="" class="w200" size="20" maxlength="9"/>
						</td>
                    </tr>
					*/ %>

                    </table>

                <!-- ��� ��û ���� �Է� ���̺� End -->

                    <!-- ���� ��ư ���̺� Start -->
                    <div class="btnset">
                    <input name="" type="submit" class="submit" value="��ҿ�û" onclick="return jsf__go_cancel(this.form);"/>
					<a href="index.html" class="home">ó������</a>
                    </div>
                    <!-- ���� ��ư ���̺� End -->
                </div>
            <div class="footer">
                Copyright (c) KCP INC. All Rights reserved.
            </div>

<%
    /* ============================================================================== */
    /* =   1-1. ��� ��û �ʼ� ���� ����                                            = */
    /* = -------------------------------------------------------------------------- = */
    /* =   �� �ʼ� - �ݵ�� �ʿ��� �����Դϴ�.                                      = */
    /* = -------------------------------------------------------------------------- = */
%>
        <input type="hidden" name="req_tx"   value="mod"  />
    </form>
<%
    /* = -------------------------------------------------------------------------- = */
    /* =   1. ��� ��û ���� END                                                    = */
    /* ============================================================================== */
%>
</div>
</body>
</html>
