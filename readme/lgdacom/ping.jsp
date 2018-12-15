<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page import="lgdacom.XPayClient.XPayClient"%>

<%
	String configPath 	= "C:/lgdacom";	//LG���÷������� ������ ȯ������("/conf/lgdacom.conf") ��ġ ����.	
	
    /*
     * [LG���÷��� ���� Ȯ�� ������]
     *
     * ���������� LG���÷������� ������ �׽�Ʈ �ϴ� ������ �Դϴ�.(�������� ������.)
     */
    String CST_PLATFORM = request.getParameter("CST_PLATFORM");
    String CST_MID      = request.getParameter("CST_MID"); // 't'�� �߰����� ���� ���Կ�û�� ���̵� �Է¹ٶ��ϴ�.

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
    xpay.Set("LGD_TXNAME", "Ping");
    xpay.Set("LGD_RESULTCNT", "3");
    xpay.TX();

    out.println("resCode = " + xpay.m_szResCode + "<br>");
    out.println("resMsg = " + xpay.m_szResMsg + "<br>");

    for (int i = 0; i < xpay.ResponseNameCount(); i++)
    {
        out.println(xpay.ResponseName(i) + " = ");
        for (int j = 0; j < xpay.ResponseCount(); j++)
        {
            out.println("\t" + xpay.Response(xpay.ResponseName(i), j) + "<br>");
        }
    }
%>
