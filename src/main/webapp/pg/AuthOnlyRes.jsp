<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page import="lgdacom.XPayClient.XPayClient"%>

<%
    /*
     * [����Ȯ�� ó�� ������]
     *
	 * �Ŵ��� "4. ����Ȯ�� ���� �̿��� ���� ����"�� "V. ����Ȯ�� ���� ����" ����
	 *
     * LG���÷������� ���� �������� LGD_AUTHONLYKEY(����Key)�� ������ ���� ������û.(�Ķ���� ���޽� POST�� ����ϼ���)
     */

    //String configPath = "C:/lgdacom";  //LG���÷������� ������ ȯ������("/conf/lgdacom.conf,/conf/mall.conf") ��ġ ����.
    String configPath = (String)request.getAttribute("g_configPath");  //LG���÷������� ������ ȯ������("/conf/lgdacom.conf,/conf/mall.conf") ��ġ ����.
    
    /*
     *************************************************
     * 1.�������� ��û - BEGIN
     *************************************************
     */
    
    String CST_PLATFORM                 = request.getParameter("CST_PLATFORM");
    String CST_MID                      = request.getParameter("CST_MID");
    String LGD_MID                      = ("test".equals(CST_PLATFORM.trim())?"t":"")+CST_MID;
    String LGD_AUTHONLYKEY              = request.getParameter("LGD_AUTHONLYKEY");            //LG���÷������κ��� �ο����� ����Ű
    String LGD_PAYTYPE    				= request.getParameter("LGD_PAYTYPE");                //������ûŸ�� (�ſ�ī��:ASC001, �޴��� ��ü����:ASC007, ����:ASC004)

    //�ش� API�� ����ϱ� ���� WEB-INF/lib/XPayClient.jar �� Classpath �� ����ϼž� �մϴ�. 
	// (1) XpayClient�� ����� ���� xpay ��ü ����
    XPayClient xpay = new XPayClient();

	// (2) Init: XPayClient �ʱ�ȭ(ȯ�漳�� ���� �ε�) 
	// configPath: ��������
	// CST_PLATFORM: - test, service ���� ���� lgdacom.conf�� test_url(test) �Ǵ� url(srvice) ���
	//				- test, service ���� ���� �׽�Ʈ�� �Ǵ� ���񽺿� ���̵� ����
   	boolean isInitOK = xpay.Init(configPath, CST_PLATFORM);   	

	
    if( !isInitOK ) {
    	//API �ʱ�ȭ ���� ȭ��ó��
        out.println( "������û�� �ʱ�ȭ �ϴµ� �����Ͽ����ϴ�.<br>");
        out.println( "LG���÷������� ������ ȯ�������� ���������� ��ġ �Ǿ����� Ȯ���Ͻñ� �ٶ��ϴ�.<br>");        
        out.println( "mall.conf���� Mert ID = Mert Key �� �ݵ�� ��ϵǾ� �־�� �մϴ�.<br><br>");
        out.println( "������ȭ LG���÷��� 1544-7772<br>");
        return;
    }     

	try{
		// (3) Init_TX: �޸𸮿� mall.conf, lgdacom.conf �Ҵ� �� Ʈ������� ������ Ű TXID ����
	    xpay.Init_TX(LGD_MID);
	    xpay.Set("LGD_TXNAME", "AuthOnlyByKey");
	    xpay.Set("LGD_AUTHONLYKEY", LGD_AUTHONLYKEY);
	    xpay.Set("LGD_PAYTYPE", LGD_PAYTYPE);
	    
    }catch(Exception e) {
		// LG U+ API ��� �Ұ�, �������� Ȯ�� �� �ʿ�(����ó��)
    	out.println("LG���÷��� ���� API�� ����� �� �����ϴ�. ȯ������ ������ Ȯ���� �ֽñ� �ٶ��ϴ�. ");
    	out.println(""+e.getMessage());    	
    	return;
    }

	/*
     *************************************************
     * 1.�������� ��û(�������� ������) - END
     *************************************************
     */


    /*
     * 2. ���� ������û ���ó��
     *
     * ���� ������û ��� ���� �Ķ���ʹ� �����޴����� �����Ͻñ� �ٶ��ϴ�.
     */
	 // (4) TX: lgdacom.conf�� ������ URL�� ���� ����Ͽ� ���� ������û, ��������� true, false ����
     if ( xpay.TX() ) {
         //1)������� ȭ��ó��(����,���� ��� ó���� �Ͻñ� �ٶ��ϴ�.)
         out.println( "������û�� �Ϸ�Ǿ����ϴ�.  <br>");
         out.println( "TX ������û Response_code = " + xpay.m_szResCode + "<br>");
         out.println( "TX ������û Response_msg = " + xpay.m_szResMsg + "<p>");
         
		 // ������û ��� ������ ���
         for (int i = 0; i < xpay.ResponseNameCount(); i++)
         {
             out.println(xpay.ResponseName(i) + " = ");
             for (int j = 0; j < xpay.ResponseCount(); j++)
             {
                 out.println("\t" + xpay.Response(xpay.ResponseName(i), j) + "<br>");
             }
         }
         out.println("<p>");
         
		 // (5) DB�� ������û ��� ó��
         if( "0000".equals( xpay.m_szResCode ) ) {
         	//������û ��� ���� DBó��
         	out.println("������û ��� ���� DBó���Ͻñ� �ٶ��ϴ�.<br>");
         }else{
         	//������û ��� ���� DBó��
         	out.println("������û ��� ���� DBó���Ͻñ� �ٶ��ϴ�.<br>");            	
         }
 	}else {
         //2)API ��û���� ȭ��ó��
         out.println( "������û�� �����Ͽ����ϴ�.  <br>");
         out.println( "TX ������û Response_code = " + xpay.m_szResCode + "<br>");
         out.println( "TX ������û Response_msg = " + xpay.m_szResMsg + "<p>");
         
     	//����������û ��� ���� DBó��
     	out.println("����������û ��� ���� DBó���Ͻñ� �ٶ��ϴ�.<br>");            	            
     }
%>