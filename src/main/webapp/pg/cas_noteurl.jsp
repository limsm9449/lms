<%@ page contentType="text/html;charset=EUC-KR" %>
<%@ page import="java.io.*" %>
<%@ page import="java.text.*" %>
<%@ page import="java.util.*" %>
<%@ page import="java.security.MessageDigest" %>

<%
    /*
     * [���� �������ó��(DB) ������]
     *
     * 1) ������ ������ ���� hashdata�� ������ �ݵ�� �����ϼž� �մϴ�.
     *
     */

    String LGD_RESPCODE = "";           // �����ڵ�: 0000(����) �׿� ����
    String LGD_RESPMSG = "";            // ����޼���
    String LGD_MID = "";                // �������̵� 
    String LGD_OID = "";                // �ֹ���ȣ
    String LGD_AMOUNT = "";             // �ŷ��ݾ�
    String LGD_TID = "";                // LG���÷������� �ο��� �ŷ���ȣ
    String LGD_PAYTYPE = "";            // ���������ڵ�
    String LGD_PAYDATE = "";            // �ŷ��Ͻ�(�����Ͻ�/��ü�Ͻ�)
    String LGD_HASHDATA = "";           // �ؽ���
    String LGD_FINANCECODE = "";        // ��������ڵ�(�����ڵ�)
    String LGD_FINANCENAME = "";        // ��������̸�(�����̸�)
    String LGD_ESCROWYN = "";           // ����ũ�� ���뿩��
    String LGD_TIMESTAMP = "";          // Ÿ�ӽ�����
    String LGD_ACCOUNTNUM = "";         // ���¹�ȣ(�������Ա�) 
    String LGD_CASTAMOUNT = "";         // �Ա��Ѿ�(�������Ա�)
    String LGD_CASCAMOUNT = "";         // ���Աݾ�(�������Ա�)
    String LGD_CASFLAG = "";            // �������Ա� �÷���(�������Ա�) - 'R':�����Ҵ�, 'I':�Ա�, 'C':�Ա���� 
    String LGD_CASSEQNO = "";           // �Աݼ���(�������Ա�)
    String LGD_CASHRECEIPTNUM = "";     // ���ݿ����� ���ι�ȣ
    String LGD_CASHRECEIPTSELFYN = "";  // ���ݿ����������߱������� Y: �����߱��� ����, �׿� : ������
    String LGD_CASHRECEIPTKIND = "";    // ���ݿ����� ���� 0: �ҵ������ , 1: ����������
    String LGD_PAYER = "";    			// �ӱ��ڸ�
    
    /*
     * ��������
     */
    String LGD_BUYER = "";              // ������
    String LGD_PRODUCTINFO = "";        // ��ǰ��
    String LGD_BUYERID = "";            // ������ ID
    String LGD_BUYERADDRESS = "";       // ������ �ּ�
    String LGD_BUYERPHONE = "";         // ������ ��ȭ��ȣ
    String LGD_BUYEREMAIL = "";         // ������ �̸���
    String LGD_BUYERSSN = "";           // ������ �ֹι�ȣ
    String LGD_PRODUCTCODE = "";        // ��ǰ�ڵ�
    String LGD_RECEIVER = "";           // ������
    String LGD_RECEIVERPHONE = "";      // ������ ��ȭ��ȣ
    String LGD_DELIVERYINFO = "";       // �����

    LGD_RESPCODE            = request.getParameter("LGD_RESPCODE");
    LGD_RESPMSG             = request.getParameter("LGD_RESPMSG");
    LGD_MID                 = request.getParameter("LGD_MID");
    LGD_OID                 = request.getParameter("LGD_OID");
    LGD_AMOUNT              = request.getParameter("LGD_AMOUNT");
    LGD_TID                 = request.getParameter("LGD_TID");
    LGD_PAYTYPE             = request.getParameter("LGD_PAYTYPE");
    LGD_PAYDATE             = request.getParameter("LGD_PAYDATE");
    LGD_HASHDATA            = request.getParameter("LGD_HASHDATA");
    LGD_FINANCECODE         = request.getParameter("LGD_FINANCECODE");
    LGD_FINANCENAME         = request.getParameter("LGD_FINANCENAME");
    LGD_ESCROWYN            = request.getParameter("LGD_ESCROWYN");
    LGD_TIMESTAMP           = request.getParameter("LGD_TIMESTAMP");
    LGD_ACCOUNTNUM          = request.getParameter("LGD_ACCOUNTNUM");
    LGD_CASTAMOUNT          = request.getParameter("LGD_CASTAMOUNT");
    LGD_CASCAMOUNT          = request.getParameter("LGD_CASCAMOUNT");
    LGD_CASFLAG             = request.getParameter("LGD_CASFLAG");
    LGD_CASSEQNO            = request.getParameter("LGD_CASSEQNO");
    LGD_CASHRECEIPTNUM      = request.getParameter("LGD_CASHRECEIPTNUM");
    LGD_CASHRECEIPTSELFYN   = request.getParameter("LGD_CASHRECEIPTSELFYN");
    LGD_CASHRECEIPTKIND     = request.getParameter("LGD_CASHRECEIPTKIND");
    LGD_PAYER     			= request.getParameter("LGD_PAYER");

    LGD_BUYER               = request.getParameter("LGD_BUYER");
    LGD_PRODUCTINFO         = request.getParameter("LGD_PRODUCTINFO");
    LGD_BUYERID             = request.getParameter("LGD_BUYERID");
    LGD_BUYERADDRESS        = request.getParameter("LGD_BUYERADDRESS");
    LGD_BUYERPHONE          = request.getParameter("LGD_BUYERPHONE");
    LGD_BUYEREMAIL          = request.getParameter("LGD_BUYEREMAIL");
    LGD_BUYERSSN            = request.getParameter("LGD_BUYERSSN");
    LGD_PRODUCTCODE         = request.getParameter("LGD_PRODUCTCODE");
    LGD_RECEIVER            = request.getParameter("LGD_RECEIVER");
    LGD_RECEIVERPHONE       = request.getParameter("LGD_RECEIVERPHONE");
    LGD_DELIVERYINFO        = request.getParameter("LGD_DELIVERYINFO");

    /*
     * hashdata ������ ���� mertkey�� ���������� -> ������� -> ���������������� Ȯ���ϽǼ� �ֽ��ϴ�. 
     * LG���÷������� �߱��� ����Ű�� �ݵ�ú����� �ֽñ� �ٶ��ϴ�.
     */  
    String LGD_MERTKEY = ""; //mertkey

    StringBuffer sb = new StringBuffer();
    sb.append(LGD_MID);
    sb.append(LGD_OID);
    sb.append(LGD_AMOUNT);
    sb.append(LGD_RESPCODE);
    sb.append(LGD_TIMESTAMP);
    sb.append(LGD_MERTKEY);

    byte[] bNoti = sb.toString().getBytes();
    MessageDigest md = MessageDigest.getInstance("MD5");
    byte[] digest = md.digest(bNoti);

    StringBuffer strBuf = new StringBuffer();
    for (int i=0 ; i < digest.length ; i++) {
        int c = digest[i] & 0xff;
        if (c <= 15){
            strBuf.append("0");
        }
        strBuf.append(Integer.toHexString(c));
    }

    String LGD_HASHDATA2 = strBuf.toString();  //�������� �ؽ���  
    
    /*
     * ���� ó����� ���ϸ޼���
     *
     * OK  : ���� ó����� ����
     * �׿� : ���� ó����� ����
     *
     * �� ���ǻ��� : ������ 'OK' �����̿��� �ٸ����ڿ��� ���ԵǸ� ����ó�� �ǿ��� �����Ͻñ� �ٶ��ϴ�.
     */    
    String resultMSG = "������� ���� DBó��(LGD_CASNOTEURL) ������� �Է��� �ֽñ� �ٶ��ϴ�.";  
    
    if (LGD_HASHDATA2.trim().equals(LGD_HASHDATA)) { //�ؽ��� ������ �����̸�
        if ( ("0000".equals(LGD_RESPCODE.trim())) ){ //������ �����̸�
        	if( "R".equals( LGD_CASFLAG.trim() ) ) {
                /*
                 * ������ �Ҵ� ���� ��� ���� ó��(DB) �κ�
                 * ���� ��� ó���� �����̸� "OK"
                 */    
                //if( ������ �Ҵ� ���� ����ó����� ���� ) 
                	resultMSG = "OK";   
        		
        	}else if( "I".equals( LGD_CASFLAG.trim() ) ) {
 	            /*
    	         * ������ �Ա� ���� ��� ���� ó��(DB) �κ�
        	     * ���� ��� ó���� �����̸� "OK"
            	 */    
            	//if( ������ �Ա� ���� ����ó����� ���� ) 
            		resultMSG = "OK";
        	}else if( "C".equals( LGD_CASFLAG.trim() ) ) {
 	            /*
    	         * ������ �Ա���� ���� ��� ���� ó��(DB) �κ�
        	     * ���� ��� ó���� �����̸� "OK"
            	 */    
            	//if( ������ �Ա���� ���� ����ó����� ���� ) 
            		resultMSG = "OK";
        	}
        } else { //������ �����̸�
            /*
             * �ŷ����� ��� ���� ó��(DB) �κ�
             * ������� ó���� �����̸� "OK"
             */  
           //if( �������� ����ó����� ���� ) 
        	   resultMSG = "OK";     
        }
    } else { //�ؽ����� ������ �����̸�
        /*
         * hashdata���� ���� �α׸� ó���Ͻñ� �ٶ��ϴ�. 
         */      
        resultMSG = "������� ���� DBó��(LGD_CASNOTEURL) �ؽ��� ������ �����Ͽ����ϴ�.";     
    }
    
    out.println(resultMSG.toString());    
%>
 
