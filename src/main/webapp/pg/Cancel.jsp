<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page import="lgdacom.XPayClient.XPayClient"%>

<%
    /*
     * [������� ��û ������]
     *
     * LG���÷������� ���� �������� �ŷ���ȣ(LGD_TID)�� ������ ��� ��û�� �մϴ�.(�Ķ���� ���޽� POST�� ����ϼ���)
     * (���ν� LG���÷������� ���� �������� PAYKEY�� ȥ������ ������.)
     */
    String CST_PLATFORM         = request.getParameter("CST_PLATFORM");                 //LG���÷��� �������� ����(test:�׽�Ʈ, service:����)
    String CST_MID              = request.getParameter("CST_MID");                      //LG���÷������� ���� �߱޹����� �������̵� �Է��ϼ���.
    String LGD_MID              = ("test".equals(CST_PLATFORM.trim())?"t":"")+CST_MID;  //�׽�Ʈ ���̵�� 't'�� �����ϰ� �Է��ϼ���.
                                                                                        //�������̵�(�ڵ�����)
    String LGD_TID              = request.getParameter("LGD_TID");                      //LG���÷������� ���� �������� �ŷ���ȣ(LGD_TID)

	/* �� �߿�
	* ȯ�漳�� ������ ��� �ݵ�� �ܺο��� ������ ������ ��ο� �νø� �ȵ˴ϴ�.
	* �ش� ȯ�������� �ܺο� ������ �Ǵ� ��� ��ŷ�� ������ �����ϹǷ� �ݵ�� �ܺο��� ������ �Ұ����� ��ο� �νñ� �ٶ��ϴ�. 
	* ��) [Window �迭] C:\inetpub\wwwroot\lgdacom ==> ����Ұ�(�� ���丮)
	*/
    String configPath 			= "C:/lgdacom";  										//LG���÷������� ������ ȯ������("/conf/lgdacom.conf") ��ġ ����.
        
    LGD_TID     				= ( LGD_TID == null )?"":LGD_TID; 
    
    XPayClient xpay = new XPayClient();
    xpay.Init(configPath, CST_PLATFORM);
    xpay.Init_TX(LGD_MID);
    xpay.Set("LGD_TXNAME", "Cancel");
    xpay.Set("LGD_TID", LGD_TID);
 
    /*
     * 1. ������� ��û ���ó��
     *
     * ��Ұ�� ���� �Ķ���ʹ� �����޴����� �����Ͻñ� �ٶ��ϴ�.
	 *
	 * [[[�߿�]]] ���翡�� ������� ó���ؾ��� �����ڵ�
	 * 1. �ſ�ī�� : 0000, AV11  
	 * 2. ������ü : 0000, RF00, RF10, RF09, RF15, RF19, RF23, RF25 (ȯ�������� �����-> ȯ�Ұ���ڵ�.xls ����)
	 * 3. ������ ���������� ��� 0000(����) �� ��Ҽ��� ó��
	 *
     */
    if (xpay.TX()) {
        //1)������Ұ�� ȭ��ó��(����,���� ��� ó���� �Ͻñ� �ٶ��ϴ�.)
        out.println("���� ��ҿ�û�� �Ϸ�Ǿ����ϴ�.  <br>");
        out.println( "TX Response_code = " + xpay.m_szResCode + "<br>");
        out.println( "TX Response_msg = " + xpay.m_szResMsg + "<p>");
    }else {
        //2)API ��û ���� ȭ��ó��
        out.println("���� ��ҿ�û�� �����Ͽ����ϴ�.  <br>");
        out.println( "TX Response_code = " + xpay.m_szResCode + "<br>");
        out.println( "TX Response_msg = " + xpay.m_szResMsg + "<p>");
    }
%>
