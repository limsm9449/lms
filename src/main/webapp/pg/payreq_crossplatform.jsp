<%@ page contentType="text/html;charset=EUC-KR" %>
<%@ page import="java.security.MessageDigest, java.util.*" %>

<%
	request.setCharacterEncoding("euc-kr");
    /*
     * [���� ������û ������(STEP2-1)]
     *
     * ���������������� �⺻ �Ķ���͸� ���õǾ� ������, ������ �ʿ��Ͻ� �Ķ���ʹ� �����޴����� �����Ͻþ� �߰� �Ͻñ� �ٶ��ϴ�.
     */

    /*
     * 1. �⺻���� ������û ���� ����
     *
     * �⺻������ �����Ͽ� �ֽñ� �ٶ��ϴ�.(�Ķ���� ���޽� POST�� ����ϼ���)
     */
 
    String CST_PLATFORM         = request.getParameter("CST_PLATFORM");                 //LG���÷��� �������� ����(test:�׽�Ʈ, service:����)
    String CST_MID              = request.getParameter("CST_MID");                      //LG���÷����� ���� �߱޹����� �������̵� �Է��ϼ���.
    String LGD_MID              = ("test".equals(CST_PLATFORM.trim())?"t":"")+CST_MID;  //�׽�Ʈ ���̵�� 't'�� �����ϰ� �Է��ϼ���.
                                                                                        //�������̵�(�ڵ�����)
    String LGD_OID              = request.getParameter("LGD_OID");                      //�ֹ���ȣ(�������� ����ũ�� �ֹ���ȣ�� �Է��ϼ���)
    String LGD_AMOUNT           = request.getParameter("LGD_AMOUNT");                   //�����ݾ�("," �� ������ �����ݾ��� �Է��ϼ���)
    String LGD_MERTKEY          = (String)request.getAttribute("g_LGD_MERTKEY");		//����MertKey(mertkey�� ���������� -> ������� -> ���������������� Ȯ���ϽǼ� �ֽ��ϴ�)
	String LGD_BUYER            = request.getParameter("LGD_BUYER");                    //�����ڸ�
    String LGD_PRODUCTINFO      = request.getParameter("LGD_PRODUCTINFO");              //��ǰ��
    String LGD_BUYEREMAIL       = request.getParameter("LGD_BUYEREMAIL");               //������ �̸���
    String LGD_TIMESTAMP        = request.getParameter("LGD_TIMESTAMP");                //Ÿ�ӽ�����
    String LGD_CUSTOM_USABLEPAY = request.getParameter("LGD_CUSTOM_USABLEPAY");        	//�������� �ʱ��������
    String LGD_CUSTOM_SKIN      = "red";                                                //�������� ����â ��Ų(red)


    String LGD_CUSTOM_SWITCHINGTYPE = request.getParameter("LGD_CUSTOM_SWITCHINGTYPE"); //�ſ�ī�� ī��� ���� ������ ���� ��� (�����Ұ�)
    String LGD_WINDOW_VER		= "2.5";												//����â ��������
    String LGD_WINDOW_TYPE      = request.getParameter("LGD_WINDOW_TYPE");              //����â ȣ�� ��� (�����Ұ�)

	String LGD_OSTYPE_CHECK     = "P";                                                  //�� P: XPay ����(PC ���� ���): PC��� ����Ͽ� ����� �Ķ���� �� ���μ����� �ٸ��Ƿ� PC���� PC ������������ ���� �ʿ�. 
                                                                                        //"P", "M" ���� ����(Null, "" ����)�� ����� �Ǵ� PC ���θ� üũ���� ����
	//String LGD_ACTIVEXYN		= "N";													//������ü ������ ���, ActiveX ��� ���η� "N" �̿��� ��: ActiveX ȯ�濡�� ������ü ���� ����(IE)

    
    /*
     * �������(������) ���� ������ �Ͻô� ��� �Ʒ� LGD_CASNOTEURL �� �����Ͽ� �ֽñ� �ٶ��ϴ�.
     */
    //String LGD_CASNOTEURL		= "https://����URL/cas_noteurl.jsp";
	String LGD_CASNOTEURL		= (String)request.getAttribute("g_LGD_CASNOTEURL");

    /*
     * LGD_RETURNURL �� �����Ͽ� �ֽñ� �ٶ��ϴ�. �ݵ�� ���� �������� ������ ����Ʈ�� ��  ȣ��Ʈ�̾�� �մϴ�. �Ʒ� �κ��� �ݵ�� �����Ͻʽÿ�.
     */
    //String LGD_RETURNURL		= "https://����URL/returnurl.jsp";// FOR MANUAL
    String LGD_RETURNURL		= (String)request.getAttribute("g_LGD_RETURNURL");// FOR MANUAL

    /*
     *************************************************
     * 2. MD5 �ؽ���ȣȭ (�������� ������) - BEGIN
     *
     * MD5 �ؽ���ȣȭ�� �ŷ� �������� �������� ����Դϴ�.
     *************************************************
     *
     * �ؽ� ��ȣȭ ����( LGD_MID + LGD_OID + LGD_AMOUNT + LGD_TIMESTAMP + LGD_MERTKEY )
     * LGD_MID          : �������̵�
     * LGD_OID          : �ֹ���ȣ
     * LGD_AMOUNT       : �ݾ�
     * LGD_TIMESTAMP    : Ÿ�ӽ�����
     * LGD_MERTKEY      : ����MertKey (mertkey�� ���������� -> ������� -> ���������������� Ȯ���ϽǼ� �ֽ��ϴ�)
     *
     * MD5 �ؽ������� ��ȣȭ ������ ����
     * LG���÷������� �߱��� ����Ű(MertKey)�� ȯ�漳�� ����(lgdacom/conf/mall.conf)�� �ݵ�� �Է��Ͽ� �ֽñ� �ٶ��ϴ�.
     */
    StringBuffer sb = new StringBuffer();
    sb.append(LGD_MID);
    sb.append(LGD_OID);
    sb.append(LGD_AMOUNT);
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

    String LGD_HASHDATA = strBuf.toString();
    String LGD_CUSTOM_PROCESSTYPE = "TWOTR";
    /*
     *************************************************
     * 2. MD5 �ؽ���ȣȭ (�������� ������) - END
     *************************************************
     */
     
     
     
     
  	 Map payReqMap = new HashMap();
     
     payReqMap.put("CST_PLATFORM"                , CST_PLATFORM);                   	// �׽�Ʈ, ���� ����
     payReqMap.put("CST_MID"                     , CST_MID );                        	// �������̵�
     payReqMap.put("LGD_WINDOW_TYPE"             , LGD_WINDOW_TYPE );                   // ����âȣ�� ���(�����Ұ�)
     payReqMap.put("LGD_MID"                     , LGD_MID );                        	// �������̵�
     payReqMap.put("LGD_OID"                     , LGD_OID );                        	// �ֹ���ȣ
     payReqMap.put("LGD_BUYER"                   , LGD_BUYER );                      	// ������
     payReqMap.put("LGD_PRODUCTINFO"             , LGD_PRODUCTINFO );                	// ��ǰ����
     payReqMap.put("LGD_AMOUNT"                  , LGD_AMOUNT );                     	// �����ݾ�
     payReqMap.put("LGD_BUYEREMAIL"              , LGD_BUYEREMAIL );                 	// ������ �̸���
     payReqMap.put("LGD_CUSTOM_SKIN"             , LGD_CUSTOM_SKIN );                	// ����â SKIN
     payReqMap.put("LGD_CUSTOM_PROCESSTYPE"      , LGD_CUSTOM_PROCESSTYPE );         	// Ʈ����� ó�����
     payReqMap.put("LGD_TIMESTAMP"               , LGD_TIMESTAMP );                  	// Ÿ�ӽ�����
     payReqMap.put("LGD_HASHDATA"                , LGD_HASHDATA );      	           	// MD5 �ؽ���ȣ��
     payReqMap.put("LGD_RETURNURL"   			, LGD_RETURNURL );      			   	// �������������
     payReqMap.put("LGD_CUSTOM_USABLEPAY"  		, LGD_CUSTOM_USABLEPAY );				// ����Ʈ �������� (�ش� �ʵ带 ������ ������ �������� ���� UI �� ���̰� �˴ϴ�.)
     payReqMap.put("LGD_CUSTOM_SWITCHINGTYPE"  	, LGD_CUSTOM_SWITCHINGTYPE );			// �ſ�ī�� ī��� ���� ������ ���� ���
     payReqMap.put("LGD_WINDOW_VER"  			, LGD_WINDOW_VER );						// ����â �������� 
     payReqMap.put("LGD_OSTYPE_CHECK"           , LGD_OSTYPE_CHECK);                    // �� P: XPay ����(PC�� ���� ���), PC, ����� ���� ���������� �������� 
	 //payReqMap.put("LGD_ACTIVEXYN"			, LGD_ACTIVEXYN);						// ������ü ������ ���, ActiveX ��� ����
	 payReqMap.put("LGD_VERSION"         		, "JSP_Non-ActiveX_Standard");			// ���Ÿ�� ����(���� �� ���� ����): �� ������ �ٰŷ� � ���񽺸� ����ϴ��� �Ǵ��� �� �ֽ��ϴ�.


     
     // �������(������) ���������� �Ͻô� ���  �Ҵ�/�Ա� ����� �뺸�ޱ� ���� �ݵ�� LGD_CASNOTEURL ������ LG ���÷����� �����ؾ� �մϴ� .
     payReqMap.put("LGD_CASNOTEURL"          , LGD_CASNOTEURL );               // ������� NOTEURL



    /*Return URL���� ���� ��� ���� �� ���õ� �Ķ���� �Դϴ�.*/
	 payReqMap.put("LGD_RESPCODE"  		 , "" );
	 payReqMap.put("LGD_RESPMSG"  		 , "" );
	 payReqMap.put("LGD_PAYKEY"  		 , "" );

	 /* �Һΰ����� */
	 payReqMap.put("LGD_INSTALLRANGE"  		 , "0:2:3" );

	 session.setAttribute("PAYREQ_MAP", payReqMap);

 %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>����LG���÷��� ���ڰἭ��</title>
