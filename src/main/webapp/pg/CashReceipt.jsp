<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page import="lgdacom.XPayClient.XPayClient"%>

<%
    /*
     * [���ݿ����� �߱޿�û ������]
     *
     * LG���÷������� ���� �������� �ŷ���ȣ(LGD_TID)�� ������ ��� ��û�� �մϴ�.(�Ķ���� ���޽� POST�� ����ϼ���)
     * (���ν� LG���÷������� ���� �������� PAYKEY�� ȥ������ ������.)
     */
    String CST_PLATFORM           = request.getParameter("CST_PLATFORM");                 //LG���÷��� �������� ����(test:�׽�Ʈ, service:����)
    String CST_MID                = request.getParameter("CST_MID");                      //LG���÷������� ���� �߱޹����� �������̵� �Է��ϼ���.
    String LGD_MID                = ("test".equals(CST_PLATFORM.trim())?"t":"")+CST_MID;  //�׽�Ʈ ���̵�� 't'�� �����ϰ� �Է��ϼ���.
                                                                                          //�������̵�(�ڵ�����)
    String LGD_METHOD   		  = request.getParameter("LGD_METHOD");                   //�޼ҵ�('AUTH':����, 'CANCEL' ���)
    String LGD_OID                = request.getParameter("LGD_OID");					  //�ֹ���ȣ(�������� ����ũ�� �ֹ���ȣ�� �Է��ϼ���)
    String LGD_PAYTYPE            = request.getParameter("LGD_PAYTYPE");				  //�������� �ڵ� (SC0030:������ü, SC0040:�������, SC0100:�������Ա� �ܵ�)
    String LGD_AMOUNT     		  = request.getParameter("LGD_AMOUNT");             	  //�ݾ�("," �� ������ �ݾ��� �Է��ϼ���)
    String LGD_CASHCARDNUM        = request.getParameter("LGD_CASHCARDNUM");              //�߱޹�ȣ(�ֹε�Ϲ�ȣ,���ݿ�����ī���ȣ,�޴�����ȣ ���)
    String LGD_CUSTOM_MERTNAME    = request.getParameter("LGD_CUSTOM_MERTNAME");       	  //������
    String LGD_CUSTOM_BUSINESSNUM = request.getParameter("LGD_CUSTOM_BUSINESSNUM");       //����ڵ�Ϲ�ȣ
    String LGD_CUSTOM_MERTPHONE   = request.getParameter("LGD_CUSTOM_MERTPHONE");         //���� ��ȭ��ȣ
    String LGD_CASHRECEIPTUSE     = request.getParameter("LGD_CASHRECEIPTUSE");			  //���ݿ������߱޿뵵('1':�ҵ����, '2':��������)
    String LGD_PRODUCTINFO        = request.getParameter("LGD_PRODUCTINFO");			  //��ǰ��
    String LGD_TID                = request.getParameter("LGD_TID");			  		  //LG���÷��� �ŷ���ȣ (��ҽø� ���) 

    /* �� �߿�
	* ȯ�漳�� ������ ��� �ݵ�� �ܺο��� ������ ������ ��ο� �νø� �ȵ˴ϴ�.
	* �ش� ȯ�������� �ܺο� ������ �Ǵ� ��� ��ŷ�� ������ �����ϹǷ� �ݵ�� �ܺο��� ������ �Ұ����� ��ο� �νñ� �ٶ��ϴ�. 
	* ��) [Window �迭] C:\inetpub\wwwroot\lgdacom ==> ����Ұ�(�� ���丮)
	*/
	
    String configPath 			  = "C:/lgdacom";  										  //LG���÷������� ������ ȯ������("/conf/lgdacom.conf") ��ġ ����.
        
    LGD_METHOD       		= ( LGD_METHOD == null )?"":LGD_METHOD;
    LGD_OID       		    = ( LGD_OID == null )?"":LGD_OID;
    LGD_PAYTYPE       		= ( LGD_PAYTYPE == null )?"":LGD_PAYTYPE;
    LGD_AMOUNT   		    = ( LGD_AMOUNT == null )?"":LGD_AMOUNT;
    LGD_CASHCARDNUM         = ( LGD_CASHCARDNUM == null )?"":LGD_CASHCARDNUM;
    LGD_CUSTOM_MERTNAME  	= ( LGD_CUSTOM_MERTNAME == null )?"":LGD_CUSTOM_MERTNAME;
    LGD_CUSTOM_BUSINESSNUM  = ( LGD_CUSTOM_BUSINESSNUM == null )?"":LGD_CUSTOM_BUSINESSNUM;
    LGD_CUSTOM_MERTPHONE  	= ( LGD_CUSTOM_MERTPHONE == null )?"":LGD_CUSTOM_MERTPHONE;
    LGD_CASHRECEIPTUSE      = ( LGD_CASHRECEIPTUSE == null )?"":LGD_CASHRECEIPTUSE;
    LGD_PRODUCTINFO         = ( LGD_PRODUCTINFO == null )?"":LGD_PRODUCTINFO;
    LGD_TID         		= ( LGD_TID == null )?"":LGD_TID;
    
    XPayClient xpay = new XPayClient();
    xpay.Init(configPath, CST_PLATFORM);
    xpay.Init_TX(LGD_MID);
    xpay.Set("LGD_TXNAME", "CashReceipt");
    xpay.Set("LGD_METHOD", LGD_METHOD);
    xpay.Set("LGD_PAYTYPE", LGD_PAYTYPE);
    
    if (LGD_METHOD.equals("AUTH")){    // ���ݿ����� �߱� ��û 
    	xpay.Set("LGD_OID", LGD_OID);
    	xpay.Set("LGD_CUSTOM_MERTNAME", LGD_CUSTOM_MERTNAME);
     	xpay.Set("LGD_CUSTOM_BUSINESSNUM", LGD_CUSTOM_BUSINESSNUM);
    	xpay.Set("LGD_CUSTOM_MERTPHONE", LGD_CUSTOM_MERTPHONE);
    	xpay.Set("LGD_CASHCARDNUM", LGD_CASHCARDNUM);
		xpay.Set("LGD_AMOUNT", LGD_AMOUNT);
    	xpay.Set("LGD_CASHRECEIPTUSE", LGD_CASHRECEIPTUSE);
    	
    	if (LGD_PAYTYPE.equals("SC0030")){  //������� ������ü�� ���ݿ����� �߱޿�û�� �ʼ�  
    		xpay.Set("LGD_TID", LGD_TID);
    	}
    	else if (LGD_PAYTYPE.equals("SC0040")){  //������� ������°� ���ݿ����� �߱޿�û�� �ʼ�  
    		xpay.Set("LGD_TID", LGD_TID);
    		xpay.Set("LGD_SEQNO", "001");
    	}
    	else {  								//�������Ա� �ܵ��� �߱޿�û  
    		xpay.Set("LGD_PRODUCTINFO", LGD_PRODUCTINFO);
        }
    }else{								// ���ݿ����� ��� ��û 
    	xpay.Set("LGD_TID", LGD_TID);

    	if (LGD_PAYTYPE.equals("SC0040")){  //������°� ���ݿ����� �߱���ҽ� �ʼ�  
			xpay.Set("LGD_SEQNO", "001");

    	}
    }
    
    /*
     * 1. ���ݿ����� �߱�/��� ��û ���ó��
     *
     * ��� ���� �Ķ���ʹ� �����޴����� �����Ͻñ� �ٶ��ϴ�.
     */
    if (xpay.TX()) {
        //1)���ݿ����� �߱�/��Ұ�� ȭ��ó��(����,���� ��� ó���� �Ͻñ� �ٶ��ϴ�.)
        out.println("���ݿ����� �߱�/��� ��ûó���� �Ϸ�Ǿ����ϴ�.  <br>");
        out.println( "TX Response_code = " + xpay.m_szResCode + "<br>");
        out.println( "TX Response_msg = " + xpay.m_szResMsg + "<p>");
        
        out.println("�ŷ���ȣ : " + xpay.Response("LGD_TID",0) + "<br>");
        out.println("����ڵ� : " + xpay.Response("LGD_RESPCODE",0) + "<br>");
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
        
    }else {
        //2)API ��û ���� ȭ��ó��
        out.println("���ݿ����� �߱�/��� ��ûó���� ���еǾ����ϴ�.  <br>");
        out.println( "TX Response_code = " + xpay.m_szResCode + "<br>");
        out.println( "TX Response_msg = " + xpay.m_szResMsg + "<p>");
    }
%>
