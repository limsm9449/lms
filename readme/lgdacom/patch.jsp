<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page import="lgdacom.XPayClient.XPayClient"%>

<%
	String configPath 	= "C:/lgdacom";  //LG���÷������� ������ ȯ������("/conf/lgdacom.conf") ��ġ ����.	
	
    /*
     * [LG���÷��� ȯ������ UPDATE]
     *
     * �� �������� LG���÷��� ȯ�������� UPDATE �մϴ�.(�������� ������.)
     */
    String CST_PLATFORM = request.getParameter("CST_PLATFORM");
    String CST_MID      = request.getParameter("CST_MID");

    if( CST_PLATFORM == null || "".equals(CST_PLATFORM.trim()) ) {
        out.println("[TX_PING error] CST_PLATFORM �Ķ���� ����<br>");
        return;
    }
    if( CST_MID == null || "".equals(CST_MID.trim()) ) {
        out.println("[TX_PING error] CST_MID �Ķ���� ����<br>");
        return;
    }
    String LGD_MID      = ("test".equals(CST_PLATFORM.trim())?"t":"")+CST_MID;    

    XPayClient xpay = new XPayClient();
    xpay.Init(configPath, CST_PLATFORM);
    xpay.Init_TX(LGD_MID);

    out.println( "patch result = " + xpay.Patch("lgdacom.conf") );
%>