<!-- 
  test�� ���
<script language="javascript" src="https://pretest.uplus.co.kr:9443/xpay/js/xpay_crossplatform.js" type="text/javascript"></script>
  service�� ��� �Ʒ� URL�� ��� 
<script language="javascript" src="https://xpay.uplus.co.kr/xpay/js/xpay_crossplatform.js" type="text/javascript"></script>
 -->
 
	<script language="javascript" src="<%=request.getAttribute("g_xpay_js")%>" type="text/javascript"></script>
	<script type="text/javascript" src="/resources/js/jquery-3.3.1.min.js"></script>


</head>

<script type="text/javascript">

$(document.body).ready(function () {
	launchCrossPlatform();
});


/*
* �����Ұ�.
*/
	var LGD_window_type = '<%=LGD_WINDOW_TYPE%>';
	
/*
* �����Ұ�
*/
function launchCrossPlatform(){
	lgdwin = openXpay(document.getElementById('LGD_PAYINFO'), '<%= CST_PLATFORM %>', LGD_window_type, null, "", "");
}
/*
* FORM ��  ���� ����
*/
function getFormObject() {
        return document.getElementById("LGD_PAYINFO");
}

/*
 * ������� ó��
 */
function payment_return() {
	var fDoc;
	
		fDoc = lgdwin.contentWindow || lgdwin.contentDocument;
	
	if (fDoc.document.getElementById('LGD_RESPCODE').value == "0000") {
		
			document.getElementById("LGD_PAYKEY").value = fDoc.document.getElementById('LGD_PAYKEY').value;
			document.getElementById("LGD_PAYINFO").target = "_self";
			document.getElementById("LGD_PAYINFO").action = "/paymentGateway/payres.do";
			document.getElementById("LGD_PAYINFO").submit();
	} else {
		alert("LGD_RESPCODE (����ڵ�) : " + fDoc.document.getElementById('LGD_RESPCODE').value + "\n" + "LGD_RESPMSG (����޽���): " + fDoc.document.getElementById('LGD_RESPMSG').value);
		closeIframe();
	}
}

