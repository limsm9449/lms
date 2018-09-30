<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page import="lgdacom.XPayClient.XPayClient"%>
<%@ page import="org.springframework.context.ApplicationContext"%>
<%@ page import="org.springframework.web.servlet.support.RequestContextUtils"%>
<%@ page import="com.qp.lms.pg.service.PgService"%>
<%@ page import="com.qp.lms.pg.model.PgSet"%>
<%@ page import="com.qp.lms.pg.model.PgVO"%>

<%
request.setCharacterEncoding("euc-kr");
    /*
     * [����������û ������(STEP2-2)]
	 *
     * �Ŵ��� "5.1. XPay ���� ��û ������ ����"�� "�ܰ� 5. ���� ���� ��û �� ��û ��� ó��" ����
	 *
     * LG���÷������� ���� �������� LGD_PAYKEY(����Key)�� ������ ���� ������û.(�Ķ���� ���޽� POST�� ����ϼ���)
     */

	/* �� �߿�
	* ȯ�漳�� ������ ��� �ݵ�� �ܺο��� ������ ������ ��ο� �νø� �ȵ˴ϴ�.
	* �ش� ȯ�������� �ܺο� ������ �Ǵ� ��� ��ŷ�� ������ �����ϹǷ� �ݵ�� �ܺο��� ������ �Ұ����� ��ο� �νñ� �ٶ��ϴ�. 
	* ��) [Window �迭] C:\inetpub\wwwroot\lgdacom ==> ����Ұ�(�� ���丮)
	*/
	
    String configPath = (String)request.getAttribute("g_configPath");  //LG���÷������� ������ ȯ������("/conf/lgdacom.conf,/conf/mall.conf") ��ġ ����.
    
    /*
     *************************************************
     * 1.�������� ��û - BEGIN
     *  (��, ���� �ݾ�üũ�� ���Ͻô� ��� �ݾ�üũ �κ� �ּ��� ���� �Ͻø� �˴ϴ�.)
     *************************************************
     */
    
    String CST_PLATFORM                 = request.getParameter("CST_PLATFORM");
    String CST_MID                      = request.getParameter("CST_MID");
    String LGD_MID                      = ("test".equals(CST_PLATFORM.trim())?"t":"")+CST_MID;
    String LGD_PAYKEY                   = request.getParameter("LGD_PAYKEY");

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
   	
   	}else{      
   		try{
   			
			// (3) Init_TX: �޸𸮿� mall.conf, lgdacom.conf �Ҵ� �� Ʈ������� ������ Ű TXID ����
	    	xpay.Init_TX(LGD_MID);
	    	xpay.Set("LGD_TXNAME", "PaymentByKey");
	    	xpay.Set("LGD_PAYKEY", LGD_PAYKEY);
	    
	    	//�ݾ��� üũ�Ͻñ� ���ϴ� ��� �Ʒ� �ּ��� Ǯ� �̿��Ͻʽÿ�.
	    	//String DB_AMOUNT = "DB�� ���ǿ��� ������ �ݾ�"; //�ݵ�� �������� �Ұ����� ��(DB�� ����)���� �ݾ��� �������ʽÿ�.
	    	//xpay.Set("LGD_AMOUNTCHECKYN", "Y");
	    	//xpay.Set("LGD_AMOUNT", DB_AMOUNT);
	    
    	}catch(Exception e) {
    		out.println("LG���÷��� ���� API�� ����� �� �����ϴ�. ȯ������ ������ Ȯ���� �ֽñ� �ٶ��ϴ�. ");
    		out.println(""+e.getMessage());    	
    		return;
    	}
   	}
	/*
	 *************************************************
	 * 1.�������� ��û(�������� ������) - END
	 *************************************************
	 */

    /*
     * 2. �������� ��û ���ó��
     *
     * ���� ������û ��� ���� �Ķ���ʹ� �����޴����� �����Ͻñ� �ٶ��ϴ�.
     */
	 // (4) TX: lgdacom.conf�� ������ URL�� ���� ����Ͽ� ���� ������û, ��������� true, false ����
     if ( xpay.TX() ) {
         //1)������� ȭ��ó��(����,���� ��� ó���� �Ͻñ� �ٶ��ϴ�.)
         out.println( "������û�� �Ϸ�Ǿ����ϴ�.  <br>");
		 out.println( "TX ������û ��� �����ڵ� = " + xpay.m_szResCode + "<br>");					//��� �����ڵ�("0000" �� �� ��� ����)
         out.println( "TX ������û ��� ����޽��� = " + xpay.m_szResMsg + "<p>");					//��� ����޽���
        
         
         out.println("�ŷ���ȣ : " + xpay.Response("LGD_TID",0) + "<br>");
         out.println("�������̵� : " + xpay.Response("LGD_MID",0) + "<br>");
         out.println("�����ֹ���ȣ : " + xpay.Response("LGD_OID",0) + "<br>");
         out.println("�����ݾ� : " + xpay.Response("LGD_AMOUNT",0) + "<br>");
         out.println("����ڵ� : " + xpay.Response("LGD_RESPCODE",0) + "<br>");						//LGD_RESPCODE �� �ݵ�� "0000" �϶��� ���� ����, �� �ܴ� ��� ����
         out.println("����޼��� : " + xpay.Response("LGD_RESPMSG",0) + "<p>");
         
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
         	// ��Ż��� ������ ������
			// ����������û ��� ���� DBó��(LGD_RESPCODE ���� ���� ������ ��������, �������� DBó��)
         	out.println("����������û ����, DBó���Ͻñ� �ٶ��ϴ�.<br>");
         	            	
         	//����������û ����� DBó���մϴ�. (�������� �Ǵ� ���� ��� DBó�� ����)
			//������ DB�� ��� ������ ó���� ���� ���Ѱ�� false�� ������ �ּ���.
         	boolean isDBOK = false;
         	
         	out.println("XpayService payOk Start <br>");
         	PgSet set = new PgSet();
    		set.setCondiVO(new PgVO());
    		set.getCondiVO().setCourseId(request.getParameter("courseId"));
    		set.getCondiVO().setTotalCost(request.getParameter("totalCost"));
    		set.getCondiVO().setPaymentPoint(request.getParameter("remainPoint"));
    		set.getCondiVO().setPaymentCost(xpay.Response("LGD_AMOUNT",0));
    		set.getCondiVO().setPaymentKind(request.getParameter("paymentKind"));
    		set.getCondiVO().setPaymentBank("");
    		set.getCondiVO().setApprovalId(xpay.Response("LGD_OID",0));
    		set.getCondiVO().setPayApprovalId(xpay.Response("LGD_TID",0));
    		
         	ApplicationContext ac = RequestContextUtils.getWebApplicationContext(request);
         	PgService pgService = (PgService) ac.getBean("pgService");
         	PgSet rtnSet = pgService.approval(set);
         	
         	if ( "OK".equals(rtnSet.getRtnMode()) ) {
         		isDBOK = true;
         	}
         	out.println("XpayService payOk End <br>");
        	
         	if( !isDBOK ) {
         		xpay.Rollback("���� DBó�� ���з� ���Ͽ� Rollback ó�� [TID:" +xpay.Response("LGD_TID",0)+",MID:" + xpay.Response("LGD_MID",0)+",OID:"+xpay.Response("LGD_OID",0)+"]");
         		
				out.println( "TX Rollback Response_code = " + xpay.Response("LGD_RESPCODE",0) + "<br>");
				out.println( "TX Rollback Response_msg = " + xpay.Response("LGD_RESPMSG",0) + "<p>");
         		
				if( "0000".equals( xpay.m_szResCode ) ) { 
					out.println("�ڵ���Ұ� ���������� �Ϸ� �Ǿ����ϴ�.<br>");
				}else{
					out.println("�ڵ���Ұ� ���������� ó������ �ʾҽ��ϴ�.<br>");
				}
         	}
         	
         }else{
			//��Ż��� ���� �߻�(����������û ��� ���� DBó��)
			out.println("����������û ��� ����, DBó���Ͻñ� �ٶ��ϴ�.<br>");
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