</script>
<body>
<form method="post" name="LGD_PAYINFO" id="LGD_PAYINFO" action="/paymentGateway/payres.do">
<table cellpadding="10">
    <tr>
        <td>������ �̸� </td>
        <td><%= LGD_BUYER %></td>
    </tr>
    <tr>
        <td>��ǰ���� </td>
        <td><%= LGD_PRODUCTINFO %></td>
    </tr>
    <tr>
        <td>�����ݾ� </td>
        <td><%= LGD_AMOUNT %></td>
    </tr>
    <tr>
        <td>������ �̸��� </td>
        <td><%= LGD_BUYEREMAIL %></td>
    </tr>
    <tr>
        <td>�ֹ���ȣ </td>
        <td><%= LGD_OID %></td>
    </tr>
    <tr>
        <td colspan="2">* �߰� �� ������û �Ķ���ʹ� �޴����� �����Ͻñ� �ٶ��ϴ�.</td>
    </tr>
    <tr>
        <td colspan="2"></td>
    </tr>
    <tr>
        <td colspan="2">
		<input type="button" value="������û" onclick="launchCrossPlatform();"/>
        </td>
    </tr>
</table>
<%
	for(Iterator i = payReqMap.keySet().iterator(); i.hasNext();){
		Object key = i.next();
		out.println("<input type='hidden' name='" + key + "' id='"+key+"' value='" + payReqMap.get(key) + "'>" );
	}
%>

<input type='hidden' name='totalCost' id='totalCost' value='<%=request.getParameter("totalCost")%>'>
<input type='hidden' name='paymentPoint' id='paymentPoint' value='<%=request.getParameter("paymentPoint")%>'>
<input type='hidden' name='courseId' id='courseId' value='<%=request.getParameter("courseId")%>'>
<input type='hidden' name='paymentKind' id='paymentKind' value='<%=request.getParameter("LGD_CUSTOM_USABLEPAY")%>'>
<input type="hidden" id="cartWeeks" name="cartWeeks" value='<%=request.getParameter("cartWeeks")%>'>

</form>

</body>

</html>
